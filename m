Received: from eggs.gnu.org ([2001:4830:134:3::10]:60145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dflogeras2@gmail.com>) id 1evVqp-0007MN-B9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dflogeras2@gmail.com>) id 1evVqn-0007hw-Nh
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:23:27 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:52271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dflogeras2@gmail.com>)
	id 1evVqn-0007h0-DE
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:23:25 -0400
Received: by mail-wm0-x22e.google.com with SMTP id t3so19692086wmc.2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 15:23:25 -0700 (PDT)
MIME-Version: 1.0
From: Dave Flogeras <dflogeras2@gmail.com>
Date: Mon, 12 Mar 2018 19:23:22 -0300
Message-ID: <CANB0TnSxWxw6WMa8EcAEV40p2nUSMQSS-PHmty-WijmqJZ-Q5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu-user issue when used with uclibc-ng
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, I use qemu-user on Gentoo to form a qemu+binfmt+chroot setup to build
packages targeting an arm uclibc-ng based system.  The process is described
here:

https://wiki.gentoo.org/wiki/Embedded_Handbook/General/Compiling_with_qemu_user_chroot

After upgrading to uclibc-ng-1.0.26 I would get the following assert and
segfault from qemu:

qemu-x86_64:
/var/tmp/portage/app-emulation/qemu-2.11.0/work/qemu-2.11.0/accel/t
cg/translate-all.c:2078: page_set_flags: Assertion `start < end' failed.
qemu:handle_cpu_signal received signal outside vCPU context @ pc=0x601c3f6b

I have tracked this down as best I could to a way to reproduce it.  First,
I don't believe it is ARM specific, because I was able to make it happen by
running qemu-x86_64 under a uclibc-ng chroot.  It has something to do with
the way uclibc-ng executes dlclose() on certain shared libraries.  If I
compile the following basic snippet:


#include <dlfcn.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

int main() {
 void* v = dlopen( "/usr/lib/syslog-ng/libdbparser.so", RTLD_LAZY |
RTLD_GLOBAL
);
 if( ! v ) fprintf( stderr, "failed to open" );
 if( 0 != dlclose( v )) {
   fprintf( stderr, "%s\n", strerror( errno ));
 }
 return 0;
}


It segfaults under qemu-x86_64 (and ARM), with the following backtrace:


#0  0x00000000601c38b0 in raise ()
#1  0x00000000601c3e6a in abort ()
#2  0x00000000601bd9a1 in __assert_fail_base ()
#3  0x00000000601bda22 in __assert_fail ()
#4  0x0000000060036c3e in page_set_flags (start=274891239424, end=2232320,
flags
=0) at
/usr/src/debug/app-emulation/qemu-2.11.0/qemu-2.11.0/accel/tcg/translate-
all.c:2078
#5  0x000000006005f010 in target_munmap (start=274891239424,
len=184467437988205
44512) at
/usr/src/debug/app-emulation/qemu-2.11.0/qemu-2.11.0/linux-user/mmap.c
:667
#6  0x00000000600526e4 in do_syscall (cpu_env=0x62619160, num=11,
arg1=274891239
424, arg2=-274889010896, arg3=6, arg4=123096, arg5=274891109664,
arg6=2228528, a
rg7=0, arg8=0) at
/usr/src/debug/app-emulation/qemu-2.11.0/qemu-2.11.0/linux-use
r/syscall.c:9304
#7  0x000000006003ad3a in cpu_loop (env=0x62619160) at
/usr/src/debug/app-emulat
ion/qemu-2.11.0/qemu-2.11.0/linux-user/main.c:252
#8  0x000000006003cc41 in main (argc=2, argv=0x7fffffffe578,
envp=0x7fffffffe590
) at
/usr/src/debug/app-emulation/qemu-2.11.0/qemu-2.11.0/linux-user/main.c:4882


I have found that after bisecting uclibc-ng between 1.0.25 and 1.0.26, the
commit causing this behaviour is:

https://cgit.uclibc-ng.org/cgi/cgit/uclibc-ng.git/commit/?id=952bb00f0b2eb576b0bf48c4f87018429a42e28d

I am completely out of my depth here, I don't know the design other either
qemu-user, or the dlopen/dlclose of a C library.  Clearly start>end, but I
don't even know what those represent.  Can anyone suggest how we can
further this and find a fix?  Right now my workaround is to revert the
above commit.

Cheers,
Dave

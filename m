Received: from eggs.gnu.org ([2001:4830:134:3::10]:45104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cs5Ri-0003gP-UU
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 06:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cs5Re-0007hu-Vi
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 06:30:50 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40852
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cs5Re-0007f6-O7
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 06:30:46 -0400
Received: from host86-184-243-30.range86-184.btcentralplus.com
	([86.184.243.30] helo=[192.168.1.65])
	by s16892447.onlinehome-server.info with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cs5RL-00067f-Hc
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 11:30:38 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d4c50e61-112c-1818-479e-494d58e361f2@ilande.co.uk>
Date: Sun, 26 Mar 2017 11:30:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] Problems with native Mingw-w64 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi all,

In order to do some testing on a Windows box, I've spent a bit of time
this weekend setting up a mingw-w64 build environment on Windows 10
using http://wiki.qemu-project.org/Hosts/W32 as a guideline.

After a few false starts, I was able to get the basic environment
working but so far I've been unable to build git master due to a couple
of failures:


1) texi2pod.pl error

  GEN     qemu.1
Bareword found where operator expected at
/c/Users/Mark/qemu/src/qemu/scripts/texi2pod.pl line 349, near "@(deftp"
  (Might be a runaway multi-line // string starting on line 337)
        (Missing operator before deftp?)
Unquoted string "deftp" may clash with future reserved word at
/c/Users/Mark/qemu/src/qemu/scripts/texi2pod.pl line 349.
Backslash found where operator expected at
/c/Users/Mark/qemu/src/qemu/scripts/texi2pod.pl line 349, near ")\"
        (Missing operator before \?)
Unrecognized escape \s passed through at
/c/Users/Mark/qemu/src/qemu/scripts/texi2pod.pl line 349.
syntax error at /c/Users/Mark/qemu/src/qemu/scripts/texi2pod.pl line
349, near "@(deftp"
Missing right curly or square bracket at
/c/Users/Mark/qemu/src/qemu/scripts/texi2pod.pl line 534, at end of line
Execution of /c/Users/Mark/qemu/src/qemu/scripts/texi2pod.pl aborted due
to compilation errors.
make: *** [qemu.1] Error 255

I'm not sure what the workaround for this is, however it is possible to
get further with the build by passing --disable-docs to configure.


2) glib-compat mkdtemp() error

  CC      qga/commands.o
In file included from
c:/Users/Mark/qemu/src/qemu/include/qemu/osdep.h:107:0,
                 from qga/commands.c:13:
c:/Users/Mark/qemu/src/qemu/include/glib-compat.h: In function
'qemu_g_dir_make_tmp':
c:/Users/Mark/qemu/src/qemu/include/glib-compat.h:59:9: error: implicit
declaration of function 'mkdtemp' [-Werror=implicit-function-declaration]
     if (mkdtemp(path) != NULL) {
         ^~~~~~~
c:/Users/Mark/qemu/src/qemu/include/glib-compat.h:59:5: error: nested
extern declaration of 'mkdtemp' [-Werror=nested-externs]
     if (mkdtemp(path) != NULL) {
     ^~
c:/Users/Mark/qemu/src/qemu/include/glib-compat.h:59:23: error:
comparison between pointer and integer [-Werror]
     if (mkdtemp(path) != NULL) {
                       ^~
cc1.exe: all warnings being treated as errors
make: *** [qga/commands.o] Error 1

This one seems to be a genuine bug since the wiki above mentions that
64-bit builds cannot use versions of glib > 2.22 due to a change in the
way global symbols are managed. Since g_dir_make_tmp() only appears in
glib 2.30 and later, we end up using the fallback code which fails
because mkdtemp() isn't available on Windows.


My guess would be that most people are using the Docker image to
cross-compile Windows binaries rather than attempting a native build
which is why no-one has really noticed (the mkdtemp() change went into
the tree around August last year). Do people consider native Windows
builds to still be supported?


ATB,

Mark.

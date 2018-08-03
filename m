Received: from eggs.gnu.org ([2001:4830:134:3::10]:35108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1flWjN-00081Z-7p
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1flWjK-0000Ol-4O
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:50:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:34492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1flWjJ-0000NQ-UX
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:50:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1flWjI-00051D-1N
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 09:50:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 078C02E80C7
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 09:50:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Aug 2018 09:42:27 -0000
From: Serge Belyshev <1785203@bugs.launchpad.net>
Reply-To: Bug 1785203 <1785203@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153328934781.28538.2265879315975123435.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785203] [NEW] accel/tcg/translate-all.c:2511:
 page_check_range: Assertion `start < ((target_ulong)1 <<
 L1_MAP_ADDR_SPACE_BITS)' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

qemu-riscv64 version 2.12.93 crashes when mincore() is called with
invalid pointer with the following message:

qemu-riscv64: /opt/qemu/accel/tcg/translate-all.c:2511: page_check_range: A=
ssertion `start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS)' failed.
qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x600014=
ef

Testcase:

#include <sys/mman.h>

int main (void)
{
  unsigned char v;
  return mincore ((void *) 0x00000010000000000, 1, &v);
}

Backtrace:

#0  raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:50
#1  0x000000006000140a in abort () at abort.c:79
#2  0x00000000600012ec in __assert_fail_base (
    fmt=3D0x6024eae8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", =

    assertion=3D0x601b9758 "start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_B=
ITS)", =

    file=3D0x601b9658 "/opt/qemu/accel/tcg/translate-all.c", line=3D2511, =

    function=3D0x601b9810 <__PRETTY_FUNCTION__.23867> "page_check_range") a=
t assert.c:92
#3  0x000000006010e10e in __assert_fail (
    assertion=3Dassertion@entry=3D0x601b9758 "start < ((target_ulong)1 << L=
1_MAP_ADDR_SPACE_BITS)", file=3Dfile@entry=3D0x601b9658 "/opt/qemu/accel/tc=
g/translate-all.c", line=3Dline@entry=3D2511, =

    function=3Dfunction@entry=3D0x601b9810 <__PRETTY_FUNCTION__.23867> "pag=
e_check_range")
    at assert.c:101
#4  0x000000006003e916 in page_check_range (start=3Dstart@entry=3D109951162=
7776, len=3Dlen@entry=3D1, =

    flags=3Dflags@entry=3D1) at /opt/qemu/accel/tcg/translate-all.c:2511
#5  0x0000000060057717 in access_ok (size=3D1, addr=3D1099511627776, type=
=3D0)
    at /opt/qemu/linux-user/qemu.h:567
#6  lock_user (copy=3D0, len=3D1, guest_addr=3D1099511627776, type=3D0)
    at /opt/qemu/linux-user/qemu.h:567
#7  do_syscall (cpu_env=3Dcpu_env@entry=3D0x622fca28, num=3D232, arg1=3D109=
9511627776, arg2=3D1, =

    arg3=3D274886298751, arg4=3D0, arg5=3D274886298808, arg6=3D66518, arg7=
=3D0, arg8=3D0)
    at /opt/qemu/linux-user/syscall.c:11635
#8  0x0000000060066c5c in cpu_loop (env=3Denv@entry=3D0x622fca28)
    at /opt/qemu/linux-user/riscv/cpu_loop.c:55
#9  0x0000000060002156 in main (argc=3D<optimized out>, argv=3D0x7fffffffed=
68, =

    envp=3D<optimized out>) at /opt/qemu/linux-user/main.c:819

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785203

Title:
  accel/tcg/translate-all.c:2511: page_check_range: Assertion `start <
  ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS)' failed.

Status in QEMU:
  New

Bug description:
  qemu-riscv64 version 2.12.93 crashes when mincore() is called with
  invalid pointer with the following message:

  qemu-riscv64: /opt/qemu/accel/tcg/translate-all.c:2511: page_check_range:=
 Assertion `start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS)' failed.
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6000=
14ef

  Testcase:

  #include <sys/mman.h>

  int main (void)
  {
    unsigned char v;
    return mincore ((void *) 0x00000010000000000, 1, &v);
  }

  Backtrace:

  #0  raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:50
  #1  0x000000006000140a in abort () at abort.c:79
  #2  0x00000000600012ec in __assert_fail_base (
      fmt=3D0x6024eae8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", =

      assertion=3D0x601b9758 "start < ((target_ulong)1 << L1_MAP_ADDR_SPACE=
_BITS)", =

      file=3D0x601b9658 "/opt/qemu/accel/tcg/translate-all.c", line=3D2511, =

      function=3D0x601b9810 <__PRETTY_FUNCTION__.23867> "page_check_range")=
 at assert.c:92
  #3  0x000000006010e10e in __assert_fail (
      assertion=3Dassertion@entry=3D0x601b9758 "start < ((target_ulong)1 <<=
 L1_MAP_ADDR_SPACE_BITS)", file=3Dfile@entry=3D0x601b9658 "/opt/qemu/accel/=
tcg/translate-all.c", line=3Dline@entry=3D2511, =

      function=3Dfunction@entry=3D0x601b9810 <__PRETTY_FUNCTION__.23867> "p=
age_check_range")
      at assert.c:101
  #4  0x000000006003e916 in page_check_range (start=3Dstart@entry=3D1099511=
627776, len=3Dlen@entry=3D1, =

      flags=3Dflags@entry=3D1) at /opt/qemu/accel/tcg/translate-all.c:2511
  #5  0x0000000060057717 in access_ok (size=3D1, addr=3D1099511627776, type=
=3D0)
      at /opt/qemu/linux-user/qemu.h:567
  #6  lock_user (copy=3D0, len=3D1, guest_addr=3D1099511627776, type=3D0)
      at /opt/qemu/linux-user/qemu.h:567
  #7  do_syscall (cpu_env=3Dcpu_env@entry=3D0x622fca28, num=3D232, arg1=3D1=
099511627776, arg2=3D1, =

      arg3=3D274886298751, arg4=3D0, arg5=3D274886298808, arg6=3D66518, arg=
7=3D0, arg8=3D0)
      at /opt/qemu/linux-user/syscall.c:11635
  #8  0x0000000060066c5c in cpu_loop (env=3Denv@entry=3D0x622fca28)
      at /opt/qemu/linux-user/riscv/cpu_loop.c:55
  #9  0x0000000060002156 in main (argc=3D<optimized out>, argv=3D0x7fffffff=
ed68, =

      envp=3D<optimized out>) at /opt/qemu/linux-user/main.c:819

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785203/+subscriptions

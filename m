Received: from eggs.gnu.org ([209.51.188.92]:45399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gzMYK-00028z-6o
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gzMYH-0006lB-T3
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:20:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:41602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gzMYH-0006iy-J8
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:20:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gzMYB-0001um-IB
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 14:20:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8518F2E8037
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 14:20:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Feb 2019 14:14:32 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1818075 <1818075@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155136199055.29310.6029801353341134939.malonedeb@chaenomeles.canonical.com>
Message-Id: <155136327295.29163.9717379667769472182.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1818075] Re: qemu x86 TCG doesn't support AVX
 insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Further debugging on IRC reveals that QEMU itself is not hanging, but
the guest code is looping infinitely, because QEMU doesn't implement the
AVX instruction set and isn't generating an undefined-instruction
exception either. So the %rdx output from the AVX insn is wrong and the
guest code never exits the loop (whose condition depends on %rdx).

We should ideally:
 * make the x86 decoder properly handle insns that don't exist for the CPU =
being emulated (not too difficult, but doesn't actually help in running thi=
s test program)
 * implement AVX (a fair chunk of effort; it is being proposed as a GSoC pr=
oject for this summer)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818075

Title:
  qemu x86 TCG doesn't support AVX insns

Status in QEMU:
  New

Bug description:
  I'm trying to execute code that has been built with -march=3Dskylake
  -mtune=3Dgeneric -mavx2 under qemu-user x86-64 with -cpu Skylake-Client.
  However this code just hangs at 100% CPU.

  Adding input tracing shows that it is likely hanging when dealing with
  an AVX instruction:

  warning: TCG doesn't support requested feature: CPUID.01H:ECX.fma [bit 12]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.pcid [bit 1=
7]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.x2apic [bit=
 21]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.tsc-deadlin=
e [bit 24]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.avx [bit 28]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.f16c [bit 2=
9]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.rdrand [bit=
 30]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.hle [bit 4]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.avx2 [bit 5]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.invpcid [bi=
t 10]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.rtm [bit 11]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.rdseed [bit=
 18]
  warning: TCG doesn't support requested feature: CPUID.80000001H:ECX.3dnow=
prefetch [bit 8]
  warning: TCG doesn't support requested feature: CPUID.0DH:EAX.xsavec [bit=
 1]

  IN:
  0x4000b4ef3b:  c5 fb 5c ca              vsubsd   %xmm2, %xmm0, %xmm1
  0x4000b4ef3f:  c4 e1 fb 2c d1           vcvttsd2si %xmm1, %rdx
  0x4000b4ef44:  4c 31 e2                 xorq     %r12, %rdx
  0x4000b4ef47:  48 85 d2                 testq    %rdx, %rdx
  0x4000b4ef4a:  79 9e                    jns      0x4000b4eeea

  [ hangs ]

  Attaching a gdb produces this stacktrace:

  (gdb) bt
  #0  canonicalize (status=3D0x55a20ff67a88, parm=3D0x55a20bb807e0 <float64=
_params>, part=3D...)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/fpu/softfloat.c:350
  #1  float64_unpack_canonical (s=3D0x55a20ff67a88, f=3D0)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/fpu/softfloat.c:547
  #2  float64_sub (a=3D0, b=3D4890909195324358656, status=3D0x55a20ff67a88)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/fpu/softfloat.c:776
  #3  0x000055a20baa1949 in helper_subsd (env=3D<optimized out>, d=3D0x55a2=
0ff67ad8, s=3D<optimized out>)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/target/i386/ops_sse.h:623
  #4  0x000055a20cfcfea8 in static_code_gen_buffer ()
  #5  0x000055a20ba3f764 in cpu_tb_exec (itb=3D<optimized out>, cpu=3D0x55a=
20cea2180 <static_code_gen_buffer+15684720>)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/accel/tcg/cpu-exec.c:171
  #6  cpu_loop_exec_tb (tb_exit=3D<synthetic pointer>, last_tb=3D<synthetic=
 pointer>, tb=3D<optimized out>,
      cpu=3D0x55a20cea2180 <static_code_gen_buffer+15684720>)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/accel/tcg/cpu-exec.c:615
  #7  cpu_exec (cpu=3Dcpu@entry=3D0x55a20ff5f4d0)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/accel/tcg/cpu-exec.c:725
  #8  0x000055a20ba6d728 in cpu_loop (env=3D0x55a20ff67780)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/linux-user/x86_64/../i386/cpu_loop.c:93
  #9  0x000055a20ba049ff in main (argc=3D<optimized out>, argv=3D0x7ffc5857=
2868, envp=3D<optimized out>)
      at /data/poky-tmp/master/work/x86_64-linux/qemu-native/3.1.0-r0/qemu-=
3.1.0/linux-user/main.c:819

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1818075/+subscriptions

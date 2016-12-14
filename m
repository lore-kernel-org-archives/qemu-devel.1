Received: from eggs.gnu.org ([2001:4830:134:3::10]:39841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cH6NU-0007Go-QU
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cH6NP-0005nr-B8
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:01:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:60385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cH6NP-0005ng-14
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:01:31 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cH6NM-0005Ej-R7
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 10:01:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A48372E818E
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 10:01:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Dec 2016 09:44:06 -0000
From: Ziyue Yang <1641637@bugs.launchpad.net>
Reply-To: Bug 1641637 <1641637@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161114154536.3631.7893.malonedeb@soybean.canonical.com>
Message-Id: <20161214094406.20226.27896.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1641637] Re: incorrect illegal SSE3 instructions
 reporting on x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Jie,

Seems that the problem was caused by not specifying the cpu model when runn=
ing QEMU.
when running =

qemu-x86_64 ./28
QEMU would recognize the cpu model as "qemu64", which act like a cpu doesn'=
t support advanced instruction sets like SSSE3. To workaround, you can run
qemu-x86_86 -cpu core2duo ./28
The cpu specifications could be found at target-i386/cpu.c. =


I haven't tested through all the cases yet, but I'm almost sure that was th=
e problem, for all your test cases used SSSE3 instructions or something ali=
ke. =

Please let me know if there are some more exceptions, thanks!

** Changed in: qemu
       Status: Confirmed =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1641637

Title:
  incorrect illegal SSE3 instructions reporting on x86_64

Status in QEMU:
  Invalid

Bug description:
  Hi all, we found 28 differently encoded illegal SSE3 instructions
  reporting on the most recent x86_64 user mode linux qemu (version
  2.7.0). We believe these reporting should be incorrect because the
  same code can be executed on a real machine. The instructions are the
  following:

  pabsb %mm0, %mm1
  pabsb %xmm0, %xmm1
  pabsd %mm0, %mm1
  pabsd %xmm0, %xmm1
  pabsw %mm0, %mm1
  pabsw %xmm0, %xmm1
  phaddd %mm0, %mm1
  phaddd %xmm0, %xmm1
  phaddsw %mm0, %mm1
  phaddsw %xmm0, %xmm1
  phaddw %mm0, %mm1
  phaddw %xmm0, %xmm1
  phsubd %mm0, %mm1
  phsubd %xmm0, %xmm1
  phsubsw %mm0, %mm1
  phsubsw %xmm0, %xmm1
  phsubw %mm0, %mm1
  phsubw %xmm0, %xmm1
  pmaddubsw %mm0, %mm1
  pmaddubsw %xmm0, %xmm1
  pmulhrsw %mm0, %mm1
  pmulhrsw %xmm0, %xmm1
  psignb %mm0, %mm1
  psignb %xmm0, %xmm1
  psignd %mm0, %mm1
  psignd %xmm0, %xmm1
  psignw %mm0, %mm1
  psignw %xmm0, %xmm1

  The following is the proof of code

  /********** Beginning of bug 1.c: pabsb %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("pabsb %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 1.c **********/

  =

  /********** Beginning of bug 2.c: pabsb %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("pabsb %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 2.c **********/

  =

  /********** Beginning of bug 3.c: pabsd %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("pabsd %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 3.c **********/

  =

  /********** Beginning of bug 4.c: pabsd %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("pabsd %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 4.c **********/

  =

  /********** Beginning of bug 5.c: pabsw %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("pabsw %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 5.c **********/

  =

  /********** Beginning of bug 6.c: pabsw %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("pabsw %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 6.c **********/

  =

  /********** Beginning of bug 7.c: phaddd %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("phaddd %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 7.c **********/

  =

  /********** Beginning of bug 8.c: phaddd %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("phaddd %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 8.c **********/

  =

  /********** Beginning of bug 9.c: phaddsw %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("phaddsw %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 9.c **********/

  =

  /********** Beginning of bug 10.c: phaddsw %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("phaddsw %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 10.c **********/

  =

  /********** Beginning of bug 11.c: phaddw %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("phaddw %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 11.c **********/

  =

  /********** Beginning of bug 12.c: phaddw %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("phaddw %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 12.c **********/

  =

  /********** Beginning of bug 13.c: phsubd %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("phsubd %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 13.c **********/

  =

  /********** Beginning of bug 14.c: phsubd %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("phsubd %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 14.c **********/

  =

  /********** Beginning of bug 15.c: phsubsw %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("phsubsw %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 15.c **********/

  =

  /********** Beginning of bug 16.c: phsubsw %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("phsubsw %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 16.c **********/

  =

  /********** Beginning of bug 17.c: phsubw %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("phsubw %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 17.c **********/

  =

  /********** Beginning of bug 18.c: phsubw %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("phsubw %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 18.c **********/

  =

  /********** Beginning of bug 19.c: pmaddubsw %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char i2[0x10];
  unsigned char i3[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm0\n"::"r"((char *)(i2)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i3)));;
      asm("pmaddubsw %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 19.c **********/

  =

  /********** Beginning of bug 20.c: pmaddubsw %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char i2[0x10];
  unsigned char i3[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm0\n"::"r"((char *)(i2)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i3)));;
      asm("pmaddubsw %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 20.c **********/

  =

  /********** Beginning of bug 21.c: pmulhrsw %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("pmulhrsw %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 21.c **********/

  =

  /********** Beginning of bug 22.c: pmulhrsw %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("pmulhrsw %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 22.c **********/

  =

  /********** Beginning of bug 23.c: psignb %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("psignb %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 23.c **********/

  =

  /********** Beginning of bug 24.c: psignb %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("psignb %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 24.c **********/

  =

  /********** Beginning of bug 25.c: psignd %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("psignd %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 25.c **********/

  =

  /********** Beginning of bug 26.c: psignd %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("psignd %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 26.c **********/

  =

  /********** Beginning of bug 27.c: psignw %mm0, %mm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movq (%%rdx), %%mm1\n"::"r"((char *)(i1)));;
      asm("psignw %mm0, %mm1");
      asm("mov %0, %%rdx\n"
          "movq %%mm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 27.c **********/

  =

  /********** Beginning of bug 28.c: psignw %xmm0, %xmm1 **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char i1[0x10];
  unsigned char o[0x10];
  int main() {
      int k =3D 0;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm0\n"::"r"((char *)(i0)));;
      asm("mov %0, %%rdx\n"
          "movdqu (%%rdx), %%xmm1\n"::"r"((char *)(i1)));;
      asm("psignw %xmm0, %xmm1");
      asm("mov %0, %%rdx\n"
          "movdqu %%xmm1, (%%rdx)\n"::"r"((char *)(o)));;
      for (k =3D 0; k < 0x10; k++)
          printf("%02x", o[0x10 - 1 - k]);
      printf("\n");
  }

  /********** End of bug 28.c **********/

  For any of the above code, when compiled into x86-64 binary code with
  gcc, qemu reports the illegal instructions bug. However, these can be
  correctly executed on a real machine. For example,

  $ gcc 28.c -o 28
  $ qemu-x86_64 ./28
  qemu: uncaught target signal 4 (Illegal instruction) - core dumped
  Illegal instruction
  $ ./28
  00000000000000000000000000000000

  Some information about the system:

  $ qemu-x86_64 --version
  qemu-x86_64 version 2.7.0, Copyright (c) 2003-2016 Fabrice Bellard and th=
e QEMU Project developers
  $ uname -a
  Linux cgos-System-Product-Name 3.13.0-32-generic #57-Ubuntu SMP Tue Jul 1=
5 03:51:08 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
  $ gcc --version
  gcc (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4
  Copyright (C) 2013 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.

  =

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1641637/+subscriptions

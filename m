Received: from eggs.gnu.org ([2001:4830:134:3::10]:51452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9FCJ-0004gd-Di
	for qemu-devel@nongnu.org; Fri, 12 May 2017 14:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9FCI-0007l2-0L
	for qemu-devel@nongnu.org; Fri, 12 May 2017 14:21:51 -0400
Date: Fri, 12 May 2017 20:21:32 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170512182132.jdw4g2pd5gvf2dti@aurel32.net>
References: <20170512033543.6789-1-f4bug@amsat.org>
	<20170512033543.6789-3-f4bug@amsat.org>
	<f447c23f-f63c-f3bb-a1b9-f63e5aff4063@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f447c23f-f63c-f3bb-a1b9-f63e5aff4063@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: optimize rev16() using
 extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On 2017-05-12 09:50, Richard Henderson wrote:
> On 05/11/2017 08:35 PM, Philippe Mathieu-Daud=E9 wrote:
> > -    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 16);
> > -    tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
> > +    tcg_gen_extract_i64(tcg_tmp, tcg_rn, 16, 0xffff);
>=20
> So your new script didn't work then?  This should be "..., 16, 16);".

Indeed that should be ..., 16, 16). That said looking a bit at the=20
actual code, it looks like rev16 is not implemented efficiently. Instead
of byteswapping individual 16-bit words one by one, it would be better
to work on the whole register at the same time using shifts and mask.
This is actually how rev16 is implemented for aarch32 (and a few other
targets). Something like that (i can send a proper patch later):

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 24de30d92c..ccb276417b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4034,25 +4034,14 @@ static void handle_rev16(DisasContext *s, unsigned =
int sf,
     TCGv_i64 tcg_rd =3D cpu_reg(s, rd);
     TCGv_i64 tcg_tmp =3D tcg_temp_new_i64();
     TCGv_i64 tcg_rn =3D read_cpu_reg(s, rn, sf);
-
-    tcg_gen_andi_i64(tcg_tmp, tcg_rn, 0xffff);
-    tcg_gen_bswap16_i64(tcg_rd, tcg_tmp);
-
-    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 16);
-    tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
-    tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
-    tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 16, 16);
-
-    if (sf) {
-        tcg_gen_shri_i64(tcg_tmp, tcg_rn, 32);
-        tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
-        tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
-        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 32, 16);
-
-        tcg_gen_shri_i64(tcg_tmp, tcg_rn, 48);
-        tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
-        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 48, 16);
-    }
+    uint64_t mask1 =3D sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff;
+    uint64_t mask2 =3D sf ? 0xff00ff00ff00ff00ull : 0xff00ff00;
+
+    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
+    tcg_gen_andi_i64(tcg_tmp, tcg_tmp, mask1);
+    tcg_gen_shli_i64(tcg_rd, tcg_rn, 8);
+    tcg_gen_andi_i64(tcg_rd, tcg_rd, mask2);
+    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
=20
     tcg_temp_free_i64(tcg_tmp);
 }

This makes the generated x86-64 code much shorter, especially with sf=3D1:


* rev16 with sf =3D 0

before:
    0x5631ecfda582:  movzwl %bx,%r12d
    0x5631ecfda586:  rol    $0x8,%r12w
    0x5631ecfda58b:  shr    $0x10,%rbx
    0x5631ecfda58f:  rol    $0x8,%bx
    0x5631ecfda593:  movzwl %bx,%ebx
    0x5631ecfda596:  shl    $0x10,%rbx
    0x5631ecfda59a:  mov    $0xffffffff0000ffff,%r13
    0x5631ecfda5a4:  and    %r13,%r12
    0x5631ecfda5a7:  or     %rbx,%r12
   =20
after:
    0x559f7aeae5f2:  mov    %rbx,%r12
    0x559f7aeae5f5:  shr    $0x8,%r12
    0x559f7aeae5f9:  and    $0xff00ff,%r12d
    0x559f7aeae600:  shl    $0x8,%rbx
    0x559f7aeae604:  and    $0xff00ff00,%ebx
    0x559f7aeae60a:  or     %r12,%rbx
   =20
   =20
* rev16 with sf =3D 1
   =20
before:
    0x5631ecfe5380:  mov    %rbx,%r12
    0x5631ecfe5383:  movzwl %bx,%ebx
    0x5631ecfe5386:  rol    $0x8,%bx
    0x5631ecfe538a:  mov    %r12,%r13
    0x5631ecfe538d:  shr    $0x10,%r13
    0x5631ecfe5391:  movzwl %r13w,%r13d
    0x5631ecfe5395:  rol    $0x8,%r13w
    0x5631ecfe539a:  movzwl %r13w,%r13d
    0x5631ecfe539e:  shl    $0x10,%r13
    0x5631ecfe53a2:  mov    $0xffffffff0000ffff,%r15
    0x5631ecfe53ac:  and    %r15,%rbx
    0x5631ecfe53af:  or     %r13,%rbx
    0x5631ecfe53b2:  mov    %r12,%r13
    0x5631ecfe53b5:  shr    $0x20,%r13
    0x5631ecfe53b9:  movzwl %r13w,%r13d
    0x5631ecfe53bd:  rol    $0x8,%r13w
    0x5631ecfe53c2:  movzwl %r13w,%r13d
    0x5631ecfe53c6:  shl    $0x20,%r13
    0x5631ecfe53ca:  mov    $0xffff0000ffffffff,%r15
    0x5631ecfe53d4:  and    %r15,%rbx
    0x5631ecfe53d7:  or     %r13,%rbx
    0x5631ecfe53da:  shr    $0x30,%r12
    0x5631ecfe53de:  rol    $0x8,%r12w
    0x5631ecfe53e3:  shl    $0x30,%r12
    0x5631ecfe53e7:  mov    $0xffffffffffff,%r13
    0x5631ecfe53f1:  and    %r13,%rbx
    0x5631ecfe53f4:  or     %r12,%rbx
   =20
after:
    0x559f7aeb93e0:  mov    %rbx,%r12
    0x559f7aeb93e3:  shr    $0x8,%r12
    0x559f7aeb93e7:  mov    $0xff00ff00ff00ff,%r13
    0x559f7aeb93f1:  and    %r13,%r12
    0x559f7aeb93f4:  shl    $0x8,%rbx
    0x559f7aeb93f8:  mov    $0xff00ff00ff00ff00,%r13
    0x559f7aeb9402:  and    %r13,%rbx
    0x559f7aeb9405:  or     %r12,%rbx

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

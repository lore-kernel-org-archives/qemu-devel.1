Received: from eggs.gnu.org ([209.51.188.92]:51972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grhpp-0000Fu-Iw
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:27:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grhpn-0001w2-8W
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:27:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1grhpm-0001nD-V8
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:27:11 -0500
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
	<20190207114913.2c5f2c5b.cohuck@redhat.com>
	<6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ffb48b9f-fc99-0766-925c-4f79c692cba7@redhat.com>
Date: Thu, 7 Feb 2019 12:26:42 +0100
MIME-Version: 1.0
In-Reply-To: <6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="mjQieWmoo95fJlKoJokQYFTttmrDiB0Hs"
Subject: Re: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck"
 under qemu-s390x in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Giovanni Mascellani <gio@debian.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mjQieWmoo95fJlKoJokQYFTttmrDiB0Hs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-02-07 12:05, Giovanni Mascellani wrote:
> Hi, thanks for answering!
>=20
> Il 07/02/19 11:49, Cornelia Huck ha scritto:
>> Did that work before commit 7de3b1cdc67 ("s390x/tcg: properly implemen=
t
>> the TOD")?
>=20
> It does not seem so
The problem is rather that the STCK instruction is fenced with
"#ifndef CONFIG_USER_ONLY" ... quick-n-dirty hack to allow it:

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 018e9dd..8baa784 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -122,12 +122,13 @@ DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
 DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
=20
+DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
 DEF_HELPER_4(diag, void, env, i32, i32, i32)
 DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
 DEF_HELPER_FLAGS_2(spx, TCG_CALL_NO_RWG, void, env, i64)
-DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
 DEF_HELPER_FLAGS_2(sck, TCG_CALL_NO_RWG, i32, env, i64)
 DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_2(sckpf, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index dab805f..41e2911 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -962,6 +962,10 @@
     D(0xb93e, KIMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_K=
IMD)
     D(0xb93f, KLMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_K=
LMD)
=20
+/* STORE CLOCK */
+    C(0xb205, STCK,    S,     Z,   la2, 0, new, m1_64, stck, 0)
+    C(0xb27c, STCKF,   S,     SCF, la2, 0, new, m1_64, stck, 0)
+
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
     E(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL=
, IF_PRIV)
@@ -1020,9 +1024,6 @@
     F(0x8000, SSM,     S,     Z,   0, m2_8u, 0, 0, ssm, 0, IF_PRIV)
 /* SIGNAL PROCESSOR */
     F(0xae00, SIGP,    RS_a,  Z,   0, a2, 0, 0, sigp, 0, IF_PRIV)
-/* STORE CLOCK */
-    C(0xb205, STCK,    S,     Z,   la2, 0, new, m1_64, stck, 0)
-    C(0xb27c, STCKF,   S,     SCF, la2, 0, new, m1_64, stck, 0)
 /* STORE CLOCK EXTENDED */
     C(0xb278, STCKE,   S,     Z,   0, a2, 0, 0, stcke, 0)
 /* STORE CLOCK COMPARATOR */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 52262f6..b9eea7f 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -396,6 +396,16 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t o=
rder_code, uint32_t r1,
=20
     return cc;
 }
+
+#else
+
+uint64_t HELPER(stck)(CPUS390XState *env)
+{
+    uint64_t ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    return (ns << 9) / 125 + (((ns & 0xff80000000000000ull) / 125) << 9)=
;
+}
+
 #endif
=20
 #ifndef CONFIG_USER_ONLY
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 639084a..177e281 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4034,6 +4034,14 @@ static DisasJumpType op_ectg(DisasContext *s, Disa=
sOps *o)
     return DISAS_NEXT;
 }
=20
+static DisasJumpType op_stck(DisasContext *s, DisasOps *o)
+{
+    gen_helper_stck(o->out, cpu_env);
+    /* ??? We don't implement clock states.  */
+    gen_op_movi_cc(s, 0);
+    return DISAS_NEXT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_spka(DisasContext *s, DisasOps *o)
 {
@@ -4061,14 +4069,6 @@ static DisasJumpType op_stap(DisasContext *s, Disa=
sOps *o)
     return DISAS_NEXT;
 }
=20
-static DisasJumpType op_stck(DisasContext *s, DisasOps *o)
-{
-    gen_helper_stck(o->out, cpu_env);
-    /* ??? We don't implement clock states.  */
-    gen_op_movi_cc(s, 0);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 c1 =3D tcg_temp_new_i64();


=2E.. then your test program works fine without crashing.

 Thomas


--mjQieWmoo95fJlKoJokQYFTttmrDiB0Hs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcXBX4AAoJEC7Z13T+cC21agEP/A7qwywQmRZyAkrz0y6YoLVw
KUlZBltVvoeDhHuqp+maLx8v93dvwY8z5swPB2skehMSwOnGtpk4kX887DXrCUdT
2pxDpR9Gvf+XF1iJ9DK6X1XVrBImt0crr+XxysPecpkJhcwGZPEb2rodKp/GfpX0
Ka8+cYHwl0baUV7/WmkaRMWfOP3vpuChJMAWhKRA0N/2kEfnZzURcJz5F5Tg9bO7
Tt7Sj8lFNqCQJzRcHRGYVJguhInTuB2dqsDszdknZ1iZ89SVJT6bg6JC0r219xjO
IObKm3Du6j+Cj06vM++aitRZa5nRDxgfTEMP/y4T60ZuUBUHdTvETIs7J6aX8Es2
P2zPBPYzHyXEgcnaQbqQiEjP0p1B33NXnNYYvw36htcdhURFT6ZnLokqMaJXs9os
6aMxmfH1IcOcdeWG2d9Vwt97Y3ESWLqW90Iyzp/H8/q21pCF2CICSsTzhB5mJryj
1zCELro5/KY4PwccCS79Db7gxvNCnFiC2GQu/iqvklpOfAoaNZjYcGCYDk1WCPqw
qiLqiwWMD6uHqo9LeuTtHEVV07PxoVXpv+IrByNPEgp6E2S8g8wo42IAcQiyFIkQ
ezNC1FGvlU6QobZVR8NCS2YG7WAg02VvHpwVL8Egmul/Ct0FYAuXxISMqYjLxSiE
8qNQUDdH4Wc5Xp3MuHfO
=0mts
-----END PGP SIGNATURE-----

--mjQieWmoo95fJlKoJokQYFTttmrDiB0Hs--

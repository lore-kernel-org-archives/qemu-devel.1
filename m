Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7517C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E410208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E410208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39333 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmDX-000317-PY
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:36:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlpu-000810-AI
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlps-0006Mu-4Y
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:12:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSlpr-0006M4-Sn; Mon, 20 May 2019 13:12:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85BAB3082B07;
	Mon, 20 May 2019 17:12:15 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AECBB2E16E;
	Mon, 20 May 2019 17:12:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:02:57 +0200
Message-Id: <20190520170302.13643-50-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 20 May 2019 17:12:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 49/54] s390x/cpumodel: msa9 facility
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
	David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Provide the MSA9 facility (stfle.155). This also contains pckmo
subfunctions for key wrapping. Keep them in a separate group to disable
those as a block if necessary. This is for example needed when disabling
key wrapping via the HMC.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20190429090250.7648-5-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features.c     | 32 +++++++++++++++++++++++++
 target/s390x/cpu_features.h     |  1 +
 target/s390x/cpu_features_def.h | 31 ++++++++++++++++++++++++
 target/s390x/cpu_models.c       |  2 ++
 target/s390x/gen-features.c     | 42 +++++++++++++++++++++++++++++++++
 target/s390x/kvm.c              |  6 +++++
 6 files changed, 114 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index bbd8902087d4..154e2bb354e7 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -108,6 +108,7 @@ static const S390FeatDef s390_features[] =3D {
     FEAT_INIT("irbm", S390_FEAT_TYPE_STFL, 145, "Insert-reference-bits-m=
ultiple facility"),
     FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-a=
ssist-extension-8 facility (excluding subfunctions)"),
     FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement =
(no translate) facility"),
+    FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-a=
ssist-extension-9 facility (excluding subfunctions)"),
     FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
=20
     /* SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
@@ -242,6 +243,11 @@ static const S390FeatDef s390_features[] =3D {
     FEAT_INIT("pckmo-aes-128", S390_FEAT_TYPE_PCKMO, 18, "PCKMO Encrypte=
d-AES-128-Key"),
     FEAT_INIT("pckmo-aes-192", S390_FEAT_TYPE_PCKMO, 19, "PCKMO Encrypte=
d-AES-192-Key"),
     FEAT_INIT("pckmo-aes-256", S390_FEAT_TYPE_PCKMO, 20, "PCKMO Encrypte=
d-AES-256-Key"),
+    FEAT_INIT("pckmo-ecc-p256", S390_FEAT_TYPE_PCKMO, 32, "PCKMO Encrypt=
-ECC-P256-Key"),
+    FEAT_INIT("pckmo-ecc-p384", S390_FEAT_TYPE_PCKMO, 33, "PCKMO Encrypt=
-ECC-P384-Key"),
+    FEAT_INIT("pckmo-ecc-p521", S390_FEAT_TYPE_PCKMO, 34, "PCKMO Encrypt=
-ECC-P521-Key"),
+    FEAT_INIT("pckmo-ecc-ed25519", S390_FEAT_TYPE_PCKMO, 40 , "PCKMO Enc=
rypt-ECC-Ed25519-Key"),
+    FEAT_INIT("pckmo-ecc-ed448", S390_FEAT_TYPE_PCKMO, 41 , "PCKMO Encry=
pt-ECC-Ed448-Key"),
=20
     FEAT_INIT("kmctr-dea", S390_FEAT_TYPE_KMCTR, 1, "KMCTR DEA"),
     FEAT_INIT("kmctr-tdea-128", S390_FEAT_TYPE_KMCTR, 2, "KMCTR TDEA-128=
"),
@@ -298,6 +304,13 @@ static const S390FeatDef s390_features[] =3D {
     FEAT_INIT("pcc-xts-aes-256", S390_FEAT_TYPE_PCC, 52, "PCC Compute-XT=
S-Parameter-Using-AES-256"),
     FEAT_INIT("pcc-xts-eaes-128", S390_FEAT_TYPE_PCC, 58, "PCC Compute-X=
TS-Parameter-Using-Encrypted-AES-128"),
     FEAT_INIT("pcc-xts-eaes-256", S390_FEAT_TYPE_PCC, 60, "PCC Compute-X=
TS-Parameter-Using-Encrypted-AES-256"),
+    FEAT_INIT("pcc-scalar-mult-p256", S390_FEAT_TYPE_PCC, 64, "PCC Scala=
r-Multiply-P256"),
+    FEAT_INIT("pcc-scalar-mult-p384", S390_FEAT_TYPE_PCC, 65, "PCC Scala=
r-Multiply-P384"),
+    FEAT_INIT("pcc-scalar-mult-p521", S390_FEAT_TYPE_PCC, 66, "PCC Scala=
r-Multiply-P521"),
+    FEAT_INIT("pcc-scalar-mult-ed25519", S390_FEAT_TYPE_PCC, 72, "PCC Sc=
alar-Multiply-Ed25519"),
+    FEAT_INIT("pcc-scalar-mult-ed448", S390_FEAT_TYPE_PCC, 73, "PCC Scal=
ar-Multiply-Ed448"),
+    FEAT_INIT("pcc-scalar-mult-x25519", S390_FEAT_TYPE_PCC, 80, "PCC Sca=
lar-Multiply-X25519"),
+    FEAT_INIT("pcc-scalar-mult-x448", S390_FEAT_TYPE_PCC, 81, "PCC Scala=
r-Multiply-X448"),
=20
     FEAT_INIT("ppno-sha-512-drng", S390_FEAT_TYPE_PPNO, 3, "PPNO SHA-512=
-DRNG"),
     FEAT_INIT("prno-trng-qrtcr", S390_FEAT_TYPE_PPNO, 112, "PRNO TRNG-Qu=
ery-Raw-to-Conditioned-Ratio"),
@@ -309,6 +322,22 @@ static const S390FeatDef s390_features[] =3D {
     FEAT_INIT("kma-gcm-eaes-128", S390_FEAT_TYPE_KMA, 26, "KMA GCM-Encry=
pted-AES-128"),
     FEAT_INIT("kma-gcm-eaes-192", S390_FEAT_TYPE_KMA, 27, "KMA GCM-Encry=
pted-AES-192"),
     FEAT_INIT("kma-gcm-eaes-256", S390_FEAT_TYPE_KMA, 28, "KMA GCM-Encry=
pted-AES-256"),
+
+    FEAT_INIT("kdsa-ecdsa-verify-p256", S390_FEAT_TYPE_KDSA, 1, "KDSA EC=
DSA-Verify-P256"),
+    FEAT_INIT("kdsa-ecdsa-verify-p384", S390_FEAT_TYPE_KDSA, 2, "KDSA EC=
DSA-Verify-P384"),
+    FEAT_INIT("kdsa-ecdsa-verify-p521", S390_FEAT_TYPE_KDSA, 3, "KDSA EC=
DSA-Verify-P521"),
+    FEAT_INIT("kdsa-ecdsa-sign-p256", S390_FEAT_TYPE_KDSA, 9, "KDSA ECDS=
A-Sign-P256"),
+    FEAT_INIT("kdsa-ecdsa-sign-p384", S390_FEAT_TYPE_KDSA, 10, "KDSA ECD=
SA-Sign-P384"),
+    FEAT_INIT("kdsa-ecdsa-sign-p521", S390_FEAT_TYPE_KDSA, 11, "KDSA ECD=
SA-Sign-P521"),
+    FEAT_INIT("kdsa-eecdsa-sign-p256", S390_FEAT_TYPE_KDSA, 17, "KDSA En=
crypted-ECDSA-Sign-P256"),
+    FEAT_INIT("kdsa-eecdsa-sign-p384", S390_FEAT_TYPE_KDSA, 18, "KDSA En=
crypted-ECDSA-Sign-P384"),
+    FEAT_INIT("kdsa-eecdsa-sign-p521", S390_FEAT_TYPE_KDSA, 19, "KDSA En=
crypted-ECDSA-Sign-P521"),
+    FEAT_INIT("kdsa-eddsa-verify-ed25519", S390_FEAT_TYPE_KDSA, 32, "KDS=
A EdDSA-Verify-Ed25519"),
+    FEAT_INIT("kdsa-eddsa-verify-ed448", S390_FEAT_TYPE_KDSA, 36, "KDSA =
EdDSA-Verify-Ed448"),
+    FEAT_INIT("kdsa-eddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 40, "KDSA =
EdDSA-Sign-Ed25519"),
+    FEAT_INIT("kdsa-eddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 44, "KDSA Ed=
DSA-Sign-Ed448"),
+    FEAT_INIT("kdsa-eeddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 48, "KDSA=
 Encrypted-EdDSA-Sign-Ed25519"),
+    FEAT_INIT("kdsa-eeddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 52, "KDSA E=
ncrypted-EdDSA-Sign-Ed448"),
 };
=20
 const S390FeatDef *s390_feat_def(S390Feat feat)
@@ -371,6 +400,7 @@ void s390_fill_feat_block(const S390FeatBitmap featur=
es, S390FeatType type,
     case S390_FEAT_TYPE_PCC:
     case S390_FEAT_TYPE_PPNO:
     case S390_FEAT_TYPE_KMA:
+    case S390_FEAT_TYPE_KDSA:
         set_be_bit(0, data); /* query is always available */
         break;
     default:
@@ -466,6 +496,8 @@ static S390FeatGroupDef s390_feature_groups[] =3D {
     FEAT_GROUP_INIT("msa6", MSA_EXT_6, "Message-security-assist-extensio=
n 6 facility"),
     FEAT_GROUP_INIT("msa7", MSA_EXT_7, "Message-security-assist-extensio=
n 7 facility"),
     FEAT_GROUP_INIT("msa8", MSA_EXT_8, "Message-security-assist-extensio=
n 8 facility"),
+    FEAT_GROUP_INIT("msa9", MSA_EXT_9, "Message-security-assist-extensio=
n 9 facility"),
+    FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-ass=
ist-extension 9 PCKMO subfunctions"),
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancement=
s introduced with Multiple-epoch facility"),
 };
=20
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index effe790271d9..5ffd3db083d4 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -39,6 +39,7 @@ typedef enum {
     S390_FEAT_TYPE_PCC,
     S390_FEAT_TYPE_PPNO,
     S390_FEAT_TYPE_KMA,
+    S390_FEAT_TYPE_KDSA,
 } S390FeatType;
=20
 /* Definition of a CPU feature */
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_=
def.h
index 31dd67830120..030784811bd6 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -96,6 +96,7 @@ typedef enum {
     S390_FEAT_INSERT_REFERENCE_BITS_MULT,
     S390_FEAT_MSA_EXT_8,
     S390_FEAT_CMM_NT,
+    S390_FEAT_MSA_EXT_9,
     S390_FEAT_ETOKEN,
=20
     /* Sclp Conf Char */
@@ -240,6 +241,11 @@ typedef enum {
     S390_FEAT_PCKMO_AES_128,
     S390_FEAT_PCKMO_AES_192,
     S390_FEAT_PCKMO_AES_256,
+    S390_FEAT_PCKMO_ECC_P256,
+    S390_FEAT_PCKMO_ECC_P384,
+    S390_FEAT_PCKMO_ECC_P521,
+    S390_FEAT_PCKMO_ECC_ED25519,
+    S390_FEAT_PCKMO_ECC_ED448,
=20
     /* KMCTR */
     S390_FEAT_KMCTR_DEA,
@@ -300,6 +306,13 @@ typedef enum {
     S390_FEAT_PCC_XTS_AES_256,
     S390_FEAT_PCC_XTS_EAES_128,
     S390_FEAT_PCC_XTS_EAES_256,
+    S390_FEAT_PCC_SCALAR_MULT_P256,
+    S390_FEAT_PCC_SCALAR_MULT_P384,
+    S390_FEAT_PCC_SCALAR_MULT_P512,
+    S390_FEAT_PCC_SCALAR_MULT_ED25519,
+    S390_FEAT_PCC_SCALAR_MULT_ED448,
+    S390_FEAT_PCC_SCALAR_MULT_X25519,
+    S390_FEAT_PCC_SCALAR_MULT_X448,
=20
     /* PPNO/PRNO */
     S390_FEAT_PPNO_SHA_512_DRNG,
@@ -313,6 +326,24 @@ typedef enum {
     S390_FEAT_KMA_GCM_EAES_128,
     S390_FEAT_KMA_GCM_EAES_192,
     S390_FEAT_KMA_GCM_EAES_256,
+
+    /* KDSA */
+    S390_FEAT_ECDSA_VERIFY_P256,
+    S390_FEAT_ECDSA_VERIFY_P384,
+    S390_FEAT_ECDSA_VERIFY_P512,
+    S390_FEAT_ECDSA_SIGN_P256,
+    S390_FEAT_ECDSA_SIGN_P384,
+    S390_FEAT_ECDSA_SIGN_P512,
+    S390_FEAT_EECDSA_SIGN_P256,
+    S390_FEAT_EECDSA_SIGN_P384,
+    S390_FEAT_EECDSA_SIGN_P512,
+    S390_FEAT_EDDSA_VERIFY_ED25519,
+    S390_FEAT_EDDSA_VERIFY_ED448,
+    S390_FEAT_EDDSA_SIGN_ED25519,
+    S390_FEAT_EDDSA_SIGN_ED448,
+    S390_FEAT_EEDDSA_SIGN_ED25519,
+    S390_FEAT_EEDDSA_SIGN_ED448,
+
     S390_FEAT_MAX,
 } S390Feat;
=20
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index b4bb5de6358e..d683635eb538 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -782,6 +782,8 @@ static void check_consistency(const S390CPUModel *mod=
el)
         { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
         { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
         { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_4 },
         { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
         { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
         { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index e4739a6b9f61..a2f9e2b43f74 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -213,6 +213,38 @@
     S390_FEAT_KMA_GCM_EAES_192, \
     S390_FEAT_KMA_GCM_EAES_256
=20
+#define S390_FEAT_GROUP_MSA_EXT_9 \
+    S390_FEAT_MSA_EXT_9, \
+    S390_FEAT_ECDSA_VERIFY_P256, \
+    S390_FEAT_ECDSA_VERIFY_P384, \
+    S390_FEAT_ECDSA_VERIFY_P512, \
+    S390_FEAT_ECDSA_SIGN_P256, \
+    S390_FEAT_ECDSA_SIGN_P384, \
+    S390_FEAT_ECDSA_SIGN_P512, \
+    S390_FEAT_EECDSA_SIGN_P256, \
+    S390_FEAT_EECDSA_SIGN_P384, \
+    S390_FEAT_EECDSA_SIGN_P512, \
+    S390_FEAT_EDDSA_VERIFY_ED25519, \
+    S390_FEAT_EDDSA_VERIFY_ED448, \
+    S390_FEAT_EDDSA_SIGN_ED25519, \
+    S390_FEAT_EDDSA_SIGN_ED448, \
+    S390_FEAT_EEDDSA_SIGN_ED25519, \
+    S390_FEAT_EEDDSA_SIGN_ED448, \
+    S390_FEAT_PCC_SCALAR_MULT_P256, \
+    S390_FEAT_PCC_SCALAR_MULT_P384, \
+    S390_FEAT_PCC_SCALAR_MULT_P512, \
+    S390_FEAT_PCC_SCALAR_MULT_ED25519, \
+    S390_FEAT_PCC_SCALAR_MULT_ED448, \
+    S390_FEAT_PCC_SCALAR_MULT_X25519, \
+    S390_FEAT_PCC_SCALAR_MULT_X448
+
+#define S390_FEAT_GROUP_MSA_EXT_9_PCKMO \
+    S390_FEAT_PCKMO_ECC_P256, \
+    S390_FEAT_PCKMO_ECC_P384, \
+    S390_FEAT_PCKMO_ECC_P521, \
+    S390_FEAT_PCKMO_ECC_ED25519, \
+    S390_FEAT_PCKMO_ECC_ED448
+
 /* cpu feature groups */
 static uint16_t group_PLO[] =3D {
     S390_FEAT_GROUP_PLO,
@@ -254,6 +286,14 @@ static uint16_t group_MSA_EXT_8[] =3D {
     S390_FEAT_GROUP_MSA_EXT_8,
 };
=20
+static uint16_t group_MSA_EXT_9[] =3D {
+    S390_FEAT_GROUP_MSA_EXT_9,
+};
+
+static uint16_t group_MSA_EXT_9_PCKMO[] =3D {
+    S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
+};
+
 /* Base features (in order of release)
  * Only non-hypervisor managed features belong here.
  * Base feature sets are static meaning they do not change in future QEM=
U
@@ -709,6 +749,8 @@ static FeatGroupDefSpec FeatGroupDef[] =3D {
     FEAT_GROUP_INITIALIZER(MSA_EXT_6),
     FEAT_GROUP_INITIALIZER(MSA_EXT_7),
     FEAT_GROUP_INITIALIZER(MSA_EXT_8),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_9),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
 };
=20
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 7df7be4a1bdc..de0b984b680e 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2073,6 +2073,9 @@ static int query_cpu_subfunc(S390FeatBitmap feature=
s)
     if (test_bit(S390_FEAT_MSA_EXT_8, features)) {
         s390_add_from_feat_block(features, S390_FEAT_TYPE_KMA, prop.kma)=
;
     }
+    if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
+        s390_add_from_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kds=
a);
+    }
     return 0;
 }
=20
@@ -2117,6 +2120,9 @@ static int configure_cpu_subfunc(const S390FeatBitm=
ap features)
     if (test_bit(S390_FEAT_MSA_EXT_8, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_KMA, prop.kma);
     }
+    if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
+        s390_fill_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kdsa);
+    }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
=20
--=20
2.20.1



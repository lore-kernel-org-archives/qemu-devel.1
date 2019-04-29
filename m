Received: from eggs.gnu.org ([209.51.188.92]:35658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hLBtW-0007t8-Gd
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 15:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hLBtU-0005Nx-K7
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 15:24:54 -0400
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
	<20190429090250.7648-5-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0ad32bcf-0132-3905-3220-0f50e26937c3@redhat.com>
Date: Mon, 29 Apr 2019 21:24:48 +0200
MIME-Version: 1.0
In-Reply-To: <20190429090250.7648-5-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/9] s390x/cpumodel: msa9 facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On 29.04.19 11:02, Christian Borntraeger wrote:
> Provide the MSA9 facility (stfle.155).
> This also contains pckmo functions for key wrapping. Keep them in a
> separate group to disable those as a block if necessary.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.c     | 32 +++++++++++++++++++++++++
>  target/s390x/cpu_features.h     |  1 +
>  target/s390x/cpu_features_def.h | 31 ++++++++++++++++++++++++
>  target/s390x/cpu_models.c       |  2 ++
>  target/s390x/gen-features.c     | 42 +++++++++++++++++++++++++++++++++
>  target/s390x/kvm.c              |  6 +++++
>  6 files changed, 114 insertions(+)
>=20
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index bbd8902087..154e2bb354 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -108,6 +108,7 @@ static const S390FeatDef s390_features[] =3D {
>      FEAT_INIT("irbm", S390_FEAT_TYPE_STFL, 145, "Insert-reference-bits=
-multiple facility"),
>      FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security=
-assist-extension-8 facility (excluding subfunctions)"),
>      FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancemen=
t (no translate) facility"),
> +    FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security=
-assist-extension-9 facility (excluding subfunctions)"),
>      FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
> =20
>      /* SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
> @@ -242,6 +243,11 @@ static const S390FeatDef s390_features[] =3D {
>      FEAT_INIT("pckmo-aes-128", S390_FEAT_TYPE_PCKMO, 18, "PCKMO Encryp=
ted-AES-128-Key"),
>      FEAT_INIT("pckmo-aes-192", S390_FEAT_TYPE_PCKMO, 19, "PCKMO Encryp=
ted-AES-192-Key"),
>      FEAT_INIT("pckmo-aes-256", S390_FEAT_TYPE_PCKMO, 20, "PCKMO Encryp=
ted-AES-256-Key"),
> +    FEAT_INIT("pckmo-ecc-p256", S390_FEAT_TYPE_PCKMO, 32, "PCKMO Encry=
pt-ECC-P256-Key"),
> +    FEAT_INIT("pckmo-ecc-p384", S390_FEAT_TYPE_PCKMO, 33, "PCKMO Encry=
pt-ECC-P384-Key"),
> +    FEAT_INIT("pckmo-ecc-p521", S390_FEAT_TYPE_PCKMO, 34, "PCKMO Encry=
pt-ECC-P521-Key"),
> +    FEAT_INIT("pckmo-ecc-ed25519", S390_FEAT_TYPE_PCKMO, 40 , "PCKMO E=
ncrypt-ECC-Ed25519-Key"),
> +    FEAT_INIT("pckmo-ecc-ed448", S390_FEAT_TYPE_PCKMO, 41 , "PCKMO Enc=
rypt-ECC-Ed448-Key"),
> =20
>      FEAT_INIT("kmctr-dea", S390_FEAT_TYPE_KMCTR, 1, "KMCTR DEA"),
>      FEAT_INIT("kmctr-tdea-128", S390_FEAT_TYPE_KMCTR, 2, "KMCTR TDEA-1=
28"),
> @@ -298,6 +304,13 @@ static const S390FeatDef s390_features[] =3D {
>      FEAT_INIT("pcc-xts-aes-256", S390_FEAT_TYPE_PCC, 52, "PCC Compute-=
XTS-Parameter-Using-AES-256"),
>      FEAT_INIT("pcc-xts-eaes-128", S390_FEAT_TYPE_PCC, 58, "PCC Compute=
-XTS-Parameter-Using-Encrypted-AES-128"),
>      FEAT_INIT("pcc-xts-eaes-256", S390_FEAT_TYPE_PCC, 60, "PCC Compute=
-XTS-Parameter-Using-Encrypted-AES-256"),
> +    FEAT_INIT("pcc-scalar-mult-p256", S390_FEAT_TYPE_PCC, 64, "PCC Sca=
lar-Multiply-P256"),
> +    FEAT_INIT("pcc-scalar-mult-p384", S390_FEAT_TYPE_PCC, 65, "PCC Sca=
lar-Multiply-P384"),
> +    FEAT_INIT("pcc-scalar-mult-p521", S390_FEAT_TYPE_PCC, 66, "PCC Sca=
lar-Multiply-P521"),
> +    FEAT_INIT("pcc-scalar-mult-ed25519", S390_FEAT_TYPE_PCC, 72, "PCC =
Scalar-Multiply-Ed25519"),
> +    FEAT_INIT("pcc-scalar-mult-ed448", S390_FEAT_TYPE_PCC, 73, "PCC Sc=
alar-Multiply-Ed448"),
> +    FEAT_INIT("pcc-scalar-mult-x25519", S390_FEAT_TYPE_PCC, 80, "PCC S=
calar-Multiply-X25519"),
> +    FEAT_INIT("pcc-scalar-mult-x448", S390_FEAT_TYPE_PCC, 81, "PCC Sca=
lar-Multiply-X448"),
> =20
>      FEAT_INIT("ppno-sha-512-drng", S390_FEAT_TYPE_PPNO, 3, "PPNO SHA-5=
12-DRNG"),
>      FEAT_INIT("prno-trng-qrtcr", S390_FEAT_TYPE_PPNO, 112, "PRNO TRNG-=
Query-Raw-to-Conditioned-Ratio"),
> @@ -309,6 +322,22 @@ static const S390FeatDef s390_features[] =3D {
>      FEAT_INIT("kma-gcm-eaes-128", S390_FEAT_TYPE_KMA, 26, "KMA GCM-Enc=
rypted-AES-128"),
>      FEAT_INIT("kma-gcm-eaes-192", S390_FEAT_TYPE_KMA, 27, "KMA GCM-Enc=
rypted-AES-192"),
>      FEAT_INIT("kma-gcm-eaes-256", S390_FEAT_TYPE_KMA, 28, "KMA GCM-Enc=
rypted-AES-256"),
> +
> +    FEAT_INIT("kdsa-ecdsa-verify-p256", S390_FEAT_TYPE_KDSA, 1, "KDSA =
ECDSA-Verify-P256"),
> +    FEAT_INIT("kdsa-ecdsa-verify-p384", S390_FEAT_TYPE_KDSA, 2, "KDSA =
ECDSA-Verify-P384"),
> +    FEAT_INIT("kdsa-ecdsa-verify-p521", S390_FEAT_TYPE_KDSA, 3, "KDSA =
ECDSA-Verify-P521"),
> +    FEAT_INIT("kdsa-ecdsa-sign-p256", S390_FEAT_TYPE_KDSA, 9, "KDSA EC=
DSA-Sign-P256"),
> +    FEAT_INIT("kdsa-ecdsa-sign-p384", S390_FEAT_TYPE_KDSA, 10, "KDSA E=
CDSA-Sign-P384"),
> +    FEAT_INIT("kdsa-ecdsa-sign-p521", S390_FEAT_TYPE_KDSA, 11, "KDSA E=
CDSA-Sign-P521"),
> +    FEAT_INIT("kdsa-eecdsa-sign-p256", S390_FEAT_TYPE_KDSA, 17, "KDSA =
Encrypted-ECDSA-Sign-P256"),
> +    FEAT_INIT("kdsa-eecdsa-sign-p384", S390_FEAT_TYPE_KDSA, 18, "KDSA =
Encrypted-ECDSA-Sign-P384"),
> +    FEAT_INIT("kdsa-eecdsa-sign-p521", S390_FEAT_TYPE_KDSA, 19, "KDSA =
Encrypted-ECDSA-Sign-P521"),
> +    FEAT_INIT("kdsa-eddsa-verify-ed25519", S390_FEAT_TYPE_KDSA, 32, "K=
DSA EdDSA-Verify-Ed25519"),
> +    FEAT_INIT("kdsa-eddsa-verify-ed448", S390_FEAT_TYPE_KDSA, 36, "KDS=
A EdDSA-Verify-Ed448"),
> +    FEAT_INIT("kdsa-eddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 40, "KDS=
A EdDSA-Sign-Ed25519"),
> +    FEAT_INIT("kdsa-eddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 44, "KDSA =
EdDSA-Sign-Ed448"),
> +    FEAT_INIT("kdsa-eeddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 48, "KD=
SA Encrypted-EdDSA-Sign-Ed25519"),
> +    FEAT_INIT("kdsa-eeddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 52, "KDSA=
 Encrypted-EdDSA-Sign-Ed448"),
>  };
> =20
>  const S390FeatDef *s390_feat_def(S390Feat feat)
> @@ -371,6 +400,7 @@ void s390_fill_feat_block(const S390FeatBitmap feat=
ures, S390FeatType type,
>      case S390_FEAT_TYPE_PCC:
>      case S390_FEAT_TYPE_PPNO:
>      case S390_FEAT_TYPE_KMA:
> +    case S390_FEAT_TYPE_KDSA:
>          set_be_bit(0, data); /* query is always available */
>          break;
>      default:
> @@ -466,6 +496,8 @@ static S390FeatGroupDef s390_feature_groups[] =3D {
>      FEAT_GROUP_INIT("msa6", MSA_EXT_6, "Message-security-assist-extens=
ion 6 facility"),
>      FEAT_GROUP_INIT("msa7", MSA_EXT_7, "Message-security-assist-extens=
ion 7 facility"),
>      FEAT_GROUP_INIT("msa8", MSA_EXT_8, "Message-security-assist-extens=
ion 8 facility"),
> +    FEAT_GROUP_INIT("msa9", MSA_EXT_9, "Message-security-assist-extens=
ion 9 facility"),
> +    FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-a=
ssist-extension 9 PCKMO subfunctions"),
>      FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhanceme=
nts introduced with Multiple-epoch facility"),
>  };
> =20
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index effe790271..5ffd3db083 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -39,6 +39,7 @@ typedef enum {
>      S390_FEAT_TYPE_PCC,
>      S390_FEAT_TYPE_PPNO,
>      S390_FEAT_TYPE_KMA,
> +    S390_FEAT_TYPE_KDSA,
>  } S390FeatType;
> =20
>  /* Definition of a CPU feature */
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_feature=
s_def.h
> index 31dd678301..030784811b 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -96,6 +96,7 @@ typedef enum {
>      S390_FEAT_INSERT_REFERENCE_BITS_MULT,
>      S390_FEAT_MSA_EXT_8,
>      S390_FEAT_CMM_NT,
> +    S390_FEAT_MSA_EXT_9,
>      S390_FEAT_ETOKEN,
> =20
>      /* Sclp Conf Char */
> @@ -240,6 +241,11 @@ typedef enum {
>      S390_FEAT_PCKMO_AES_128,
>      S390_FEAT_PCKMO_AES_192,
>      S390_FEAT_PCKMO_AES_256,
> +    S390_FEAT_PCKMO_ECC_P256,
> +    S390_FEAT_PCKMO_ECC_P384,
> +    S390_FEAT_PCKMO_ECC_P521,
> +    S390_FEAT_PCKMO_ECC_ED25519,
> +    S390_FEAT_PCKMO_ECC_ED448,
> =20
>      /* KMCTR */
>      S390_FEAT_KMCTR_DEA,
> @@ -300,6 +306,13 @@ typedef enum {
>      S390_FEAT_PCC_XTS_AES_256,
>      S390_FEAT_PCC_XTS_EAES_128,
>      S390_FEAT_PCC_XTS_EAES_256,
> +    S390_FEAT_PCC_SCALAR_MULT_P256,
> +    S390_FEAT_PCC_SCALAR_MULT_P384,
> +    S390_FEAT_PCC_SCALAR_MULT_P512,
> +    S390_FEAT_PCC_SCALAR_MULT_ED25519,
> +    S390_FEAT_PCC_SCALAR_MULT_ED448,
> +    S390_FEAT_PCC_SCALAR_MULT_X25519,
> +    S390_FEAT_PCC_SCALAR_MULT_X448,
> =20
>      /* PPNO/PRNO */
>      S390_FEAT_PPNO_SHA_512_DRNG,
> @@ -313,6 +326,24 @@ typedef enum {
>      S390_FEAT_KMA_GCM_EAES_128,
>      S390_FEAT_KMA_GCM_EAES_192,
>      S390_FEAT_KMA_GCM_EAES_256,
> +
> +    /* KDSA */
> +    S390_FEAT_ECDSA_VERIFY_P256,
> +    S390_FEAT_ECDSA_VERIFY_P384,
> +    S390_FEAT_ECDSA_VERIFY_P512,
> +    S390_FEAT_ECDSA_SIGN_P256,
> +    S390_FEAT_ECDSA_SIGN_P384,
> +    S390_FEAT_ECDSA_SIGN_P512,
> +    S390_FEAT_EECDSA_SIGN_P256,
> +    S390_FEAT_EECDSA_SIGN_P384,
> +    S390_FEAT_EECDSA_SIGN_P512,
> +    S390_FEAT_EDDSA_VERIFY_ED25519,
> +    S390_FEAT_EDDSA_VERIFY_ED448,
> +    S390_FEAT_EDDSA_SIGN_ED25519,
> +    S390_FEAT_EDDSA_SIGN_ED448,
> +    S390_FEAT_EEDDSA_SIGN_ED25519,
> +    S390_FEAT_EEDDSA_SIGN_ED448,
> +
>      S390_FEAT_MAX,
>  } S390Feat;
> =20
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index b4bb5de635..d683635eb5 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -782,6 +782,8 @@ static void check_consistency(const S390CPUModel *m=
odel)
>          { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
>          { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
>          { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
> +        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },
> +        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_4 },
>          { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
>          { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
>          { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index e4739a6b9f..a2f9e2b43f 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -213,6 +213,38 @@
>      S390_FEAT_KMA_GCM_EAES_192, \
>      S390_FEAT_KMA_GCM_EAES_256
> =20
> +#define S390_FEAT_GROUP_MSA_EXT_9 \
> +    S390_FEAT_MSA_EXT_9, \
> +    S390_FEAT_ECDSA_VERIFY_P256, \
> +    S390_FEAT_ECDSA_VERIFY_P384, \
> +    S390_FEAT_ECDSA_VERIFY_P512, \
> +    S390_FEAT_ECDSA_SIGN_P256, \
> +    S390_FEAT_ECDSA_SIGN_P384, \
> +    S390_FEAT_ECDSA_SIGN_P512, \
> +    S390_FEAT_EECDSA_SIGN_P256, \
> +    S390_FEAT_EECDSA_SIGN_P384, \
> +    S390_FEAT_EECDSA_SIGN_P512, \
> +    S390_FEAT_EDDSA_VERIFY_ED25519, \
> +    S390_FEAT_EDDSA_VERIFY_ED448, \
> +    S390_FEAT_EDDSA_SIGN_ED25519, \
> +    S390_FEAT_EDDSA_SIGN_ED448, \
> +    S390_FEAT_EEDDSA_SIGN_ED25519, \
> +    S390_FEAT_EEDDSA_SIGN_ED448, \
> +    S390_FEAT_PCC_SCALAR_MULT_P256, \
> +    S390_FEAT_PCC_SCALAR_MULT_P384, \
> +    S390_FEAT_PCC_SCALAR_MULT_P512, \
> +    S390_FEAT_PCC_SCALAR_MULT_ED25519, \
> +    S390_FEAT_PCC_SCALAR_MULT_ED448, \
> +    S390_FEAT_PCC_SCALAR_MULT_X25519, \
> +    S390_FEAT_PCC_SCALAR_MULT_X448
> +
> +#define S390_FEAT_GROUP_MSA_EXT_9_PCKMO \
> +    S390_FEAT_PCKMO_ECC_P256, \
> +    S390_FEAT_PCKMO_ECC_P384, \
> +    S390_FEAT_PCKMO_ECC_P521, \
> +    S390_FEAT_PCKMO_ECC_ED25519, \
> +    S390_FEAT_PCKMO_ECC_ED448
> +

Just wondering, why keep the PCKMO ones separate, but not e.g. PCC ?

Many subfunctions, luckily we have feature groups.

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD19C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632C720833
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632C720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaeU0-0005VC-JI
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iaeIo-0006bs-1V
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iaeIk-000177-LO
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:19:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51792
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iaeIk-0000tv-Fz
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:19:06 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xATBCV2V026044
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:19:02 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wjxay881n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:19:02 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 29 Nov 2019 11:19:00 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 11:18:58 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xATBIv9j53477542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 11:18:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AD794203F;
 Fri, 29 Nov 2019 11:18:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DEB142047;
 Fri, 29 Nov 2019 11:18:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.188.128])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 11:18:56 +0000 (GMT)
Subject: Re: [PATCH v2 01/13] s390x: protvirt: Add diag308 subcodes 8 - 10
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-2-frankja@linux.ibm.com>
 <d12fe27e-fcce-1704-8ac3-5dca18627422@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 29 Nov 2019 12:18:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d12fe27e-fcce-1704-8ac3-5dca18627422@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H1oTA8pp0J7Umb5HRe4KzVdTbEwlDM3it"
X-TM-AS-GCONF: 00
x-cbid: 19112911-0020-0000-0000-000003909961
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112911-0021-0000-0000-000021E7AB62
Message-Id: <46d14db9-f7cc-adce-df1c-d35cd26dc546@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_03:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H1oTA8pp0J7Umb5HRe4KzVdTbEwlDM3it
Content-Type: multipart/mixed; boundary="1H4aYY9JANUUV0NyNvBZG5uuwtjFk4SM2"

--1H4aYY9JANUUV0NyNvBZG5uuwtjFk4SM2
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/29/19 11:09 AM, David Hildenbrand wrote:
> [...]
>> =20
>> +struct IPLBlockPVComp {
>> +    uint64_t tweak_pref;
>> +    uint64_t addr;
>> +    uint64_t size;
>> +} QEMU_PACKED;
>=20
> QEMU_PACKED  should not be needed.
>=20
>> +typedef struct IPLBlockPVComp IPLBlockPVComp;
>> +
>> +struct IPLBlockPV {
>> +    uint8_t  reserved[84];
>=20
> "reserved0"
>=20
>> +    uint8_t  reserved67[3];
>=20
> Where does that magic 67 come from? (84 dec is 54 hex)
>=20
>> +    uint8_t  version;
>=20
> So, to this point we spent 88 bytes =3D=3D 11 * uint64_t.

I'll have a look

>=20
>> +    uint32_t num_comp;
>=20
> ... so after this, all uint64_t (and components) are mis-aligned by
> 32bit - is that correct?
>=20
>> +    uint64_t pv_header_addr;
>> +    uint64_t pv_header_len;
>> +    struct IPLBlockPVComp components[];
>> +} QEMU_PACKED;
>> +typedef struct IPLBlockPV IPLBlockPV;
>> +
>>  struct IplBlockCcw {
>>      uint8_t  reserved0[85];
>>      uint8_t  ssid;
>> @@ -71,6 +89,7 @@ union IplParameterBlock {
>>          union {
>>              IplBlockCcw ccw;
>>              IplBlockFcp fcp;
>> +            IPLBlockPV pv;
>>              IplBlockQemuScsi scsi;
>>          };
>>      } QEMU_PACKED;
>> @@ -84,9 +103,11 @@ union IplParameterBlock {
>>  typedef union IplParameterBlock IplParameterBlock;
>> =20
>>  int s390_ipl_set_loadparm(uint8_t *loadparm);
>> +int s390_ipl_pv_check_comp(IplParameterBlock *iplb);
>>  void s390_ipl_update_diag308(IplParameterBlock *iplb);
>>  void s390_ipl_prepare_cpu(S390CPU *cpu);
>>  IplParameterBlock *s390_ipl_get_iplb(void);
>> +IplParameterBlock *s390_ipl_get_iplb_secure(void);
>> =20
>>  enum s390_reset {
>>      /* default is a reset not triggered by a CPU e.g. issued by QMP *=
/
>> @@ -94,6 +115,7 @@ enum s390_reset {
>>      S390_RESET_REIPL,
>>      S390_RESET_MODIFIED_CLEAR,
>>      S390_RESET_LOAD_NORMAL,
>> +    S390_RESET_PV,
>=20
> I do wonder if that should be called S390_RESET_PV_START

I have no strong feelings for the name, whatever floats you boat(s)

>=20
>>  };
>>  void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)=
;
>>  void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset=
_type);
>> @@ -133,6 +155,7 @@ struct S390IPLState {
>>      /*< private >*/
>>      DeviceState parent_obj;
>>      IplParameterBlock iplb;
>> +    IplParameterBlock iplb_pbt5;
>>      QemuIplParameters qipl;
>>      uint64_t start_addr;
>>      uint64_t compat_start_addr;
>> @@ -140,6 +163,7 @@ struct S390IPLState {
>>      uint64_t compat_bios_start_addr;
>>      bool enforce_bios;
>>      bool iplb_valid;
>> +    bool iplb_valid_pbt5;
>>      bool netboot;
>>      /* reset related properties don't have to be migrated or reset */=

>>      enum s390_reset reset_type;
>> @@ -161,9 +185,11 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) &=
 3, "alignment of iplb wrong");
>> =20
>>  #define S390_IPL_TYPE_FCP 0x00
>>  #define S390_IPL_TYPE_CCW 0x02
>> +#define S390_IPL_TYPE_PV 0x05
>>  #define S390_IPL_TYPE_QEMU_SCSI 0xff
>> =20
>>  #define S390_IPLB_HEADER_LEN 8
>> +#define S390_IPLB_MIN_PV_LEN 148
>>  #define S390_IPLB_MIN_CCW_LEN 200
>>  #define S390_IPLB_MIN_FCP_LEN 384
>>  #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
>> @@ -185,4 +211,11 @@ static inline bool iplb_valid_fcp(IplParameterBlo=
ck *iplb)
>>             iplb->pbt =3D=3D S390_IPL_TYPE_FCP;
>>  }
>> =20
>> +static inline bool iplb_valid_se(IplParameterBlock *iplb)
>=20
> s/_se/_pv/ ? Or was that intended?

Not intended, the rename in the middle of the project took some tolls.

>=20
>> +{
>> +    return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_PV_LEN &&
>> +           iplb->pbt =3D=3D S390_IPL_TYPE_PV;
>> +}
>> +
>> +
>=20
> Maybe drop one empty line

Sure

>=20
>>  #endif
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index b5aec06d6b..112a6c92e0 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
> [...]
>=20
>=20



--1H4aYY9JANUUV0NyNvBZG5uuwtjFk4SM2--

--H1oTA8pp0J7Umb5HRe4KzVdTbEwlDM3it
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIxBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3g/qAACgkQ41TmuOI4
ufgLTw/vVxVKDStyESyNApEx5hRAymKZwa2Rlv2YC0Lv25j3HK0gZ5/Dv2j74HD7
MfeKfSH9IMe6WogBowRAGfNbca/2HliSsEOU9vGUk3uRbmwdzI3nOFxyvkEcIMbm
P/giP/Q0Xq0RWXBEuVmN6y1MVlhnS/uvn/r6m5vHlzkTI7d5AosX+9mHlqGE9cDJ
G60Prxfk9AwvuvnxArM/DNFHvs6VqQ4vYBb8sp5nDAPKKhyIOW2ZFf3lRuZK5Ue0
QkyBTN5HE2EP8BNz66rjRQjdxWj86JASl8V7UIixfpg5ZX0jSzLEFmQQniobXgKx
7q1qKcUWX5nspIuvEZ8dJ+ksVAuA/bHZQVPBfaYscyJpeKJtaHHy1CDxehEdF+Om
tD2jwxNDOdZJBhIhJLK9IZK8/d+0VnaJWtsmFFaqCkk6DpJtItiaLm/3AVdrDVMX
nKf6Yz56H3mZjNY2jzSPLI47S7tQF+poSvztJYxjWyXO1GdI4+RzCOHA/vKRk2JO
z+dOt+IpIkRKMzdIEmLNaLraWmhIIATR4ctsw87lY3Em0cNCNQ5UPdKixgzCjEZp
s2PTSfgzwuxTArOYo9vvrkS/d33yvaxpncMpcdzTMdKUZPw9imumufZC+o5TEs5i
vEmdE2xbE6vdFyFYEHCphiuffIw3szQOtL7efy/EUoBt9QHg
=g7ah
-----END PGP SIGNATURE-----

--H1oTA8pp0J7Umb5HRe4KzVdTbEwlDM3it--



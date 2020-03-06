Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E8CC10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB932072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB932072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9mi-0000jn-Mb
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:00:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jA9lr-0000GJ-8h
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jA9lp-0000fm-Cw
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:59:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jA9lp-0008Ua-2g
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:59:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0269o8cO077159
 for <qemu-devel@nongnu.org>; Fri, 6 Mar 2020 04:59:35 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhryfvehr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 04:59:34 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 6 Mar 2020 09:59:32 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 6 Mar 2020 09:59:29 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0269xTrb57081900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2020 09:59:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0B1D4C04A;
 Fri,  6 Mar 2020 09:59:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 982DD4C044;
 Fri,  6 Mar 2020 09:59:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.37.7])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2020 09:59:28 +0000 (GMT)
Subject: Re: [PATCH v6 02/18] s390x: protvirt: Add diag308 subcodes 8 - 10
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-3-frankja@linux.ibm.com>
 <e6247adf-32c6-09a8-7243-b1a4b8274094@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 6 Mar 2020 10:59:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e6247adf-32c6-09a8-7243-b1a4b8274094@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5RdtzIn7xZfKIAUT0Ja7172uCV2rALsQQ"
X-TM-AS-GCONF: 00
x-cbid: 20030609-0020-0000-0000-000003B107DA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030609-0021-0000-0000-000022094791
Message-Id: <9af18035-df37-5a7a-f4f8-b5ba5f2ad4b0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-06_02:2020-03-05,
 2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=2 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060070
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5RdtzIn7xZfKIAUT0Ja7172uCV2rALsQQ
Content-Type: multipart/mixed; boundary="F9qQOvQFy1PqJDdGAgMGlx8fYNu626zCW"

--F9qQOvQFy1PqJDdGAgMGlx8fYNu626zCW
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/4/20 6:06 PM, David Hildenbrand wrote:
> On 04.03.20 12:42, Janosch Frank wrote:
>> For diag308 subcodes 8 - 10 we have a new ipib of type 5. The ipib
>> holds the address and length of the secure execution header, as well
>> as a list of guest components.
>>
>> Each component is a block of memory, for example kernel or initrd,
>> which needs to be decrypted by the Ultravisor in order to run a
>> protected VM. The secure execution header instructs the Ultravisor on
>> how to handle the protected VM and its components.
>>
>> Subcodes 8 and 9 are similiar to 5 and 6 and subcode 10 will finally
>> start the protected guest.
>>
>> Subcodes 8-10 are not valid in protected mode, we have to do a subcode=

>> 3 and then the 8 and 10 combination for a protected reboot.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/ipl.c      | 47 ++++++++++++++++++++++++++++++++++++++++++--=
-
>>  hw/s390x/ipl.h      | 32 ++++++++++++++++++++++++++++++
>>  target/s390x/diag.c | 26 ++++++++++++++++++++++---
>>  3 files changed, 99 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 9c1ecd423c..80c6ab233a 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -538,15 +538,55 @@ static bool is_virtio_scsi_device(IplParameterBl=
ock *iplb)
>>      return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
>>  }
>> =20
>> +int s390_ipl_pv_check_components(IplParameterBlock *iplb)
>> +{
>> +    int i;
>> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
>> +
>> +    if (ipib_pv->num_comp =3D=3D 0) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
>> +        /* Addr must be 4k aligned */
>> +        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
>> +            return -EINVAL;
>> +        }
>> +
>> +        /* Tweak prefix is monotonously increasing with each componen=
t */
>> +        if (i < ipib_pv->num_comp - 1 &&
>> +            ipib_pv->components[i].tweak_pref >
>> +            ipib_pv->components[i + 1].tweak_pref) {
>> +            return -EINVAL;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>>  void s390_ipl_update_diag308(IplParameterBlock *iplb)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> =20
>> -    ipl->iplb =3D *iplb;
>> -    ipl->iplb_valid =3D true;
>> +    if (iplb->pbt =3D=3D S390_IPL_TYPE_PV) {
>> +        ipl->iplb_pv =3D *iplb;
>> +        ipl->iplb_valid_pv =3D true;
>> +    } else {
>> +        ipl->iplb =3D *iplb;
>> +        ipl->iplb_valid =3D true;
>> +    }
>>      ipl->netboot =3D is_virtio_net_device(iplb);
>>  }
>> =20
>> +IplParameterBlock *s390_ipl_get_iplb_secure(void)
>> +{
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +
>> +    if (!ipl->iplb_valid_pv) {
>> +        return NULL;
>> +    }
>> +    return &ipl->iplb_pv;
>> +}
>> +
>>  IplParameterBlock *s390_ipl_get_iplb(void)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> @@ -561,7 +601,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s39=
0_reset reset_type)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> =20
>> -    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S3=
90_RESET_REIPL) {
>> +    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S3=
90_RESET_REIPL ||
>> +        reset_type =3D=3D S390_RESET_PV) {
>>          /* use CPU 0 for full resets */
>>          ipl->reset_cpu_index =3D 0;
>>      } else {
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index d4813105db..04be63cee1 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -15,6 +15,24 @@
>>  #include "cpu.h"
>>  #include "hw/qdev-core.h"
>> =20
>> +struct IPLBlockPVComp {
>> +    uint64_t tweak_pref;
>> +    uint64_t addr;
>> +    uint64_t size;
>> +} QEMU_PACKED;
>> +typedef struct IPLBlockPVComp IPLBlockPVComp;
>> +
>> +struct IPLBlockPV {
>> +    uint8_t  reserved[87];
>> +    uint8_t  version;
>> +    uint32_t reserved70;
>> +    uint32_t num_comp;
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
>> +int s390_ipl_pv_check_components(IplParameterBlock *iplb);
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
>>  };
>>  void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)=
;
>>  void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset=
_type);
>> @@ -133,6 +155,7 @@ struct S390IPLState {
>>      /*< private >*/
>>      DeviceState parent_obj;
>>      IplParameterBlock iplb;
>> +    IplParameterBlock iplb_pv;
>>      QemuIplParameters qipl;
>>      uint64_t start_addr;
>>      uint64_t compat_start_addr;
>> @@ -140,6 +163,7 @@ struct S390IPLState {
>>      uint64_t compat_bios_start_addr;
>>      bool enforce_bios;
>>      bool iplb_valid;
>> +    bool iplb_valid_pv;
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
>> @@ -185,4 +211,10 @@ static inline bool iplb_valid_fcp(IplParameterBlo=
ck *iplb)
>>             iplb->pbt =3D=3D S390_IPL_TYPE_FCP;
>>  }
>> =20
>> +static inline bool iplb_valid_pv(IplParameterBlock *iplb)
>> +{
>> +    return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_PV_LEN &&
>> +           iplb->pbt =3D=3D S390_IPL_TYPE_PV;
>> +}
>> +
>>  #endif
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index b5aec06d6b..945b263f0a 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -52,6 +52,7 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1,=
 uint64_t r3)
>>  #define DIAG_308_RC_OK              0x0001
>>  #define DIAG_308_RC_NO_CONF         0x0102
>>  #define DIAG_308_RC_INVALID         0x0402
>> +#define DIAG_308_RC_NO_PV_CONF      0x0902
>> =20
>>  #define DIAG308_RESET_MOD_CLR       0
>>  #define DIAG308_RESET_LOAD_NORM     1
>> @@ -59,6 +60,9 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1,=
 uint64_t r3)
>>  #define DIAG308_LOAD_NORMAL_DUMP    4
>>  #define DIAG308_SET                 5
>>  #define DIAG308_STORE               6
>> +#define DIAG308_PV_SET              8
>> +#define DIAG308_PV_STORE            9
>> +#define DIAG308_PV_START            10
>> =20
>>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64=
_t addr,
>>                                uintptr_t ra, bool write)
>> @@ -105,6 +109,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t =
r1, uint64_t r3, uintptr_t ra)
>>          s390_ipl_reset_request(cs, S390_RESET_REIPL);
>>          break;
>>      case DIAG308_SET:
>> +    case DIAG308_PV_SET:
>>          if (diag308_parm_check(env, r1, addr, ra, false)) {
>>              return;
>>          }
>> @@ -117,7 +122,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t =
r1, uint64_t r3, uintptr_t ra)
>> =20
>>          cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));=

>> =20
>> -        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
>> +        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
>> +            !(iplb_valid_pv(iplb) && !s390_ipl_pv_check_components(ip=
lb))) {
>>              env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
>>              goto out;
>>          }
>> @@ -128,17 +134,31 @@ out:
>>          g_free(iplb);
>>          return;
>>      case DIAG308_STORE:
>> +    case DIAG308_PV_STORE:
>>          if (diag308_parm_check(env, r1, addr, ra, true)) {
>>              return;
>>          }
>> -        iplb =3D s390_ipl_get_iplb();
>> +        if (subcode =3D=3D DIAG308_PV_STORE) {
>> +            iplb =3D s390_ipl_get_iplb_secure();
>> +        } else {
>> +            iplb =3D s390_ipl_get_iplb();
>> +        }
>>          if (iplb) {
>>              cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->l=
en));
>>              env->regs[r1 + 1] =3D DIAG_308_RC_OK;
>>          } else {
>>              env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
>>          }
>> -        return;
>> +        break;
>> +    case DIAG308_PV_START:
>> +        iplb =3D s390_ipl_get_iplb_secure();
>> +        if (!iplb || !iplb_valid_pv(iplb)) {
>> +            env->regs[r1 + 1] =3D DIAG_308_RC_NO_PV_CONF;
>> +            return;
>> +        }
>> +
>> +        s390_ipl_reset_request(cs, S390_RESET_PV);
>> +        break;
>>      default:
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>          break;
>>
>=20
> Sorry, another comment. The new subcodes should be fenced via the cpu
> model or similar. Applying this patch and triggering one of these
> subcodes will end in a questionable state.
>=20

Ahh, yes, we removed the KVM check for this.
Will add.


--F9qQOvQFy1PqJDdGAgMGlx8fYNu626zCW--

--5RdtzIn7xZfKIAUT0Ja7172uCV2rALsQQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5iHwAACgkQ41TmuOI4
ufhJHRAAsunbCrejx8GH1tfMttCorJ5wp4ipSHoYcDB58kLJr66taEfqvSY+J11I
N8qOOFzfnzfaLzixBrkDC0qLhiJXVTZseZ7rNWRfqr0ee8l8qiiE/jLXkrYDhPaK
fIobK77dbiI9XRNCvPrSgIxOpBhOnEm+AaNqN85VjqyxStKJhjiwZv3MFrjb9WZi
50nsfqvr7/a4szc6wtNiS2zAmLtWTDL+IIuiaudL2wcHbHkuGTTg/A1cVp2fak7P
AO3XjWqkXwZqzI0jLcpRBTCFn7a+BZU9ywKlJzjdZkamahEkuS5lgdJHLAFfx4pV
CXr+6amfQSGEWayWCW6oeiC3LCJaNHFdZx1roF1IT4JiZAFY9G3WKk0esgJ9SbY4
53pFDnEf/YU61pKYQkI/fadj8T3CoaXWc3eZPVnuRW8H/gBqUce3FENtxZtPMnLa
qUuHfy+wChlvZfWLl0S29XEShqQaiEun167QCRuuIqligKMQxHxmol5w39W8iQrX
T4tuFdKfSx+Sz/DkhCr3yYpGexfSShKGPRvRudGZrhMQfF+ajEfa/C/kfFCA4tcP
GY7084q73GIdRDWh85kjIYaq3fIcioQcAenbuaMH5FbANQ8WDTHOMUPqK9KPk+Df
+v1eVLrzwq/GPwJGjuivtCBm0//RVKh6tDiI4T+EKTvqhBZvqVI=
=GLp+
-----END PGP SIGNATURE-----

--5RdtzIn7xZfKIAUT0Ja7172uCV2rALsQQ--



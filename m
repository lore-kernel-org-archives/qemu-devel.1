Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDEBC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6B42166E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6B42166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ZFQ-0000ek-84
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 14:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1j9ZEe-0008J2-Ov
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1j9ZEd-0004In-Fp
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:59:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1j9ZEd-0004IA-8b
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:59:11 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 024IsxVU151351
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2020 13:59:10 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhhy7234t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 13:59:09 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Wed, 4 Mar 2020 18:59:07 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Mar 2020 18:59:05 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 024Ix44i45810048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 18:59:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A7E411C050;
 Wed,  4 Mar 2020 18:59:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7E7D11C04C;
 Wed,  4 Mar 2020 18:59:03 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.55.212])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2020 18:59:03 +0000 (GMT)
Subject: Re: [PATCH v6 02/18] s390x: protvirt: Add diag308 subcodes 8 - 10
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-3-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Wed, 4 Mar 2020 19:59:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304114231.23493-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030418-0008-0000-0000-000003595D1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030418-0009-0000-0000-00004A7A91E2
Message-Id: <0e56347f-eb63-84e8-3d6d-cbdac47a22f6@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-04_08:2020-03-04,
 2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040126
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 024IsxVU151351
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 04.03.20 12:42, Janosch Frank wrote:
> For diag308 subcodes 8 - 10 we have a new ipib of type 5. The ipib
> holds the address and length of the secure execution header, as well
> as a list of guest components.
>=20
> Each component is a block of memory, for example kernel or initrd,
> which needs to be decrypted by the Ultravisor in order to run a
> protected VM. The secure execution header instructs the Ultravisor on
> how to handle the protected VM and its components.
>=20
> Subcodes 8 and 9 are similiar to 5 and 6 and subcode 10 will finally
> start the protected guest.
>=20
> Subcodes 8-10 are not valid in protected mode, we have to do a subcode
> 3 and then the 8 and 10 combination for a protected reboot.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/ipl.c      | 47 ++++++++++++++++++++++++++++++++++++++++++---
>  hw/s390x/ipl.h      | 32 ++++++++++++++++++++++++++++++
>  target/s390x/diag.c | 26 ++++++++++++++++++++++---
>  3 files changed, 99 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 9c1ecd423c..80c6ab233a 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c

Can you update the copyright dates for files that you touch?

> @@ -538,15 +538,55 @@ static bool is_virtio_scsi_device(IplParameterBlo=
ck *iplb)
>      return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
>  }
> =20
> +int s390_ipl_pv_check_components(IplParameterBlock *iplb)
> +{
> +    int i;
> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
> +
> +    if (ipib_pv->num_comp =3D=3D 0) {
> +        return -EINVAL;
> +    }
> +
> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
> +        /* Addr must be 4k aligned */
> +        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
> +            return -EINVAL;
> +        }
> +
> +        /* Tweak prefix is monotonously increasing with each component=
 */
> +        if (i < ipib_pv->num_comp - 1 &&

Why do we need this check? Isnt that already ensured by the for loop?

> +            ipib_pv->components[i].tweak_pref >
> +            ipib_pv->components[i + 1].tweak_pref) {

I think i+1 must be greater than i. So ">=3D" instead?

> +            return -EINVAL;
> +        }
> +    }
> +    return 0;
> +}
> +
>  void s390_ipl_update_diag308(IplParameterBlock *iplb)

maybe add a comment that explains that a guest can have 2 IPLBs. one for
the secure guest and one thsat we go back to when rebooting.
>  {
>      S390IPLState *ipl =3D get_ipl_device();
> =20
> -    ipl->iplb =3D *iplb;
> -    ipl->iplb_valid =3D true;
> +    if (iplb->pbt =3D=3D S390_IPL_TYPE_PV) {
> +        ipl->iplb_pv =3D *iplb;
> +        ipl->iplb_valid_pv =3D true;
> +    } else {
> +        ipl->iplb =3D *iplb;
> +        ipl->iplb_valid =3D true;
> +    }
>      ipl->netboot =3D is_virtio_net_device(iplb);
>  }
> =20
> +IplParameterBlock *s390_ipl_get_iplb_secure(void)
> +{
> +    S390IPLState *ipl =3D get_ipl_device();
> +
> +    if (!ipl->iplb_valid_pv) {
> +        return NULL;
> +    }
> +    return &ipl->iplb_pv;
> +}
> +
>  IplParameterBlock *s390_ipl_get_iplb(void)
>  {
>      S390IPLState *ipl =3D get_ipl_device();
> @@ -561,7 +601,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s390=
_reset reset_type)
>  {
>      S390IPLState *ipl =3D get_ipl_device();
> =20
> -    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S39=
0_RESET_REIPL) {
> +    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S39=
0_RESET_REIPL ||
> +        reset_type =3D=3D S390_RESET_PV) {
>          /* use CPU 0 for full resets */
>          ipl->reset_cpu_index =3D 0;
>      } else {
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index d4813105db..04be63cee1 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -15,6 +15,24 @@
>  #include "cpu.h"
>  #include "hw/qdev-core.h"
> =20
> +struct IPLBlockPVComp {
> +    uint64_t tweak_pref;
> +    uint64_t addr;
> +    uint64_t size;
> +} QEMU_PACKED;
> +typedef struct IPLBlockPVComp IPLBlockPVComp;
> +
> +struct IPLBlockPV {
> +    uint8_t  reserved[87];
> +    uint8_t  version;
> +    uint32_t reserved70;

Here you have 70 (the offset in hex I guess), I t=C3=9Fhink this is an od=
d name. In addition the reserved field 2 lines above has no address part =
in its
name.=20



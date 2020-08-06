Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9D1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76312312D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Insh3vlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76312312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fyv-00024V-Q4
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1k3fx7-0007iP-KL; Thu, 06 Aug 2020 09:29:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1k3fx5-0001oG-Kz; Thu, 06 Aug 2020 09:29:01 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 076DQC5f027212; Thu, 6 Aug 2020 09:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=2Y5Pq0re0a95dI/UTTdWPe9T3o1qI+X8MCSWwGidCqs=;
 b=Insh3vlXwQWQTS9mKo1m6khKVGy7r+4v7i8NJe+Eaw8RzcElwxRjjY0bTOOpLiv+PUYs
 wpGVX45aJdwIvzc0WYBv8CyTumzNgtGu2GBxbIoh31VsExjA+QOvLlhA8bF3fm8bQBj8
 3UN5Tcwx0LF+6gqu+7xJMbmIf33UrEOZktYty0NIGC0BoxbAQYFy9rt0tNjPjC8+e55E
 wJ41Q4F38z654RLw8R9Ci14kMN/giqTfdQQnOQSlUvCU9laWYeSp1BhGpnSzKj/6L2NL
 mCHGEp+AylxkiVJxIGeXIUnZGRkZHtrId2N355vvcfzlHGkaTpmSsl3iEIYyiuP83IQ9 tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32qcf3828c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2020 09:28:57 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 076DQFBa027396;
 Thu, 6 Aug 2020 09:28:57 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32qcf3827q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2020 09:28:57 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 076DJnLq010706;
 Thu, 6 Aug 2020 13:28:55 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma04fra.de.ibm.com with ESMTP id 32n018bc0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2020 13:28:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 076DSqKN24838568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Aug 2020 13:28:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D2E9A4062;
 Thu,  6 Aug 2020 13:28:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19FF9A4054;
 Thu,  6 Aug 2020 13:28:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.35.222])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  6 Aug 2020 13:28:52 +0000 (GMT)
Subject: Re: [PATCH for-5.2 v2 4/9] pc-bios/s390-ccw: Move the inner logic of
 find_subch() to a separate function
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20200806105349.632-1-thuth@redhat.com>
 <20200806105349.632-5-thuth@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1e0c1b3a-de5a-bfc2-6688-4718850100a6@linux.ibm.com>
Date: Thu, 6 Aug 2020 15:28:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200806105349.632-5-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gJjtdvVMbYX0HJtoHdFVZvrxhofFr5mjc"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-06_09:2020-08-06,
 2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008060094
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 09:28:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, qemu-block@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gJjtdvVMbYX0HJtoHdFVZvrxhofFr5mjc
Content-Type: multipart/mixed; boundary="3ngvRYa8Lr1zfvcFZSw4l4aN5HJCjedMh"

--3ngvRYa8Lr1zfvcFZSw4l4aN5HJCjedMh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/6/20 12:53 PM, Thomas Huth wrote:
> Move the code to a separate function to be able to re-use it from a
> different spot later.
>=20
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

The new function name helps a lot :)

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  pc-bios/s390-ccw/main.c | 99 ++++++++++++++++++++++++-----------------=

>  1 file changed, 57 insertions(+), 42 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 9b64eb0c24..0d2aabbc58 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -51,6 +51,60 @@ unsigned int get_loadparm_index(void)
>      return atoui(loadparm_str);
>  }
> =20
> +static int is_dev_possibly_bootable(int dev_no, int sch_no)
> +{
> +    bool is_virtio;
> +    Schib schib;
> +    int r;
> +
> +    blk_schid.sch_no =3D sch_no;
> +    r =3D stsch_err(blk_schid, &schib);
> +    if (r =3D=3D 3 || r =3D=3D -EIO) {
> +        return -ENODEV;
> +    }
> +    if (!schib.pmcw.dnv) {
> +        return false;
> +    }
> +
> +    enable_subchannel(blk_schid);
> +    cutype =3D cu_type(blk_schid);
> +
> +    /*
> +     * Note: we always have to run virtio_is_supported() here to make
> +     * sure that the vdev.senseid data gets pre-initialized correctly
> +     */
> +    is_virtio =3D virtio_is_supported(blk_schid);
> +
> +    /* No specific devno given, just return whether the device is poss=
ibly bootable */
> +    if (dev_no < 0) {
> +        switch (cutype) {
> +        case CU_TYPE_VIRTIO:
> +            if (is_virtio) {
> +                /*
> +                 * Skip net devices since no IPLB is created and there=
fore
> +                 * no network bootloader has been loaded
> +                 */
> +                if (virtio_get_device_type() !=3D VIRTIO_ID_NET) {
> +                    return true;
> +                }
> +            }
> +            return false;
> +        case CU_TYPE_DASD_3990:
> +        case CU_TYPE_DASD_2107:
> +            return true;
> +        default:
> +            return false;
> +        }
> +    }
> +
> +    /* Caller asked for a specific devno */
> +    if (schib.pmcw.dev =3D=3D dev_no) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  /*
>   * Find the subchannel connected to the given device (dev_no) and fill=
 in the
>   * subchannel information block (schib) with the connected subchannel'=
s info.
> @@ -62,53 +116,14 @@ unsigned int get_loadparm_index(void)
>   */
>  static bool find_subch(int dev_no)
>  {
> -    Schib schib;
>      int i, r;
> -    bool is_virtio;
> =20
>      for (i =3D 0; i < 0x10000; i++) {
> -        blk_schid.sch_no =3D i;
> -        r =3D stsch_err(blk_schid, &schib);
> -        if ((r =3D=3D 3) || (r =3D=3D -EIO)) {
> +        r =3D is_dev_possibly_bootable(dev_no, i);
> +        if (r < 0) {
>              break;
>          }
> -        if (!schib.pmcw.dnv) {
> -            continue;
> -        }
> -
> -        enable_subchannel(blk_schid);
> -        cutype =3D cu_type(blk_schid);
> -
> -        /*
> -         * Note: we always have to run virtio_is_supported() here to m=
ake
> -         * sure that the vdev.senseid data gets pre-initialized correc=
tly
> -         */
> -        is_virtio =3D virtio_is_supported(blk_schid);
> -
> -        /* No specific devno given, just return 1st possibly bootable =
device */
> -        if (dev_no < 0) {
> -            switch (cutype) {
> -            case CU_TYPE_VIRTIO:
> -                if (is_virtio) {
> -                    /*
> -                     * Skip net devices since no IPLB is created and t=
herefore
> -                     * no network bootloader has been loaded
> -                     */
> -                    if (virtio_get_device_type() !=3D VIRTIO_ID_NET) {=

> -                        return true;
> -                    }
> -                }
> -                continue;
> -            case CU_TYPE_DASD_3990:
> -            case CU_TYPE_DASD_2107:
> -                return true;
> -            default:
> -                continue;
> -            }
> -        }
> -
> -        /* Caller asked for a specific devno */
> -        if (schib.pmcw.dev =3D=3D dev_no) {
> +        if (r =3D=3D true) {
>              return true;
>          }
>      }
>=20



--3ngvRYa8Lr1zfvcFZSw4l4aN5HJCjedMh--

--gJjtdvVMbYX0HJtoHdFVZvrxhofFr5mjc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8sBZMACgkQ41TmuOI4
ufi6uA/+Oqm8hxukTzbgFN5XbiOFE+9OGoxY+eetkLPUbmBr4RvBnL2lsXod/j1Z
Pxr5sPEX65WLM9ET+7+4dWLR01WnH5E+n3LWaNjJ8q43qiWxVdz4h6xzm/lJGEwb
tviqa176p0RPYUuNUSlBLB8lFZdw+d5T7RvVK5E2JSVkktGqd+dLJj1MeUn6kX6h
YE6hQAkA8jvA4AUDwaKjePn6NuQ51HqDeEKh8YHOA+7Hlf/OlTTZYa0LRupDJ6Yr
EQoW1MQSp79CNtQKHq+4Vl1qW+sGZLP2OB1DLUP26YGPGM4jDS8E1OsRCwJCmvq9
XvSfKF5l53CDsXExItO65aB8bczlRVe8fhFjH0h2RlAlC2cm87UDK8EBuKBj5w7B
Z3AQVAoNeTXy1SWuH7/mV9Yi3MrX1UeRK9mDWacE4IKPISfM78PnrTi+pfzWaAiW
9DQe/Kzf8culJc/uN8SshPiqgV32GnGdfQSIGMq89ePcKX+e+VRJJyuK6O1GaAPo
f6mPn6uMZH8ZYwz3+/w1tz+422dzOgmmgsx96qRtyXV+2GROW1TV5j4ASgj2ougG
t9vyMfik2lfF8yQhBhJZVORm7EX6YajtrWhz4pLSHCiyPPGvwodmuZQ2HEeo7OUW
bDnO9G60oSTFczBsCkelGlURLHMoMFBxgHeE8FwBFM1F48v9iMI=
=RVJ+
-----END PGP SIGNATURE-----

--gJjtdvVMbYX0HJtoHdFVZvrxhofFr5mjc--



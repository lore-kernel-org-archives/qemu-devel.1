Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7B1C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FC421741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mr5zGgK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FC421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05Dl-0002Qq-T4
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1j04lC-0007cs-L6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1j04lB-0000ZB-Iz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:37:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1j04lB-0000YE-9M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:37:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017EYO3v068731;
 Fri, 7 Feb 2020 14:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Mei5PN0W74WXwRPU1LsX9CCpKWFCJXX4kihdRaR0ybc=;
 b=Mr5zGgK456EqpufRaHHJz3x32TFWkeDaD3rgeDhBskovz1Vd2TRcb0j8/jjG2IvR9CbG
 womzYyFiC1MnBxoa0z2XVoLFwjKKR5ed8fuKlKv+NIdcr+cqzCEwjPI7a+ujSYBBbiFy
 YEd5E+YYLOb48G0VLFhGx4iJuQXc0ywgP3Lh3YowZ/8c63aqDtPu1C87IspGxCsQgSLi
 giG1Fn33ebJm4gSWsRQ2OMGe5mxFG8IaGrlXW7be/C/6RJP5S6F2LYpvY64QuB+8F3Js
 O2RXvzNf+3A35lSK7u7k9ciVbTFqw5qoFOnyRnBJPFR0tssAcHEqgvl3D+e5EDsCWBjE +Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2xykbprd4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Feb 2020 14:37:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017EYGnJ106779;
 Fri, 7 Feb 2020 14:37:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2y16pqtyqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Feb 2020 14:37:31 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 017EbTNX028039;
 Fri, 7 Feb 2020 14:37:29 GMT
Received: from [10.175.208.183] (/10.175.208.183)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Feb 2020 06:37:29 -0800
Subject: Re: [PATCH v2 12/29] python/qemu/accel: Use
 binutils::binary_get_accels()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-13-philmd@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <44b8b644-f37d-7363-8871-4d89ff61ff75@oracle.com>
Date: Fri, 7 Feb 2020 14:37:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-13-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070112
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 017EYO3v068731
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/2020 21:23, Philippe Mathieu-Daud=C3=A9 wrote:
> Instead of parsing the process help output, use the
> binary_get_accels() helper which queries the list of
> accelerators over a QMP socket.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   python/qemu/accel.py | 26 ++++----------------------
>   1 file changed, 4 insertions(+), 22 deletions(-)
>=20
> diff --git a/python/qemu/accel.py b/python/qemu/accel.py
> index 0b38ddf0ab..cde51ae159 100644
> --- a/python/qemu/accel.py
> +++ b/python/qemu/accel.py
> @@ -16,7 +16,8 @@ accelerators.
>  =20
>   import logging
>   import os
> -import subprocess
> +
> +from .binutils import binary_get_accels
>  =20
>   LOG =3D logging.getLogger(__name__)
>  =20
> @@ -27,25 +28,6 @@ ADDITIONAL_ARCHES =3D {
>       "aarch64" : "armhf"
>   }
>  =20
> -def list_accel(qemu_bin):
> -    """
> -    List accelerators enabled in the QEMU binary.
> -
> -    @param qemu_bin (str): path to the QEMU binary.
> -    @raise Exception: if failed to run `qemu -accel help`
> -    @return a list of accelerator names.
> -    """
> -    if not qemu_bin:
> -        return []
> -    try:
> -        out =3D subprocess.check_output([qemu_bin, '-accel', 'help'],
> -                                      universal_newlines=3DTrue)
> -    except:
> -        LOG.debug("Failed to get the list of accelerators in %s", qemu=
_bin)
> -        raise
> -    # Skip the first line which is the header.
> -    return [acc.strip() for acc in out.splitlines()[1:]]
> -
>   def kvm_available(target_arch=3DNone, qemu_bin=3DNone):
>       """
>       Check if KVM is available using the following heuristic:
> @@ -64,7 +46,7 @@ def kvm_available(target_arch=3DNone, qemu_bin=3DNone=
):
>           if target_arch !=3D host_arch:
>               if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
>                   return False
> -    if qemu_bin and "kvm" not in list_accel(qemu_bin):
> +    if qemu_bin and "kvm" not in binary_get_accels(qemu_bin):
>           return False
>       return True
>  =20
> @@ -74,4 +56,4 @@ def tcg_available(qemu_bin):
>  =20
>       @param qemu_bin (str): path to the QEMU binary
>       """
> -    return 'tcg' in list_accel(qemu_bin)
> +    return 'tcg' in binary_get_accels(qemu_bin)
>=20



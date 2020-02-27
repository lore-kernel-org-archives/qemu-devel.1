Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A04C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1071424692
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TofFI1ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1071424692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HqJ-0008TG-7C
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1j7How-0007Ah-2R
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1j7Hot-00086S-PE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:59:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1j7Hot-00084O-F9
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:59:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RBvp9R190973;
 Thu, 27 Feb 2020 11:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZfBfU4l2lCyKAtHRyJBJpgaF0BG3XH7DfhBvX/2uPCk=;
 b=TofFI1wwKMtaDEMm95UzAV0K9uwSUIWJ5ygk51zWxa9KSwiVlf2cYYI3YLs3ke0+YbVm
 JeLJbLCtD2THk6U7ClAW5BSB0ApM8/0E6KNcY7jWjIwuGrKWEfDe3D/eJzQgGfg8SP/j
 xHpb9y2Loa/ovTWTt7u4HLxToKL/svVwMaC0gceMeKAThwt6eBL5cwITjNqjpKdxqTqb
 eRpJd9vMefASvfbTJupMdFHV7DSAvVsL30Ir0aUGDIv9d5I45+9A5uAOhnf10UkfsKqr
 lVMuEkU3nhoZOpDgb20JvRuyafi/XBXIHvx7GW5zp7vVxltD51CcdbeQFBrXk9jR/25G wA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2ydybcmf80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2020 11:59:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RBw7Pb002080;
 Thu, 27 Feb 2020 11:59:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2ydj4mbsfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2020 11:59:06 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01RBx5cC022416;
 Thu, 27 Feb 2020 11:59:05 GMT
Received: from [10.175.167.101] (/10.175.167.101)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Feb 2020 03:59:05 -0800
Subject: Re: [PATCH] qapi/machine: Place the 'Notes' tag after the 'Since' tag
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200227104153.29425-1-philmd@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <24ca5661-7707-1413-c910-e531e89488b0@oracle.com>
Date: Thu, 27 Feb 2020 11:59:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227104153.29425-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270097
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 01RBvp9R190973
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/02/2020 10:41, Philippe Mathieu-Daud=C3=A9 wrote:
> This fixes when adding a 'Since' tag:
>=20
>    In file included from qapi/qapi-schema.json:105:
>    qapi/machine.json:25:1: '@arch:' can't follow 'Notes' section
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   qapi/machine.json | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6c11e3cf3a..2b4f5f0962 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -16,11 +16,11 @@
>   # individual target constants are not documented here, for the time
>   # being.
>   #
> +# Since: 3.0
> +#
>   # Notes: The resulting QMP strings can be appended to the "qemu-syste=
m-"
>   #        prefix to produce the corresponding QEMU executable name. Th=
is
>   #        is true even for "qemu-system-x86_64".
> -#
> -# Since: 3.0
>   ##
>   { 'enum' : 'SysEmuTarget',
>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32=
',
>=20


Does the same issue occur for @CpuInstanceProperties: at line 829?
The 'Since:' follows a 'Note:' section (but maybe the singular usage is=20
intended).

otherwise

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


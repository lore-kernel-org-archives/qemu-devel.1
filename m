Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C26C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253E1246B2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VguAU+XF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253E1246B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7fWG-0001HS-7x
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 08:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1j7fVX-0000eO-Qi
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1j7fVW-0002v4-Mw
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:16:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1j7fVS-0002rY-6P; Fri, 28 Feb 2020 08:16:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SD3U8B180318;
 Fri, 28 Feb 2020 13:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Vit04kuf5cpLPAqMK990JLKErosxAkUFTazysUbIreQ=;
 b=VguAU+XFZvpQlfN5Rf+RoiENC9G2HNZAifPkOCzVTpXFYzo2mtg+iuWn68UjTrtxKDz9
 EzhRMyaJB+iLCO8MOz47vYDpRFWjFlTXVpk4cUaWFrGX4PQqTM6vike3Zvq90OrT/Y6R
 V4mIJ23fWbY0qE4DSQYCjvktLUEOESA4XGULwfxSvkTdRxqwXH0PNVZ+rUa8gYWGGOHc
 JI+wM/79ryOfUeC8lT5vos86rZa2XzR6icacyOurpZbuvUCvAsMqWhZQb20kfAzKP456
 ZyWruZ7YMBG/pPlQ3EMySvBMj6tZNnPUyAlTa0bj9txoq14F3yaqgW6mU1PS29Al3c3I RA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2ydcsntukc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2020 13:16:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SDEKv1008395;
 Fri, 28 Feb 2020 13:16:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2ydj4qrrdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2020 13:16:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01SDGcUH002848;
 Fri, 28 Feb 2020 13:16:38 GMT
Received: from [10.175.185.164] (/10.175.185.164)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 28 Feb 2020 05:16:37 -0800
Subject: Re: [PATCH] block: Remove trailing newline in format used by
 error_report API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200228123637.15160-1-philmd@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <a89ccf3d-1d5f-ca0f-0f51-ca207676eea4@oracle.com>
Date: Fri, 28 Feb 2020 13:16:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228123637.15160-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280106
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 01SD3U8B180318
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/02/2020 12:36, Philippe Mathieu-Daud=C3=A9 wrote:
> The error_report API doesn't want trailing newline characters.
> Remove it, to avoid and error when moving the code around:
>=20

s/and/an/

>    ERROR: Error messages should not contain newlines
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block.c b/block.c
> index 1bdb9c679d..e466d15914 100644
> --- a/block.c
> +++ b/block.c
> @@ -5994,7 +5994,7 @@ void bdrv_img_create(const char *filename, const =
char *fmt,
>               /* Couldn't open BS, but we have a size, so it's nonfatal=
 */
>               warn_reportf_err(local_err,
>                               "Could not verify backing image. "
> -                            "This may become an error in future versio=
ns.\n");
> +                            "This may become an error in future versio=
ns.");
>               local_err =3D NULL;
>           } else if (!bs) {
>               /* Couldn't open bs, do not have size */
>=20



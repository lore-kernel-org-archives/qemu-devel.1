Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8EBC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 02:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D9520840
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 02:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t8kEPHwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D9520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htNlz-0006md-OC
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 22:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yuval.shaia@oracle.com>) id 1htNlR-0006Gi-RM
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 22:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1htNlQ-0002fl-SW
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 22:57:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1htNlQ-0002fK-LA
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 22:57:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x722sEdJ015922;
 Fri, 2 Aug 2019 02:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=wg5DHftin+80vzsEM2PmMdsMH0BmEkgYiA+Acmm44IY=;
 b=t8kEPHwPzvlq4/+YcJTLskrkNR0tLUVNhZXeHD7Q3Nwp1FWD6rsgBMeWpIlhDhsO/Ur/
 am20PZPT3YoNA4zDw0l3kE0hEPEeTCTVJHa7zOkvvoy9FXpmbKK3DdfrWPZGcqm9IYcW
 bmgRRqtrT/LdMwqdZSuPc8KsvyaxNhfnvLoMBYCLOhhzhPIpY6cIWfG0mq+mUfHsZr/k
 Gqlajuq8vF280DoWEscaHTFvVF5ZLlDrl9Kx04kef9wrAODs9lUI+7OtihrO3O9AEaXC
 swn3dDu2dM1hj/+GhfVDxvcDzyx5HnGBe/9LM2RQwivgAK2CsyGhhVaRvCFUHyOWiGH6 Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2u0ejpy8xb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 Aug 2019 02:57:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x722rQgk038611;
 Fri, 2 Aug 2019 02:57:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2u3mbv0fcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 Aug 2019 02:57:48 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x722vkWd015845;
 Fri, 2 Aug 2019 02:57:47 GMT
Received: from lap1 (/49.145.126.232) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 01 Aug 2019 19:57:45 -0700
Date: Fri, 2 Aug 2019 05:57:41 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190802025740.GA4271@lap1>
References: <20190716100719.29722-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190716100719.29722-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020029
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 x722sEdJ015922
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [PATCH 1/2] rdmacm-mux: fix strcpy string warning
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 02:07:18PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> ../contrib/rdmacm-mux/main.c: In function =E2=80=98parse_args=E2=80=99:
> ../contrib/rdmacm-mux/main.c:118:13: error: =E2=80=98strncpy=E2=80=99 s=
pecified bound 3835 equals destination size [-Werror=3Dstringop-truncatio=
n]
>   118 |             strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX);
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/rdmacm-mux/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
> index 30c7052651..de53048f06 100644
> --- a/contrib/rdmacm-mux/main.c
> +++ b/contrib/rdmacm-mux/main.c
> @@ -115,7 +115,7 @@ static void parse_args(int argc, char *argv[])
> =20
>          case 's':
>              /* This is temporary, final name will build below */
> -            strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX);
> +            strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX - 1);
>              break;

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

> =20
>          case 'p':
> --=20
> 2.22.0.428.g6d5b264208
>=20


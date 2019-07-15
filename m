Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43384C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A8D206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xgabz/Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A8D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn0ok-00013A-D0
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45958)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yuval.shaia@oracle.com>) id 1hn0oW-0000QB-K4
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1hn0oU-0006ks-PR
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:14:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1hn0oU-0006ig-FD
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:14:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FDE840078249;
 Mon, 15 Jul 2019 13:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=UvoCCl1cbLx5uLf0Qp4W9IPQas4CFFI0zmS1fhcdF4M=;
 b=Xgabz/JfQovTLBXZ8p4VUhayrHyaV4NahV/nTg35fCQsi2fNMhFMwGp9XUpT87nTUv10
 JGpWjbp55vgzU4Pmrd8EBiLKwDYKWuFF4xCtBPThkoAOcsBHCG7pAu7t+j5oufReZ+sL
 EBkrpMNKjO8h0AXklMeQZ1gJB1aNq1Bx+1ZB8IorxG7m1gfJ+/x14cdMR9y0SrWrVqsN
 FE+ANt87Tl/YrCppa832h4H2nAX6mema75/hlSI/yr/zy7Zn8cyOHeKbUv82WQ4369ge
 MEkz4fedmHe7yOeL4ej58nSuPfmSthoyFMHH6jdiJmK62tkn9FbO8KLI0ADwADSRIopy DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2tq6qteegd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jul 2019 13:14:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FDCb5j044747;
 Mon, 15 Jul 2019 13:14:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2tq4dta6sd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jul 2019 13:14:36 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6FDEZe6011765;
 Mon, 15 Jul 2019 13:14:35 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 15 Jul 2019 06:14:35 -0700
Date: Mon, 15 Jul 2019 16:14:31 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190715131430.GA10679@lap1>
References: <20190712165154.11504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190712165154.11504-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9318
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9318
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150160
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 x6FDE840078249
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH] rdmacm-mux: fix strcpy string warning
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 12, 2019 at 08:51:54PM +0400, Marc-Andr=C3=A9 Lureau wrote:
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

Oops,
Thanks!

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

>              break;
> =20
>          case 'p':
> --=20
> 2.22.0.428.g6d5b264208
>=20


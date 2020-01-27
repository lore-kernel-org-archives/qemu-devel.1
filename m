Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D065EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F84A21739
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gDDCI7AH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F84A21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw7gR-0004oo-MQ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 11:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1iw7fW-0004M2-KR
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1iw7fV-0006F3-7Y
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:55:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1iw7fU-0006Eb-UQ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:55:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RGcBt8061799;
 Mon, 27 Jan 2020 16:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=ScZNi6OdDIaEcoL3YGLdFbmu9cYT+I6RV1O1QqrktrE=;
 b=gDDCI7AHGX+Igd1PrL/n81HFEbo/my0PG+PlGBHbUqMS7X5F24vitF+sRw32eeqKhV2y
 XVkSQMaac19GtzNuuq3rMaP7el12jLMQOri/3MTkyZD5cLjRIHKp36K5CcUm3vYjslBj
 n0pNSav1r131/nTHk+EQTIqibKezDDjsOfInfvxAIAm+qPgBTSTunKWRNhoxs9IFWOdN
 5L5RGd/ZlEYxBCGvH6DIPXNVo4aEnU5V8zl6EROfubC9rySdR8gmgwPILHgSv90RPE6y
 phi4EDDBOgzV7Ue7H6Q7IEJPRn9wR1rcanyhoHx/2vP/wzFg4W5DhjaFFMTlwH9fVDc9 ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2xrear0hfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2020 16:55:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RGdbdr151366;
 Mon, 27 Jan 2020 16:55:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2xry6u04yx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2020 16:55:17 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00RGtGCs003942;
 Mon, 27 Jan 2020 16:55:16 GMT
Received: from [10.175.203.109] (/10.175.203.109)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 27 Jan 2020 08:55:15 -0800
Subject: Re: [PATCH] docs: add virtiofsd(1) man page
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200127162514.56784-1-stefanha@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <539e9834-8b3f-5d7c-eb0c-ff2c19d44ff8@oracle.com>
Date: Mon, 27 Jan 2020 16:55:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200127162514.56784-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270139
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/01/2020 16:25, Stefan Hajnoczi wrote:
> Document the virtiofsd(1) program and its command-line options.  This
> man page is a rST conversion of the original texi documentation that I
> wrote.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Based-on: 20200124162606.8787-1-peter.maydell@linaro.org
>            ("[PATCH v2 0/8] qemu-img, qemu-trace-stap, virtfs-proxy-helper: convert to rST")
> ---
>   MAINTAINERS                |   1 +
>   Makefile                   |   8 ++-
>   docs/interop/conf.py       |   5 +-
>   docs/interop/index.rst     |   1 +
>   docs/interop/virtiofsd.rst | 123 +++++++++++++++++++++++++++++++++++++
>   5 files changed, 136 insertions(+), 2 deletions(-)
>   create mode 100644 docs/interop/virtiofsd.rst
> 

[ ... deleted ...]

> +
> +Examples
> +--------
> +
> +Export ``/var/lib/fs/vm001/`` on vhost-user UNIX domain socket
> +``/var/run/vm001-vhost-fs.sock``:
> +
> +::
> +
> +  host# virtiofsd --socket-path=/var/run/vm001-vhost-fs.sock -o source=/var/lib/fs/vm001
> +  host# qemu-system-x86_64 \
> +      -chardev socket,id=char0,path=/var/run/vm001-vhost-fs.sock \
> +      -device vhost-user-fs-pci,chardev=char0,tag=myfs \
> +      -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
> +      -numa node,memdev=mem \
> +      ...
> +  guest# mount -t virtio_fs myfs /mnt
> 

This should be 'mount -t virtiofs myfs /mnt' like on 
https://virtio-fs.gitlab.io/howto-qemu.html

otherwise

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>



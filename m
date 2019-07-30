Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB331C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953C1206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mdmf6V35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953C1206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsRAT-0004S4-Qv
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 08:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34603)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liam.merwick@oracle.com>) id 1hsR9r-00040v-0A
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1hsR9p-00012b-UL
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:23:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1hsR9p-00011X-Kv
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:23:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UC9Io4168333;
 Tue, 30 Jul 2019 12:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=TdL8lYAbo8VRfghnHW9UAHDiOlDzL3xO1gRPLcN8n58=;
 b=mdmf6V358bPDUopEO9NVonUYx6XwfPFfoZ1sZEii9FJz6a4k646Pr2iEOlGYopsZQlgQ
 siIzHB10d5GSfAd6wRTVpMbZqPxtM0fyGvSYkTy45e7jBMK67NPCC8Hj1wLX6LkRBMaU
 0I03vTwsLDsMD69eTX0FErFQ30tfinFJLqP3yakya9v9oOtttnkvcflJ3hBwkqGk8Isl
 MBNMbuLVuuxNx3Q0worQmIMv3M4Ctlu482x91Vcem8xNDyth8MFj2MjW0VSDl0aR1LPe
 JkzS/ZIAUqjqJjolYGcDIFmP/6LiQbZyMYb0V5PQzMXHX5dHXibETsik1w1bUAdlc9uS kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2u0e1tp8sx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2019 12:22:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UC8F3E163590;
 Tue, 30 Jul 2019 12:22:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2u0bqu3e4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2019 12:22:58 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6UCMviH011325;
 Tue, 30 Jul 2019 12:22:57 GMT
Received: from dhcp-10-175-172-128.vpn.oracle.com (/10.175.172.128)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 30 Jul 2019 05:22:57 -0700
To: piaojun <piaojun@huawei.com>, virtio-fs@redhat.com, qemu-devel@nongnu.org
References: <5D3F8F04.3030404@huawei.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <8748798a-ac4f-4c0a-96fa-190e24dca52b@oracle.com>
Date: Tue, 30 Jul 2019 13:22:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5D3F8F04.3030404@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300129
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH] virtiofsd: fix compile error if
 'F_OFD_GETLK' not defined
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/07/2019 01:27, piaojun wrote:
> Use F_GETLK for fcntl when F_OFD_GETLK not defined.


Use F_GETLK/F_SETLK for fcntl when F_OFD_GETLK/F_OFD_SETLK not defined.

> 
> Signed-off-by: Jun Piao <piaojun@huawei.com>
> ---
>   contrib/virtiofsd/passthrough_ll.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> index 9ae1381..757785b 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -1619,7 +1619,11 @@ static void lo_getlk(fuse_req_t req, fuse_ino_t ino,
>   		return;
>   	}
> 
> +#ifdef F_OFD_GETLK
>   	ret = fcntl(plock->fd, F_OFD_GETLK, lock);
> +#else
> +	ret = fcntl(plock->fd, F_GETLK, lock);
> +#endif
>   	if (ret == -1)
>   		saverr = errno;
>   	pthread_mutex_unlock(&inode->plock_mutex);
> @@ -1668,7 +1672,12 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino,
> 
>   	/* TODO: Is it alright to modify flock? */
>   	lock->l_pid = 0;
> +
> +#ifdef F_OFD_GETLK


This checks for F_OFD_GETLK but uses F_OFD_SETLK (albeit unlikely one 
being defined without the other)


>   	ret = fcntl(plock->fd, F_OFD_SETLK, lock);
> +#else
> +	ret = fcntl(plock->fd, F_SETLK, lock);
> +#endif
>   	if (ret == -1) {
>   		saverr = errno;
>   	}
>
Might qemu_lock_fd()/qemu_unlock_fd() in util/osdep.c be useful to hide 
this instead?

Regards,
Liam


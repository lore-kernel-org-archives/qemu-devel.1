Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E65EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8166206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8166206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BFd-0000kT-4m
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <piaojun@huawei.com>) id 1i1BDI-0007P7-L6
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1i1BDH-00017P-GG
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:10:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2187 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1i1BDH-000131-4J
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:10:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B2E34D390E96B8A1944F;
 Fri, 23 Aug 2019 23:10:41 +0800 (CST)
Received: from [10.45.7.186] (10.45.7.186) by smtp.huawei.com (10.3.19.204)
 with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019 23:10:37 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>, <qemu-devel@nongnu.org>
References: <20190823092401.11883-1-stefanha@redhat.com>
 <20190823092401.11883-2-stefanha@redhat.com>
From: piaojun <piaojun@huawei.com>
Message-ID: <b60880a6-ff0b-0137-81d4-de9626cc75c2@huawei.com>
Date: Fri, 23 Aug 2019 23:09:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823092401.11883-2-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.7.186]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: Re: [Qemu-devel] [PATCH 1/2] virtiofsd: replace warn(3) and
 warnx(3) with fuse_warning()
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



On 2019/8/23 17:24, Stefan Hajnoczi wrote:
> Do not use warn(3) and warnx(3) since they print to stderr.  When
> --syslog is used these messages must go to syslog(3) instead.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  contrib/virtiofsd/passthrough_ll.c | 36 +++++++++++++++---------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> index ca11764feb..873e0938a7 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -628,12 +628,12 @@ retry:
>  
>  	res = readlinkat(lo->proc_self_fd, procname, path, PATH_MAX);
>  	if (res < 0) {
> -		warn("lo_parent_and_name: readlink failed");
> +		fuse_warning("lo_parent_and_name: readlink failed: %m\n");
>  		goto fail_noretry;
>  	}
>  
>  	if (res >= PATH_MAX) {
> -		warnx("lo_parent_and_name: readlink overflowed");
> +		fuse_warning("lo_parent_and_name: readlink overflowed\n");
>  		goto fail_noretry;
>  	}
>  	path[res] = '\0';
> @@ -641,7 +641,7 @@ retry:
>  	last = strrchr(path, '/');
>  	if (last == NULL) {
>  		/* Shouldn't happen */
> -		warnx("lo_parent_and_name: INTERNAL ERROR: bad path read from proc");
> +		fuse_warning("lo_parent_and_name: INTERNAL ERROR: bad path read from proc\n");
>  		goto fail_noretry;
>  	}
>  	if (last == path) {
> @@ -655,13 +655,13 @@ retry:
>  		res = fstatat(AT_FDCWD, last == path ? "/" : path, &stat, 0);
>  		if (res == -1) {
>  			if (!retries)
> -				warn("lo_parent_and_name: failed to stat parent");
> +				fuse_warning("lo_parent_and_name: failed to stat parent: %m\n");
>  			goto fail;
>  		}
>  		p = lo_find(lo, &stat);
>  		if (p == NULL) {
>  			if (!retries)
> -				warnx("lo_parent_and_name: failed to find parent");
> +				fuse_warning("lo_parent_and_name: failed to find parent\n");
>  			goto fail;
>  		}
>  	}
> @@ -669,12 +669,12 @@ retry:
>  	res = fstatat(p->fd, last, &stat, AT_SYMLINK_NOFOLLOW);
>  	if (res == -1) {
>  		if (!retries)
> -			warn("lo_parent_and_name: failed to stat last");
> +			fuse_warning("lo_parent_and_name: failed to stat last: %m\n");
>  		goto fail_unref;
>  	}
>  	if (stat.st_dev != inode->key.dev || stat.st_ino != inode->key.ino) {
>  		if (!retries)
> -			warnx("lo_parent_and_name: filed to match last");
> +			fuse_warning("lo_parent_and_name: filed to match last\n");

Typo *filed* -> *failed*, and others looks good to me. Feel free to add:

Reviewed-by: Jun Piao <piaojun@huawei.com>

Jun


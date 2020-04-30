Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD117C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 23:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BBE20873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 23:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BBE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUIAr-0008NO-PT
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 19:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slyfox@gentoo.org>) id 1jUI9m-000723-Nq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 18:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <slyfox@gentoo.org>) id 1jUI9k-0005T0-St
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 18:59:49 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:35202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <slyfox@gentoo.org>) id 1jUI9k-0005Ak-7t
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 18:59:48 -0400
Date: Thu, 30 Apr 2020 23:59:34 +0100
From: Sergei Trofimovich <slyfox@gentoo.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] linux-user/strace.list: fix epoll_create{,1} -strace
 output
Message-ID: <20200430235934.210904e7@sf>
In-Reply-To: <20200416175957.1274882-1-slyfox@gentoo.org>
References: <20200416175957.1274882-1-slyfox@gentoo.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=140.211.166.183; envelope-from=slyfox@gentoo.org;
 helo=smtp.gentoo.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 18:59:39
X-ACL-Warn: Detected OS   = ???
X-Received-From: 140.211.166.183
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Apr 2020 18:59:57 +0100
Sergei Trofimovich <slyfox@gentoo.org> wrote:

> Fix syscall name and parameters priinter.
> 
> Before the change:
> 
> ```
> $ alpha-linux-user/qemu-alpha -strace -L /usr/alpha-unknown-linux-gnu/ /tmp/a
> ...
> 1274697 %s(%d)(2097152,274903156744,274903156760,274905840712,274877908880,274903235616) = 3
> 1274697 exit_group(0)
> ```
> 
> After the change:
> 
> ```
> $ alpha-linux-user/qemu-alpha -strace -L /usr/alpha-unknown-linux-gnu/ /tmp/a
> ...
> 1273719 epoll_create1(2097152) = 3
> 1273719 exit_group(0)
> ```
> 
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> CC: Riku Voipio <riku.voipio@iki.fi>
> CC: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/strace.list | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index d49a1e92a8..9281c0a758 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -125,10 +125,10 @@
>  { TARGET_NR_dup3, "dup3" , "%s(%d,%d,%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_epoll_create
> -{ TARGET_NR_epoll_create, "%s(%d)", NULL, NULL, NULL },
> +{ TARGET_NR_epoll_create, "epoll_create", "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_epoll_create1
> -{ TARGET_NR_epoll_create1, "%s(%d)", NULL, NULL, NULL },
> +{ TARGET_NR_epoll_create1, "epoll_create1", "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_epoll_ctl
>  { TARGET_NR_epoll_ctl, "epoll_ctl" , NULL, NULL, NULL },
> -- 
> 2.26.1
> 

Should it be handled differently?

-- 

  Sergei


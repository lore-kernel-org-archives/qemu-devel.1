Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CD8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A47C22263
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eWD1AaS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A47C22263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUT8S-0004Us-CT
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUT7X-0003xW-05; Mon, 19 Oct 2020 07:14:31 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:35440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUT7T-0004ZO-Lv; Mon, 19 Oct 2020 07:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=MOfma3WLWYLYcQbaImizx7sndJJMOUFPubhYSdtKfPE=; 
 b=eWD1AaS7NYNB43xg7e4c2O/fVrRHdAygM+9N/rbGSCbNZ3VybNCLTFQR9JhQs88gdxmo5FRBgxRiqhP+Ra2VQrUbr1RcuUKzgO5B31//4COGyBFqaOBu5odsQK5qiG2hXXH19+cfWNbB1fjz1zIe9nPZctxBqLvVNmAy58nG2evZNnKAGsRJBHi6PPnGiSQwXwrcKwQ1Eg3hla+pmS9ycj8XtGaf5IDNVVJOaHaeo2q9WrB8cD+TTxYj8SrWT0dbTV9mVx28Y/YuM0A4C7h59a5ifgsSINeBqLE99f0ruiuNaFeROL6YroXHGWXgBb/EUTmkrBy0JV9yT7djwijXdQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kUT6s-0006sQ-Kz; Mon, 19 Oct 2020 13:13:50 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kUT6s-0002rh-Bf; Mon, 19 Oct 2020 13:13:50 +0200
From: Alberto Garcia <berto@igalia.com>
To: Zhengui li <lizhengui@huawei.com>, pbonzini@redhat.com, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH] qemu-img: add support for rate limit in qemu-img commit
In-Reply-To: <1603002839-1532-1-git-send-email-lizhengui@huawei.com>
References: <1603002839-1532-1-git-send-email-lizhengui@huawei.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 19 Oct 2020 13:13:50 +0200
Message-ID: <w51imb6lb81.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 07:14:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: xieyingtai@huawei.com, lizhengui@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun 18 Oct 2020 08:33:59 AM CEST, Zhengui li wrote:

Hello,

> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index b89c019..ed55b76 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -34,9 +34,9 @@ SRST
>  ERST
>  
>  DEF("commit", img_commit,
> -    "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-d] [-p] filename")
> +    "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-s speed] [-d] [-p] filename")
>  SRST
> -.. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t CACHE] [-b BASE] [-d] [-p] FILENAME
> +.. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t CACHE] [-b BASE] [-s SPEED] [-d] [-p] FILENAME
>  ERST

You should also update docs/tools/qemu-img.rst and explain what the new
parameter does.

> +        case 's': {
> +            unsigned long long sval;
> +            if (qemu_strtou64(optarg, NULL, 10, &sval)) {
> +                error_report("rate limit parse failed");
> +                return 1;
> +            }

You are using 'unsigned long long' here but qemu_strtou64() takes a
uint64_t.

> +            rate_limit = (int64_t)sval * 1024 * 1024;
> +        }   break;

And then you multiply that value by 1024*1024, which can overflow.

So I understand that the value received by 'qemu-img' is in megabytes?
Is there a reason for using that and not bytes?

qemu-img.c provides cvtnum() and cvtnum_full() which allow the user to
specify the units.

Berto


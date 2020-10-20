Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009DCC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F61D20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kSGeRPCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F61D20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUqUN-0003E5-0M
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 08:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUqTa-0002XP-L6; Tue, 20 Oct 2020 08:10:50 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:34265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUqTX-00076n-0X; Tue, 20 Oct 2020 08:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=zgYilRFZ+KzZ0ocjxhZjl606bWDPhCOHs0HByJHz5Lo=; 
 b=kSGeRPCsmEJXSEnkS3COeKge1Ccpeqmg61L3nFLDZJROHjKbEIETWXqsLx5KchJmaSphRKRuVmrGtEtjd4JDqaElVAa1DQoJr/MBhur7MgEsQJz64WkjQiOPjfqpkb+AEv1bsOMAB2OBQ15q/3+u1I6MhypM59ipc4zbiAOkT7wGfeOUNBNiaBKdpgN4nUh73vg9SxVxvJam/+F9Sx+1mDS/nK3tzravEVV1iy/+HV20AW7F1OJet5PTuFBfYPxk0e3dSBErTIJmFLsEslWx6P+9pm1flvdueDGX81H+w8A4qMLtZ+IGXP89fVdfdkHS+cPFnutQVSClIcLrUX1dEQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kUqTL-0000Zo-Ku; Tue, 20 Oct 2020 14:10:35 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kUqTL-00032r-AX; Tue, 20 Oct 2020 14:10:35 +0200
From: Alberto Garcia <berto@igalia.com>
To: Zhengui li <lizhengui@huawei.com>, pbonzini@redhat.com, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH v2 1/2] qemu-img: add support for offline rate limit in
 qemu-img commit
In-Reply-To: <1603193946-30096-1-git-send-email-lizhengui@huawei.com>
References: <1603193946-30096-1-git-send-email-lizhengui@huawei.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 20 Oct 2020 14:10:35 +0200
Message-ID: <w51k0vlm72c.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:53:12
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

On Tue 20 Oct 2020 01:39:05 PM CEST, Zhengui li wrote:
> From: Zhengui <lizhengui@huawei.com>
>
> Currently, there is no rate limit for qemu-img commit. This may
> cause the task of qemu-img commit to consume all the bandwidth
> of the storage. This will affect the IO performance of other processes
> and virtual machines under shared storage. So we add support for
> offline rate limit in qemu-img commit to get better quality of sevice.
>
> Signed-off-by: Zhengui <lizhengui@huawei.com>

Thanks for the patch!

When you send more than one patch you should add a cover letter (you can
use git format-patch --cover-letter).

See https://wiki.qemu.org/Contribute/SubmitAPatch#Include_a_meaningful_cover_letter

> +        case 'r': {
> +            int64_t sval;
> +
> +            sval = cvtnum("rate limit", optarg);
> +            if (sval < 0) {
> +                return 1;
> +            }
> +            rate_limit = sval;
> +        }   break;

I don't think you need sval here, do you?

rate_limit = cvtnum(...);
if (rate_limit < 0) {
    return 1;
}

Like that you can also get rid of the extra braces { }

Other than that the patch looks correct.

With that changed,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto


Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C32C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAA821707
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IP4wOmJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAA821707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUqWq-0005HK-Ug
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 08:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUqVu-0004TJ-F6; Tue, 20 Oct 2020 08:13:14 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:39035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUqVs-0007Ut-Kl; Tue, 20 Oct 2020 08:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=/FO5yBbSjkD3n/RNKhaSs2IodjZ3zclQOHp6Vll0tQk=; 
 b=IP4wOmJkAmdpaF4IYsYlmOV9OW6Elj4l42z+qNdGxpRpJf5mwMBmJe9dpmBOJb8rxog/xx1p1c7+oWLXRPsxeU3J6L2jREn0hDGYx5FMmXapUBAVsO1CfmfCYMkietOKoHauNq34js1l78Ndb9k1lT1Ag6oSenqbPwKW8kLLF8Q17AhP/XY41CaCgY2LLMs5r9oDFjsLylwmOXOf7Gm9iVPEjHTIZ2nUFqG1E9yulghSzBUVaKlvbFfMVgyp3pHarPw8CkbgX0LCXAanXcIa/FgJjPVoN9F2SRaRSb45tIBUeiuOMbvJUkx1lysWgdh1knRhX4jCvskc0sMBcumrcQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kUqVm-0000tU-8Y; Tue, 20 Oct 2020 14:13:06 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kUqVl-0003AX-Tf; Tue, 20 Oct 2020 14:13:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: Zhengui li <lizhengui@huawei.com>, pbonzini@redhat.com, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH v2 2/2] qemu-img: add support for rate limit in qemu-img
 convert
In-Reply-To: <1603193946-30096-2-git-send-email-lizhengui@huawei.com>
References: <1603193946-30096-1-git-send-email-lizhengui@huawei.com>
 <1603193946-30096-2-git-send-email-lizhengui@huawei.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 20 Oct 2020 14:13:05 +0200
Message-ID: <w51h7qpm6y6.fsf@maestria.local.igalia.com>
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

On Tue 20 Oct 2020 01:39:06 PM CEST, Zhengui li wrote:

> +static void set_rate_limit(BlockBackend *blk, int64_t rate_limit)
> +{
> +    ThrottleConfig cfg;
> +
> +    throttle_config_init(&cfg);
> +    cfg.buckets[THROTTLE_BPS_WRITE].avg = rate_limit;
> +
> +    blk_io_limits_enable(blk, CONVERT_THROTTLE_GROUP);
> +    blk_set_io_limits(blk, &cfg);
> +}

You only use this code once so I don't know if it really deserves to
have a separate function, but it's ok I guess :)

> +        case 'r': {
> +            int64_t sval;
> +
> +            sval = cvtnum("rate limit", optarg);
> +            if (sval < 0) {
> +                goto fail_getopt;
> +            }
> +            rate_limit = sval;
> +        }   break;

As with the other patch I would get rid of 'sval' here.

With that changed,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto


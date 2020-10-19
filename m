Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0173C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B06221FC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="L6rCpCP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B06221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTit-0006bU-Or
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUTbf-0003HV-2a; Mon, 19 Oct 2020 07:45:39 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUTbb-0000LX-Il; Mon, 19 Oct 2020 07:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=BQxHEpyK9mODEQoEkvGObDC3pveoQGgLpKiFk7h1qxg=; 
 b=L6rCpCP62W7Ql3Wa8leKxMIHmJiyO7d6PsHfrLoMfCuBe4NLC8OMfUP0yNLTdYHf4MMZVWNBdNPpYFtTtkNaMIimsrQBcm14y6A+hJ0J1YxVbkYL/B1ljdYWfW/UnblqV2npSe7XgMqvRlSmWRJNlVPjNJ+V5wZC8jPf6WP3Y2MAOYOFrCEwK8k+bgsVG+OIKNunQM3QegFUeIoMktX57j+oGw50T2INAW9yJv0fMJXHfealEtbLJcFSG63eFW+FFE333r2bZ9cbNo3HU4T5GFcaGSl2/W5TnZthi71Xjs0W/1NGAFrd906jjYvp+dVYwUF04wJqZEl1BHu7DvsElg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kUTbR-0002h0-HY; Mon, 19 Oct 2020 13:45:25 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kUTbR-0005Vj-89; Mon, 19 Oct 2020 13:45:25 +0200
From: Alberto Garcia <berto@igalia.com>
To: Zhengui li <lizhengui@huawei.com>, pbonzini@redhat.com, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH] qemu-img: add support for rate limit in qemu-img convert
In-Reply-To: <1603002879-26288-1-git-send-email-lizhengui@huawei.com>
References: <1603002879-26288-1-git-send-email-lizhengui@huawei.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 19 Oct 2020 13:45:25 +0200
Message-ID: <w51ft6al9re.fsf@maestria.local.igalia.com>
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

On Sun 18 Oct 2020 08:34:39 AM CEST, Zhengui li wrote:
> @@ -2729,6 +2757,10 @@ out:
>      qemu_opts_del(opts);
>      qemu_opts_free(create_opts);
>      qemu_opts_del(sn_opts);
> +    if (s.target && rate_limit &&
> +        blk_get_public(s.target)->throttle_group_member.throttle_state) {
> +        blk_io_limits_disable(s.target);
> +    }
>      qobject_unref(open_opts);
>      blk_unref(s.target);
>      if (s.src) {

Apart from the comments that I wrote to the other patch, which also
apply to this one, blk_delete() already calls blk_io_limits_disable() so
I don't think you need to do it manually here.

Berto


Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EF8C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4BC208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="DN8FopuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4BC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8hTa-0002Aq-N2
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 06:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k8hT4-0001kV-Ry
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 06:06:46 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:41869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k8hT2-0000ZB-4i
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 06:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=VfDXYx2I8gm/xIbKk3lJeExWNHDhb/aJ+QZss8ZGBg0=; b=DN8FopuJm0m3K8vCcRHRuJQssk
 RzYZAqVYnx+6z5sCl1rB/4i4NxylnkogWrVPS/Si+N6E/nxotrDvPo9ZSvfOcFK/15rq9f9Oiq0qb
 nlhixLOS5eQ56EfgSHqjHds7gl/HiL+qI6XwPvmuaiCRvgN4MW/jzqAHwlxp7K/TBjk/IR6W+fHQk
 T4PDXDkcZPV53f9MVrkdEc9b0c2wF7/rhLDVDNvKC+W6xktZese6cgDh03djWfBB7lXyxB55UL5h9
 XO6y/K7+28d8fxmmB6GzAlRWPkm1oNc8+ALvw74pEewxVCa7BGiuEa+QG+5TEz8LIcdGMAa6Tw+LF
 TQ+Pfvsw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Geoffrey McRae <geoff@hostfission.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 1/1] audio/jack: fix use after free segfault
Date: Thu, 20 Aug 2020 12:06:39 +0200
Message-ID: <3140676.b1PlGooJ8z@silver>
In-Reply-To: <20200820053728.kv7pngxqzp32uky3@sirius.home.kraxel.org>
References: <20200819062940.52774-1-geoff@hostfission.com>
 <5029913.bOW1W81TKx@silver>
 <20200820053728.kv7pngxqzp32uky3@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:06:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 20. August 2020 07:37:28 CEST Gerd Hoffmann wrote:
>   Hi,
> 
> > > +    qemu_bh_cancel(c->shutdown_bh);
> > 
> > Looks like a potential race. Quote from the API doc of qemu_bh_cancel():
> > 	"While cancellation itself is also wait-free and thread-safe, it can of
> > 	course race with the loop that executes bottom halves unless you are
> > 	holding the iothread mutex.  This makes it mostly useless if you are not
> > 	holding the mutex."
> 
> Should not be a problem, all auto backend code should only be called
> while qemu holds the iothread mutex.  With the exception of the shutdown
> handler which jack might call from signal context (which is why we need
> the BH in the first place).

Hmmm, as Geoffrey already added a lock today, I noticed that QEMU's main IO 
thread mutex is not initialized as 'recursive' lock type. Does that make 
sense? I.e. shouldn't there be a

	qemu_rec_mutex_init(&qemu_global_mutex);

in softmmu/cpus.c for safety reasons to prevent nested locks from same thread 
causing misbehaviour?

CCing Paolo to clarify.

Best regards,
Christian Schoenebeck




Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4997C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A038E20684
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujIkqr/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A038E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41885 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYW84-0003sf-Tf
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 09:39:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYW6Y-00030c-Vq
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYW6X-0007la-T1
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:37:26 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hYW6X-0007kR-Lk
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:37:25 -0400
Received: by mail-ed1-x542.google.com with SMTP id p26so5882198edr.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=z20ryOAhp/PAveE/iCVB47JTN54u+f0t7GSKvLL7ygE=;
	b=ujIkqr/ALHu68Q+Jsb7D5/mJ5zYduKXAmQ6g2B5B2UNV4QyZcHWcrv4GT5TgQ7yj6b
	q/K3eSDjsU++/I6qjljrIGT7f0or37vBpp7Il8Jm2zW9CHcaR1NYJ8jBnyfRt/jv1WLP
	g3ZcLTTDIOtPVBILehZLAK2TqJV3Rz5PHbNuXEdhfVs1hIjMNLcVpaPKEoh+rCEQZveT
	4f2aUQYYPRbUN90GthC9egFnw/s3H4euzY5lTxkzJSyybTRF6naN8Axiboy+VHC4qz1u
	MGIcfX0QvkJ9ZRBLObKRgilYV1GVyekCKDEuV+aQ1wwj5/U7kgSRXgCBMnzgib859yJC
	jT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=z20ryOAhp/PAveE/iCVB47JTN54u+f0t7GSKvLL7ygE=;
	b=sqffiGKkIJV11f5kWhCRyvDjpp5xsbiSSDwqY4MJK+Dm5u66IjbEnT+kQjr1WhkBBj
	WwSYd7wdrt+kPb+sINv85Pe415YbmHm9KETZOz4Jk4pV5KtWBtv+yQ+9MZEaGLV0Rgfm
	6SMGz6/GVFLhQebYKquzPWSDkYcAS5QFV+3apqv1hHQefLVVi7buBDbzWqwKu76a5sat
	vspRIaAGoJXAzp7qmGTucnYO2IOU8B6ObHc3Uy9iBbdgXbsDl7dQ69917OkA47C8webr
	qP3oCTQFo6P/QPSzF1M6OnLwEkhbu2Mc19IlBjf2gMAAzInLdkjbfqy9/arMk9bEucMN
	jibQ==
X-Gm-Message-State: APjAAAXSEfU3CQAU0SRjxeNVJdnuE3aiXINZBlfwzKJNpx2L0k9zfn/L
	+vNsVOp7AQ0jWCTID7YGEy0=
X-Google-Smtp-Source: APXvYqwLhsP6OCFDLuhXsZzCbNVtsCgvK7Kkxg0DFGhzCUPd9NNnQsFIEd2a7zxo2ApcymiegUzjOA==
X-Received: by 2002:a17:906:c404:: with SMTP id
	u4mr13782961ejz.123.1559741844592; 
	Wed, 05 Jun 2019 06:37:24 -0700 (PDT)
Received: from localhost ([185.92.221.13])
	by smtp.gmail.com with ESMTPSA id y8sm3755774ejq.24.2019.06.05.06.37.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 05 Jun 2019 06:37:23 -0700 (PDT)
Date: Wed, 5 Jun 2019 13:37:22 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190605133722.gjgqraifq53pdv6s@master>
References: <20190605115318.9972-1-quintela@redhat.com>
	<20190605115318.9972-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605115318.9972-6-quintela@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PULL 5/5] migratioin/ram: leave RAMBlock->bmap
 blank on allocating
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 01:53:18PM +0200, Juan Quintela wrote:
>From: Wei Yang <richardw.yang@linux.intel.com>
>
>During migration, we would sync bitmap from ram_list.dirty_memory to
>RAMBlock.bmap in cpu_physical_memory_sync_dirty_bitmap().
>
>Since we set RAMBlock.bmap and ram_list.dirty_memory both to all 1, this
>means at the first round this sync is meaningless and is a duplicated
>work.
>
>Leaving RAMBlock->bmap blank on allocating would have a side effect on
>migration_dirty_pages, since it is calculated from the result of
>cpu_physical_memory_sync_dirty_bitmap(). To keep it right, we need to
>set migration_dirty_pages to 0 in ram_state_init().
>
>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>Reviewed-by: Juan Quintela <quintela@redhat.com>
>Signed-off-by: Juan Quintela <quintela@redhat.com>

I think Peter acked this and gave some suggestions.

>---
> migration/ram.c | 18 +++++++++++++-----
> 1 file changed, 13 insertions(+), 5 deletions(-)
>
>diff --git a/migration/ram.c b/migration/ram.c
>index 03a9cce9f9..082aea9d23 100644
>--- a/migration/ram.c
>+++ b/migration/ram.c
>@@ -3173,11 +3173,11 @@ static int ram_state_init(RAMState **rsp)
>     QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
> 
>     /*
>-     * Count the total number of pages used by ram blocks not including any
>-     * gaps due to alignment or unplugs.
>+     * This must match with the initial values of dirty bitmap.
>+     * Currently we initialize the dirty bitmap to all zeros so
>+     * here the total dirty page count is zero.
>      */
>-    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
>-
>+    (*rsp)->migration_dirty_pages = 0;
>     ram_state_reset(*rsp);
> 
>     return 0;
>@@ -3192,8 +3192,16 @@ static void ram_list_init_bitmaps(void)
>     if (ram_bytes_total()) {
>         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>             pages = block->max_length >> TARGET_PAGE_BITS;
>+            /*
>+             * The initial dirty bitmap for migration must be set with all
>+             * ones to make sure we'll migrate every guest RAM page to
>+             * destination.
>+             * Here we didn't set RAMBlock.bmap simply because it is already
>+             * set in ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in
>+             * ram_block_add, and that's where we'll sync the dirty bitmaps.
>+             * Here setting RAMBlock.bmap would be fine too but not necessary.
>+             */
>             block->bmap = bitmap_new(pages);
>-            bitmap_set(block->bmap, 0, pages);
>             if (migrate_postcopy_ram()) {
>                 block->unsentmap = bitmap_new(pages);
>                 bitmap_set(block->unsentmap, 0, pages);
>-- 
>2.21.0
>

-- 
Wei Yang
Help you, Help me


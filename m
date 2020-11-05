Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B62C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 20:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D50120729
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmGHxQOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D50120729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kalQt-00071C-Px
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 15:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kalPR-0005ey-OP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:59:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kalPP-0003jr-8j
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604606337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tWkXgIleouugxo3PdpbwwVeevYp5tGB4/0J/7cKni1Q=;
 b=RmGHxQOfRYgucuyxty0d0EiGCJJEYJ2lZbq4HFFrIMgqzeoxOl5uc3PWKDX2Y1geM0KBgE
 DKBnyud2NJP6h7rkfTHl5WQ2ZCRlpwQJgVNXeWfoZ4q4hYmwHZSHcwGUz3gDdHi8pYRgER
 eSt7+6Gs2px1epv82aQVb2TUn/+nzMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-dfSJs9G9OhSkN-ZumfDpQA-1; Thu, 05 Nov 2020 14:58:56 -0500
X-MC-Unique: dfSJs9G9OhSkN-ZumfDpQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01E43805EF7;
 Thu,  5 Nov 2020 19:58:55 +0000 (UTC)
Received: from work-vm (ovpn-113-170.ams2.redhat.com [10.36.113.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 301D75B4DD;
 Thu,  5 Nov 2020 19:58:54 +0000 (UTC)
Date: Thu, 5 Nov 2020 19:58:51 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wayne Li <waynli329@gmail.com>
Subject: Re: QEMU RAM allocation function fails
Message-ID: <20201105195851.GC3187@work-vm>
References: <CAM2K0npECL3MpdkXH99htxGdTUTyC47PtnGAT4nkazpV6_rUPA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAM2K0npECL3MpdkXH99htxGdTUTyC47PtnGAT4nkazpV6_rUPA@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wayne Li (waynli329@gmail.com) wrote:
> Dear QEMU list members,
> 
> We developed a virtual machine that runs on QEMU.  This virtual
> machine is pretty much an emulated P4080 processor with some
> peripherals attached.  Initializing one of these peripherals, i.e. the
> RAM, seems to be having problems.  I use the function
> "memory_region_init_ram" to initialize the RAM and farther down the
> call stack I see that the "qemu_ram_alloc" function returns an address
> of 0 proving the RAM allocation wasn't successful.  Here is the block
> of code in question copied from the file memory.c:
> 
> void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
>                                              Object *owner,
>                                              const char *name,
>                                              uint64_t size,
>                                              bool share,
>                                              Error **errp)
> {
>     memory_region_init(mr, owner, name, size);
>     mr->ram = true;
>     mr->terminates = true;
>     mr->destructor = memory_region_destructor_ram;
>     mr->ram_block = qemu_ram_alloc(size, share, mr, errp);
>     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> }
> 
> Tracing farther into the "qemu_ram_alloc" function reveals that the
> function fails because inside the "qemu_ram_alloc_internal" function
> in file exec.c, the function "ram_block_add" fails.  Interestingly, a
> local_err object is populated here and the msg field in this object is
> populated with the String "cannot set up guest memory 'ram0': Invalid
> argument".  Here is the block of code in question copied from the file
> exec.c:

I'm surprised something didn't print that message out for you - most
callers pass something like &error_fatal at the end and it should print
it I think.

> 
> RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>                                   void (*resized)(const char*,
>                                                   uint64_t length,
>                                                   void *host),
>                                   void *host, bool resizeable, bool share,
>                                   MemoryRegion *mr, Error **errp)
> {
>     RAMBlock *new_block;
>     Error *local_err = NULL;
> 
>     size = HOST_PAGE_ALIGN(size);
>     max_size = HOST_PAGE_ALIGN(max_size);
>     new_block = g_malloc0(sizeof(*new_block));
>     new_block->mr = mr;
>     new_block->resized = resized;
>     new_block->used_length = size;
>     new_block->max_length = max_size;
>     assert(max_size >= size);
>     new_block->fd = -1;
>     new_block->page_size = getpagesize();
>     new_block->host = host;
>     if (host) {
>         new_block->flags |= RAM_PREALLOC;
>     }
>     if (resizeable) {
>         new_block->flags |= RAM_RESIZEABLE;
>     }
>     ram_block_add(new_block, &local_err, share);
>     if (local_err) {
>         g_free(new_block);
>         error_propagate(errp, local_err);
>         return NULL;
>     }
>     return new_block;
> }
> 
> Anyway, our VM runs fine until it tries to access the RAM region so
> this is a pretty critical problem for us to solve.  Does anyone know
> much about these QEMU functions?  What could be causing these RAM
> initialzation functions to fail in this way?

You're going the right way - keep following it; that 'cannot set up
guest memory' string is only in one place; softmmu/physmem.c - so
the phys_mem_alloc must have failed.  That suggests either your
max_length or your align requirements are wrong; but keep following
it along.

Dave

> -Thanks, Wayne Li
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



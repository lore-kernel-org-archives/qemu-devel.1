Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6D1C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0922074F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKPXdQ6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0922074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM6fl-0002In-51
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jM6LF-0004N8-51
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jM6LD-0002Dy-CW
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:45:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jM6LD-0002Do-4G
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586335546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CV6v+7b84TmRYGjD1UFwdw7I8sjvK5I7Q8fmXQQc8r0=;
 b=VKPXdQ6n+9D3zcdiJ6QlrvkI9kbzxgDVuSyMGEn3LQlVQUyoHcTZ64moWKCMTGCg4qlzhS
 DKsK/AQ5PRxxLWfFJ0mfYduARh9AvDvD0FJm/yjCk0dKfbdyVFWuARkv80v+rLt40YxpjF
 FNbjjgFyYp0Q7E9mO9FleZWmU+E6eg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-LPUBMjDMPMG_T__2zYdObQ-1; Wed, 08 Apr 2020 04:45:44 -0400
X-MC-Unique: LPUBMjDMPMG_T__2zYdObQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80491106BC09;
 Wed,  8 Apr 2020 08:45:43 +0000 (UTC)
Received: from localhost (unknown [10.40.208.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6948860BFB;
 Wed,  8 Apr 2020 08:45:38 +0000 (UTC)
Date: Wed, 8 Apr 2020 10:45:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH for-5.0] xen: fixup RAM memory region initialization
Message-ID: <20200408104536.4a353c10@redhat.com>
In-Reply-To: <20200407113634.GW4088@perard.uk.xensource.com>
References: <20200327104828.12647-1-imammedo@redhat.com>
 <20200330165248.GR4088@perard.uk.xensource.com>
 <20200402142925.75e0c482@redhat.com>
 <20200402132530.GS4088@perard.uk.xensource.com>
 <20200402163033.45585e70@redhat.com>
 <20200407113634.GW4088@perard.uk.xensource.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org,
 ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 12:36:34 +0100
Anthony PERARD <anthony.perard@citrix.com> wrote:

> On Thu, Apr 02, 2020 at 04:30:33PM +0200, Igor Mammedov wrote:
> > 1. why xen uses memory_region_init_ram() which does not allocate anything  
> 
> This seems to be due to history.
> 
> >    can it use plain memory_region_init() instead?  
> 
> I can give it a try. And it doesn't work, I had to call qemu_ram_alloc() as
> well, to set ram_memory.c.
> 
> On the other and, I think memory_region_init_ram_nomigrate() would be
> enough. QEMU didn't complain when I migrated the guest.

Why does it need ramblock fir main ram if it does not allocate nor migrate
it using QEMU infrastructure?

> 
> > 2. how main ram is allocated?  
> 
> It's done by the toolstack, libxl. It creates a new domain in the
> hypervisor, memory allocation is part of this, then QEMU is started, for
> emulation of some devices.
> 
> There is one thing that QEMU does in regards to memory, it's the call
> xc_domain_populate_physmap_exact() in xen_ram_alloc(). This is for when
> an emulated PCI device needs some memory, like for the VGA region.
> 
> > 3. code has
> >            /*                                                                       
> >          * Xen does not allocate the memory continuously, it keeps a             
> >          * hole of the size computed above or passed in.                         
> >          */                                                                      
> >         block_len = (1ULL << 32) + x86ms->above_4g_mem_size; 
> >    which fixes up size ram memory region
> >    can we allocate 1 memory region of ram_size and then
> >    alias lower and upper memory instead of that?  
> 
> I don't know, I don't think I know enough about how memory_region are
> used to be able to answer that.
> 
> > 4. how RAM migration works in case of xen?  
> 
> From QEMU, we only migrate devices states, we call the
> "xen-save-devices-state" QMP command. Memory migration is done by the
> toolstack. In QEMU, there is a bodge in xen_ram_alloc() to avoid having
> QEMU doing some "allocation" during migration.
> 
> I hope that help.
> Cheers,
> 



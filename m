Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277C7C2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A80206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAPaQoiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A80206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXB5-00008b-0w
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYXAA-0007rn-7C
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:49:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23497
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYXA7-00088q-Uw
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589298581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzfozrOy5KSJFpHnpS7fAp0DczTHi+CvFdOlx3IXCxs=;
 b=OAPaQoizJgmVE3rm2HRGymoWF8R0V05TIpIXVaDxhaAGpq9sBZPaolf7uVSr0vrheujpSC
 xbvvo3ALadbSTYtaw8LONQZVu7fHEal/A24wHFoS66ANPcJ1Ksj5TF7yNxJ2Png5gQZn9S
 z7PM/9gaeuNY39abc7EAoTB5gdgaT5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-4PD3AymmNF2rrBf-bomzew-1; Tue, 12 May 2020 11:49:39 -0400
X-MC-Unique: 4PD3AymmNF2rrBf-bomzew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37177872FE1;
 Tue, 12 May 2020 15:49:37 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9FDD5D9DD;
 Tue, 12 May 2020 15:49:23 +0000 (UTC)
Date: Tue, 12 May 2020 16:49:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RESEND v6 22/36] multi-process: Synchronize remote memory
Message-ID: <20200512154921.GG2802@work-vm>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <63a7f84be8c1c86d1bdea5f538239d0d9c3cdb06.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512150759.GL300009@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200512150759.GL300009@stefanha-x1.localdomain>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Wed, Apr 22, 2020 at 09:13:57PM -0700, elena.ufimtseva@oracle.com wrote:
> > diff --git a/hw/proxy/memory-sync.c b/hw/proxy/memory-sync.c
> > new file mode 100644
> > index 0000000000..b3f57747f3
> > --- /dev/null
> > +++ b/hw/proxy/memory-sync.c
> > @@ -0,0 +1,217 @@
> > +/*
> > + * Copyright © 2018, 2020 Oracle and/or its affiliates.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include <sys/types.h>
> > +#include <stdio.h>
> > +#include <string.h>
> 
> These headers should already be included by "qemu/osdep.h".
> 
> > +static void proxy_ml_region_addnop(MemoryListener *listener,
> > +                                   MemoryRegionSection *section)
> > +{
> > +    RemoteMemSync *sync = container_of(listener, RemoteMemSync, listener);
> > +    bool need_add = true;
> > +    uint64_t mrs_size, mrs_gpa, mrs_page;
> > +    uintptr_t mrs_host;
> > +    RAMBlock *mrs_rb;
> > +    MemoryRegionSection *prev_sec;
> > +
> > +    if (!(memory_region_is_ram(section->mr) &&
> > +          !memory_region_is_rom(section->mr))) {
> > +        return;
> > +    }
> > +
> > +    mrs_rb = section->mr->ram_block;
> > +    mrs_page = (uint64_t)qemu_ram_pagesize(mrs_rb);
> > +    mrs_size = int128_get64(section->size);
> > +    mrs_gpa = section->offset_within_address_space;
> > +    mrs_host = (uintptr_t)memory_region_get_ram_ptr(section->mr) +
> > +               section->offset_within_region;
> 
> These variables are only used in the if (sync->n_mr_sections) case. This
> function could be split into a something like this:
> 
>   static void proxy_ml_region_addnop(MemoryListener *listener,
>                                      MemoryRegionSection *section)
>       RemoteMemSync *sync = container_of(listener, RemoteMemSync, listener);
> 
>       if (!(memory_region_is_ram(section->mr) &&
>             !memory_region_is_rom(section->mr))) {
>           return;
>       }
> 
>       if (try_merge(sync, section)) {
>           return;
>       }
> 
>       ...add new section...
>   }
> 
> And the try_merge() helper function has the rest of the code:
> 
>   /* Returns true if the section was merged */
>   static bool try_merge(RemoteMemSync *sync, MemoryRegionSection *section)
>   {
>       if (sync->n_mr_sections == 0) {
>           return false;
>       }
> 
>       ...most of the code...
>   }
> 
> > +
> > +    if (get_fd_from_hostaddr(mrs_host, NULL) <= 0) {
> 
> 0 is a valid fd number, the comparison should probably be < 0?
> 
> > +        return;
> > +    }
> > +
> > +    mrs_host = mrs_host & ~(mrs_page - 1);
> > +    mrs_gpa = mrs_gpa & ~(mrs_page - 1);
> > +    mrs_size = ROUND_UP(mrs_size, mrs_page);
> 
> Why is it necessary to align to the RAM block's page size?
> 
> Can mrs_host and mrs_size be misaligned to the RAM block's page size?
> 
> Why round the *guest* physical address down using the *host* page size?

That sounds like the type of magic we do for postcopy; where we can only
'place' pages atomically on a host page boundary.

Dave

> > +
> > +    if (sync->n_mr_sections) {
> > +        prev_sec = sync->mr_sections + (sync->n_mr_sections - 1);
> > +        uint64_t prev_gpa_start = prev_sec->offset_within_address_space;
> > +        uint64_t prev_size = int128_get64(prev_sec->size);
> > +        uint64_t prev_gpa_end   = range_get_last(prev_gpa_start, prev_size);
> > +        uint64_t prev_host_start =
> > +            (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
> > +            prev_sec->offset_within_region;
> > +        uint64_t prev_host_end = range_get_last(prev_host_start, prev_size);
> 
> Is it okay not to do the page alignment stuff for the previous
> MemoryRegionSection?
> 
> > +void deconfigure_memory_sync(RemoteMemSync *sync)
> > +{
> > +    memory_listener_unregister(&sync->listener);
> > +}
> 
> This function is unused? It must be tied into the mpqemu_link lifecycle.
> It must be possible to hot plug/unplug proxy PCI devices without memory
> leaks or use-after-frees.
> 
> > diff --git a/include/hw/proxy/memory-sync.h b/include/hw/proxy/memory-sync.h
> > new file mode 100644
> > index 0000000000..d8329c9b52
> > --- /dev/null
> > +++ b/include/hw/proxy/memory-sync.h
> > @@ -0,0 +1,37 @@
> > +/*
> > + * Copyright © 2018, 2020 Oracle and/or its affiliates.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef MEMORY_SYNC_H
> > +#define MEMORY_SYNC_H
> > +
> > +#include <sys/types.h>
> > +
> > +#include "qemu/osdep.h"
> > +#include "qom/object.h"
> > +#include "exec/memory.h"
> > +#include "io/mpqemu-link.h"
> > +
> > +#define TYPE_MEMORY_LISTENER "memory-listener"
> 
> This name is too generic. There is already a C struct called
> MemoryListener. Please call this class "remote-memory-sync".
> 
> I'm not sure if a QOM object is needed here. Can this just be a plain C
> struct? If you're not using QOM object-orientated features then there is
> no need to define a QOM object.
> 
> > @@ -39,8 +40,13 @@ typedef struct ProxyMemoryRegion {
> >  struct PCIProxyDev {
> >      PCIDevice parent_dev;
> >  
> > +    int n_mr_sections;
> > +    MemoryRegionSection *mr_sections;
> 
> Is it necessary to duplicate these fields here since a RemoteMemSync
> field is also being added and it contains these same fields?


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



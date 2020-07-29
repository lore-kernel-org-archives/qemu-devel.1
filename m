Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FB420809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgzQHfHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FB420809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0m7z-0005x4-U2
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k0m7N-0005LK-Lk
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:27:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36530
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k0m7L-0001Gt-VK
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596029254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L8jdaDRG0GXZ61LUlX5za7TqyeIOkf1OM8fEt+atIkI=;
 b=XgzQHfHVsETFlGXzlF+JuySgu/e8B6y4uZ2lavb4U9/AlYE4sfDKZXQVVZpxfN+PVezY5c
 oFAw8cN/GL0xmd/GrLlXMpiH6dMSfLLIBsbJuyH520zIHGs7dQ7C1lwFTImh2Un/erwrrd
 w9wC1PD67E5IH4NcF97ynf32OXT6wW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-WwKmukndMIS8Yi6NhieEhw-1; Wed, 29 Jul 2020 09:27:31 -0400
X-MC-Unique: WwKmukndMIS8Yi6NhieEhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C62680BCA2;
 Wed, 29 Jul 2020 13:27:30 +0000 (UTC)
Received: from work-vm (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2C3719C71;
 Wed, 29 Jul 2020 13:27:23 +0000 (UTC)
Date: Wed, 29 Jul 2020 14:27:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 3/4] migration: add background snapshot
Message-ID: <20200729132721.GF2795@work-vm>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722081133.29926-4-dplotnikov@virtuozzo.com>
 <20200727164848.GR3040@work-vm>
 <092ca853-d4ec-788d-6f26-7361714b8dea@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <092ca853-d4ec-788d-6f26-7361714b8dea@virtuozzo.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
> 
> 
> On 27.07.2020 19:48, Dr. David Alan Gilbert wrote:
> > * Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
> ...
> > > +static void page_fault_thread_stop(void)
> > > +{
> > > +    if (page_fault_fd) {
> > > +        close(page_fault_fd);
> > > +        page_fault_fd = 0;
> > > +    }
> > I think you need to do that after you've done the quit and join,
> > otherwise the fault thread might still be reading this.
> 
> Seems to be so
> > 
> > > +    if (thread_quit_fd) {
> > > +        uint64_t val = 1;
> > > +        int ret;
> > > +
> > > +        ret = write(thread_quit_fd, &val, sizeof(val));
> > > +        assert(ret == sizeof(val));
> > > +
> > > +        qemu_thread_join(&page_fault_thread);
> > > +        close(thread_quit_fd);
> > > +        thread_quit_fd = 0;
> > > +    }
> > > +}
> ...
> > >   /**
> > >    * ram_find_and_save_block: finds a dirty page and sends it to f
> > >    *
> > > @@ -1782,6 +2274,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
> > >       pss.block = rs->last_seen_block;
> > >       pss.page = rs->last_page;
> > >       pss.complete_round = false;
> > > +    pss.page_copy = NULL;
> > >       if (!pss.block) {
> > >           pss.block = QLIST_FIRST_RCU(&ram_list.blocks);
> > > @@ -1794,11 +2287,30 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
> > >           if (!found) {
> > >               /* priority queue empty, so just search for something dirty */
> > >               found = find_dirty_block(rs, &pss, &again);
> > > +
> > > +            if (found && migrate_background_snapshot()) {
> > > +                /*
> > > +                 * make a copy of the page and
> > > +                 * pass it to the page search status
> > > +                 */
> > > +                int ret;
> > > +                ret = ram_copy_page(pss.block, pss.page, &pss.page_copy);
> > I'm a bit confused about why we hit this; the way I'd thought about your
> > code was we turn on the write faulting, do one big save and then fixup
> > the faults as the save is happening (doing the copies) as the writes
> > hit; so when does this case hit?
> 
> To make it more clear, let me draw the whole picture:
> 
> When we do background snapshot, the vm is paused untill all vmstate EXCEPT
> ram is saved.
> RAM isn't written at all. That vmstate part is saved in the temporary
> buffer.
> 
> Then all the RAM is marked as read-only and the vm is un-paused. Note that
> at this moment all vm's vCPUs are
> running and can touch any part of memory.
> After that, the migration thread starts writing the ram content. Once a
> memory chunk is written, the write protection is removed for that chunk.
> If a vCPU wants to write to a memory page which is write protected (hasn't
> been written yet), this write is intercepted, the memory page is copied
> and queued for writing, the memory page write access is restored. The
> intention behind of that, is to allow vCPU to work with a memory page as
> soon as possible.

So I think I'm confusing this description with the code I'm seeing
above.  The code above, being in ram_find_and_save_block makes me think
it's calling ram_copy_page for every page at the point just before it
writes it - I'm not seeing how that corresponds to what you're saying
about it being queued when the CPU tries to write it.

> Once all the RAM has been written, the rest of the vmstate is written from
> the buffer. This needs to be so because some of the emulated devices, saved
> in that
> buffered vmstate part, expects the RAM content to be available first on its
> loading.

Right, same type of problem as postcopy.

Dave

> 
> I hope this description will make things more clear.
> If not, please let me know, so I could add more details.
> 
> Denis
> 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



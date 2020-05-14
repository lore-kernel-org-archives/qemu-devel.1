Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18822C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C834F20671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+BzpsG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C834F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZAXd-0003ed-UK
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 05:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZAWw-0003Cx-Fw
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:51:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42773
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZAWu-0002P0-Lh
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589449911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=meTD/jnqlNvqnn83aNL1kAVfPwR7jZuni8AgBLQPows=;
 b=R+BzpsG/2m9htfiNwJI8+f8dxtGf8LOFzSzdjQYWLVp15j1dPKdQIVR1lBlpqT+Lu3crpi
 YUo7EHIyAcuSGJjsjexjw0cGFgqBtOmvmk/nN7Kl3svt6geknCHp0jJmFt5U/PbbPMxZgD
 Xrm/+YoZrj2yIR5wD1i/1D+yT7DXbwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-b0wAHdf0OXuBrNblrDdHMQ-1; Thu, 14 May 2020 05:51:49 -0400
X-MC-Unique: b0wAHdf0OXuBrNblrDdHMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEDF3EC1A1;
 Thu, 14 May 2020 09:51:47 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1798010027AC;
 Thu, 14 May 2020 09:51:34 +0000 (UTC)
Date: Thu, 14 May 2020 10:51:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [PATCH RESEND v6 01/36] memory: alloc RAM from file at offset
Message-ID: <20200514095132.GF2787@work-vm>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <cb792b8d6f93d00c10790de8698c468b6ff4ab69.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512084855.GC1191162@redhat.com>
 <B4DB4B9E-E7E3-4F1F-917C-898F9B150EFB@oracle.com>
 <20200513084042.GA317907@stefanha-x1.localdomain>
 <20200513172547.48d87447@redhat.com>
 <C83E7EA9-7813-4C81-A635-E1A513902330@oracle.com>
MIME-Version: 1.0
In-Reply-To: <C83E7EA9-7813-4C81-A635-E1A513902330@oracle.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net, kwolf@redhat.com,
 Daniel Berrange <berrange@redhat.com>, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jag Raman (jag.raman@oracle.com) wrote:
> 
> 
> > On May 13, 2020, at 11:25 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > On Wed, 13 May 2020 09:40:42 +0100
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > 
> >> On Tue, May 12, 2020 at 07:56:33AM -0400, Jag Raman wrote:
> >>> 
> >>> 
> >>>> On May 12, 2020, at 4:48 AM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >>>> 
> >>>> On Wed, Apr 22, 2020 at 09:13:36PM -0700, elena.ufimtseva@oracle.com wrote:  
> >>>>> From: Jagannathan Raman <jag.raman@oracle.com>
> >>>>> 
> >>>>> Allow RAM MemoryRegion to be created from an offset in a file, instead
> >>>>> of allocating at offset of 0 by default. This is needed to synchronize
> >>>>> RAM between QEMU & remote process.  
> >>>> 
> >>>> Can you elaborate on why remote processes require the RAM to be offset
> >>>> from zero ?  
> >>> 
> >>> Hi Daniel,
> >>> 
> >>> As it turns out, the RAM is scattered across the physical address space
> >>> (system_memory) of QEMU. Therefore, the system memory is composed
> >>> of multiple sections of RAM, and some sections start at a non-zero RAM
> >>> offset.
> >>> 
> >>> As a result, the remote process needs the ability to map these RAM
> >>> sections into system_memory.  
> >> 
> >> To explain a bit more, my understanding is that the offset is
> >> specifically for mmap(2). As Jag alluded to, multiple sections can use a
> >> single backing RAM file. These sections have different offsets in the
> >> file.
> >> 
> >> Jag, maybe you can include a concrete explanation like the following in
> >> the commit description:
> >> 
> >> Launch QEMU like this:
> >> 
> >>  qemu-system-x86_64 -mem-path /dev/shm -m 8G
> >> 
> >> There is only one RAM file descriptor:
> >> 
> >>  $ cat /proc/$(pidof qemu)/fd
> >>  ...
> >>  lrwx------. 1 stefanha stefanha 64 May 13 09:34 19 -> '/dev/shm/qemu_back_mem.pc.ram.7YAlqn (deleted)'
> >> 
> >> But the memory tree shows that single file is split into multiple ranges
> >> of guest physical address space:
> >> 
> >>  (qemu) info mtree
> >>  memory-region: system
> >>  0000000000000000-ffffffffffffffff (prio 0, i/o): system
> >>    0000000000000000-00000000bfffffff (prio 0, i/o): alias ram-below-4g @pc.ram 0000000000000000-00000000bfffffff
> >>    ...
> >>    0000000100000000-000000023fffffff (prio 0, i/o): alias ram-above-4g @pc.ram 00000000c0000000-00000001ffffffff
> >> 
> >> This means QEMU needs to send two regions to the remote device process.
> >> They both mmap the same file but from different starting file offsets.
> > 
> > are we talking here about GPA offests her or about host offsets in mmaped host file?
> > If it's the later then above mtree doesn't show true picture (those entries are just aliases),
> > main guest RAM is allocated as a single continuous chunk (so far) which belongs
> > to a memory-backend.
> 
> Thanks for the info about ‘mtree’ QMP option. We’ll use that to better explain the need for offset
> during memory allocation.
> 
> As we can observe from the ‘mtree’ output, different sections of system memory vector into the
> RAM. Since we have only one file descriptor available for all of RAM, we need to mmap() these
> sections at different offsets within the memory file.
> 
> Hey Igor, the offset passed into the mmap() syscall is the offset within host file. Thanks for
> pointing out that these are aliases. I believe the mmap() operation is equivalent to the “alias”
> operation within MemoryRegion framework. We are sending the ‘fd’, ‘offset’ within the fd and
> the size of these RAM regions to the remote device over the unix socket. Hopefully, this looks
> good to you.

Vhost-user already does something similar; see it's
vhost_user_fill_set_mem_table_msg:

            msg->payload.memory.regions[*fd_num].userspace_addr =
                reg->userspace_addr;
            msg->payload.memory.regions[*fd_num].memory_size =
                reg->memory_size;
            msg->payload.memory.regions[*fd_num].guest_phys_addr =
                reg->guest_phys_addr;
            msg->payload.memory.regions[*fd_num].mmap_offset = offset;

Note you're not needing to map the fd with an offset on the qemu side,
it's something only needed on the remote.

Dave

> Thanks!
> --
> Jag
> 
> > 
> >> Stefan
> > 
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



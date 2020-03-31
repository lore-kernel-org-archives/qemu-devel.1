Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DD9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 19:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9CD2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 19:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPxUQ1nQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9CD2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJMZZ-0000CF-Vp
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 15:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jJMYr-00085b-MI
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jJMYp-0002yV-Sv
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:28:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21860
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jJMYp-0002y1-IM
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585682910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14AouyvoiVM6Rr1P9WqHOVjO0WYwEYfDMIoyNpa3BII=;
 b=XPxUQ1nQ6WadENoSxQHZ9wfSlxSPSQNiIQ6fJVihYXzkydP5Vnlr3V05XTZrlndotd5F07
 sMlQIG8f3+7iZUwEApybw67a0X5KEhkqVviC5N/DSUvYkfj8HFATjhj9D2RJxjT27SLMwM
 Ff1Yq2DV+ZrseAnHra0LJS/oRKq/zGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-6cEi1hVdM1qcO2Xneb3vDw-1; Tue, 31 Mar 2020 15:28:29 -0400
X-MC-Unique: 6cEi1hVdM1qcO2Xneb3vDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 360C9101FC65;
 Tue, 31 Mar 2020 19:28:28 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B84FE96B93;
 Tue, 31 Mar 2020 19:28:27 +0000 (UTC)
Date: Tue, 31 Mar 2020 13:28:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH] hw/vfio: let readonly flag take effect for mmaped regions
Message-ID: <20200331132827.514b73b0@w520.home>
In-Reply-To: <20200331015941.GD6631@joy-OptiPlex-7040>
References: <20200327111934.71066-1-yan.y.zhao@intel.com>
 <20200327112537.2efd65ac@w520.home>
 <20200330013527.GA30683@joy-OptiPlex-7040>
 <20200330063402.GE30683@joy-OptiPlex-7040>
 <20200330085923.19d7345f@w520.home>
 <20200331015941.GD6631@joy-OptiPlex-7040>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Zeng,
 Xin" <xin.zeng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 21:59:41 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Mon, Mar 30, 2020 at 10:59:23PM +0800, Alex Williamson wrote:
> > On Mon, 30 Mar 2020 02:34:02 -0400
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >   
> > > On Mon, Mar 30, 2020 at 09:35:27AM +0800, Yan Zhao wrote:  
> > > > On Sat, Mar 28, 2020 at 01:25:37AM +0800, Alex Williamson wrote:    
> > > > > On Fri, 27 Mar 2020 11:19:34 +0000
> > > > > yan.y.zhao@intel.com wrote:
> > > > >     
> > > > > > From: Yan Zhao <yan.y.zhao@intel.com>
> > > > > > 
> > > > > > currently, vfio regions without VFIO_REGION_INFO_FLAG_WRITE are only
> > > > > > read-only when VFIO_REGION_INFO_FLAG_MMAP is not set.
> > > > > > 
> > > > > > regions with flag VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_MMAP
> > > > > > are only read-only in host page table for qemu.
> > > > > > 
> > > > > > This patch sets corresponding ept page entries read-only for regions
> > > > > > with flag VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_MMAP.
> > > > > > 
> > > > > > accordingly, it ignores guest write when guest writes to the read-only
> > > > > > regions are trapped.
> > > > > > 
> > > > > > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > > > > > Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> > > > > > ---    
> > > > > 
> > > > > Currently we set the r/w protection on the mmap, do I understand
> > > > > correctly that the change in the vfio code below results in KVM exiting
> > > > > to QEMU to handle a write to a read-only region and therefore we need
> > > > > the memory.c change to drop the write?  This prevents a SIGBUS or
> > > > > similar?    
> > > > yes, correct. the change in memory.c is to prevent a SIGSEGV in host as
> > > > it's mmaped to read-only. we think it's better to just drop the writes
> > > > from guest rather than corrupt the qemu.
> > > >     
> > > > > 
> > > > > Meanwhile vfio_region_setup() uses the same vfio_region_ops for all
> > > > > regions and vfio_region_write() would still allow writes, so if the
> > > > > device were using x-no-mmap=on, I think we'd still get a write to this
> > > > > region and expect the vfio device to drop it.  Should we prevent that
> > > > > write in QEMU as well?    
> > > > yes, it expects vfio device to drop it right now.
> > > > As the driver sets the flag without VFIO_REGION_INFO_FLAG_WRITE, it should
> > > > handle it properly.
> > > > both dropping in qemu and dropping in vfio device are fine to us.
> > > > we wonder which one is your preference :)  
> > 
> > The kernel and device should always do the right thing, we cannot rely
> > on the user to honor the mapping, but it's also a reasonable response
> > from the kernel to kill the process with a SIGSEGV if the user ignores
> > the protections.  So I don't think it's an either/or, the kernel needs
> > to do the right thing for itself and in this case QEMU should do the
> > right thing for itself, which is to drop writes for regions that don't
> > support it.  So in general, I agree with your patch.
> >  
> hi Alex
> so is there anything I need to do? do I need to add a write dropping in
> vfio_region_write() too? if yes, do I need to keep the
> trace_vfio_region_write() before dropping ?

Hi Yan,

Yes to both feels the most consistent, right?  If we want the same
behavior between mmap'd and non-mmap'd regions, QEMU should drop both
writes.  Your change to memory_region_ram_device_write() drops the
write after tracing.  For both cases though it might be worthwhile to
have a separate trace recorded to indicate a dropped write, probably in
place of the normal trace to avoid confusion.  Thanks,

Alex



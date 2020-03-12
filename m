Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250C4C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC2E20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpGPRqfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC2E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOVG-0003gJ-4c
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jCOUe-0003GL-3p
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jCOUc-0006B1-E0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:07:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24749
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jCOUc-0006AT-9r
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584022041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rR6It2UNdhtMo/RNClesXv8k20c19FCRC7egYni4KgY=;
 b=gpGPRqfSl2vJPK5AsOlc5Q0fxMy+s9BUbLjspVVzP5Qb4PVMZhobve7QVnFI3CtX9exDYJ
 vQWs33+IWsVpivTiOdwvOGcTwJ14bXyG8/a+idH+OlWiVIvlYEZhuY3Lebhx/EdVkJweA9
 /oKWmWd3zG0eqXkCnsHLp7HjJBLIiyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-25QYEr2JMZupVNqAEvqDtQ-1; Thu, 12 Mar 2020 10:07:12 -0400
X-MC-Unique: 25QYEr2JMZupVNqAEvqDtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F4EC100550E;
 Thu, 12 Mar 2020 14:07:11 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3576390CFF;
 Thu, 12 Mar 2020 14:07:07 +0000 (UTC)
Date: Thu, 12 Mar 2020 08:07:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RESEND 1/3] vfio/pci: fix a null pointer reference in
 vfio_rom_read
Message-ID: <20200312080706.3f6f9d8e@w520.home>
In-Reply-To: <87zhcmrujd.fsf@dusky.pond.sub.org>
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-2-longpeng2@huawei.com>
 <20200224090458.080152c0@w520.home>
 <87k13rl6df.fsf@dusky.pond.sub.org>
 <20200311093939.494bfe27@w520.home>
 <87zhcmrujd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: weifuqiang@huawei.com, mst@redhat.com, qemu-devel@nongnu.org,
 arei.gonglei@huawei.com, huangzhichao@huawei.com,
 "Longpeng\(Mike\)" <longpeng2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 06:50:30 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Alex Williamson <alex.williamson@redhat.com> writes:
> 
> > On Wed, 11 Mar 2020 08:04:28 +0100
> > Markus Armbruster <armbru@redhat.com> wrote:
> >  
> >> Alex Williamson <alex.williamson@redhat.com> writes:
> >>   
> >> > On Mon, 24 Feb 2020 14:42:17 +0800
> >> > "Longpeng(Mike)" <longpeng2@huawei.com> wrote:
> >> >    
> >> >> From: Longpeng <longpeng2@huawei.com>
> >> >> 
> >> >> vfio_pci_load_rom() maybe failed and then the vdev->rom is NULL in
> >> >> some situation (though I've not encountered yet), maybe we should
> >> >> avoid the VM abort.    
> >> 
> >> What "VM abort" exactly?  
> >
> > There is none because memcpy() does something sane when size is zero,
> > but to be ISO whatever spec compliant we shouldn't rely on that.
> >  
> >> >> 
> >> >> Signed-off-by: Longpeng <longpeng2@huawei.com>
> >> >> ---
> >> >>  hw/vfio/pci.c | 13 ++++++++-----
> >> >>  1 file changed, 8 insertions(+), 5 deletions(-)
> >> >> 
> >> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >> >> index 5e75a95..ed798ae 100644
> >> >> --- a/hw/vfio/pci.c
> >> >> +++ b/hw/vfio/pci.c
> >> >> @@ -768,7 +768,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
> >> >>      }
> >> >>  }
> >> >>  
> >> >> -static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
> >> >> +static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
> >> >>  {
> >> >>      struct vfio_region_info *reg_info;
> >> >>      uint64_t size;
> >> >> @@ -778,7 +778,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
> >> >>      if (vfio_get_region_info(&vdev->vbasedev,
> >> >>                               VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
> >> >>          error_report("vfio: Error getting ROM info: %m");
> >> >> -        return;
> >> >> +        return false;
> >> >>      }
> >> >>  
> >> >>      trace_vfio_pci_load_rom(vdev->vbasedev.name, (unsigned long)reg_info->size,
> >> >> @@ -797,7 +797,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
> >> >>          error_printf("Device option ROM contents are probably invalid "
> >> >>                      "(check dmesg).\nSkip option ROM probe with rombar=0, "
> >> >>                      "or load from file with romfile=\n");
> >> >> -        return;
> >> >> +        return false;
> >> >>      }
> >> >>  
> >> >>      vdev->rom = g_malloc(size);
> >> >> @@ -849,6 +849,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
> >> >>              data[6] = -csum;
> >> >>          }
> >> >>      }
> >> >> +
> >> >> +    return true;
> >> >>  }
> >> >>  
> >> >>  static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
> >> >> @@ -863,8 +865,9 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)    
> >>     {
> >>         VFIOPCIDevice *vdev = opaque;
> >>         union {
> >>             uint8_t byte;
> >>             uint16_t word;
> >>             uint32_t dword;
> >>             uint64_t qword;
> >>         } val;  
> >> >>      uint64_t data = 0;
> >> >>  
> >> >>      /* Load the ROM lazily when the guest tries to read it */
> >> >> -    if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
> >> >> -        vfio_pci_load_rom(vdev);
> >> >> +    if (unlikely(!vdev->rom && !vdev->rom_read_failed) &&
> >> >> +        !vfio_pci_load_rom(vdev)) {
> >> >> +        return 0;
> >> >>      }
> >> >>  
> >> >>      memcpy(&val, vdev->rom + addr,    
> >> >
> >> > Looks like an obvious bug, until you look at the rest of this memcpy():
> >> >
> >> > memcpy(&val, vdev->rom + addr,
> >> >            (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
> >> >
> >> > IOW, we'll do a zero sized memcpy() if rom_size is zero, so there's no
> >> > risk of the concern identified in the commit log.  This patch is
> >> > unnecessary.  Thanks,    
> >> 
> >> I'm blind: why does !vdev->rom imply !vdev->rom_size?  
> >
> > See vfio_pci_load_rom(), rom_size and rom are set and allocated
> > together.  
> 
> What if vfio_pci_load_rom() isn't called, or returns before it sets
> these guys?

vfio_pci_load_rom() is called from this read function if they're not
set and we haven't triggered a read failure.  They're zero allocated.
The intention is that any vfio_pci_load_rom() failure will leave these
unset and trigger a zero sized memcpy, or now skip the mempcy as in the
patch below.  Thanks,

Alex

> >> Moreover, when MIN(size, vdev->rom_size - addr) < size, we seem to read
> >> uninitialized data from @val:  
> >
> > This is fixed in my patch
> > https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg02778.html  
> 
> Yes.
> 
> >> 
> >>         switch (size) {
> >>         case 1:
> >>             data = val.byte;
> >>             break;
> >>         case 2:
> >>             data = le16_to_cpu(val.word);
> >>             break;
> >>         case 4:
> >>             data = le32_to_cpu(val.dword);
> >>             break;
> >>         default:
> >>             hw_error("vfio: unsupported read size, %d bytes\n", size);
> >>             break;
> >>         }
> >> 
> >>         trace_vfio_rom_read(vdev->vbasedev.name, addr, size, data);
> >> 
> >>         return data;
> >>     }
> >> 
> >> Why is that okay?
> >> 
> >> Why do we initialize @data?  
> >
> > Bug.  The switch was only added later (75bd0c7253f3) and we failed to
> > catch it.  Prior to that we were initializing val and the memcpy() only
> > overwrote it as necessary.  In any case, getting back garbage for the
> > rom when there isn't one generally works ok since the chances of
> > generating a proper rom signature are infinitesimal.  Clearly not what
> > was intended though.
> >  
> >> How can we get to the default case?  If we can get there, is hw_error()
> >> really the right thing to do?  It almost never is...  If getting there
> >> is the guest's fault, we need to tell it off the same way physical
> >> hardware does.  If we should not ever get there (i.e. it's a QEMU bug),
> >> then a plain abort() would be clearer.  
> >
> > AFAIK this is relatively standard, if not somewhat paranoid, handling
> > for a MemoryRegion ops callback.  The MemoryRegionOps code only allows
> > certain size accesses, so it would effectively be an internal error to
> > hit the default case, which seems to be not an uncommon use case of
> > hw_error.  Thanks,  
> 
> Using hw_error() for such programming errors is not helpful.  Everything
> it adds to abort() is useless or misleading.
> 
> In fact, most uses of hw_error() are not helpful.
> 
> But you're going with the flow here.  I accept that.



Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21012C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E355820873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPsGbL2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E355820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBhUR-0003qq-4g
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jBhTY-0003QO-SM
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jBhTW-0004mJ-8Q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:11:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30168
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jBhTW-0004ku-33
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583856681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bfKOZr3R4F0BZwo+ubAZXzfY4xLhFaetFjle8rAobg=;
 b=DPsGbL2ji2mankJGzO+xvraF78hrHeta0gA5m/epzU/P28B6gIpl7nZQqrYfO2anQnIKD5
 FdukixKJ3n38ltjsqj+8ciL9j/WLsJsDAeyI2V5BHa4ZqKMqtNcJalNkL9nw7wWQYmrv/x
 /i9G+T21sZcWMBkm6fCwy/7K9Js/v20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-dEi8-dQWMaeiVWzTvg9P_g-1; Tue, 10 Mar 2020 12:11:14 -0400
X-MC-Unique: dEi8-dQWMaeiVWzTvg9P_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 966738EDBF2;
 Tue, 10 Mar 2020 16:11:10 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09AC128992;
 Tue, 10 Mar 2020 16:11:08 +0000 (UTC)
Date: Tue, 10 Mar 2020 10:11:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
Subject: Re: [PATCH RESEND 1/3] vfio/pci: fix a null pointer reference in
 vfio_rom_read
Message-ID: <20200310101108.3377b878@x1.home>
In-Reply-To: <5b6a9b3c-0efe-8f57-d61e-731e9fd51470@huawei.com>
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-2-longpeng2@huawei.com>
 <20200224090458.080152c0@w520.home>
 <5b6a9b3c-0efe-8f57-d61e-731e9fd51470@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 07:48:33 +0800
"Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
<longpeng2@huawei.com> wrote:

> On 2020/2/25 0:04, Alex Williamson wrote:
> > On Mon, 24 Feb 2020 14:42:17 +0800
> > "Longpeng(Mike)" <longpeng2@huawei.com> wrote:
> >   
> >> From: Longpeng <longpeng2@huawei.com>
> >>
> >> vfio_pci_load_rom() maybe failed and then the vdev->rom is NULL in
> >> some situation (though I've not encountered yet), maybe we should
> >> avoid the VM abort.
> >>
> >> Signed-off-by: Longpeng <longpeng2@huawei.com>
> >> ---
> >>  hw/vfio/pci.c | 13 ++++++++-----
> >>  1 file changed, 8 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >> index 5e75a95..ed798ae 100644
> >> --- a/hw/vfio/pci.c
> >> +++ b/hw/vfio/pci.c
> >> @@ -768,7 +768,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
> >>      }
> >>  }
> >>  
> >> -static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
> >> +static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
> >>  {
> >>      struct vfio_region_info *reg_info;
> >>      uint64_t size;
> >> @@ -778,7 +778,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
> >>      if (vfio_get_region_info(&vdev->vbasedev,
> >>                               VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
> >>          error_report("vfio: Error getting ROM info: %m");
> >> -        return;
> >> +        return false;
> >>      }
> >>  
> >>      trace_vfio_pci_load_rom(vdev->vbasedev.name, (unsigned long)reg_info->size,
> >> @@ -797,7 +797,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
> >>          error_printf("Device option ROM contents are probably invalid "
> >>                      "(check dmesg).\nSkip option ROM probe with rombar=0, "
> >>                      "or load from file with romfile=\n");
> >> -        return;
> >> +        return false;
> >>      }
> >>  
> >>      vdev->rom = g_malloc(size);
> >> @@ -849,6 +849,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
> >>              data[6] = -csum;
> >>          }
> >>      }
> >> +
> >> +    return true;
> >>  }
> >>  
> >>  static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
> >> @@ -863,8 +865,9 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
> >>      uint64_t data = 0;
> >>  
> >>      /* Load the ROM lazily when the guest tries to read it */
> >> -    if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
> >> -        vfio_pci_load_rom(vdev);
> >> +    if (unlikely(!vdev->rom && !vdev->rom_read_failed) &&
> >> +        !vfio_pci_load_rom(vdev)) {
> >> +        return 0;
> >>      }
> >>  
> >>      memcpy(&val, vdev->rom + addr,  
> > 
> > Looks like an obvious bug, until you look at the rest of this memcpy():
> > 
> > memcpy(&val, vdev->rom + addr,
> >            (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
> > 
> > IOW, we'll do a zero sized memcpy() if rom_size is zero, so there's no
> > risk of the concern identified in the commit log.  This patch is
> > unnecessary.  Thanks,
> >   
> Oh, I missed that, sorry for make the noise, thanks

Actually, not noise.  After some internal discussion thanks to Laszlo,
it seems that while memcpy() with a zero size seems to do the right
thing, the behavior for any case where we pass a null pointer is not
actually defined.  However, there's still a bug in the implementation
of the fix above, if vdev->rom_read_failed is set, we'll still fall
through to the memcpy.  I think there's also another bug in the current
implementation that we initialize data to zero but we'll overwrite it
with the uninitialized 'val' in the switch statement.  I think the
below resolves both.  I'll formally post it after a bit of testing:

commit 2088fc1e1f426b98e9ca4d7bcdbe53d886a18c37
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Tue Mar 10 10:04:36 2020 -0600

    vfio/pci: Use defined memcpy() behavior
    
    vfio_rom_read() relies on memcpy() doing the logically correct thing,
    ie. safely copying zero bytes from a NULL pointer when rom_size is
    zero, rather than the spec definition, which is undefined when the
    source or target pointers are NULL.  Resolve this by wrapping the
    call in the condition expressed previously by the ternary.
    
    Additionally, we still use @val to fill data based on the provided
    @size regardless of mempcy(), so we should initialize @val rather
    than @data.
    
    Reported-by: Longpeng <longpeng2@huawei.com>
    Reported-by: Laszlo Ersek <lersek@redhat.com>
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5e75a95129ac..b0799cdc28ad 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -859,16 +859,17 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
         uint16_t word;
         uint32_t dword;
         uint64_t qword;
-    } val;
-    uint64_t data = 0;
+    } val = { 0 };
+    uint64_t data;
 
     /* Load the ROM lazily when the guest tries to read it */
     if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
         vfio_pci_load_rom(vdev);
     }
 
-    memcpy(&val, vdev->rom + addr,
-           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
+    if (addr < vdev->rom_size) {
+        memcpy(&val, vdev->rom + addr, MIN(size, vdev->rom_size - addr));
+    }
 
     switch (size) {
     case 1:






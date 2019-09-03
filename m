Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BEBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028E222CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGJf8W5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028E222CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Gcw-0002s5-8d
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <skrtbhtngr@gmail.com>) id 1i5GQj-0007FF-Qp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skrtbhtngr@gmail.com>) id 1i5GQh-0001cW-KJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:33:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
 id 1i5GQf-0001bQ-Ny
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:33:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id g207so997655wmg.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=awgfOpwvDAovCi5JmOSNnZrXf5kVuQ4eu4El+yyvK1Y=;
 b=QGJf8W5oAa/lVTXaHC94Tk464RwyKLAz84+58gZQTy0p/osuEl6PxoVzO+TY7dKAAX
 54EcOVMjbZjzkabIcmEY+TGeUfF05GNK1wDC70lbyfzZLc72XQnDtbD0Wm1Ku5+Wcl4f
 fPlYF9BiF/zX2GLSOGBEQumWq6XdATivGmqqsmARwuG2BvBA01g9Fv97rD4Ry8AccWiB
 eeFKWrilCTwDO9nkY6RcVimUJuBeItP2+NAA/qAUXGxjU/I6zUokivweMhER4B+uosvo
 inSyEU8n+oJgtVbMp/TfTrEy6uPrvUNR3tn1JFz0gpSvdsf2tZ6PUN9VLYpJ6FEvgSaZ
 aqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=awgfOpwvDAovCi5JmOSNnZrXf5kVuQ4eu4El+yyvK1Y=;
 b=toqWugdP4X4WboGu3GEv4mWv4DpkrItKAj8nAcqYBnDv5wUMdvsvBFrz0V3CwvEHzg
 qVQq0Q7iwTwME1rQGQeIlRgZVw1r7vlo4emoCtfmzpwwLufDXdR9COiSeG3TDmSYJ78i
 ZtyCmawvLIMioXx5Dm8JGRYXsob+LKNMjoH+fFjbEbVCwpMLzcWmSKgkch5DdLEwa3xD
 zMy0W4wL00e3lBVaB7URxc85dQ8txE4PryAvXgQQjOEaa63eit40jjY8juEgbtpdmC8M
 5+CLUR3dSM2hL5cG4O5eXToU6s7O3M4RSmOuGx7ClB1ob2F7dw3UqDxmFfW11VBFhQ10
 nVSQ==
X-Gm-Message-State: APjAAAWF/15HQQ28atlVoULDfZooL6qCtXYlr+VR1RnDaXpiW+J8Pxz/
 XPpJ0us0KKVVwtg/CiQOUAjh9uNbmly2JNhBTzs=
X-Google-Smtp-Source: APXvYqz8EXONRBPHAU9jQqiMTG3oDgT6kxywiN8K8FynbYZwiAXDLXW6+3LJ9oUdTeT8q0aQO7cTV/vj9yRvK0On0FM=
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr1582655wmg.20.1567546411752;
 Tue, 03 Sep 2019 14:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190828142328.24561-1-skrtbhtngr@gmail.com>
 <20190828142328.24561-3-skrtbhtngr@gmail.com>
 <20190829125313.GB9911@lap1>
In-Reply-To: <20190829125313.GB9911@lap1>
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Date: Wed, 4 Sep 2019 03:03:20 +0530
Message-ID: <CAMzgYoO24uhNUg_4RTVkw0JZ1Eerwyd549GX8T82M_18eUp8fA@mail.gmail.com>
To: Yuval Shaia <yuval.shaia@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v1 2/2] hw/pvrdma: add live migration
 support
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Aug 2019 at 18:23, Yuval Shaia <yuval.shaia@oracle.com> wrote:
>
> On Wed, Aug 28, 2019 at 07:53:28PM +0530, Sukrit Bhatnagar wrote:
> > vmstate_pvrdma describes the PCI and MSIX states as well as the dma
> > address for dsr and the gid table of device.
> > vmstate_pvrdma_gids describes each gid in the gid table.
> >
> > pvrdma_post_save() does the job of unregistering gid entries from the
> > backend device in the source host.
> >
> > pvrdma_post_load() maps to dsr using the loaded dma address, registers
> > each loaded gid into the backend device, and finally calls load_dsr()
> > to perform other mappings and ring init operations.
>
> I think it worth to mention that the dma address is kept in driver/device
> shared memory (dsr->dma) which is migrated as part of memory migration and
> it is out of the scope of this change and so we do not need to save/load
> the dma address during migration.
>
> Also you should specifically comment that this migration-support does not
> includes QP migration. This means that support for life migration *during*
> traffic is not yet supported.
>
> >
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Yuval Shaia <yuval.shaia@oracle.com>
> > Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> > ---
> >  hw/rdma/vmw/pvrdma_main.c | 77 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >
> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > index 6c90db96f9..6f8b56dea3 100644
> > --- a/hw/rdma/vmw/pvrdma_main.c
> > +++ b/hw/rdma/vmw/pvrdma_main.c
> > @@ -28,6 +28,7 @@
> >  #include "sysemu/sysemu.h"
> >  #include "monitor/monitor.h"
> >  #include "hw/rdma/rdma.h"
> > +#include "migration/register.h"
> >
> >  #include "../rdma_rm.h"
> >  #include "../rdma_backend.h"
> > @@ -593,6 +594,81 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
> >      pvrdma_fini(pci_dev);
> >  }
> >
> > +static int pvrdma_post_save(void *opaque)
> > +{
> > +    int i, rc;
> > +    PVRDMADev *dev = opaque;
> > +
> > +    for (i = 0; i < MAX_GIDS; i++) {
> > +
>
> Empty line is redundant here.
>
> > +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> > +            continue;
> > +        }
> > +        rc = rdma_backend_del_gid(&dev->backend_dev,
> > +                                   dev->backend_eth_device_name,
> > +                                   &dev->rdma_dev_res.port.gid_tbl[i].gid);
> > +        if (rc) {
> > +            return -EINVAL;
>
> Some error report will help here i guess.

rdma_backend_del_gid() already generates an error report
when rc isn't 0.

Adding another statement for the same seems redundant.

> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int pvrdma_post_load(void *opaque, int version_id)
> > +{
> > +    int i, rc;
> > +    PVRDMADev *dev = opaque;
> > +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> > +    DSRInfo *dsr_info = &dev->dsr_info;
> > +
> > +    dsr_info->dsr = rdma_pci_dma_map(pci_dev, dsr_info->dma,
> > +                                sizeof(struct pvrdma_device_shared_region));
> > +    if (!dsr_info->dsr) {
> > +        rdma_error_report("Failed to map to DSR");
> > +        return -ENOMEM;
> > +    }
> > +
> > +    for (i = 0; i < MAX_GIDS; i++) {
> > +
>
> Empty line is redundant here.
>
> > +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> > +            continue;
> > +        }
> > +
> > +        rc = rdma_backend_add_gid(&dev->backend_dev,
> > +                                  dev->backend_eth_device_name,
> > +                                  &dev->rdma_dev_res.port.gid_tbl[i].gid);
> > +        if (rc) {
> > +            return -EINVAL;
> > +        }
> > +    }
> > +
> > +    return load_dsr(dev);

Now that I will move load_dsr() before the del_gid loop,
I can use goto jumps on exit/error paths, so that I can
undo load_dsr if any del_gid fails.

> > +}
> > +
> > +static const VMStateDescription vmstate_pvrdma_gids = {
> > +    .name = "pvrdma-gids",
> > +    .fields = (VMStateField[]) {
> > +            VMSTATE_UINT8_ARRAY_V(gid.raw, RdmaRmGid, 16, 0),
> > +            VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static const VMStateDescription vmstate_pvrdma = {
> > +    .name = PVRDMA_HW_NAME,
> > +    .post_save = pvrdma_post_save,
> > +    .post_load = pvrdma_post_load,
> > +    .fields = (VMStateField[]) {
> > +            VMSTATE_PCI_DEVICE(parent_obj, PVRDMADev),
> > +            VMSTATE_MSIX(parent_obj, PVRDMADev),
> > +            VMSTATE_UINT64(dsr_info.dma, PVRDMADev),
> > +            VMSTATE_STRUCT_ARRAY(rdma_dev_res.port.gid_tbl, PVRDMADev,
> > +                                 MAX_PORT_GIDS, 0, vmstate_pvrdma_gids,
> > +                                 RdmaRmGid),
> > +            VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> >  {
> >      int rc = 0;
> > @@ -688,6 +764,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
> >
> >      dc->desc = "RDMA Device";
> >      dc->props = pvrdma_dev_properties;
> > +    dc->vmsd = &vmstate_pvrdma;
> >      set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> >
> >      ir->print_statistics = pvrdma_print_statistics;
> > --
> > 2.21.0
> >
> >


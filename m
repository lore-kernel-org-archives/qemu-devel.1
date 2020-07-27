Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B5CC433F4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B2320838
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WykKYIbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B2320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03oz-0004BF-Rg
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03nz-0002v7-4q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:08:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49389
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03nt-00067P-UK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595858913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YeYfTrYBMyGbtUXh9mefDxLKNMxCNPFtbjAQm80q4B0=;
 b=WykKYIbcOySgpRCqZlipOKUjs8zgWQtcUA1f8lRNiLW94I3gCimFkU70au5tWbK5ltx/sj
 lLoi0mFLC792FgkdeajoPwhA1O+XpyWNWMRhVvIcdCsM95VFGGiG9AZ2kNLE778iX9MQN0
 f2lvok6sh5Y16uVVzaw2lJ/KfUyQ8VE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-ffnfhWplOp2rNO65KhVSFA-1; Mon, 27 Jul 2020 10:08:31 -0400
X-MC-Unique: ffnfhWplOp2rNO65KhVSFA-1
Received: by mail-wm1-f72.google.com with SMTP id v4so5752415wmh.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YeYfTrYBMyGbtUXh9mefDxLKNMxCNPFtbjAQm80q4B0=;
 b=CaYOBq6e9krMbwkD43UMU+xYUNS7eBSuAG88WjuPPuzu3XzCF0efB1ZOgO+NBNZCNk
 Cr9ysNz6TO15HyHWzpCLXXMNotRHf88YeyHNrAZ1IdMGP6Bk9P8Ni9rSlslpixuQbHiv
 PrZTZd0rA66ooqtqRTn77PYLZIiYOmDEKUvpM+ddMHM9N3aiiADNH0ddZwrUDIe7jtSf
 rJWdczgb2lm0Fz7T2SJp90qdoLTguFij8r+YsdhMjqc85SaEtxpC7hT13uXPNLeTOQcT
 gnZ+nQcdWLUHgbDi/TqwpDEyVqkLNuBKkYKsFJQnNHMdamR88YQyFE8a+Ot7X1bmJX/+
 EiIA==
X-Gm-Message-State: AOAM533x6smSflyoz2LxVRVVX6GEBLl3ksc8jaRXG5A8UGyVtpN41mSh
 SQoNnpNnZ5aGxxtg/s0qZywQbVvbUDoRu7gFfvtXZux0otXgbV0fPKUIYic7TpPDigGPcE8oF7C
 BvJwyMMD9c4zMV+k=
X-Received: by 2002:adf:e647:: with SMTP id b7mr14997924wrn.220.1595858910188; 
 Mon, 27 Jul 2020 07:08:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy829pbyWldHCcfE/iFYKs7+KAXfN13QGED4ISVHc8PH8Di6/mBDbZ6Pbyqz9O7cyDvFQU5tg==
X-Received: by 2002:adf:e647:: with SMTP id b7mr14997903wrn.220.1595858909871; 
 Mon, 27 Jul 2020 07:08:29 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id v1sm12188751wro.83.2020.07.27.07.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 07:08:29 -0700 (PDT)
Date: Mon, 27 Jul 2020 10:08:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 2/2] hw/pci-host: save/restore pci host config
 register for old ones
Message-ID: <20200727100109-mutt-send-email-mst@kernel.org>
References: <20200727084621.3279-1-hogan.wang@huawei.com>
 <20200727084621.3279-2-hogan.wang@huawei.com>
 <20200727090806-mutt-send-email-mst@kernel.org>
 <20200727135329.GO3040@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200727135329.GO3040@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jusual@redhat.com,
 qemu-devel@nongnu.org, Hogan Wang <hogan.wang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 02:53:29PM +0100, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Mon, Jul 27, 2020 at 04:46:21PM +0800, Hogan Wang wrote:
> > > The i440fx and q35 machines integrate i440FX or MCH PCI device by default.
> > > Refer to i440FX and ICH9-LPC spcifications, there are some reserved
> > > configuration registers can used to save/restore PCIHostState.config_reg.
> > > It's nasty but friendly to old ones.
> > > 
> > > Reproducer steps:
> > > step 1. Make modifications to seabios and qemu for increase reproduction
> > > efficiency, write 0xf0 to 0x402 port notify qemu to stop vcpu after
> > > 0x0cf8 port wrote i440 configure register. qemu stop vcpu when catch
> > > 0x402 port wrote 0xf0.
> > > 
> > > seabios:/src/hw/pci.c
> > > @@ -52,6 +52,11 @@ void pci_config_writeb(u16 bdf, u32 addr, u8 val)
> > >          writeb(mmconfig_addr(bdf, addr), val);
> > >      } else {
> > >          outl(ioconfig_cmd(bdf, addr), PORT_PCI_CMD);
> > > +       if (bdf == 0 && addr == 0x72 && val == 0xa) {
> > > +            dprintf(1, "stop vcpu\n");
> > > +            outb(0xf0, 0x402); // notify qemu to stop vcpu
> > > +            dprintf(1, "resume vcpu\n");
> > > +        }
> > >          outb(val, PORT_PCI_DATA + (addr & 3));
> > >      }
> > >  }
> > > 
> > > qemu:hw/char/debugcon.c
> > > @@ -60,6 +61,9 @@ static void debugcon_ioport_write(void *opaque, hwaddr addr, uint64_t val,
> > >      printf(" [debugcon: write addr=0x%04" HWADDR_PRIx " val=0x%02" PRIx64 "]\n", addr, val);
> > >  #endif
> > > 
> > > +    if (ch == 0xf0) {
> > > +        vm_stop(RUN_STATE_PAUSED);
> > > +    }
> > >      /* XXX this blocks entire thread. Rewrite to use
> > >       * qemu_chr_fe_write and background I/O callbacks */
> > >      qemu_chr_fe_write_all(&s->chr, &ch, 1);
> > > 
> > > step 2. start vm1 by the following command line, and then vm stopped.
> > > $ qemu-system-x86_64 -machine pc-i440fx-5.0,accel=kvm\
> > >  -netdev tap,ifname=tap-test,id=hostnet0,vhost=on,downscript=no,script=no\
> > >  -device virtio-net-pci,netdev=hostnet0,id=net0,bus=pci.0,addr=0x13,bootindex=3\
> > >  -device cirrus-vga,id=video0,vgamem_mb=16,bus=pci.0,addr=0x2\
> > >  -chardev file,id=seabios,path=/var/log/test.seabios,append=on\
> > >  -device isa-debugcon,iobase=0x402,chardev=seabios\
> > >  -monitor stdio
> > > 
> > > step 3. start vm2 to accept vm1 state.
> > > $ qemu-system-x86_64 -machine pc-i440fx-5.0,accel=kvm\
> > >  -netdev tap,ifname=tap-test1,id=hostnet0,vhost=on,downscript=no,script=no\
> > >  -device virtio-net-pci,netdev=hostnet0,id=net0,bus=pci.0,addr=0x13,bootindex=3\
> > >  -device cirrus-vga,id=video0,vgamem_mb=16,bus=pci.0,addr=0x2\
> > >  -chardev file,id=seabios,path=/var/log/test.seabios,append=on\
> > >  -device isa-debugcon,iobase=0x402,chardev=seabios\
> > >  -monitor stdio \
> > >  -incoming tcp:127.0.0.1:8000
> > > 
> > > step 4. execute the following qmp command in vm1 to migrate.
> > > (qemu) migrate tcp:127.0.0.1:8000
> > > 
> > > step 5. execute the following qmp command in vm2 to resume vcpu.
> > > (qemu) cont
> > > 
> > > Before this patch, we can get KVM "emulation failure" error on vm2.
> > > This patch can fix it.
> > > 
> > > Signed-off-by: Hogan Wang <hogan.wang@huawei.com>
> > 
> > Question - did you test that this migrates successfully to
> > old QEMU too? Thanks!
> 
> I'm not seeing how it will;

Well the way this is supposed to work is, it's a reserved register.
So if you migrate to an old qemu it will ignore it, the bug is
not fixed but if you got lucky and did not run into the bug,
the guest will keep going.

Migrating back has a small chance to mess up the guest in a way that is
different from how it was messed up previously, because old qemu will
send a stale config value if you run into the race.
The scariest thing  is it can convert a buggy write into register 0
into a write into another register - potentially more dangerous.
OTOH not writing at all which is what write to register 0 does
it also unlikely to work as expected ...

I really think we need a way to add migrated data without breaking
compat with old machine types, and have old types just ignore it. If we
had such a way we could now use it and at least we would not be making
the problem bigger for anyway.


> and isn't pci_host used in lots of
> architectures?

It doesn't affect these others. They can add a work around
too if there's a migrated register.

> 
> Dave
> 
> > And I guess this needs a CC stable?
> > 
> > > ---
> > >  hw/pci-host/i440fx.c | 31 +++++++++++++++++++++++++++++++
> > >  hw/pci-host/q35.c    | 30 ++++++++++++++++++++++++++++++
> > >  2 files changed, 61 insertions(+)
> > > 
> > > diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> > > index 8ed2417f0c..b78c8bc5f9 100644
> > > --- a/hw/pci-host/i440fx.c
> > > +++ b/hw/pci-host/i440fx.c
> > > @@ -64,6 +64,14 @@ typedef struct I440FXState {
> > >   */
> > >  #define I440FX_COREBOOT_RAM_SIZE 0x57
> > >  
> > > +/* Older I440FX machines (5.0 and older) not support i440FX-pcihost state
> > > + * migration, use some reserved INTEL 82441 configuration registers to
> > > + * save/restore i440FX-pcihost config register. Refer to [INTEL 440FX PCISET
> > > + * 82441FX PCI AND MEMORY CONTROLLER (PMC) AND 82442FX DATA BUS ACCELERATOR
> > > + * (DBX) Table 1. PMC Configuration Space]
> > > + */
> > > +#define I440FX_PCI_HOST_CONFIG_REG 0x94
> > > +
> > >  static void i440fx_update_memory_mappings(PCII440FXState *d)
> > >  {
> > >      int i;
> > > @@ -98,8 +106,30 @@ static void i440fx_write_config(PCIDevice *dev,
> > >  static int i440fx_post_load(void *opaque, int version_id)
> > >  {
> > >      PCII440FXState *d = opaque;
> > > +    PCIDevice *dev;
> > > +    PCIHostState *s = OBJECT_CHECK(PCIHostState,
> > > +                                   object_resolve_path("/machine/i440fx", NULL),
> > > +                                   TYPE_PCI_HOST_BRIDGE);
> > >  
> > >      i440fx_update_memory_mappings(d);
> > > +
> > > +    if (!s->mig_enabled) {
> > > +        dev = PCI_DEVICE(d);
> > > +        s->config_reg = pci_get_long(&dev->config[I440FX_PCI_HOST_CONFIG_REG]);
> > > +    }
> > > +    return 0;
> > > +}
> > > +
> > > +static int i440fx_pre_save(void *opaque)
> > > +{
> > > +    PCIDevice *dev = opaque;
> > > +    PCIHostState *s = OBJECT_CHECK(PCIHostState,
> > > +                                   object_resolve_path("/machine/i440fx", NULL),
> > > +                                   TYPE_PCI_HOST_BRIDGE);
> > > +    if (!s->mig_enabled) {
> > > +        pci_set_long(&dev->config[I440FX_PCI_HOST_CONFIG_REG],
> > > +                     s->config_reg);
> > > +    }
> > >      return 0;
> > >  }
> > >  
> > > @@ -107,6 +137,7 @@ static const VMStateDescription vmstate_i440fx = {
> > >      .name = "I440FX",
> > >      .version_id = 3,
> > >      .minimum_version_id = 3,
> > > +    .pre_save = i440fx_pre_save,
> > >      .post_load = i440fx_post_load,
> > >      .fields = (VMStateField[]) {
> > >          VMSTATE_PCI_DEVICE(parent_obj, PCII440FXState),
> > > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > > index b67cb9c29f..bed66be181 100644
> > > --- a/hw/pci-host/q35.c
> > > +++ b/hw/pci-host/q35.c
> > > @@ -43,6 +43,15 @@
> > >  
> > >  #define Q35_PCI_HOST_HOLE64_SIZE_DEFAULT (1ULL << 35)
> > >  
> > > +/* Older Q35 machines (5.0 and older) not support q35-pcihost state
> > > + * migration, use some reserved INTEL MCH configuration registers to
> > > + * save/restore q35-pcihost config register. Refer to [Intel 3 Series
> > > + * Chipset Family Datasheet Table 5-1. DRAM Controller Register Address
> > > + * Map (D0:F0)]
> > > + */
> > > +#define Q35_PCI_HOST_CONFIG_REG 0x70
> > > +
> > > +
> > >  static void q35_host_realize(DeviceState *dev, Error **errp)
> > >  {
> > >      PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> > > @@ -513,7 +522,27 @@ static void mch_update(MCHPCIState *mch)
> > >  static int mch_post_load(void *opaque, int version_id)
> > >  {
> > >      MCHPCIState *mch = opaque;
> > > +    PCIDevice *dev;
> > > +    PCIHostState *s = OBJECT_CHECK(PCIHostState,
> > > +                                   object_resolve_path("/machine/q35", NULL),
> > > +                                   TYPE_PCI_HOST_BRIDGE);
> > >      mch_update(mch);
> > > +    if (!s->mig_enabled) {
> > > +        dev = PCI_DEVICE(mch);
> > > +        s->config_reg = pci_get_long(&dev->config[Q35_PCI_HOST_CONFIG_REG]);
> > > +    }
> > > +    return 0;
> > > +}
> > > +
> > > +static int mch_pre_save(void *opaque)
> > > +{
> > > +    PCIDevice *dev = opaque;
> > > +    PCIHostState *s = OBJECT_CHECK(PCIHostState,
> > > +                                   object_resolve_path("/machine/q35", NULL),
> > > +                                   TYPE_PCI_HOST_BRIDGE);
> > > +    if (!s->mig_enabled) {
> > > +        pci_set_long(&dev->config[Q35_PCI_HOST_CONFIG_REG], s->config_reg);
> > > +    }
> > >      return 0;
> > >  }
> > >  
> > > @@ -521,6 +550,7 @@ static const VMStateDescription vmstate_mch = {
> > >      .name = "mch",
> > >      .version_id = 1,
> > >      .minimum_version_id = 1,
> > > +    .pre_save = mch_pre_save,
> > >      .post_load = mch_post_load,
> > >      .fields = (VMStateField[]) {
> > >          VMSTATE_PCI_DEVICE(parent_obj, MCHPCIState),
> > > -- 
> > > 2.27.0
> > > 
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92150C4363A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 04:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EC822202
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 04:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EC822202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWXdl-0008Aj-NX
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 00:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kWXdC-0007m3-OK
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 00:27:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:22074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kWXd9-0004eg-KA
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 00:27:46 -0400
IronPort-SDR: S3Vo1dP9y7npgTN3NiK85P0T929Xe5tF315w4UOLOVl3A2GaCxNPyY3zz9xn748UEis2zSromb
 66vY6fDBx0Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9784"; a="154774122"
X-IronPort-AV: E=Sophos;i="5.77,414,1596524400"; d="scan'208";a="154774122"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2020 21:27:36 -0700
IronPort-SDR: 5McXZTnwkCzgxbiTj9UkGLPSe1tw6ljgIqZ6cEU9jP9XKUd6i0ASSpnLoX6pDkeYtP8iI02ksy
 Qdt4X2ypPvZg==
X-IronPort-AV: E=Sophos;i="5.77,414,1596524400"; d="scan'208";a="534927004"
Received: from joy-optiplex-7040.sh.intel.com (HELO yzhao56-desk)
 ([10.239.13.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2020 21:27:30 -0700
Date: Sun, 25 Oct 2020 12:26:11 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v28 03/17] vfio: Add save and load functions for VFIO PCI
 devices
Message-ID: <20201025042611.GE11827@yzhao56-desk>
References: <1603449643-12851-1-git-send-email-kwankhede@nvidia.com>
 <1603449643-12851-4-git-send-email-kwankhede@nvidia.com>
 <20201024115327.GA11667@yzhao56-desk>
 <20201024081630.29d3a2bf@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024081630.29d3a2bf@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.20; envelope-from=yan.y.zhao@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 00:27:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 24, 2020 at 08:16:30AM -0600, Alex Williamson wrote:
> On Sat, 24 Oct 2020 19:53:39 +0800
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > hi
> > when I migrating VFs, the PCI_COMMAND is not properly saved. and the
> > target side would meet below bug
> > root@tester:~# [  189.360671] ++++++++++>> reset starts here: iavf_reset_task !!!
> > [  199.360798] iavf 0000:00:04.0: Reset never finished (0)
> > [  199.380504] kernel BUG at drivers/pci/msi.c:352!
> > [  199.382957] invalid opcode: 0000 [#1] SMP PTI
> > [  199.384855] CPU: 1 PID: 419 Comm: kworker/1:2 Tainted: G           OE     5.0.0-13-generic #14-Ubuntu
> > [  199.388204] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [  199.392401] Workqueue: events iavf_reset_task [iavf]
> > [  199.393586] RIP: 0010:free_msi_irqs+0x17b/0x1b0
> > [  199.394659] Code: 84 e1 fe ff ff 45 31 f6 eb 11 41 83 c6 01 44 39 73 14 0f 86 ce fe ff ff 8b 7b 10 44 01 f7 e8 3c 7a ba ff 48 83 78 70 00 74 e0 <0f> 0b 49 8d b5 b0 00 00 00 e8 07 27 bb ff e9 cf fe ff ff 48 8b 78
> > [  199.399056] RSP: 0018:ffffabd1006cfdb8 EFLAGS: 00010282
> > [  199.400302] RAX: ffff9e336d8a2800 RBX: ffff9e3333b006c0 RCX: 0000000000000000
> > [  199.402000] RDX: 0000000000000000 RSI: 0000000000000019 RDI: ffffffffbaa68100
> > [  199.403168] RBP: ffffabd1006cfde8 R08: ffff9e3375000248 R09: ffff9e3375000338
> > [  199.404343] R10: 0000000000000000 R11: ffffffffbaa68108 R12: ffff9e3374ef12c0
> > [  199.405526] R13: ffff9e3374ef1000 R14: 0000000000000000 R15: ffff9e3371f2d018
> > [  199.406702] FS:  0000000000000000(0000) GS:ffff9e3375b00000(0000) knlGS:0000000000000000
> > [  199.408027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  199.408987] CR2: 00000000ffffffff CR3: 0000000033266000 CR4: 00000000000006e0
> > [  199.410155] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  199.411321] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  199.412437] Call Trace:
> > [  199.412750]  pci_disable_msix+0xf3/0x120
> > [  199.413227]  iavf_reset_interrupt_capability.part.40+0x19/0x40 [iavf]
> > [  199.413998]  iavf_reset_task+0x4b3/0x9d0 [iavf]
> > [  199.414544]  process_one_work+0x20f/0x410
> > [  199.415026]  worker_thread+0x34/0x400
> > [  199.415486]  kthread+0x120/0x140
> > [  199.415876]  ? process_one_work+0x410/0x410
> > [  199.416380]  ? __kthread_parkme+0x70/0x70
> > [  199.416864]  ret_from_fork+0x35/0x40
> > 
> > I fixed it with below patch.
> > 
> > 
> > commit ad3efa0eeea7edb352294bfce35b904b8d3c759c
> > Author: Yan Zhao <yan.y.zhao@intel.com>
> > Date:   Sat Oct 24 19:45:01 2020 +0800
> > 
> >     msix fix.
> >     
> >     Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > 
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index f63f15b553..92f71bf933 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2423,8 +2423,14 @@ const VMStateDescription vmstate_vfio_pci_config = {
> >  static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> >  {
> >      VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> > +    PCIDevice *pdev = &vdev->pdev;
> > +    uint16_t pci_cmd;
> > +
> > +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
> > +    qemu_put_be16(f, pci_cmd);
> >  
> >      vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
> > +
> >  }
> >  
> >  static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> > @@ -2432,6 +2438,10 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> >      VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> >      PCIDevice *pdev = &vdev->pdev;
> >      int ret;
> > +    uint16_t pci_cmd;
> > +
> > +    pci_cmd = qemu_get_be16(f);
> > +    vfio_pci_write_config(pdev, PCI_COMMAND, pci_cmd, 2);
> >  
> >      ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
> >      if (ret) {
> > 
> 
> 
> We need to avoid this sort of ad-hoc stuffing random fields into the
> config stream.  The command register is already migrated in vconfig, it
> only needs to be written through vfio:
> 
> vfio_pci_write_config(pdev, PCI_COMMAND,
> 		      pci_get_word(pdev->config, PCI_COMMAND), 2);
> 
yes, it should work. previously we just rely on qemu to save and load
the common fields.

Thanks
Yan

> 
> 
> > On Fri, Oct 23, 2020 at 04:10:29PM +0530, Kirti Wankhede wrote:
> > > Added functions to save and restore PCI device specific data,
> > > specifically config space of PCI device.
> > > 
> > > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > > ---
> > >  hw/vfio/pci.c                 | 48 +++++++++++++++++++++++++++++++++++++++++++
> > >  include/hw/vfio/vfio-common.h |  2 ++
> > >  2 files changed, 50 insertions(+)
> > > 
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index bffd5bfe3b78..92cc25a5489f 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -41,6 +41,7 @@
> > >  #include "trace.h"
> > >  #include "qapi/error.h"
> > >  #include "migration/blocker.h"
> > > +#include "migration/qemu-file.h"
> > >  
> > >  #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
> > >  
> > > @@ -2401,11 +2402,58 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
> > >      return OBJECT(vdev);
> > >  }
> > >  
> > > +static bool vfio_msix_present(void *opaque, int version_id)
> > > +{
> > > +    PCIDevice *pdev = opaque;
> > > +
> > > +    return msix_present(pdev);
> > > +}
> > > +
> > > +const VMStateDescription vmstate_vfio_pci_config = {
> > > +    .name = "VFIOPCIDevice",
> > > +    .version_id = 1,
> > > +    .minimum_version_id = 1,
> > > +    .fields = (VMStateField[]) {
> > > +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
> > > +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> > > +{
> > > +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> > > +
> > > +    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
> > > +}
> > > +
> > > +static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> > > +{
> > > +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> > > +    PCIDevice *pdev = &vdev->pdev;
> > > +    int ret;
> > > +
> > > +    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
> > > +    if (ret) {
> > > +        return ret;
> > > +    }
> > > +
> > > +    if (msi_enabled(pdev)) {
> > > +        vfio_msi_enable(vdev);
> > > +    } else if (msix_enabled(pdev)) {
> > > +        vfio_msix_enable(vdev);
> > > +    }
> > > +
> > > +    return ret;
> > > +}
> > > +
> > >  static VFIODeviceOps vfio_pci_ops = {
> > >      .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
> > >      .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
> > >      .vfio_eoi = vfio_intx_eoi,
> > >      .vfio_get_object = vfio_pci_get_object,
> > > +    .vfio_save_config = vfio_pci_save_config,
> > > +    .vfio_load_config = vfio_pci_load_config,
> > >  };
> > >  
> > >  int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
> > > diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> > > index fe99c36a693a..ba6169cd926e 100644
> > > --- a/include/hw/vfio/vfio-common.h
> > > +++ b/include/hw/vfio/vfio-common.h
> > > @@ -120,6 +120,8 @@ struct VFIODeviceOps {
> > >      int (*vfio_hot_reset_multi)(VFIODevice *vdev);
> > >      void (*vfio_eoi)(VFIODevice *vdev);
> > >      Object *(*vfio_get_object)(VFIODevice *vdev);
> > > +    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
> > > +    int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
> > >  };
> > >  
> > >  typedef struct VFIOGroup {
> > > -- 
> > > 2.7.0
> > >   
> > 
> 


Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73467C5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 08:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC052089C
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 08:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nxppk2qE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC052089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhUzZ-0003ju-8L
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 04:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56448)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yuval.shaia@oracle.com>) id 1hhUyL-0003L3-2H
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 04:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1hhUyJ-0000yj-8G
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 04:14:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1hhUyI-0000vF-Tt
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 04:14:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5U8DIbI046014;
 Sun, 30 Jun 2019 08:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yC10q+Mxf32oXAb+rxRSfjxKuKpnnyMrBL431jgb7ko=;
 b=nxppk2qEdzJ1ysoGTJR9lhUdF/wFp10xO+ElyAKGuY9fHZcuW+DYKB7jFUIErALWftRP
 72+hH8BtvUzPtbqA5nRGRleNdixxGcsFVv7d0hbCILunjWn+hrw+xNm2DXBe9QeSyaDO
 iYqsDT7WrQzR5Ehv9MHRKqmrzvRhL5+G0CA3uYxAcqaodQ2cNf1yuuwrliTKv4QDlagj
 x2AZRmI04FqDv34FmIwvtcrAxAFMyQpbvEI4CIB2mhAgbht39CDgbGph/KjLW9Aw5+xa
 T3MS7XrFigFlPb0jy5p9w5Qg3yDE5ZXrElTdU1tz/wfMlnFYJlI9PBAWzIWkYM/91Kbo HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2te61phgrn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2019 08:13:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5U8DCrd143003;
 Sun, 30 Jun 2019 08:13:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2tebbhsbk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2019 08:13:58 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5U8DvNM022794;
 Sun, 30 Jun 2019 08:13:57 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 30 Jun 2019 01:13:56 -0700
Date: Sun, 30 Jun 2019 11:13:50 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190630081349.GA2817@lap1>
References: <20190621144541.13770-1-skrtbhtngr@gmail.com>
 <20190621144541.13770-2-skrtbhtngr@gmail.com>
 <20190625153253.GA10458@lap1> <20190628112634.GB2987@work-vm>
 <CAMzgYoOb7VbFk3U6zP9OvDPtcbT3K4CHjBVuaKUzQWfe_yFCYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzgYoOb7VbFk3U6zP9OvDPtcbT3K4CHjBVuaKUzQWfe_yFCYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9303
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906300109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9303
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906300109
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [RFC 1/1] hw/pvrdma: Add live migration support
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 29, 2019 at 06:15:21PM +0530, Sukrit Bhatnagar wrote:
> On Fri, 28 Jun 2019 at 16:56, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Yuval Shaia (yuval.shaia@oracle.com) wrote:
> > > On Fri, Jun 21, 2019 at 08:15:41PM +0530, Sukrit Bhatnagar wrote:
> > > > Define and register SaveVMHandlers pvrdma_save and
> > > > pvrdma_load for saving and loading the device state,
> > > > which currently includes only the dma, command slot
> > > > and response slot addresses.
> > > >
> > > > Remap the DSR, command slot and response slot upon
> > > > loading the addresses in the pvrdma_load function.
> > > >
> > > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > > Cc: Yuval Shaia <yuval.shaia@oracle.com>
> > > > Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> > > > ---
> > > >  hw/rdma/vmw/pvrdma_main.c | 56 +++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 56 insertions(+)
> > > >
> > > > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > > > index adcf79cd63..cd8573173c 100644
> > > > --- a/hw/rdma/vmw/pvrdma_main.c
> > > > +++ b/hw/rdma/vmw/pvrdma_main.c
> > > > @@ -28,6 +28,7 @@
> > > >  #include "sysemu/sysemu.h"
> > > >  #include "monitor/monitor.h"
> > > >  #include "hw/rdma/rdma.h"
> > > > +#include "migration/register.h"
> > > >
> > > >  #include "../rdma_rm.h"
> > > >  #include "../rdma_backend.h"
> > > > @@ -592,9 +593,62 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
> > > >      pvrdma_fini(pci_dev);
> > > >  }
> > > >
> > > > +static void pvrdma_save(QEMUFile *f, void *opaque)
> > > > +{
> > > > +    PVRDMADev *dev = PVRDMA_DEV(opaque);
> > > > +
> > > > +    qemu_put_be64(f, dev->dsr_info.dma);
> > > > +    qemu_put_be64(f, dev->dsr_info.dsr->cmd_slot_dma);
> > > > +    qemu_put_be64(f, dev->dsr_info.dsr->resp_slot_dma);
> > > > +}
> > > > +
> > > > +static int pvrdma_load(QEMUFile *f, void *opaque, int version_id)
> > > > +{
> > > > +    PVRDMADev *dev = PVRDMA_DEV(opaque);
> > > > +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> > > > +
> > > > +    // Remap DSR
> > > > +    dev->dsr_info.dma = qemu_get_be64(f);
> > > > +    dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
> > > > +                                    sizeof(struct pvrdma_device_shared_region));
> > > > +    if (!dev->dsr_info.dsr) {
> > > > +        rdma_error_report("Failed to map to DSR");
> > > > +        return -1;
> > > > +    }
> > > > +    qemu_log("pvrdma_load: successfully remapped to DSR\n");
> > > > +
> > > > +    // Remap cmd slot
> > > > +    dev->dsr_info.dsr->cmd_slot_dma = qemu_get_be64(f);
> > > > +    dev->dsr_info.req = rdma_pci_dma_map(pci_dev, dev->dsr_info.dsr->cmd_slot_dma,
> > > > +                                     sizeof(union pvrdma_cmd_req));
> > > > +    if (!dev->dsr_info.req) {
> > >
> > > So this is where you hit the error, right?
> > > All looks good to me, i wonder why the first pci_dma_map works fine but
> > > second fails where the global BounceBuffer is marked as used.
> > >
> > > Anyone?
> >
> > I've got a few guesses:
> >   a) My reading of address_space_map is that it gives a bounce buffer
> > pointer and then it has to be freed; so if it's going wrong and using a
> > bounce buffer, then the 1st call would work and only the 2nd would fail.
> 
> In the scenario without any migration, the device is init and load_dsr()
> is called when the guest writes to DSR in BAR1 of pvrdma.
> 
> Inside the load_dsr(), there are similar calls to rdma_pci_dma_map().
> 
> The difference is that when the address_space_map() is called there,
> !memory_access_is_direct() condition is FALSE.
> So, there is no use for BounceBuffer.
> 
> 
> In the migration scenario, when the device at dest calls load and
> subsequently rdma_pci_dma_map(), the !memory_access_is_direct()
> condition is TRUE.
> So, the first rdma_pci_dma_map() will set BounceBuffer from FALSE to
> TRUE and succeed. But, the subsequent calls will fail at atomic_xchg().
> 
> This BounceBuffer is only freed when address_space_unmap() is called.
> 
> 
> I am guessing that when the address is translated to one in FlatView,
> the MemoryRegion returned at dest is causing the issue.
> To be honest, at this point I am not sure how FlatView translations works.
> 
> I tried adding qemu_log to memory_access_is_direct(), but I guess it is
> called too many times, so the vm stalls before it even starts.
> 
> >   b) Perhaps the dma address read from the stream is bad, and isn't
> > pointing into RAM properly - and that's why you're getting a bounce
> > buffer.
> 
> I have logged the addresses saved in pvrdma_save(), and the ones
> loaded in pvrdma_load(). They are same. So, there is no problem in the
> stream itself, I suppose.
> 
> >   c) Do you have some ordering problems? i.e. is this code happening
> > before some other device has been loaded/initialised?  If you're relying
> > on some other state, then perhaps the right thing is to perform these
> > mappings later, at the end of migration, not during the loading itself.
> 
> The device which is saved/loaded before pvrdma is vmxnet3, on which
> the pvrdma depends.
> 
> I have included the last few lines of my traces during migration below.
> The pvrdma migration is performed in this last part of migration.
> I had added some debug messages at various places to see which parts
> of the code are touched. The ones I added are without any timestamp.
> 
> Source:
> 15942@1561806657.197239:vmstate_subsection_save_top PCIDevice
> 15942@1561806657.197257:vmstate_subsection_save_top vmxnet3/pcie
> 15942@1561806657.197275:savevm_section_end 0000:00:10.0/vmxnet3,
> section_id 46 -> 0
> 15942@1561806657.197302:savevm_section_start 0000:00:10.1/pvrdma, section_id 47
> 15942@1561806657.197326:vmstate_save 0000:00:10.1/pvrdma, (old)
> pvrdma_save: dev->dsr_info.dma is 2032963584
> pvrdma_save: dev->dsr_info.dsr->cmd_slot_dma is 2032660480
> pvrdma_save: dev->dsr_info.dsr->resp_slot_dma is 893681664
> 15942@1561806657.197372:savevm_section_end 0000:00:10.1/pvrdma,
> section_id 47 -> 0
> 15942@1561806657.197397:savevm_section_start acpi_build, section_id 48
> 15942@1561806657.197420:vmstate_save acpi_build, acpi_build
> 15942@1561806657.197441:vmstate_save_state_top acpi_build
> 15942@1561806657.197459:vmstate_n_elems patched: 1
> 15942@1561806657.197479:vmstate_save_state_loop acpi_build/patched[1]
> 15942@1561806657.197503:vmstate_subsection_save_top acpi_build
> 15942@1561806657.197520:savevm_section_end acpi_build, section_id 48 -> 0
> 15942@1561806657.197545:savevm_section_start globalstate, section_id 49
> 15942@1561806657.197568:vmstate_save globalstate, globalstate
> 15942@1561806657.197589:vmstate_save_state_top globalstate
> 15942@1561806657.197606:migrate_global_state_pre_save saved state: running
> 15942@1561806657.197624:vmstate_save_state_pre_save_res globalstate/0
> 15942@1561806657.197645:vmstate_n_elems size: 1
> 15942@1561806657.197677:vmstate_save_state_loop globalstate/size[1]
> 15942@1561806657.197710:vmstate_n_elems runstate: 1
> 15942@1561806657.197730:vmstate_save_state_loop globalstate/runstate[1]
> 15942@1561806657.197822:vmstate_subsection_save_top globalstate
> 15942@1561806657.197885:savevm_section_end globalstate, section_id 49 -> 0
> 15942@1561806657.198240:migrate_set_state new state completed
> 15942@1561806657.198269:migration_thread_after_loop
> 15797@1561806657.198329:savevm_state_cleanup
> 15797@1561806657.198377:migrate_fd_cleanup
> 15797@1561806657.199072:qemu_file_fclose
> 
> Destination:
> 15830@1561806657.667024:vmstate_subsection_load vmxnet3/pcie
> 15830@1561806657.667064:vmstate_subsection_load_good vmxnet3/pcie
> 15830@1561806657.667106:vmstate_load_state_end vmxnet3/pcie end/0
> 15830@1561806657.667150:vmstate_subsection_load_good vmxnet3
> 15830@1561806657.667213:vmstate_load_state_end vmxnet3 end/0
> 15830@1561806657.667263:qemu_loadvm_state_section 4
> 15830@1561806657.667293:qemu_loadvm_state_section_startfull
> 47(0000:00:10.1/pvrdma) 0 1
> 15830@1561806657.667346:vmstate_load 0000:00:10.1/pvrdma, (old)
> pvrdma_load: dev->dsr_info.dma is 2032963584
> address_space_map: is_write is 0
> address_space_map: addr is 2032963584
> address_space_map: Inside !memory_access_is_direct
> 15830@1561806657.667453:rdma_pci_dma_map 0x792c9000 -> 0x5616d1f66000 (len=280)
> pvrdma_load: successfully remapped to DSR
> pvrdma_load: dev->dsr_info.dsr->cmd_slot_dma is 2032660480
> address_space_map: is_write is 0
> address_space_map: addr is 2032660480
> address_space_map: Inside !memory_access_is_direct
> address_space_map: Inside atomic_xchg
> qemu-system-x86_64: rdma: pci_dma_map fail, addr=0x7927f000, len=184
> qemu-system-x86_64: rdma: Failed to map to command slot address
> qemu-system-x86_64: error while loading state for instance 0x0 of
> device '0000:00:10.1/pvrdma'
> 15830@1561806657.667693:qemu_loadvm_state_post_main -1
> 15830@1561806657.667729:loadvm_state_cleanup
> 15830@1561806657.668568:process_incoming_migration_co_end ret=-1
> postcopy-state=0
> qemu-system-x86_64: load of migration failed: Operation not permitted
> 15830@1561806657.668721:migrate_set_state new state failed
> 15830@1561806657.668807:qemu_file_fclose
> qemu-system-x86_64: network script /etc/qemu-ifdown failed with status 256
> 
> @Marcel, @Yuval: As David has suggested, what if we just read the dma
> addresses in pvrdma_load(), and let the load_dsr() do the mapping?
> In pvrdma_regs_write(), we can check if dev->dsr_info.dma is already set, so
> that its value is not overwritten.

Have you tried that? Did it works?

So it is like a lazy load and the first command will be bit slower, we can
live with that i guess.

Is there other way to postpone work so it will be executed right after
migration is completes? I just don't like the fact that we are adding an
'if' statement.

In any case, wrap the "if (dev->dsr_info.dma)" with "unlikely" because as
soon as it be initialized it will always true.

> 
> 
> > Other notes:
> >   d) Use VMSTATE macros and structures rather than open-coding qemu_get
> > calls.
> 
> Yes, I am trying it currently.
> 
> >   e) QEMU normally uses /* comments */ rather than //
> 
> I have corrected this mistake in my code. patchew notified me about this
> and the line length issues minutes after I had sent this patch.
> 
> 
> > Dave
> >
> > > > +        rdma_error_report("Failed to map to command slot address");
> > > > +        return -1;
> > > > +    }
> > > > +    qemu_log("pvrdma_load: successfully remapped to cmd slot\n");
> > > > +
> > > > +    // Remap rsp slot
> > >
> > > btw, this is RFC so we are fine but try to avoid such way of comments.
> > >
> > > > +    dev->dsr_info.dsr->resp_slot_dma = qemu_get_be64(f);
> > > > +    dev->dsr_info.rsp = rdma_pci_dma_map(pci_dev, dev->dsr_info.dsr->resp_slot_dma,
> > > > +                                     sizeof(union pvrdma_cmd_resp));
> > > > +    if (!dev->dsr_info.rsp) {
> > > > +        rdma_error_report("Failed to map to response slot address");
> > > > +        return -1;
> > > > +    }
> > > > +    qemu_log("pvrdma_load: successfully remapped to rsp slot\n");
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > > +static SaveVMHandlers savevm_pvrdma = {
> > > > +    .save_state = pvrdma_save,
> > > > +    .load_state = pvrdma_load,
> > > > +};
> > > > +
> > > >  static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> > > >  {
> > > >      int rc = 0;
> > > > +    DeviceState *s = DEVICE(pdev);
> > > >      PVRDMADev *dev = PVRDMA_DEV(pdev);
> > > >      Object *memdev_root;
> > > >      bool ram_shared = false;
> > > > @@ -666,6 +720,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> > > >      dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
> > > >      qemu_register_shutdown_notifier(&dev->shutdown_notifier);
> > > >
> > > > +    register_savevm_live(s, "pvrdma", -1, 1, &savevm_pvrdma, dev);
> > > > +
> > > >  out:
> > > >      if (rc) {
> > > >          pvrdma_fini(pdev);
> > > > --
> > > > 2.21.0
> > > >
> > > >
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


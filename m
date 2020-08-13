Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F67C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1AB20768
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1AB20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Kxn-0006Jq-JQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 17:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k6Kwr-0005Vm-0C; Thu, 13 Aug 2020 17:39:48 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:34801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k6Kwn-00063y-OS; Thu, 13 Aug 2020 17:39:44 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.90])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id E2B4750432A7;
 Thu, 13 Aug 2020 23:39:28 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 13 Aug
 2020 23:39:28 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0011d6447e1-42c9-4b9f-8b90-5611e8325963,
 56FC6CFA6F9FB878813463EC2CBCCD0911300B36) smtp.auth=groug@kaod.org
Date: Thu, 13 Aug 2020 23:39:27 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 01/14] spapr: Simplify error handling in
 spapr_phb_realize()
Message-ID: <20200813233927.52e38400@bahia.lan>
In-Reply-To: <2c8847d7-0f87-4fb1-8551-2e4fdb8f2708@gmail.com>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707843851.1489912.6108405733810934642.stgit@bahia.lan>
 <2c8847d7-0f87-4fb1-8551-2e4fdb8f2708@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 4ce23647-cbb1-40e0-a003-1be033f22bfd
X-Ovh-Tracer-Id: 12902812933695117731
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrleehgddufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeuudfgleejteejhfefudfhffelvdeileffgfeggeefgeetgeefueekudduteffudenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 17:39:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Aug 2020 16:57:04 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> Greg,
> 
> This patch is breaking guest startup in ppc-for-5.2 for me. The process
> gives an almost instant segfault. Here's what I'm doing:
> 

Ok, this is because this patch should have been applied after
the "spapr: Cleanups for XIVE" series:

http://patchwork.ozlabs.org/project/qemu-devel/cover/159679991916.876294.8967140647442842745.stgit@bahia.lan/

specifically this patch:

http://patchwork.ozlabs.org/project/qemu-devel/patch/159679993438.876294.7285654331498605426.stgit@bahia.lan/

which prevents of a bogus error path in kvmppc_xive_source_reset_one() to
be taken:

/* The KVM XIVE device is not in use */
if (xive->fd == -1) {
    return -ENODEV; <== this should return 0 to avoid the segfault, but
                        the real issue is that kvmppc_xive_*() calls
                        shouldn't be called at all when we don't have
                        a KVM XIVE device. This is the purpose of the
                        "spapr: Cleanups for XIVE" series.
}

I should maybe have added some Based-on: tag to make it clearer...

David,

Can you apply the series the other way around ?

First :

"spapr: Cleanups for XIVE"

http://patchwork.ozlabs.org/project/qemu-devel/cover/159679991916.876294.8967140647442842745.stgit@bahia.lan/

Then :

"ppc/spapr: Error handling fixes and cleanups"

http://patchwork.ozlabs.org/project/qemu-devel/cover/159707843034.1489912.1082061742626355958.stgit@bahia.lan/

Sorry everyone for the inconvenience.

Cheers,

--
Greg

> $ sudo ./qemu-system-ppc64 -machine pseries-5.1,accel=kvm,usb=off,dump-guest-core=off -m 65536\
> -overcommit mem-lock=off -smp 4,sockets=4,cores=1,threads=1 -rtc base=utc -display none -vga none -nographic -boot menu=on \
> -device spapr-pci-host-bridge,index=1,id=pci.1 -device spapr-pci-host-bridge,index=2,id=pci.2 \
> -device spapr-pci-host-bridge,index=3,id=pci.3 -device spapr-pci-host-bridge,index=4,id=pci.4 \
> -device qemu-xhci,id=usb,bus=pci.0,addr=0x2 \
> -drive file=/home/danielhb/f32.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 \
> -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x3,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 \
> -device usb-kbd,id=input0,bus=usb.0,port=1 -device usb-mouse,id=input1,bus=usb.0,port=2 \
> -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x4 -msg timestamp=on \
> -machine cap-ccf-assist=off
> Segmentation fault
> $
> 
> 
> GDB points this backtrace:
> 
> Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
> error_vprepend (errp=0x7fffffffe400, fmt=0x100ec2698 "can't allocate LSIs: ", ap=0x7fffffffe290 "\030") at /home/danielhb/qemu/util/error.c:134
> 134         g_string_append(newmsg, (*errp)->msg);
> Missing separate debuginfos, use: dnf debuginfo-install glib2-2.64.4-1.fc32.ppc64le libblkid-2.35.2-1.fc32.ppc64le libffi-3.1-24.fc32.ppc64le libgcrypt-1.8.5-3.fc32.ppc64le libgpg-error-1.36-3.fc32.ppc64le libmount-2.35.2-1.fc32.ppc64le libselinux-3.0-5.fc32.ppc64le libxml2-2.9.10-3.fc32.ppc64le ncurses-libs-6.1-15.20191109.fc32.ppc64le numactl-libs-2.0.12-4.fc32.ppc64le pcre-8.44-1.fc32.ppc64le pcre2-10.35-4.fc32.ppc64le pixman-0.40.0-1.fc32.ppc64le xz-libs-5.2.5-1.fc32.ppc64le zlib-1.2.11-21.fc32.ppc64le
> (gdb) bt
> #0  error_vprepend (errp=0x7fffffffe400, fmt=0x100ec2698 "can't allocate LSIs: ", ap=0x7fffffffe290 "\030") at /home/danielhb/qemu/util/error.c:134
> #1  0x0000000100c1e9cc in error_prepend (errp=0x7fffffffe400, fmt=0x100ec2698 "can't allocate LSIs: ") at /home/danielhb/qemu/util/error.c:144
> #2  0x00000001004cdad4 in spapr_phb_realize (dev=0x101d6cb90, errp=0x7fffffffe400) at /home/danielhb/qemu/hw/ppc/spapr_pci.c:1982
> #3  0x0000000100735f70 in device_set_realized (obj=0x101d6cb90, value=true, errp=0x7fffffffe568) at /home/danielhb/qemu/hw/core/qdev.c:864
> #4  0x0000000100a5aae4 in property_set_bool (obj=0x101d6cb90, v=0x101d6daa0, name=0x100f13df8 "realized", opaque=0x1016d2430, errp=0x7fffffffe568) at /home/danielhb/qemu/qom/object.c:2202
> #5  0x0000000100a57d64 in object_property_set (obj=0x101d6cb90, name=0x100f13df8 "realized", v=0x101d6daa0, errp=0x1016156c0 <error_fatal>) at /home/danielhb/qemu/qom/object.c:1349
> #6  0x0000000100a5cb38 in object_property_set_qobject (obj=0x101d6cb90, name=0x100f13df8 "realized", value=0x101d6c950, errp=0x1016156c0 <error_fatal>)
>      at /home/danielhb/qemu/qom/qom-qobject.c:28
> #7  0x0000000100a581fc in object_property_set_bool (obj=0x101d6cb90, name=0x100f13df8 "realized", value=true, errp=0x1016156c0 <error_fatal>) at /home/danielhb/qemu/qom/object.c:1416
> #8  0x0000000100734178 in qdev_realize (dev=0x101d6cb90, bus=0x10198e250, errp=0x1016156c0 <error_fatal>) at /home/danielhb/qemu/hw/core/qdev.c:379
> #9  0x00000001007341dc in qdev_realize_and_unref (dev=0x101d6cb90, bus=0x10198e250, errp=0x1016156c0 <error_fatal>) at /home/danielhb/qemu/hw/core/qdev.c:386
> #10 0x00000001007463c0 in sysbus_realize_and_unref (dev=0x101d6cb90, errp=0x1016156c0 <error_fatal>) at /home/danielhb/qemu/hw/core/sysbus.c:260
> #11 0x00000001004a6960 in spapr_create_default_phb () at /home/danielhb/qemu/hw/ppc/spapr.c:2652
> #12 0x00000001004a7428 in spapr_machine_init (machine=0x101965800) at /home/danielhb/qemu/hw/ppc/spapr.c:2940
> #13 0x000000010074a3b0 in machine_run_board_init (machine=0x101965800) at /home/danielhb/qemu/hw/core/machine.c:1135
> #14 0x000000010054f390 in qemu_init (argc=42, argv=0x7ffffffff0a8, envp=0x7ffffffff200) at /home/danielhb/qemu/softmmu/vl.c:4355
> #15 0x0000000100b8ee00 in main (argc=42, argv=0x7ffffffff0a8, envp=0x7ffffffff200) at /home/danielhb/qemu/softmmu/main.c:48
> (gdb)
> 
> 
> Removing this patch (i.e. resetting HEAD at "target/ppc: Integrate icount
> to purr, vtb, and tbu40") allows me to get the guest rolling.
> 
> 
> 
> Thanks,
> 
> 
> Daniel
> 
> 
> 
> On 8/10/20 1:53 PM, Greg Kurz wrote:
> > The spapr_phb_realize() function has a local_err variable which
> > is used to:
> > 
> > 1) check failures of spapr_irq_findone() and spapr_irq_claim()
> > 
> > 2) prepend extra information to the error message
> > 
> > Recent work from Markus Armbruster highlighted we get better
> > code when testing the return value of a function, rather than
> > setting up all the local_err boiler plate. For similar reasons,
> > it is now preferred to use ERRP_GUARD() and error_prepend()
> > rather than error_propagate_prepend().
> > 
> > Since spapr_irq_findone() and spapr_irq_claim() return negative
> > values in case of failure, do both changes.
> > 
> > This is just cleanup, no functional impact.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >   hw/ppc/spapr_pci.c |   16 +++++++---------
> >   1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 363cdb3f7b8d..0a418f1e6711 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1796,6 +1796,7 @@ static void spapr_phb_destroy_msi(gpointer opaque)
> >   
> >   static void spapr_phb_realize(DeviceState *dev, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
> >        * tries to add a sPAPR PHB to a non-pseries machine.
> >        */
> > @@ -1813,7 +1814,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
> >       uint64_t msi_window_size = 4096;
> >       SpaprTceTable *tcet;
> >       const unsigned windows_supported = spapr_phb_windows_supported(sphb);
> > -    Error *local_err = NULL;
> >   
> >       if (!spapr) {
> >           error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries machine");
> > @@ -1964,13 +1964,12 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
> >   
> >       /* Initialize the LSI table */
> >       for (i = 0; i < PCI_NUM_PINS; i++) {
> > -        uint32_t irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
> > +        int irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
> >   
> >           if (smc->legacy_irq_allocation) {
> > -            irq = spapr_irq_findone(spapr, &local_err);
> > -            if (local_err) {
> > -                error_propagate_prepend(errp, local_err,
> > -                                        "can't allocate LSIs: ");
> > +            irq = spapr_irq_findone(spapr, errp);
> > +            if (irq < 0) {
> > +                error_prepend(errp, "can't allocate LSIs: ");
> >                   /*
> >                    * Older machines will never support PHB hotplug, ie, this is an
> >                    * init only path and QEMU will terminate. No need to rollback.
> > @@ -1979,9 +1978,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
> >               }
> >           }
> >   
> > -        spapr_irq_claim(spapr, irq, true, &local_err);
> > -        if (local_err) {
> > -            error_propagate_prepend(errp, local_err, "can't allocate LSIs: ");
> > +        if (spapr_irq_claim(spapr, irq, true, errp) < 0) {
> > +            error_prepend(errp, "can't allocate LSIs: ");
> >               goto unrealize;
> >           }
> >   
> > 
> > 
> > 



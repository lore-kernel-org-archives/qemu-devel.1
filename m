Received: from eggs.gnu.org ([2001:4830:134:3::10]:34855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ett60-0000HE-4W
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ett5w-0001dD-7R
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:48:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ett5w-0001cf-0U
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:48:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3849580461
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 10:48:19 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B6AF5D9C8
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 10:48:19 +0000 (UTC)
Date: Thu, 8 Mar 2018 05:48:18 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <368741524.5994930.1520506098881.JavaMail.zimbra@redhat.com>
In-Reply-To: <599bfe48-6848-d5a4-5df6-64e0aa627aee@redhat.com>
References: <20180306194600.9650-1-pbonzini@redhat.com>
	<20180306194600.9650-4-pbonzini@redhat.com>
	<599bfe48-6848-d5a4-5df6-64e0aa627aee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] q35: change default NIC to e1000e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>


> > -        if (!pci_bus || (nd->model && strcmp(nd->model, "ne2k_isa") == 0))
> > {
> > +        if (!strcmp(model, "ne2k_isa")) {
> 
> <bikeshedpainting>
> I'd prefer g_str_equal() these days ...
> </bikeshedpainting>

I guess I owe you a lot of bikeshedding.  Changed.

> > -    if (!strcmp(nd->model, "virtio")) {
> > +    if (nd->model && !strcmp(nd->model, "virtio")) {
> 
> Please squash that into the previous patch instead.

Pro tip: don't write patches at 5 AM after the son woke up, even if
you cannot fall asleep again.  Sorry for the mess.

Paolo

> >          g_free(nd->model);
> >          nd->model = g_strdup("virtio-net-pci");
> >      }
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index bb49165fe0..e81654eb7f 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -114,6 +114,7 @@ struct PCMachineClass {
> >      /* Device configuration: */
> >      bool pci_enabled;
> >      bool kvmclock_enabled;
> > +    const char *default_nic_model;
> >  
> >      /* Compat options: */
> >  
> > @@ -248,7 +249,7 @@ void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd);
> >  void pc_cmos_init(PCMachineState *pcms,
> >                    BusState *ide0, BusState *ide1,
> >                    ISADevice *s);
> > -void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus);
> > +void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
> >  void pc_pci_device_init(PCIBus *pci_bus);
> >  
> >  typedef void (*cpu_set_smm_t)(int smm, void *arg);
> > 
> 
> Apart from the nits, this looks fine to me.
> 
>  Thomas
> 

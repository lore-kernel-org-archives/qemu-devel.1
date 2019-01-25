Received: from eggs.gnu.org ([209.51.188.92]:37658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gmwq8-00075s-Dc
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gmwoV-0003nE-RP
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:26:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gmwoV-0003mI-La
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:26:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AE377BDCA
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 08:26:10 +0000 (UTC)
Date: Fri, 25 Jan 2019 09:26:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190125092605.2d40dce8@redhat.com>
In-Reply-To: <20190123182858.GG2193@work-vm>
References: <20190122200740.GC2241@work-vm>
	<20190122215941-mutt-send-email-mst@kernel.org>
	<20190123182858.GG2193@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] of apci_1_compatible in CPUHotplugFeatures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On Wed, 23 Jan 2019 18:28:59 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Tue, Jan 22, 2019 at 08:07:41PM +0000, Dr. David Alan Gilbert wrote:  
> > > Hi,
> > >   I noticed that the acpi_1_compatible flag was misspelt as
> > >                      apci_1_compatible
> > > 
> > > so have a trivial patch to fix that,
pls post it.

> > > but looking at it - are
> > > thre any cases where a[cp]i_1_compatible can possibly be false?
ATM it's not possible, but I've wrote it with intent to reuse
build_cpus_aml() in arm/virt board and there we shall use newer
aml_device() instead of legacy aml_processor(), hence a feature flag
to toggle behavior.


> > > 
> > > Dave  
> > 
> > legacy_cpu_hotplug so machine 2.6 and older - no?  
> 
> That doesn't seem to affect that flag by my reading;
> the only place I see legacy_cpu_hotplug checked is
> acpi-build.c:build_dsdt and we have:
> 
>     if (pcmc->legacy_cpu_hotplug) {
>         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>     } else {
>         CPUHotplugFeatures opts = {
>             .acpi_1_compatible = true, .has_legacy_cphp = true
>         };
>         build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
>                        "\\_SB.PCI0", "\\_GPE._E02");
>     }
> 
> so the 'opts' field is only used in the non-legacy case.
> 
> That's the only caller of build_cpus_aml, and I'm not seeing another
> user of CPUHotplugFeatures.
> 
> Dave
> 
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK  
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

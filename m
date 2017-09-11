Received: from eggs.gnu.org ([2001:4830:134:3::10]:39653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drMQA-0008QJ-BB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drMQ5-0002Un-TG
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drMQ5-0002UQ-Mi
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:58:25 -0400
Date: Mon, 11 Sep 2017 12:58:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170911125814.27a8d496@nial.brq.redhat.com>
In-Reply-To: <e970608d-fb97-210c-72e9-bf4f43a3e54c@cn.fujitsu.com>
References: <20170901154542.5687-1-cascardo@canonical.com>
	<20170901161118.GQ7570@localhost.localdomain>
	<2ab3aaef-c6d7-ae3d-808b-f947dcb3ed1c@cn.fujitsu.com>
	<20170904130814.GR7570@localhost.localdomain>
	<e970608d-fb97-210c-72e9-bf4f43a3e54c@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86/acpi: build SRAT when memory hotplug
 is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Thadeu Lima de Souza Cascardo <cascardo@canonical.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 5 Sep 2017 09:17:06 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> Hi Eduardo,
> 
> At 09/04/2017 09:08 PM, Eduardo Habkost wrote:
> [...]
> >> In my opinion, this may also add the hotpluggable memory, and see the
> >> following commemts.
> >>
> >>     /*
> >>      * Entry is required for Windows to enable memory hotplug in OS
> >>      * and for Linux to enable SWIOTLB when booted with less than
> >>            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>      * 4G of RAM. Windows works better if the entry sets proximity
> >>      * to the highest NUMA node in the machine.
> >>      * Memory devices may override proximity set by this entry,
> >>      * providing _PXM method if necessary.
> >>      */
> >>     if (hotplugabble_address_space_size) {
> >>         numamem = acpi_data_push(table_data, sizeof *numamem);
> >>         build_srat_memory(numamem, pcms->hotplug_memory.base,
> >>                           hotplugabble_address_space_size, pcms->numa_nodes
> >> - 1,
> >>                           MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> >>     }  
> >
> > You are correct, I didn't see that part of the code.  If that's
> > the entry that's missing, the patch makes sense.  Thanks!
> >
> > However, the resulting tables still don't look correct: it will
> > generate an entry assigned to NUMA node (uint32_t)-1 if no NUMA
> > nodes are configured elsewhere, some APIC entries, but no entries
> > for the rest of the memory.  
> 
> Yes, indeed.
> 
> >
> > Igor's suggestion to enable NUMA implicitly sounds safer to me.
> >  
> 
> I agree with Igor too.
> 
> Is anybody doing this? If not, may I make a patch to enable adding NUMA
> node implicitly first. let's see what it looks like.
As far as I'm aware nobody is doing it, so fill free to look into it.

> 
> Thanks,
> 	dou.
> 
> 

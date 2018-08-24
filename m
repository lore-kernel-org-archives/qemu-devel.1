Received: from eggs.gnu.org ([2001:4830:134:3::10]:56613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ft9bt-0003ms-Cj
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ft9bq-0001ao-7t
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:46:33 -0400
Date: Fri, 24 Aug 2018 07:46:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180824104622.GV3778@localhost.localdomain>
References: <1534931204-112747-1-git-send-email-imammedo@redhat.com>
	<c88ef55d-738b-57bc-f00f-b4a4d7303bd6@redhat.com>
	<20180822150536.6d79a1e1@redhat.com>
	<20180822180112.GB3778@localhost.localdomain>
	<20180823101406.06320b35@redhat.com>
	<20180823172501.GM3778@localhost.localdomain>
	<20180824100305.64e3ff08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824100305.64e3ff08@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pc: acpi: revert back to 1 SRAT entry for
 hotpluggable area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: haozhong.zhang@intel.com, xiaoguangrong.eric@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, john.ji@intel.com, Laszlo Ersek <lersek@redhat.com>

On Fri, Aug 24, 2018 at 10:03:05AM +0200, Igor Mammedov wrote:
> On Thu, 23 Aug 2018 14:25:01 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Thu, Aug 23, 2018 at 10:14:06AM +0200, Igor Mammedov wrote:
> > > On Wed, 22 Aug 2018 15:01:12 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:  
> > [...]
> > > > However, have you considered keeping adding separate entries for
> > > > NVDIMM devices only (so we follow the spec), but add a single
> > > > (numa_nodes-1, MEM_AFFINITY_HOTPLUGGABLE|MEM_AFFINITY_ENABLED)
> > > > entry to the rest?  
> > > Indeed, I did. It doesn't work either.  
> > 
> > When exactly it didn't work?  Did nvdimm + memory hotplug ever
> > worked together on Windows guests?
> before 848a1cc1e QEMU CLI with nvdimm + memory hotplug worked
> as expected for Windows.

OK, so my suggestion would still have a regression.  Nevermind.

> With approach you suggested, it would create several SRAT entries
> X for nvdimm and Y for the rest (1 in the best case or many if
> nvdimms/pc-dimms are interleaved) and that breaks memory hotplug.
>  
> > For all the other cases there should be absolutely no difference:
> > 
> > nvdimm users would still get a spec-compliant SRAT table (like on
> > QEMU 3.0).
> > 
> > Memory hotplug users w/o nvdimm would get the same ACPI table
> > that they would get after applying this patch (i.e. the one we
> > had before commit 848a1cc1e ("hw/acpi-build: build SRAT memory
> > affinity structures for DIMM devices").
> I did consider it. It still would be a regression but a minor one
> (only Windows nvdimm enabled cases will have regressed memory
> hotplug). I even have a patch for it, but it's still a regression,
> that's why I've posted full 848a1cc1e revert.
> 
> If it were a bug in the newest version of windows (assuming it's
> proven Windows bug), I'd be inclined towards being spec compliant
> and let MS fix Windows as it was with CPU hotplug (hijacked ACPI0010
> container) which they eventually fixed, but in this case it affects
> all guests versions and there is no proof that's a Windows bug.
> 
> So my hope here is that Intel has resources to figure out what
> Windows expectations are wrt SRAT/memory layout and memory hotplug.

Agreed.

-- 
Eduardo

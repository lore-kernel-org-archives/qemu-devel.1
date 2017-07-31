Received: from eggs.gnu.org ([2001:4830:134:3::10]:34148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dcDA0-0005fW-PN
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dcD9w-0000T4-Lv
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:03:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dcD9w-0000SQ-Bt
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:03:08 -0400
Date: Mon, 31 Jul 2017 18:03:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170731180300.6eceba74@nial.brq.redhat.com>
In-Reply-To: <20170731154808.GA13791@linux.intel.com>
References: <20170728180446.GA31104@linux.intel.com>
	<CAPcyv4i5YWK6RHYEkH6C1oPWwhPLOD-atmkMVXDXc-qdv_0hgw@mail.gmail.com>
	<20170728194543.GA20726@linux.intel.com>
	<20170729104933.zlsn7asawltzlfbx@hz-desktop>
	<20170731154808.GA13791@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU NVDIMM as type 7 in e820 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Linda Knippers <linda.knippers@hpe.com>, "Kani, Toshimitsu" <toshi.kani@hpe.com>

On Mon, 31 Jul 2017 09:48:08 -0600
Ross Zwisler <ross.zwisler@linux.intel.com> wrote:

> On Sat, Jul 29, 2017 at 06:49:33PM +0800, Haozhong Zhang wrote:
> > On 07/28/17 13:45 -0600, Ross Zwisler wrote:  
> > > On Fri, Jul 28, 2017 at 11:11:10AM -0700, Dan Williams wrote:  
> > > > On Fri, Jul 28, 2017 at 11:04 AM, Ross Zwisler
> > > > <ross.zwisler@linux.intel.com> wrote:  
> > > > > I've been using the virtualized NVDIMM support in QEMU for testing, and I
> > > > > noticed that the physical addresses used by the virtual NVDIMMs aren't present
> > > > > in the guest's e820 table.
> > > > >
> > > > > Here is the e820 table on my QEMU instance where I have one 32 GiB virtual
> > > > > NVDIMM:
> > > > >
> > > > > [    0.000000] e820: BIOS-provided physical RAM map:
> > > > > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> > > > > [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> > > > > [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> > > > > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdefff] usable
> > > > > [    0.000000] BIOS-e820: [mem 0x00000000bffdf000-0x00000000bfffffff] reserved
> > > > > [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> > > > > [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> > > > > [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable
> > > > >
> > > > > The physical addresses used by the virtual NVDIMM are 0x240000000-0xA40000000.
> > > > > You can see this by looking at ndctl and the values we get from the NFIT:
> > > > >
> > > > > # ndctl list -R
> > > > > {
> > > > >   "dev":"region0",
> > > > >   "size":34359738368,
> > > > >   "available_size":0,
> > > > >   "type":"pmem"
> > > > > }
> > > > >
> > > > > # grep . /sys/bus/nd/devices/region0/{resource,size}
> > > > > region0/resource:0x240000000
> > > > > region0/size:34359738368
> > > > >
> > > > > Or you can see the same info by using iasl to dump
> > > > > /sys/firmware/acpi/tables/NFIT:
> > > > >
> > > > > [028h 0040   2]                Subtable Type : 0000 [System Physical Address Range]
> > > > > [02Ah 0042   2]                       Length : 0038
> > > > >
> > > > > [02Ch 0044   2]                  Range Index : 0002
> > > > > [02Eh 0046   2]        Flags (decoded below) : 0003
> > > > >                    Add/Online Operation Only : 1
> > > > >                       Proximity Domain Valid : 1
> > > > > [030h 0048   4]                     Reserved : 00000000
> > > > > [034h 0052   4]             Proximity Domain : 00000000
> > > > > [038h 0056  16]           Address Range GUID : 66F0D379-B4F3-4074-AC43-0D3318B78CDB
> > > > > [048h 0072   8]           Address Range Base : 0000000240000000
> > > > > [050h 0080   8]         Address Range Length : 0000000800000000
> > > > > [058h 0088   8]         Memory Map Attribute : 0000000000008008
> > > > >
> > > > > I expected to see a type 7 region for the NVDIMM physical address range in the
> > > > > e820 table, so something like:
> > > > >
> > > > > [    0.000000] e820: BIOS-provided physical RAM map:
> > > > > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> > > > > [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> > > > > [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> > > > > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdefff] usable
> > > > > [    0.000000] BIOS-e820: [mem 0x00000000bffdf000-0x00000000bfffffff] reserved
> > > > > [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> > > > > [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> > > > > [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable
> > > > > [    0.000000] BIOS-e820: [mem 0x0000000240000000-0x0000000A40000000] persistent (type 7)
> > > > >  
> > > > 
> > > > Do you need that informationin e820? Linux effectively ignores type-7.
> > > > As long as the range is treated as reserved it's not clear that you
> > > > need the e820 entry. We also infect the persistent type back into the
> > > > memory map when the NFIT driver loads. /proc/iomem should show the
> > > > right data.  
> > > 
> > > [ Adding Linda & Toshi to see if they have an opinion. ]
> > > 
> > > I guess maybe we don't need it.  Yep, /proc/iomem looks good:
> > > 
> > >   # cat /proc/iomem
> > >   00000000-00000fff : Reserved
> > >   00001000-0009fbff : System RAM
> > >   ...
> > >   100000000-23fffffff : System RAM
> > >   240000000-a3fffffff : Persistent Memory
> > >     240000000-a3fffffff : namespace0.0
> > > 
> > > I was just worried that this was an inconsistency between the way that virtual
> > > NVDIMMs are presented vs the way that they will be presented on bare metal.  I
> > > at least look at the e820 table to get my bearings of how memory is laid out -
> > > maybe I just need to look at /proc/iomem instead?  
> > 
> > Do any OS or applications rely on the E820 information or the
> > consistency between E820 and NFIT to properly work? If any, I can make
> > a QEMU patch to build type-7 e820 entries.  
> 
> I don't know of any off hand, but IMO it would be good to have this
> consistency.
Maybe we should wait till there is an actual hardware that does it and OS
which uses it.

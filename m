Received: from eggs.gnu.org ([2001:4830:134:3::10]:40149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1db9d8-0002SR-LT
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1db9d3-00050y-Ri
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:04:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:19129)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1db9d3-0004zl-Jk
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:04:49 -0400
Date: Fri, 28 Jul 2017 12:04:46 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Message-ID: <20170728180446.GA31104@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] QEMU NVDIMM as type 7 in e820 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, linux-nvdimm@lists.01.org
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>

I've been using the virtualized NVDIMM support in QEMU for testing, and I
noticed that the physical addresses used by the virtual NVDIMMs aren't present
in the guest's e820 table.

Here is the e820 table on my QEMU instance where I have one 32 GiB virtual
NVDIMM:

[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffdf000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable

The physical addresses used by the virtual NVDIMM are 0x240000000-0xA40000000.
You can see this by looking at ndctl and the values we get from the NFIT:

# ndctl list -R 
{
  "dev":"region0",
  "size":34359738368,
  "available_size":0,
  "type":"pmem"
}

# grep . /sys/bus/nd/devices/region0/{resource,size}
region0/resource:0x240000000
region0/size:34359738368

Or you can see the same info by using iasl to dump
/sys/firmware/acpi/tables/NFIT:

[028h 0040   2]                Subtable Type : 0000 [System Physical Address Range]
[02Ah 0042   2]                       Length : 0038

[02Ch 0044   2]                  Range Index : 0002
[02Eh 0046   2]        Flags (decoded below) : 0003
                   Add/Online Operation Only : 1
                      Proximity Domain Valid : 1
[030h 0048   4]                     Reserved : 00000000
[034h 0052   4]             Proximity Domain : 00000000
[038h 0056  16]           Address Range GUID : 66F0D379-B4F3-4074-AC43-0D3318B78CDB
[048h 0072   8]           Address Range Base : 0000000240000000
[050h 0080   8]         Address Range Length : 0000000800000000
[058h 0088   8]         Memory Map Attribute : 0000000000008008

I expected to see a type 7 region for the NVDIMM physical address range in the
e820 table, so something like:

[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffdf000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000240000000-0x0000000A40000000] persistent (type 7)

Thanks,
- Ross

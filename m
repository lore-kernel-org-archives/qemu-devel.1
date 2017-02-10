Received: from eggs.gnu.org ([2001:4830:134:3::10]:41630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cc8RG-0003Kf-5d
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cc8RD-0008Iz-B5
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:28:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cc8RD-0008II-3K
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:28:23 -0500
Date: Fri, 10 Feb 2017 11:28:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170210112819.40455c70@nial.brq.redhat.com>
In-Reply-To: <88aaebda-29dd-a77a-1b78-7d0d6f911a76@redhat.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<88aaebda-29dd-a77a-1b78-7d0d6f911a76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/10] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org, mst@redhat.com

On Fri, 10 Feb 2017 11:12:13 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 02/05/17 10:11, ben@skyportsystems.com wrote:
> > From: Ben Warren <ben@skyportsystems.com>
> > 
> > This patch set adds support for passing a GUID to Windows guests.  It is a
> > re-implementation of previous patch sets written by Igor Mammedov et al, but
> > this time passing the GUID data as a fw_cfg blob.
> > 
> > This patch set has dependencies on new guest functionality, in particular the
> > support for a new linker-loader command and the ability to write back data
> > to QEMU over a DMA link.  Work is in flight in both SeaBIOS and OVMF to support this.
> > 
> > v4->v5:
> >     - Added significantly more detail to the documentation.
> >     - Replaced the previously-implemented linker-loader command with a new one:
> >       "write pointer".  This allows writing the guest address of a fw_cfg blob back
> >       to an arbitrary offset in a writeable fw_cfg file visible to QEMU.  This will
> >       require support in SeaBIOS and OVMF (ongoing).
> >     - Fixed endianness issues throughout.
> >     - Several styling cleanups.  
> 
> Low importance question, but I'll ask it anyway:
> 
> Can we somehow make the realization of "-device vmgenid" fail, if the PC
> machine type in use is 2.6 or earlier? Because, those machine types do
> not have DMA enabled for fw_cfg. Hence the WRITE_POINTER commands cannot
> be effectively executed by firmware (the underlying virtual hardware is
> not enabled).
> 
> For example, if a user adds VMGENID to a 2.5 machine type, and migrates
> the VM, then on the target host,
> 
>   vmgenid_post_load()
>     vmgenid_update_guest()
> 
> will not be effective, because (back on the source host) the guest had
> no way to write the address of the downloaded "etc/vmgenid" blob to
> "etc/vmgenid_addr".
> 
> I don't think it's a big deal, but perhaps we can be user-friendly a
> bit. Things that crossed my mind (different levels of ugliness):
> 
> - in the realize function for vmgenid (which I've proposed anyway, for
> registering the reset handler), we could look up the fw_cfg object, and
> see if its "dma-enabled" property is on or off. Possible problem: not
> sure if such cross-device checks are allowed in realize methods, and if
> there are any ordering issues for this. (I.e., when vmgenid's realize
> checks, has the property been set for fw_cfg?)
> 
> - or else, add another boolean property to vmgenid, one that parallels
> "dma-enabled" of "fw-cfg" precisely, in HW_COMPAT*. Then simply fail
> realize() when this property is false.
we usually shouldn't poke from realize to outside world so
I'd go compat property way.


> There are probably better ways...
> 
> Anyway, it's not a big deal, I think this can be addressed incrementally
> (or not at all, perhaps). I don't want to delay the series with it, just
> throwing it out there.
> 
> BTW, I tested the OVMF patches against v5, and it looks good. I
> cross-referenced the firmware log with acpidump in the guest, plus I
> used dump-guest-memory and the "crash" utility to check the memory
> contents for the guest, before/after setting the GUID with the monitor
> command.
> 
> I'd like to verify S3 too, but for that I'd like to use v6 (which I hope
> clears "vgia_le" on reset).
> 
> Thanks,
> Laszlo
> 
> > 
> > v3->v4:
> >     - Rebased to top of tree.
> >     - Re-added document patch that was accidentally dropped from the last revision.
> >     - Added VMState functionality so that VGIA is restored properly.
> >     - Added Unit tests
> > v2->v3:
> >     - Added second writeable fw_cfg for storing the VM Generaiton ID
> >       address.  This uses a new linker-loader command for instructing the
> >       guest to write back the allocated address.  A patch for SeaBIOS has been
> >       submitted (https://www.seabios.org/pipermail/seabios/2017-January/011079.html)
> >       and the resulting binary will need to be pulled into QEMU once accepted.
> >     - Setting VM Generation ID by command line or qmp/hmp now accepts an "auto"
> >       value, whereby QEMU generates a random GUID.
> >     - Incorporated review comments from v2 mainly around code styling and AML syntax
> >     - Changed to use the E05 ACPI event instead of E00
> > v1->v2:
> >     - Removed "changed" boolean parameter as it is unneeded
> >     - Added ACPI Notify logic
> >     - Style changes to pass checkpatch.pl
> >     - Added support for dynamic sysbus to pc_piix boards
> > 
> > 
> > Ben Warren (8):
> >   ACPI: Add a function for building named qword entries
> >   linker-loader: Add new 'write pointer' command
> >   docs: VM Generation ID device description
> >   ACPI: Add vmgenid storage entries to the build tables
> >   ACPI: Add Virtual Machine Generation ID support
> >   PC: Support dynamic sysbus on pc_i440fx
> >   tests: Move reusable ACPI macros into a new header file
> >   tests: Add unit tests for the VM Generation ID feature
> > 
> > Igor Mammedov (2):
> >   qmp/hmp: add query-vm-generation-id and 'info vm-generation-id'
> >     commands
> >   qmp/hmp: add set-vm-generation-id commands
> > 
> >  default-configs/i386-softmmu.mak     |   1 +
> >  default-configs/x86_64-softmmu.mak   |   1 +
> >  docs/specs/vmgenid.txt               | 239 +++++++++++++++++++++++++++++++++++
> >  hmp-commands-info.hx                 |  13 ++
> >  hmp-commands.hx                      |  13 ++
> >  hmp.c                                |  21 +++
> >  hmp.h                                |   2 +
> >  hw/acpi/Makefile.objs                |   1 +
> >  hw/acpi/aml-build.c                  |  39 +++++-
> >  hw/acpi/bios-linker-loader.c         |  35 +++--
> >  hw/acpi/nvdimm.c                     |   2 +-
> >  hw/acpi/vmgenid.c                    | 238 ++++++++++++++++++++++++++++++++++
> >  hw/arm/virt-acpi-build.c             |   4 +-
> >  hw/i386/acpi-build.c                 |  18 ++-
> >  hw/i386/pc_piix.c                    |   1 +
> >  include/hw/acpi/acpi_dev_interface.h |   1 +
> >  include/hw/acpi/aml-build.h          |   5 +
> >  include/hw/acpi/bios-linker-loader.h |   3 +-
> >  include/hw/acpi/vmgenid.h            |  37 ++++++
> >  qapi-schema.json                     |  31 +++++
> >  stubs/Makefile.objs                  |   1 +
> >  stubs/vmgenid.c                      |  14 ++
> >  tests/Makefile.include               |   2 +
> >  tests/acpi-utils.h                   |  75 +++++++++++
> >  tests/bios-tables-test.c             |  72 +----------
> >  tests/vmgenid-test.c                 | 184 +++++++++++++++++++++++++++
> >  26 files changed, 962 insertions(+), 91 deletions(-)
> >  create mode 100644 docs/specs/vmgenid.txt
> >  create mode 100644 hw/acpi/vmgenid.c
> >  create mode 100644 include/hw/acpi/vmgenid.h
> >  create mode 100644 stubs/vmgenid.c
> >  create mode 100644 tests/acpi-utils.h
> >  create mode 100644 tests/vmgenid-test.c
> >   
> 

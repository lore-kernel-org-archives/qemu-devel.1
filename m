Received: from eggs.gnu.org ([2001:4830:134:3::10]:39798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cQyHB-0002xP-8t
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 10:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cQyHA-0002uz-2z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 10:23:53 -0500
References: <20161201170624.26496-1-lersek@redhat.com>
	<20170110170453-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <26322db9-c82b-405f-b2a8-f2d16b0d69b0@redhat.com>
Date: Tue, 10 Jan 2017 16:23:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170110170453-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/7] q35: add negotiable broadcast SMI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Gabriel L. Somlo" <somlo@cmu.edu>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Walle <michael@walle.cc>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org

On 01/10/17 16:06, Michael S. Tsirkin wrote:
> On Thu, Dec 01, 2016 at 06:06:17PM +0100, Laszlo Ersek wrote:
>> * This is version 4 of the series; the last version was at
>>   <http://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg03582.html>.
>>
>>   This version is practically a rewrite from scratch, seeking to address
>>   the v3 feedback. Here's what the individual patches do:
>>
>>   - Patch #1 rebases and extends Michael's "writeable fw_cfg blobs"
>>     patch from Feb/March 2016. The changes relative to the original
>>     patch are documented in the commit message (the code changes are
>>     minimal).
>>
>>   - Patches #2 and #3 turn the FW_CFG_FILE_SLOTS constant into a device
>>     property, and expose the desired number of fw_cfg file slots to
>>     board code. This is meant to address a concern raised by Paolo in
>>     the v2 review
>>     <http://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg03125.html>,
>>     namely that we're about to run out of FW_CFG_FILE_SLOTS.
>>
>>   - Patch #4 introduces the "pc-q35-2.9" and "pc-i440fx-2.9" machine
>>     types, which are allowed to take advantage of the new default for
>>     fw_cfg file slots (0x20 rather than 0x10).
>>
>>   - Patch #5 introduces SMI feature negotiation via fw_cfg, with the
>>     following new files:
>>
>>     - etc/smi/host-features
>>     - etc/smi/guest-features
>>     - etc/smi/features-ok
>>
>>     This is supposed to follow Michael's recommendation re: imitating
>>     virtio
>>     <http://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg03218.html>.
>>
>>     The guest-features file is freely writeable by the guest (no write
>>     callbacks in fw_cfg), and the feature validation & lockdown occurs
>>     when the guest selects the features-ok file (for reading).
>>
>>     Board code is allowed to choose the host feature bitmap to
>>     advertise.
>>
>>     This patch doesn't add any specific SMI features yet.
>>
>>   - Patch #6 adds the ICH9_LPC_SMI_F_BROADCAST feature.
>>
>>   - Patch #7 introduces the PCMachineClass.get_smi_host_features method,
>>     and implements it for "pc-q35-2.9" and later. The idea is to tie the
>>     SMI host features to machine types, and let the machine types
>>     calculate their host features with code (i.e., not just a constant).
>>
>>     In this patch, the "pc-q35-2.9" machine type exposes the
>>     ICH9_LPC_SMI_F_BROADCAST feature iff (smp_cpus == max_cpus), that
>>     is, when VCPU hotplug is not possible. (Also from Paolo's v3
>>     feedback, in
>>     <http://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg04919.html>.)
>>
>> * I've written the OVMF side patches too and tested them together
>>   (including gdb / debug messages for "white box" testing).
>>
>> * Note that this version depends on the following PULL req from Michael:
>>
>>   [Qemu-devel] [PULL 0/5] virtio, vhost, pc: fixes
>>   http://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg05503.html
>>
>>   In particular on the following patch:
>>   "loader: fix handling of custom address spaces when adding ROM blobs"
>>
>> Cc: "Gabriel L. Somlo" <somlo@cmu.edu>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Michael Walle <michael@walle.cc>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Shannon Zhao <zhaoshenglong@huawei.com>
>> Cc: qemu-arm@nongnu.org
>>
>> Thanks
>> Laszlo
> 
> So I reviewed fw cfg stuff, looks good to me.

Thank you.

I should note that Igor suggested / requested changes for patches #2 and
#3; the sub-threads start at

http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg00695.html
msg-id: <20161206115038.4495a217@nial.brq.redhat.com>

http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg00706.html
msg-id: <20161206124906.76a41896@nial.brq.redhat.com>

I was about to rework the patches based on his feedback. Should we
resume those discussions?

> I'd prefer Paolo to review
> and merge broadcast SMI stuff as appropriate.  Paolo, makes sense?

If it helps, I can split the series into two "waves", and deal only with
fw_cfg first.

Thanks!
Laszlo

> 
> 
>> Laszlo Ersek (6):
>>   fw-cfg: turn FW_CFG_FILE_SLOTS into a device property
>>   fw-cfg: expose "file_slots" parameter in fw_cfg_init_io_dma()
>>   hw/i386/pc: introduce 2.9 machine types with 0x20 fw_cfg file slots
>>   hw/isa/lpc_ich9: add SMI feature negotiation via fw_cfg
>>   hw/isa/lpc_ich9: add broadcast SMI feature
>>   hw/i386/pc_q35: advertise broadcast SMI if VCPU hotplug is turned off
>>
>> Michael S. Tsirkin (1):
>>   fw-cfg: support writeable blobs
>>
>>  docs/specs/fw_cfg.txt          |  36 +++++++++---
>>  hw/lm32/lm32_hwsetup.h         |   2 +-
>>  include/hw/compat.h            |  11 ++++
>>  include/hw/i386/ich9.h         |  15 ++++-
>>  include/hw/i386/pc.h           |   4 ++
>>  include/hw/loader.h            |   7 ++-
>>  include/hw/nvram/fw_cfg.h      |   5 +-
>>  include/hw/nvram/fw_cfg_keys.h |   7 ++-
>>  hw/arm/virt-acpi-build.c       |   2 +-
>>  hw/core/loader.c               |  18 +++---
>>  hw/i386/acpi-build.c           |   4 +-
>>  hw/i386/pc.c                   |   3 +-
>>  hw/i386/pc_piix.c              |  16 +++++-
>>  hw/i386/pc_q35.c               |  37 ++++++++++++-
>>  hw/isa/lpc_ich9.c              |  92 +++++++++++++++++++++++++++++-
>>  hw/nvram/fw_cfg.c              | 123 +++++++++++++++++++++++++++++++++++------
>>  16 files changed, 326 insertions(+), 56 deletions(-)
>>
>> -- 
>> 2.9.2

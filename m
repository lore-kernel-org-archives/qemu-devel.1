Received: from eggs.gnu.org ([2001:4830:134:3::10]:44961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fn4OY-0007ie-HB
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fn4OU-0008Tq-Jf
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:59:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46088 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fn4OU-0008RX-Ck
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:59:34 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
	<893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
Message-ID: <e06b10e0-d0b6-d190-6673-f97199bebb72@redhat.com>
Date: Tue, 7 Aug 2018 17:59:20 +0200
MIME-Version: 1.0
In-Reply-To: <893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pci: add pci capability to pci-pci
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jing Liu <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, mst@redhat.com

On 08/07/18 14:19, Laszlo Ersek wrote:
> On 08/07/18 09:04, Jing Liu wrote:
>> Add hint to firmware (e.g. SeaBIOS) to reserve addtional
>> IO/MEM/PREF spaces for legacy pci-pci bridge, to enable
>> some pci devices hotplugging whose IO/MEM/PREF spaces
>> requests are larger than the ones in pci-pci bridge set
>> by firmware.
>>
>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
>> ---
>>  hw/pci-bridge/pci_bridge_dev.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)

>> +cap_error:
>> +    msi_uninit(dev);
> 
> (4) This error handler doesn't look entirely correct; we can reach it
> without having initialized MSI. (MSI setup is conditional; and even if
> we attempt it, it is permitted to fail with "msi=auto".) Therefore,
> msi_uninit() should be wrapped into "if (msi_present())", same as you
> see in pci_bridge_dev_exitfn().
> 
>>  msi_error:
>>      slotid_cap_cleanup(dev);
>>  slotid_error:

I tried to understand the error handling a bit better. I'm confused.

First, under the label "shpc_error", we call pci_bridge_exitfn(), which
seems to clean up everything (checking individually for each thing to
clean up). Given this, I wonder why we introduced the "slotid_error" and
"msi_error" labels at all. Cascading teardown on the error path, and
invkoing a function that checks everything individually and then tears
it all down, are usually mutually exclusive.

Second, msi_uninit() and shpc_cleanup() are internally inconsistent
between each other. The former removes the respective capability from
config space -- with pci_del_capability() --, but the latter only has a
comment, "/* TODO: cleanup config space changes? */". The same comment
is present in the slotid_cap_cleanup() function. Given this
inconsistency, I don't know what to suggest for the new capability's
teardown, in pci_bridge_dev_exitfn()  -- should we just ignore it (as
suggested by this patch)?

Thanks
Laszlo

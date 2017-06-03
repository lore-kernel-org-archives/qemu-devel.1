Received: from eggs.gnu.org ([2001:4830:134:3::10]:44070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dH3bz-0002Pw-3L
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 03:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dH3bw-00082N-0s
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 03:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dH3bv-00081W-R5
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 03:36:35 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
Message-ID: <2ff62b03-d71b-93c4-79bf-10682b229758@redhat.com>
Date: Sat, 3 Jun 2017 09:36:23 +0200
MIME-Version: 1.0
In-Reply-To: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] allocation zone extensions for the firmware
 linker/loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: SeaBIOS devel list <SeaBIOS@seabios.org>, qemu devel list <qemu-devel@nongnu.org>, edk2-devel-ml01 <edk2-devel@ml01.01.org>
Cc: Kevin O'Connor <kevin@koconnor.net>, "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ben Warren <ben@skyportsystems.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, "Jordan Justen (Intel address)" <jordan.l.justen@intel.com>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 06/02/17 17:45, Laszlo Ersek wrote:

> The patches can cause linker/loader breakage when old firmware is booted
> on new QEMU. However, that's no problem (it's nothing new), the next
> release of QEMU should bundle the new firmware binaries as always.

Dave made a good point (which I should have realized myself, really!),
namely if you launch old fw on old qemu, then migrate the guest to a new
qemu and then reboot the guest on the target host, within the migrated
VM, things will break.

So that makes this approach dead in the water.

Possible mitigations I could think of:
- Make it machine type dependent. Complicated (we don't usually bind
ACPI generation to machine types) and wouldn't help existing devices.
- Let the firmware negotiate these extensions. Very complicated (new
fw-cfg files are needed for negotiation) and wouldn't help existing devices.

So I guess I'll do what Igor and Gerd suggested: record in advance
whether any pointer field narrower than 8 bytes points into a given
blob, and if so, forbid allocating that blob from 64-bit address space.
This should solve Ard's needs purely within the firmware.

Regarding the NOACPI hint, I guess I'm dropping that. I only meant
NOACPI for addressing Igor's long-standing dislike for the "ACPI SDT
header probe suppression" in VMGENID (and future similar devices). But,
there's no actual *technical* need to eliminate that (unlike the
technical need for 64-bit blob allocations which should really be
solved), so I guess it's OK to postpone NOACPI indefinitely.

Self-nack for this set of sets.

Thanks for the feedback,
Laszlo

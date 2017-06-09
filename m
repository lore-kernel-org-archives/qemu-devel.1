Received: from eggs.gnu.org ([2001:4830:134:3::10]:36477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dJNuT-0003m0-E8
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dJNuP-0001Zq-Gr
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:41:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dJNuP-0001ZS-7w
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:41:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FC1BC057FA6
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 17:41:14 +0000 (UTC)
References: <20170608161013.17920-1-lersek@redhat.com>
	<20170608204026-mutt-send-email-mst@kernel.org>
	<1496951333.29761.5.camel@redhat.com>
	<20170608224942-mutt-send-email-mst@kernel.org>
	<d7cb6756-6d1f-60ee-c7b6-ef6a8b08bb08@redhat.com>
	<20170609031436-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <232488ab-cbb5-d296-2087-5af3c869214c@redhat.com>
Date: Fri, 9 Jun 2017 19:41:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170609031436-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 06/09/17 02:19, Michael S. Tsirkin wrote:
> On Fri, Jun 09, 2017 at 01:01:54AM +0200, Laszlo Ersek wrote:
>> On 06/08/17 21:55, Michael S. Tsirkin wrote:
>>> On Thu, Jun 08, 2017 at 09:48:53PM +0200, Gerd Hoffmann wrote:
>>>>   Hi,
>>>>
>>>>> I really dislike negotiation being re-invented for each device.  Do
>>>>> we
>>>>> need these tricks?  Can we just do fw cfg with standard discovery?
>>>>> This ties in with my proposal to generalize smi features to
>>>>> generic ones.
>>>>
>>>> Device properties should be part of the device.
>>>> We should have done this with the smi too.
>>>
>>> What is part of the device and what isn't? It's all part
>>> of QEMU in the end.  Adding probing for multiple devices
>>> will just add to number of exits and slow down guest boot.
>>>
>>> We do want to stick to emulating real devices if we can, no argument
>>> here - but this stuff is PV anyway - what do we gain by spreading it
>>> out?
>>>
>>>> A more standard way to handle this would be to add a vendor-specific
>>>> pci capability and place the register there.  Not sure we have room for
>>>> that in the pci config space though.
>>>>
>>>> cheers,
>>>>   Gerd
>>>
>>> We don't have room anywhere in PCI config space. Laszlo makes argument
>>> why it's safe for this device based on spec but it's anyone's guess
>>> whether current and future software will follow spec.  In short, going
>>> anywhere near the emulated device has a potential to break some drivers.
>>
>> I'm fine using any QEMU facility that lets independent firmware modules
>> perform their feature detections / negotiations / lockdowns in arbitrary
>> order between each other. (Hopefully without extreme parsing requirements.)
> 
> How about adding etc/mch/features etc copying the smi stuff? Is this
> simple enough? We can worry about removing code duplication later.

I'm having a hard time mapping the negotiation used for SMI to this
TSEG-size case. (Just to be sure I've now re-read the commit message on
50de920b372b ("hw/isa/lpc_ich9: add SMI feature negotiation via fw_cfg",
2017-01-26).)

For SMI, there is only one way to trigger it. And the broadcast feature,
if negotiated, modifies the behavior of SMI. It does not change how the
SMI is triggered by the guest.

The TSEG size selection differs. There are already three options for the
guest (bit patterns 00 -> 1MB, 01 -> 2MB, 10 -> 8MB) to write to
ESMRAMC.TSEG_SZ. Let's say the guest wants more:

- First, beyond learning whether "more is possible", it has to know
exactly "how much". So a single bit in some "host-features" bitmask is
not good enough for that.

- Second, assuming an increased TSEG size is available (with a queriable
size), the bit patterns 00, 01, 10 should still not change their
behavior / meaning. For example, I don't see how

  ESMRAMC.TSEG_SZ == 00

(implying 1MB TSEG) could coexist with the guest actually negotiating
16MB via another communication channel. Whatever code looked at
ESMRAMC.TSEG_SZ would rightfully think there was a 1MB TSEG.

So I think such a side-channel negotiation would actually violate
specified behavior from the Q35 spec, rather than just fill in
reserved/unspecified bits.

- The third doubt I have is security / lockdown. In the SMI case, we
defined our own lockdown scheme, and it did not overlap or conflict with
anything. For SMRAM however, the SMRAM.D_LCK bit already locks down a
whole bunch of things, including the ESMRAMC.TSEG_SZ field. Should
SMRAM.D_LCK also lock down the "other" negotiation channel? If that's
our choice, then we diverge at once from the negotiation pattern seen
with SMI. Or else, what if we lock down the "other" channel (selecting
16MB for example), but don't lock down D_LCK? Then ESMRAMC.TSEG_SZ can
still be modified, and that should actually affect the TSEG size
(because D_LCK is not set).

... I think the negotiation pattern we used for etc/smi/* doesn't apply
here; the Q35 spec already defines too much of a selection / lockdown
dance for that. We could perhaps figure out the interactions, but (a)
it's a security thing so there isn't much room for mistakes, and (b) we
wouldn't be reusing the pattern seen with the SMI feature negotiation
anyway.

ESMRAMC.TSEG_SZ == 11 is the simplest (non-conflicting) extension to the
Q35 spec, IMO. That's the core thing.

How we pass the information to the guest that
(a) ESMRAMC.TSEG_SZ == 11 is available, and
(b) what size it actually means

is a secondary question. For this, my original suggestion was a new
fw_cfg file indeed:

https://lists.01.org/pipermail/edk2-devel/2017-May/010404.html

but Gerd seemed to prefer PCI config space. I was fine either way.

(Please note that a malicious guest OS cannot fake an fw_cfg file on old
QEMU, but it can fill in unimplemented registers in PCI config space.
This is why using fw_cfg for querying the extended TSEG availability and
size would be a "read only" operation in the guest, and why using PCI
config space instead requires a *write* operation first. The latter has
nothing to do with feature negotiation; the write occurs only to
suppress earlier tampering from a malicious guest OS, pre-reboot.)

Summary:

(1) I don't think the pattern that we used for broadcast SMI applies
here; we already have a spec-mandated selection and lockdown protocol
involving ESMRAMC.TSEG_SZ and SMRAM.D_LCK.

I don't think we can, or should try to, diverge from this protocol. In
fact we're lucky to have a reserved bitmask value (11) in ESMRAMC.TSEG_SZ.

(2) How exactly we inform the guest about the TSEG size that
(ESMRAMC.TSEG_SZ == 11) corresponds to is a secondary question. We can
make it a constant (and pray, like Paolo mentions), or we can make it
cmdline-configurable and expose it via PCI config space, or we can make
it cmdline-configurable and expose it via a new fw_cfg file. In OVMF I
can easily accommodate either of these three options.

Thanks
Laszlo

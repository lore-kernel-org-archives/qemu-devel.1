Received: from eggs.gnu.org ([2001:4830:134:3::10]:33455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1dd6Eg-0005Y9-Ai
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 22:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1dd6Eb-0005G7-NH
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 22:51:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laine@redhat.com>) id 1dd6Eb-0005FF-DK
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 22:51:37 -0400
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-6-git-send-email-zuban32s@gmail.com>
	<491f77fc-974c-33dd-3974-08ab61d2c078@redhat.com>
	<CAKSfGUCTom8YBs8wOHMX_MpzDF1efB8_USb4tuW+hcAdoG2xvw@mail.gmail.com>
	<20170802003910-mutt-send-email-mst@kernel.org>
	<17a71bfc-1933-f707-2504-c9c699534cea@redhat.com>
	<20170802164551-mutt-send-email-mst@kernel.org>
	<9e36b7d6-bff3-b046-6053-162fb75ca0a0@redhat.com>
	<b0e1c72d-9c17-42e5-3135-5ebb1e53b4f1@redhat.com>
	<c4761b15-4525-247c-14da-510b20dbf90a@redhat.com>
	<20170802192446-mutt-send-email-mst@kernel.org>
	<597fd60c-d8ec-0334-10de-3ff4947055ea@redhat.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <6b6e8efe-18d6-8d77-ad8c-54b8f7ba2ef8@redhat.com>
Date: Wed, 2 Aug 2017 22:41:34 -0400
MIME-Version: 1.0
In-Reply-To: <597fd60c-d8ec-0334-10de-3ff4947055ea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] docs: update documentation
 considering PCIE-PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Alexander Bezzubikov <zuban32s@gmail.com>, ehabkost@redhat.com, seabios@seabios.org, Kevin OConnor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net

On 08/02/2017 01:58 PM, Marcel Apfelbaum wrote:
> On 02/08/2017 19:26, Michael S. Tsirkin wrote:
>> On Wed, Aug 02, 2017 at 06:36:29PM +0300, Marcel Apfelbaum wrote:
>>>>>>>> Can dmi-pci support shpc? why doesn't it? For compatibility?
>>>>>>>
>>>>>>> I don't know why, but the fact that it doesn't is the reason libvirt
>>>>>>> settled on auto-creating a dmi-pci bridge and a pci-pci bridge under
>>>>>>> that for Q35. The reasoning was (IIRC Laine's words correctly)
>>>>>>> that the
>>>>>>> dmi-pci bridge cannot receive hotplugged devices, while the pci-pci
>>>>>>> bridge cannot be connected to the root complex. So both were needed.


At least that's what I was told :-) (seriously, 50% of the convoluted
rules encoded into libvirt's PCI bus topology construction and
connection rules come from trial and error, and the other 50% come from
advice and recommendations from others who (unlike me) actually know
something about PCI.)

Of course the whole setup of plugging a pci-bridge into a
dmi-to-pci-bridge was (at the time at least) an exercise in futility,
since hotplug didn't work properly on pci-bridge+Q35 anyway (that
initially wasn't explained to me; it was only after I had constructed
the odd bus topology and it was in released code that someone told me
"Oh, by the way, hotplug to pci-bridge doesn't work on Q35". At first it
was described as a bug, then later reclassified as a future feature.)

(I guess the upside is that all of the horrible complex/confusing code
needed to automatically add two controllers just to plug in a single
endpoint is now already in the code, and will "just work" if/when needed).

Now that I go back to look at this thread (qemu-devel is just too much
for me to try and read unless something has been Cc'ed to me - I really
don't know how you guys manage it!), I see that pcie-pci-bridge has been
implemented, and we (libvirt) will want to use that instead of
dmi-to-pci-bridge when available. And pcie-pci-bridge itself can have
endpoints hotplugged into it, correct? This means there will need to be
patches for libvirt that check for the presence of pcie-pci-bridge, and
if it's found they will replace any auto-added
dmi-to-pci-bridge+pci-bridge with a long pcie-pci-bridge.

>>>>>>>
>>>>>>> Thanks
>>>>>>> Laszlo
>>>>>>
>>>>>> OK. Is it true that dmi-pci + pci-pci under it will allow hotplug
>>>>>> on Q35 if we just flip the bit in _OSC?
>>>>>
>>>>> Marcel, what say you?... :)
>>>
>>> Good news, works with:
>>>     -device i82801b11-bridge,id=b1
>>>     -device pci-bridge,id=b2,bus=b1,chassis_nr=1,msi=off
>>
>> And presumably it works for modern windows?
>> OK, so it looks like patch 1 is merely a bugfix, I'll merge it for 2.10.
>>
> 
> Tested with Win10, I think is OK to merge if for 2.10.
> 
>>> Notice bridge's msi=off until the following kernel bug will be merged:
>>>    https://www.spinics.net/lists/linux-pci/msg63052.html
>>
>> Does libvirt support msi=off as a work-around?

We have no explicit setting for msi on pci controllers. The only place
we explicitly set that is on the ivshmem device.

That doesn't mean that we couldn't add it. However, if we were going to
do it manually, that would mean adding another knob that we have to
support forever. And even if we wanted to do it automatically, we would
not only need to find something in qemu to key off of when deciding
whether or not to set it, but we would *still* have to explicitly store
the setting in the config so that migrations between hosts using
differing versions of qemu would preserve guest ABI. Are there really
enough people demanding (with actual concrete plans of *using*) hotplug
of legacy PCI devices on Q35 guests *immediately* that we want to
permanently pollute libvirt's code in this manner just for an interim
workaround?


I didn't have enough time/energy to fully parse all the rest of this
thread - is msi=off currently required for pcie-pci-bridge hotplug as
well? (not that it changes my opinion - just as we can tell people
"upgrade to a new qemu and libvirt if you want to hotplug legacy PCI
devices on Q35 guests", we can also tell them "Oh, and wait X weeks and
upgrade to a new kernel too".

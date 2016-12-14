Received: from eggs.gnu.org ([2001:4830:134:3::10]:40128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cH6OW-0002Z2-Qa
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cH6OU-00065b-QE
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:02:40 -0500
References: <1473773430-19616-1-git-send-email-maxime.coquelin@redhat.com>
	<20161213212745.1976.91005@loki>
	<20161214084451.2a5236d2.cornelia.huck@de.ibm.com>
	<94a0c474-4998-b03a-9353-d41d0e4e690f@redhat.com>
	<CAJSP0QUHdEYN+gW61eV-REGYRP84SpdOT8R7OPF5jCjUJpaMEQ@mail.gmail.com>
	<20161214095906.45e00d81.cornelia.huck@de.ibm.com>
	<8d1ada4b-2939-5d88-cf8d-b93321f1c81b@redhat.com>
	<20161214095006.GA2522@work-vm>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <e5397f3f-77ce-a14f-42d9-172997906fd4@redhat.com>
Date: Wed, 14 Dec 2016 11:02:31 +0100
MIME-Version: 1.0
In-Reply-To: <20161214095006.GA2522@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v2] virtio-bus: Plug devices
 after features are negotiated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>



On 12/14/2016 10:50 AM, Dr. David Alan Gilbert wrote:
> * Maxime Coquelin (maxime.coquelin@redhat.com) wrote:
>>
>>
>> On 12/14/2016 09:59 AM, Cornelia Huck wrote:
>>> On Wed, 14 Dec 2016 08:41:55 +0000
>>> Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>
>>>> On Wed, Dec 14, 2016 at 8:28 AM, Maxime Coquelin
>>>> <maxime.coquelin@redhat.com> wrote:
>>>>>
>>>>>
>>>>> On 12/14/2016 08:44 AM, Cornelia Huck wrote:
>>>>>>>
>>>>>>>> 14:44 < stefanha> Not sure if anyone can think of a nicer solution.
>>>>>>>> 14:45 < stefanha> But we're going to have to keep lying to the guest if
>>>>>>>> we want to preserve migration compatibility
>>>>>>>> 14:45 < stefanha> The key change in behavior with the patch you
>>>>>>>> identified is:
>>>>>>>> 14:46 < stefanha> if (!virtio_has_feature(vdev->host_features,
>>>>>>>> VIRTIO_F_VERSION_1)) {
>>>>>>>> 14:46 < stefanha> virtio_pci_disable_modern(proxy);
>>>>>>>> 14:46 < stefanha> Previously it didn't care about vdev->host_features.
>>>>>>>> It simply allowed VERSION_1 when proxy's disable_modern boolean was false.
>>>>>>>> 14:47 < mdroth> stefanha: ok, that explains why it seems to work with
>>>>>>>> disable-modern=true
>>>>>>>> 14:48 < stefanha> mdroth: Your Ubuntu kernel old but 14.04 LTS is
>>>>>>>> definitely still around so I don't think we can ship QEMU 2.8 like this.
>>>>>>>> 14:49 < stefanha> mdroth: Let's summarize it on the mailing list and
>>>>>>>> see what Michael Tsirkin and Maxime Coquelin think.
>>>>>>>> 14:49 < mdroth> stefanha: i suppose a potential workaround would be to
>>>>>>>> tell users to set disable-modern= to match their vhost capabilities, but
>>>>>>>> it's hard for them to apply that retroactively if they're looking to migrate
>>>>>>
>>>>>> Another thought: Maybe this bug only surfaced right now because older
>>>>>> qemus defaulted virtio-pci to legacy?
>>>>>>
>>>>>> (I think modern virtio-pci with old vhost resulted in a config that was
>>>>>> rejected at least by Linux guests. Because pci defaulted to legacy, we
>>>>>> only had the post-plugged workaround for ccw before.)
>>>>>
>>>>>
>>>>> Yes, for PCI with old vhost, modern enabled and recent kernel on guest,
>>>>> we get this failure at virtio-pci probe time:
>>>>>
>>>>> virtio_net virtio0: virtio: device uses modern interface but does not have
>>>>> VIRTIO_F_VERSION_1.
>>>>
>>>> Is this error a regression in QEMU 2.8?
>>>
>>> I think it pokes up because modern virtio-pci is now by default on. It
>>> was broken before if the user wanted a modern virtio-pci device
>>> explicitly.
>>>
>>> (ccw defaulted to virtio 1.0 much earlier, so we had the post-plugged
>>> solution that this patch replaced and which is basically the same for
>>> ccw.)
>>>
>>>>
>>>> It's better to ship with an existing issue still open than with a new
>>>> regression.  We must not break existing users' setups.
>>>>
>>>> A solution for the next QEMU version is to use a flag in the machine
>>>> type version telling virtio whether or not allow devices (e.g.
>>>> vhost-net) to influence the host feature bits.  Old machine types will
>>>> say no, new machine types will say yes.
>>>>
>>>> In the meantime I would revert your patch for QEMU 2.8.
>>>>
>>>> Maxime, Cornelia, Michael: Do you agree?
>>>>
>>>> Stefan
>>>
>>> Reverting the patch should be fine for ccw. What about the virtio-pci
>>> with old vhost mess, though? Defaulting to modern would mean that users
>>> get unusable devices in that setup.
>>
>> Just did some tests, and can confirm that reverting the patch would
>> re-introduce initial bug, which is breaking virtio-pci when host does
>> not support VERSION_1.
>
> Can you modify it so it only fixes the problem on new machine types?
> Either that or *fail* if you attempt to bring up a virtio interface
> using version 1 with a kernel that doesn't support it (with a note
> saying that you could use an option to disable it).
Yes, fixing the problem for new machine types only was the workaround
suggested by Stefan.
I think this is a better solution than failing at bring-up the virtio
interface if the kernel doesn't support version 1 and modern is not
disabled.

I start working on the implementation.

Thanks,
Maxime
>
> Dave
>
>> Note that this problem is present in v2.7.0 since:
>>
>> commit 9a4c0e220d8a4f82b5665d0ee95ef94d8e1509d5
>> Author: Marcel Apfelbaum <marcel@redhat.com>
>> Date:   Wed Jul 20 18:28:21 2016 +0300
>>
>>     hw/virtio-pci: fix virtio behaviour
>>
>>     Enable transitional virtio devices by default.
>>     Enable virtio-1.0 for devices plugged into
>>     PCIe ports (Root ports or Downstream ports).
>>
>>     Using the virtio-1 mode will remove the limitation
>>     of the number of devices that can be attached to a machine
>>     by removing the need for the IO BAR.
>>
>>     Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>>     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>     Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>
>>
>> Maybe better to implement the workaround you proposed Stefan?
>>
>> Thanks,
>> Maxime
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

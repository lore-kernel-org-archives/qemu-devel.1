Received: from eggs.gnu.org ([2001:4830:134:3::10]:36460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwu9x-0000Wz-BB
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwu9w-0007XH-9k
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:00:41 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:46109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwu9w-0007X3-2P
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:00:40 -0400
Received: by mail-wm0-x232.google.com with SMTP id m72so10603276wmc.1
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:00:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c5d2998d-64aa-8320-ad73-76cde1176cec@redhat.com>
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
	<20170925135316.74fed6da.cohuck@redhat.com>
	<20170925133153.GZ3030@localhost.localdomain>
	<20170925154647.357047b9@nial.brq.redhat.com>
	<20170925143439.GA3030@localhost.localdomain>
	<f078939d-4ae0-0ae8-4030-3df0ed66299a@redhat.com>
	<CAFEAcA-kmSkjhM0f+Ti7nY1_AuDm1pPcYHNGn50fes20YvOeBg@mail.gmail.com>
	<59e890ab-45e4-fe8a-a8de-3c441de19080@redhat.com>
	<20170925175944.GD3030@localhost.localdomain>
	<c5d2998d-64aa-8320-ad73-76cde1176cec@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2017 19:00:17 +0100
Message-ID: <CAFEAcA8yp4hWWW1Gw8KiCy7SAk1-8FKFAH9vViH93KgbpqbxJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On 26 September 2017 at 18:27, Thomas Huth <thuth@redhat.com> wrote:
> On 25.09.2017 19:59, Eduardo Habkost wrote:
>> On Mon, Sep 25, 2017 at 07:42:13PM +0200, Thomas Huth wrote:
>> "make check" found a few candidates:
>> https://travis-ci.org/ehabkost/qemu/jobs/278743999
>>
>>   Initialization of device dpcd failed: Device 'dpcd' does not support hotplugging
>> [...]
>>   Initialization of device nand failed: Device 'nand' does not support hotplugging
>
> I've now had a look at those, and I now feel like the whole
> "hotpluggable = false by default" idea was either just wrong or there
> are other smart ideas necessary to solve this issue: These devices are
> created during the instance_init() function of another device, e.g.
> "dpcd" is created in the xlnx_dp_init() function, which is the
> instance_init of TYPE_XLNX_DP. Now, instance_init() can be called at any
> time during runtime, even without really adding the device, e.g. for
> parameter introspection (try "device_add xlnx.v-dp,help" at the HMP
> prompt for example).

This is a bit weird though, because it means we have a lot of devices
which are "it's OK to instance_init this but not to actually create
(realize) it". I don't think that that should count as hotpluggable.
(Is it actually useful to be able to call "help" for a device
that it is not possible to create?)

> But just setting "hotpluggable = true" for a device (e.g. "dpcd") which
> could be created during instance_init also does not sound very
> attractive to me... Not sure about any good alternative way to tackle
> this right now, maybe I've eventually got to check user_creatable in
> device_set_realized, too, or move the hotpluggable checks to
> qmp_device_add() instead... I'll think about that for a while...
> suggestions welcome!

I think the general principle of defaulting to "you need to
specifically mark the device if you want it to be permitted to
hotplug it" seems right -- even devices which are created under
the hood by the real hotpluggable device still need to be
written to support it (ie by having a finalize method or
whatever to clean up). So they should probably be marked as
"hotpluggable but not user createable" or similar.

We just need to get the details right.

thanks
-- PMM

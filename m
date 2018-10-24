Received: from eggs.gnu.org ([2001:4830:134:3::10]:50231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gFJ4R-0000xh-Ke
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gFIux-0005LQ-C5
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:09:52 -0400
References: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
	<20181016155600.31de8883@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9d503a8b-5847-a1ae-2d2c-a2d1f0e7ac95@redhat.com>
Date: Wed, 24 Oct 2018 15:09:36 +0200
MIME-Version: 1.0
In-Reply-To: <20181016155600.31de8883@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] call HotplugHandler->plug()
 as the last step in device realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On 16.10.18 15:56, Igor Mammedov wrote:
> On Tue, 16 Oct 2018 15:33:40 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
>> When [2] was fixed it was agreed that adding and calling post_plug()
>> callback after device_reset() was low risk approach to hotfix issue
>> right before release. So it was merged instead of moving already
>> existing plug() callback after device_reset() is called which would
>> be more risky and require all plug() callbacks audit.
>>
>> Looking at the current plug() callbacks, it doesn't seem that moving
>> plug() callback after device_reset() is breaking anything, so here
>> goes agreed upon [3] proper fix which essentially reverts [1][2]
>> and moves plug() callback after device_reset().
>> This way devices always comes to plug() stage, after it's been fully
>> initialized (including being reset), which fixes race condition [2]
>> without need for an extra post_plug() callback.
>>
>>  1. (25e897881 "qdev: add HotplugHandler->post_plug() callback")
>>  2. (8449bcf94 "virtio-scsi: fix hotplug ->reset() vs event race")
>>  3. https://www.mail-archive.com/qemu-devel@nongnu.org/msg549915.html
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> TODO:
>>  remove usage of Error** from plug() callback, we need to factor out
>>  pre_plug part from plug() callbacks, before proceeding with it.
>>  DavidH has recently finished it for pc-dimm/memory_devices, cpus
>>  mostly have pre_plug parts factored out, but there still are parts
>>  that could fail so it needs some more work to eliminate failure point=
s
>>  from plug() callbacks. Meanwhile, I'll plan to treat other misc
>>  handlers (pci[e]/acpi/usb/...) and introduce pre_plug() where
>>  necessary.

Saw this mail just now. I guess we should do more. Especially what seems
to be fragile is errors during unrealize() and unplug().

Errors during unplug() should only ever happen if it was not triggered
via unplug_request(). Otherwise, unplug_request() should check for all
possible errors and unplug() will not result in errors.

Also, errors during unrealize() should definitely be avoided. Or even
forbidden. E.g. looking at hw/core/qdev.c:device_set_realized,

1. failing to unrealize might already have resulted in the unplug
handler getting called.
2. will result in a unparent of the device and therefore removal
3. will have already eventually unrealized child devices or buses.

To summarize, failing in unrealize() is a bad idea and might leave the
rest of the system in a very unpredictable state. Failing in unplug() is
a bad idea unless we don't have a unplug_request().

>=20
> Forgot to CC spapr/s390 folks to give it an extra scrutiny.
>=20


--=20

Thanks,

David / dhildenb

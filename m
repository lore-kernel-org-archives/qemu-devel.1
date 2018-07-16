Received: from eggs.gnu.org ([2001:4830:134:3::10]:46952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fexdM-0002uo-0N
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fexdK-00062p-Nj
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:09:23 -0400
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-4-git-send-email-thuth@redhat.com>
	<20180713212613.GU31657@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4d13b88-e758-2fde-d290-0fdd00b524b2@redhat.com>
Date: Mon, 16 Jul 2018 09:09:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180713212613.GU31657@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/16] hw/arm/bcm2836: Fix crash with
 device_add bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 13.07.2018 23:26, Eduardo Habkost wrote:
> On Fri, Jul 13, 2018 at 10:27:31AM +0200, Thomas Huth wrote:
>> When trying to "device_add bcm2837" on a machine that is not suitable for
>> this device, you can quickly crash QEMU afterwards, e.g. with "info qtree":
>>
>> echo "{'execute':'qmp_capabilities'} {'execute':'device_add', " \
>>  "'arguments':{'driver':'bcm2837'}} {'execute': 'human-monitor-command', " \
>>  "'arguments': {'command-line': 'info qtree'}}" | \
>>  aarch64-softmmu/qemu-system-aarch64 -M integratorcp,accel=qtest -S -qmp stdio
>>
>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
>>  "package": "build-all"}, "capabilities": []}}
>> {"return": {}}
>> {"error": {"class": "GenericError", "desc": "Device 'bcm2837' can not be
>>  hotplugged on this machine"}}
>> Segmentation fault (core dumped)
>>
>> The qdev_set_parent_bus() from instance_init adds a link to the child devices
>> which is not valid anymore after the bcm2837 instance has been destroyed.
>> Unfortunately, the child devices do not get destroyed / unlinked correctly
>> because both object_initialize() and object_property_add_child() increase
>> the reference count of the child objects by one, but only one reference
>> is dropped when the parent gets removed. So let's use the new functions
>> object_initialize_child() and sysbus_init_child_obj() instead to create
>> the objects, which will take care of creating the child objects with the
>> correct reference count of one.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> The usage of &error_abort in code that can be triggered from
> device-list-properties still makes me nervous, but that's a
> separate issue.

I first had similar thoughts, but I think it's a clear coding issue if
the abort triggers here (and not something that the user should normally
be able to trigger somehow), so error_abort should be ok in this case.

 Thomas

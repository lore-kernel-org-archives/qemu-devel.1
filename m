Received: from eggs.gnu.org ([2001:4830:134:3::10]:46224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fceGA-0008Ae-4D
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 18:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fceG9-0000pm-30
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 18:03:54 -0400
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5d0c7195-ffbf-1618-6106-ef6c82df3bd7@redhat.com>
Date: Tue, 10 Jul 2018 00:03:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 09.07.2018 23:42, Peter Maydell wrote:
> On 9 July 2018 at 22:03, Thomas Huth <thuth@redhat.com> wrote:
>> When trying to "device_add bcm2837" on a machine that is not suitable =
for
>> this device, you can quickly crash QEMU afterwards, e.g. with "info qt=
ree":
>>
>> echo "{'execute':'qmp_capabilities'} {'execute':'device_add', " \
>>  "'arguments':{'driver':'bcm2837'}} {'execute': 'human-monitor-command=
', " \
>>  "'arguments': {'command-line': 'info qtree'}}" | \
>>  aarch64-softmmu/qemu-system-aarch64 -M integratorcp,accel=3Dqtest -S =
-qmp stdio
>>
>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
>>  "package": "build-all"}, "capabilities": []}}
>> {"return": {}}
>> {"error": {"class": "GenericError", "desc": "Device 'bcm2837' can not =
be
>>  hotplugged on this machine"}}
>> Segmentation fault (core dumped)
>>
>> The problem is that qdev_set_parent_bus() from instance_init adds a li=
nk
>> to the child devices which is not valid anymore after the device init
>> failed. Thus the qdev_set_parent_bus() must rather be done in the real=
ize
>> function instead.
>=20
> Yuck. The real problem here is that we're still requiring the
> code that creates these QOM devices to manually set the parent
> in the first place. It's not surprising that we don't get it right
> (either parenting in the wrong place or not at all). I'd much
> rather see us fix that properly than keep papering over places
> where we get it wrong.

Sorry, I'm still not an expert in all this QOM stuff yet ... so what do
you exactly recommend to do instead?

> Also, "device_add bcm2837" is just nonsensical: there's no
> way to create an SoC device like this with device_add.
> We should not allow it (for this and all the other
> devices that device_add will never work with)...

I'm fine if we additionally add a user_creatable =3D false here, but the
problem then still persists, e.g. with :

echo "{'execute':'qmp_capabilities'} " \
 "{'execute':'device-list-properties', 'arguments': " \
 "{'typename':'bcm2837'}} {'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}"   | valgrind -q \
  aarch64-softmmu/qemu-system-aarch64 -M integratorcp -S -qmp stdio

The same problem also exists for some other devices which have already
been marked with user_creatable =3D false, e.g.:

echo "{'execute':'qmp_capabilities'} " \
 "{'execute':'device-list-properties', " \
 "'arguments':{'typename':'macio-newworld'}} " \
 "{'execute': 'human-monitor-command', 'arguments': " \
 "{'command-line': 'info qtree'}}" | valgrind -q \
 ppc64-softmmu/qemu-system-ppc64 -M mac99 -S -qmp stdio

Hmm, maybe we need a qtest that first executes "info qtree", then runs
'device-list-properties' for all devices and finally checks "info qtree"
again ... since 'device-list-properties' should not change the qtree,
the output of the "info qtree" should be the same. Currently this is not
the case :-/

 Thomas

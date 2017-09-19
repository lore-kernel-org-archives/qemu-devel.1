Received: from eggs.gnu.org ([2001:4830:134:3::10]:39331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duB2l-0002ff-5Y
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 01:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duB2h-00021o-6q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 01:25:59 -0400
References: <1504605227-5124-1-git-send-email-thuth@redhat.com>
	<871snlwev0.fsf@dusky.pond.sub.org> <20170905164835.GF2112@work-vm>
	<6e03aa82-3663-c251-c8e1-ac2e7eb0e7e7@redhat.com>
	<87mv68e2i3.fsf@dusky.pond.sub.org>
	<20170909204133.GH7570@localhost.localdomain>
	<825b29f3-7857-558e-9092-855c9f75463e@redhat.com>
	<20170912173723.GA7570@localhost.localdomain>
	<808c097f-a422-3aba-2e0d-d8360425f75b@redhat.com>
	<20170915221802.GA10621@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4b277dfb-3eba-c9c1-9028-15ac86a5c0e9@redhat.com>
Date: Tue, 19 Sep 2017 07:25:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170915221802.GA10621@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH] tests: Add a device_add/del
 HMP test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 16.09.2017 00:18, Eduardo Habkost wrote:
> On Wed, Sep 13, 2017 at 07:45:11AM +0200, Thomas Huth wrote:
>> On 12.09.2017 19:37, Eduardo Habkost wrote:
>>> On Mon, Sep 11, 2017 at 08:13:21AM +0200, Thomas Huth wrote:
>>>> On 09.09.2017 22:41, Eduardo Habkost wrote:
>>>>> On Wed, Sep 06, 2017 at 08:59:32AM +0200, Markus Armbruster wrote:
>>>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>>>
>>>>>>> On 05.09.2017 18:48, Dr. David Alan Gilbert wrote:
>>>>>>>> * Markus Armbruster (armbru@redhat.com) wrote:
>>>>>>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>>>>>>
>>>>>>>>>> People tend to forget to mark internal devices with "user_crea=
table =3D false
>>>>>>>>>> or hotpluggable =3D false, and these devices can crash QEMU if=
 added via the
>>>>>>>>>> HMP monitor. So let's add a test to run through all devices an=
d that tries
>>>>>>>>>> to add them blindly (without arguments) to see whether this co=
uld crash the
>>>>>>>>>> QEMU instance.
>>>> [...]
>>>>>>>>> * The device supports only cold plug with -device, not hot plug=
 with
>>>>>>>>>   device_add.
>>>>>>>
>>>>>>> We've got Eduardo's scripts/device-crash-test script for that alr=
eady,
>>>>>>> so no need to cover that here.
>>>>>>
>>>>>> Point taken.  So this test is really about hot plug / unplug.  Sug=
gest
>>>>>> to clarify the commit message: s/add them blindly/hotplug and unpl=
ug
>>>>>> them blindly/.
>>>>>
>>>>> We could extend device-crash-test to test device_add too, as it
>>>>> already has extra code to deal with known crashes and testing
>>>>> multiple machine-types.  Also, any additional code we write to
>>>>> ensure we add mandatory arguments or plug only to valid buses
>>>>> would apply to both -device and device_add.  I also think Python
>>>>> test code is easier to maintain and extend, but that's just my
>>>>> personal preference.
>>>>
>>>> Adding device_add/del support to device-crash-test is certainly an
>>>> option. The problem is that nobody runs it by default, so this won't
>>>> help to avoid that new problems are being committed to the repositor=
y.
>>>>
>>>> I think we really should have a test for "make check", too. So would=
 my
>>>> test be acceptable if I'd rewrite it to use QMP instead (I don't thi=
nk I
>>>> could do the full list that Markus mentioned, but at least a basic t=
est
>>>> via QMP as a start)?
>>>
>>> We can run device-crash-test on "make check", we just need to
>>> choose what's the subset of tests we want to run (because testing
>>> all machine+device+target combinations would take too long).
>>
>> Maybe we should just run it one time for every machine - and try to ad=
d
>> all available devices at once?
>=20
> Yes, it makes sense.  I will keep that in mind when trying to
> implement device_add support on device-crash-test (but if anybody
> wants to volunteer to implement it, be my guest).

Never mind, that was a unrealistic idea, since there are very likely
devices in the list that prevent QEMU from starting if a certain
property is missing... so we likely won't catch any crashes with such a
test (unless we want to pedanticly maintain a blacklist of devices which
can not be used in that test ... you certainly got a very good start for
that in device-crash-test already, but I think the list will rather
explode if we want to get it usable for this idea?)

 Thomas

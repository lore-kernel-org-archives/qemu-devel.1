Received: from eggs.gnu.org ([2001:4830:134:3::10]:35570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpIKK-0008Ia-7R
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpIKE-0001lj-A5
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:11:56 -0400
References: <1504605227-5124-1-git-send-email-thuth@redhat.com>
	<871snlwev0.fsf@dusky.pond.sub.org> <20170905164835.GF2112@work-vm>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6e03aa82-3663-c251-c8e1-ac2e7eb0e7e7@redhat.com>
Date: Tue, 5 Sep 2017 20:11:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170905164835.GF2112@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>

On 05.09.2017 18:48, Dr. David Alan Gilbert wrote:
> * Markus Armbruster (armbru@redhat.com) wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> People tend to forget to mark internal devices with "user_creatable =3D=
 false
>>> or hotpluggable =3D false, and these devices can crash QEMU if added =
via the
>>> HMP monitor. So let's add a test to run through all devices and that =
tries
>>> to add them blindly (without arguments) to see whether this could cra=
sh the
>>> QEMU instance.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  I've marked the patch as RFC since not all of the required device bu=
g
>>>  fixes have been merged yet (so this patch can not be included yet wi=
thout
>>>  breaking "make check"). It's also sad that "macio-oldworld" currentl=
y
>>>  has to be blacklisted - I tried to find a fix for that device,  but =
I was
>>>  not able to spot the exact problem so far. So help for fixing that d=
evice
>>>  is very very welcome! The crash can be reproduced like this:
>>>
>>>  $ qemu-system-ppc64 -nographic -S -monitor stdio -serial none
>>>  QEMU 2.10.50 monitor - type 'help' for more information
>>>  (qemu) device_add macio-oldworld,id=3Dx
>>>  (qemu) device_del x
>>>  (qemu) **
>>>  ERROR:qom/object.c:1611:object_get_canonical_path_component:
>>>   assertion failed: (obj->parent !=3D NULL)
>>>  Aborted (core dumped)
>>>
>>>  tests/test-hmp.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++-
>>>  1 file changed, 59 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
>>> index 7a38cdc..e8a25c4 100644
>>> --- a/tests/test-hmp.c
>>> +++ b/tests/test-hmp.c
>>> @@ -28,7 +28,6 @@ static const char *hmp_cmds[] =3D {
>>>      "commit all",
>>>      "cpu-add 1",
>>>      "cpu 0",
>>> -    "device_add ?",
>>>      "device_add usb-mouse,id=3Dmouse1",
>>>      "mouse_button 7",
>>>      "mouse_move 10 10",
>>> @@ -116,6 +115,64 @@ static void test_info_commands(void)
>>>      g_free(info_buf);
>>>  }
>>> =20
>>> +/*
>>> + * People tend to forget to mark internal devices with "user_creatab=
le =3D false
>>> + * and these devices can crash QEMU if added via the HMP monitor. So=
 let's run
>>> + * through all devices and try to add them blindly (without argument=
s) to see
>>> + * whether this could crash the QEMU instance.
>>> + */
>>> +static void test_device_add_commands(void)
>>> +{
>>> +    char *resp, *devices, *devices_buf, *endp;
>>> +
>>> +    devices =3D devices_buf =3D hmp("device_add help");
>>> +
>>> +    while (*devices) {
>>> +        /* Ignore header lines etc. */
>>> +        if (strncmp(devices, "name \"", 6)) {
>>> +            devices =3D strchr(devices, '\n');
>>> +            if (!devices) {
>>> +                break;
>>> +            }
>>> +            devices +=3D 1;
>>> +            continue;
>>> +        }
>>> +        /* Extract the device name, ignore parameters and descriptio=
n */
>>> +        devices +=3D 6;
>>> +        endp =3D strchr(devices, '"');
>>> +        g_assert(endp !=3D NULL);
>>> +        *endp =3D '\0';
>>> +        /* Check whether it is blacklisted... */
>>> +        if (g_str_equal("macio-oldworld", devices)) {
>>> +            devices =3D strchr(endp + 1, '\n');
>>> +            if (!devices) {
>>> +                break;
>>> +            }
>>> +            devices +=3D 1;
>>> +            continue;
>>> +        }
>>> +        /* Now run the device_add + device_del commands */
>>> +        if (verbose) {
>>> +            fprintf(stderr, "\tdevice_add %s,id=3D%s\n", devices, de=
vices);
>>> +        }
>>> +        resp =3D hmp("device_add %s,id=3D%s", devices, devices);
>>> +        g_free(resp);
>>> +        if (verbose) {
>>> +            fprintf(stderr, "\tdevice_del %s\n", devices);
>>> +        }
>>> +        resp =3D hmp("device_del %s", devices);
>>> +        g_free(resp);
>>> +        /* And move forward to the next line */
>>> +        devices =3D strchr(endp + 1, '\n');
>>> +        if (!devices) {
>>> +            break;
>>> +        }
>>> +        devices +=3D 1;
>>> +    }
>>> +
>>> +    g_free(devices_buf);
>>> +}
>>> +
>>>  static void test_machine(gconstpointer data)
>>>  {
>>>      const char *machine =3D data;
>>> @@ -125,6 +182,7 @@ static void test_machine(gconstpointer data)
>>>      qtest_start(args);
>>> =20
>>>      test_info_commands();
>>> +    test_device_add_commands();
>>>      test_commands();
>>> =20
>>>      qtest_end();
>>
>> This finds devices by parsing output of HMP help.  I think you should
>> use introspection instead, like device-introspect-test does.  You may
>> want to extract common utility code from there.

Well, I wrote a HMP test, to simulate what users can do at the HMP
prompt. But ok, it's likely to crash QEMU also when using the QMP
interface instead ... but then the code should also go into a different
.c file, I think.

>> The actual device_add and device_del also use HMP.  Failures are
>> ignored.  A few device_add failures I'd expect:
>>
>> * There is no suitable bus.
>>
>> * There are suitable buses, but the default one is full.

You can partly work around the above two problems by looping a couple of
times through the "device_add"s first, before doing the "device_del"s.
Then the first iteration adds additional buses which get populated in
the second iteration. I can get additional QEMU crashes if I modify my
test that way... but currently I lack time for debugging all these
crashes, so I don't want to include that in this patch here yet.

>> * Mandatory parameters are missing, such as device backend.

That's quite hard to handle even with QMP, isn't it? How should a
generic test know which parameter have to be populated with which value?

>> * The bus doesn't support hot plug (some other bus might).

That should not be a problem - at least QEMU should not crash in this
situation.

>> * The device supports only cold plug with -device, not hot plug with
>>   device_add.

We've got Eduardo's scripts/device-crash-test script for that already,
so no need to cover that here.

>> I'm afraid the test only tests one of these common failure modes for
>> many devices.
>>
>> device_del failures I'd expect:
>>
>> * The device doesn't exist, because it hasn't completed hot plug, yet.
>>   In some cases such as ACPI PCI hot plug, hot plug may require guest
>>   cooperation, which may take unbounded time.  device_add merely kicks
>>   off the hot plug then.  I can't remember how to poll for completion.
>>   I also can't remember why we don't send a QMP event.
>>
>>   The hot plug usually completes quickly, but it may take its own swee=
t
>>   time, or not complete at all, say because the guest doesn't support
>>   ACPI, or just doesn't feel like plugging right now.
>>
>>   The test needs to set up a guest that cooperates.  I guess that
>>   involves libqos; yet another thing I've forgotten.

That was certainly not my scope when I wrote this test. I just want to
get rid of these devices that can easily crash QEMU if you just try to
add or remove them at the monitor prompt. A more detailed hotplug test
should IMHO be done by the individual device tests instead, like it is
done in many tests/virtio*.c and tests/usb*.c files already.

>> * Same for device_del.  You should wait for the DEVICE_DELETED event
>>   with a suitable timeout.
>=20
> Yes, I think that's an interesting problem - although the test
> might still be worth it just to see how many issues it finds;   I'm
> curious how many devices actually work with no parameters though,
> most seem to fail.

My test already helped to find lots of problems:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Df58f25599b72c7479e6=
a1
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D469f3da42ef4af347fa=
78
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D574ee06de9c4fe63c90=
be
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D84ebd3e8c7d4fe955b3=
59
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D0d4fa4996fc5ee56ea7=
d0
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D1f98e55385d11da1dc0=
de
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D8ccccff9dd7ba24c7a7=
88
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D0479097859372a76084=
3a
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da808c0865b720e22ca2=
92
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04618.html
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04164.html
https://lists.gnu.org/archive/html/qemu-arm/2017-08/msg00306.html
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04622.html
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04635.html
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05390.html

... so does it now sound at least a little bit usable?

> If I'm reading the code right it's creating the device with the same
> name as the device;  I wonder if that always works?

Why not? The id is just an arbitrary string, isn't it?

> But still,  it should mean that if the previous hotplug hasn't really
> happened then you can move onto the next add.
>=20
>> We could improve device_add to cold plug before the machine starts,
>> i.e. between start with -S and the first cont.  We could similarly
>> improve device_del to cold plug.  Together, that would let you sideste=
p
>> the hot plug complications.
>>
>> I guess this test is a case of "if it was easy, we would've done it
>> already"...
>=20
> Still maybe it's worth it as a start.

Agreed that we should finally move to a smarter, QMP-based test. But
until someone wrote that, maybe we could include this as a temporary
guard to avoid that problems like the ones above creep in again?

 Thomas

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpUJI-0003Hz-7z
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpUJF-00055A-35
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:59:40 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1504605227-5124-1-git-send-email-thuth@redhat.com>
	<871snlwev0.fsf@dusky.pond.sub.org> <20170905164835.GF2112@work-vm>
	<6e03aa82-3663-c251-c8e1-ac2e7eb0e7e7@redhat.com>
Date: Wed, 06 Sep 2017 08:59:32 +0200
In-Reply-To: <6e03aa82-3663-c251-c8e1-ac2e7eb0e7e7@redhat.com> (Thomas Huth's
	message of "Tue, 5 Sep 2017 20:11:39 +0200")
Message-ID: <87mv68e2i3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Thomas Huth <thuth@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Thomas Huth <thuth@redhat.com> writes:

> On 05.09.2017 18:48, Dr. David Alan Gilbert wrote:
>> * Markus Armbruster (armbru@redhat.com) wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> People tend to forget to mark internal devices with "user_creatable = false
>>>> or hotpluggable = false, and these devices can crash QEMU if added via the
>>>> HMP monitor. So let's add a test to run through all devices and that tries
>>>> to add them blindly (without arguments) to see whether this could crash the
>>>> QEMU instance.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  I've marked the patch as RFC since not all of the required device bug
>>>>  fixes have been merged yet (so this patch can not be included yet without
>>>>  breaking "make check"). It's also sad that "macio-oldworld" currently
>>>>  has to be blacklisted - I tried to find a fix for that device,  but I was
>>>>  not able to spot the exact problem so far. So help for fixing that device
>>>>  is very very welcome! The crash can be reproduced like this:
>>>>
>>>>  $ qemu-system-ppc64 -nographic -S -monitor stdio -serial none
>>>>  QEMU 2.10.50 monitor - type 'help' for more information
>>>>  (qemu) device_add macio-oldworld,id=x
>>>>  (qemu) device_del x
>>>>  (qemu) **
>>>>  ERROR:qom/object.c:1611:object_get_canonical_path_component:
>>>>   assertion failed: (obj->parent != NULL)
>>>>  Aborted (core dumped)
>>>>
>>>>  tests/test-hmp.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 59 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
>>>> index 7a38cdc..e8a25c4 100644
>>>> --- a/tests/test-hmp.c
>>>> +++ b/tests/test-hmp.c
>>>> @@ -28,7 +28,6 @@ static const char *hmp_cmds[] = {
>>>>      "commit all",
>>>>      "cpu-add 1",
>>>>      "cpu 0",
>>>> -    "device_add ?",
>>>>      "device_add usb-mouse,id=mouse1",
>>>>      "mouse_button 7",
>>>>      "mouse_move 10 10",
>>>> @@ -116,6 +115,64 @@ static void test_info_commands(void)
>>>>      g_free(info_buf);
>>>>  }
>>>>  
>>>> +/*
>>>> + * People tend to forget to mark internal devices with "user_creatable = false
>>>> + * and these devices can crash QEMU if added via the HMP monitor. So let's run
>>>> + * through all devices and try to add them blindly (without arguments) to see
>>>> + * whether this could crash the QEMU instance.
>>>> + */
>>>> +static void test_device_add_commands(void)
>>>> +{
>>>> +    char *resp, *devices, *devices_buf, *endp;
>>>> +
>>>> +    devices = devices_buf = hmp("device_add help");
>>>> +
>>>> +    while (*devices) {
>>>> +        /* Ignore header lines etc. */
>>>> +        if (strncmp(devices, "name \"", 6)) {
>>>> +            devices = strchr(devices, '\n');
>>>> +            if (!devices) {
>>>> +                break;
>>>> +            }
>>>> +            devices += 1;
>>>> +            continue;
>>>> +        }
>>>> +        /* Extract the device name, ignore parameters and description */
>>>> +        devices += 6;
>>>> +        endp = strchr(devices, '"');
>>>> +        g_assert(endp != NULL);
>>>> +        *endp = '\0';
>>>> +        /* Check whether it is blacklisted... */
>>>> +        if (g_str_equal("macio-oldworld", devices)) {
>>>> +            devices = strchr(endp + 1, '\n');
>>>> +            if (!devices) {
>>>> +                break;
>>>> +            }
>>>> +            devices += 1;
>>>> +            continue;
>>>> +        }
>>>> +        /* Now run the device_add + device_del commands */
>>>> +        if (verbose) {
>>>> +            fprintf(stderr, "\tdevice_add %s,id=%s\n", devices, devices);
>>>> +        }
>>>> +        resp = hmp("device_add %s,id=%s", devices, devices);
>>>> +        g_free(resp);
>>>> +        if (verbose) {
>>>> +            fprintf(stderr, "\tdevice_del %s\n", devices);
>>>> +        }
>>>> +        resp = hmp("device_del %s", devices);
>>>> +        g_free(resp);
>>>> +        /* And move forward to the next line */
>>>> +        devices = strchr(endp + 1, '\n');
>>>> +        if (!devices) {
>>>> +            break;
>>>> +        }
>>>> +        devices += 1;
>>>> +    }
>>>> +
>>>> +    g_free(devices_buf);
>>>> +}
>>>> +
>>>>  static void test_machine(gconstpointer data)
>>>>  {
>>>>      const char *machine = data;
>>>> @@ -125,6 +182,7 @@ static void test_machine(gconstpointer data)
>>>>      qtest_start(args);
>>>>  
>>>>      test_info_commands();
>>>> +    test_device_add_commands();
>>>>      test_commands();
>>>>  
>>>>      qtest_end();
>>>
>>> This finds devices by parsing output of HMP help.  I think you should
>>> use introspection instead, like device-introspect-test does.  You may
>>> want to extract common utility code from there.
>
> Well, I wrote a HMP test, to simulate what users can do at the HMP
> prompt. But ok, it's likely to crash QEMU also when using the QMP
> interface instead ... but then the code should also go into a different
> .c file, I think.

HMP device_add is a trivial wrapper around QMP, as is proper:

    void hmp_device_add(Monitor *mon, const QDict *qdict)
    {
        Error *err = NULL;

        qmp_device_add((QDict *)qdict, NULL, &err);
        hmp_handle_error(mon, &err);
    }

If anything ever breaks in this wrapper, it won't be specific to HMP
device_add.

>>> The actual device_add and device_del also use HMP.  Failures are
>>> ignored.  A few device_add failures I'd expect:
>>>
>>> * There is no suitable bus.
>>>
>>> * There are suitable buses, but the default one is full.
>
> You can partly work around the above two problems by looping a couple of
> times through the "device_add"s first, before doing the "device_del"s.
> Then the first iteration adds additional buses which get populated in
> the second iteration. I can get additional QEMU crashes if I modify my
> test that way... but currently I lack time for debugging all these
> crashes, so I don't want to include that in this patch here yet.

Kind of a random walk.

Eduardo has been working on "socket introspection", i.e. means to find
available "sockets" for devices to plug into.  Could be used to for a
more directed walk.  Eduardo, any thoughts?

>>> * Mandatory parameters are missing, such as device backend.
>
> That's quite hard to handle even with QMP, isn't it? How should a
> generic test know which parameter have to be populated with which value?

It could perhaps populate sufficiently generic parameters such as common
backends.

Sadly, device-list-properties is weak, and unless we improve or replace
it, this would involve somewhat ugly hardcoding of descriptions.  For
instance, we'd have to recognize from

    {"name": "netdev", "description": "ID of a netdev to use as a backend", "type": "str"}

that property netdev is a network backend, and very likely mandatory.

>>> * The bus doesn't support hot plug (some other bus might).
>
> That should not be a problem - at least QEMU should not crash in this
> situation.

Yes, and testing that has some value.  It doesn't test the device,
though, only the qdev core.

I don't mean to suggest your test is useless.  I'm merely pointing at
some gaping coverage holes :)

>>> * The device supports only cold plug with -device, not hot plug with
>>>   device_add.
>
> We've got Eduardo's scripts/device-crash-test script for that already,
> so no need to cover that here.

Point taken.  So this test is really about hot plug / unplug.  Suggest
to clarify the commit message: s/add them blindly/hotplug and unplug
them blindly/.

>>> I'm afraid the test only tests one of these common failure modes for
>>> many devices.
>>>
>>> device_del failures I'd expect:
>>>
>>> * The device doesn't exist, because it hasn't completed hot plug, yet.
>>>   In some cases such as ACPI PCI hot plug, hot plug may require guest
>>>   cooperation, which may take unbounded time.  device_add merely kicks
>>>   off the hot plug then.  I can't remember how to poll for completion.
>>>   I also can't remember why we don't send a QMP event.
>>>
>>>   The hot plug usually completes quickly, but it may take its own sweet
>>>   time, or not complete at all, say because the guest doesn't support
>>>   ACPI, or just doesn't feel like plugging right now.
>>>
>>>   The test needs to set up a guest that cooperates.  I guess that
>>>   involves libqos; yet another thing I've forgotten.
>
> That was certainly not my scope when I wrote this test. I just want to
> get rid of these devices that can easily crash QEMU if you just try to
> add or remove them at the monitor prompt. A more detailed hotplug test
> should IMHO be done by the individual device tests instead, like it is
> done in many tests/virtio*.c and tests/usb*.c files already.

I'm not trying to talk you into widening the scope of your test.  I am
pointing out that your testing of unplug is racy, and may therefore miss
failures randomly: if hotplug is slow, device_del won't actually do
anything interesting.

>>> * Same for device_del.  You should wait for the DEVICE_DELETED event
>>>   with a suitable timeout.
>> 
>> Yes, I think that's an interesting problem - although the test
>> might still be worth it just to see how many issues it finds;   I'm
>> curious how many devices actually work with no parameters though,
>> most seem to fail.
>
> My test already helped to find lots of problems:
>
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=f58f25599b72c7479e6a1
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=469f3da42ef4af347fa78
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=574ee06de9c4fe63c90be
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=84ebd3e8c7d4fe955b359
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=0d4fa4996fc5ee56ea7d0
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=1f98e55385d11da1dc0de
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=8ccccff9dd7ba24c7a788
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=0479097859372a760843a
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=a808c0865b720e22ca292
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04618.html
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04164.html
> https://lists.gnu.org/archive/html/qemu-arm/2017-08/msg00306.html
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04622.html
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04635.html
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05390.html
>
> ... so does it now sound at least a little bit usable?

I don't doubt it is, but its limitations need to be understood and
either relaxed or documented.

>> If I'm reading the code right it's creating the device with the same
>> name as the device;  I wonder if that always works?
>
> Why not? The id is just an arbitrary string, isn't it?

Since you're using HMP, you get to quote ',', which occurs in some
device names[*].  Enjoy!  ;-P

Picking IDs that aren't anti-social may be easier.

>> But still,  it should mean that if the previous hotplug hasn't really
>> happened then you can move onto the next add.
>> 
>>> We could improve device_add to cold plug before the machine starts,
>>> i.e. between start with -S and the first cont.  We could similarly
>>> improve device_del to cold plug.  Together, that would let you sidestep
>>> the hot plug complications.
>>>
>>> I guess this test is a case of "if it was easy, we would've done it
>>> already"...
>> 
>> Still maybe it's worth it as a start.
>
> Agreed that we should finally move to a smarter, QMP-based test. But
> until someone wrote that, maybe we could include this as a temporary
> guard to avoid that problems like the ones above creep in again?

I think its limitations need to be understood to a useful degree, and
either relaxed or documented.


[*] Blame IEEE 1275 device trees.

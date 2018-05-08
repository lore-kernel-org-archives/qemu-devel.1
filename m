Received: from eggs.gnu.org ([2001:4830:134:3::10]:42269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFvGK-0007GX-7a
	for qemu-devel@nongnu.org; Tue, 08 May 2018 01:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFvGI-0006pE-Q9
	for qemu-devel@nongnu.org; Tue, 08 May 2018 01:34:08 -0400
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87bme62nu0.fsf@dusky.pond.sub.org>
	<068649bc-1546-6fc5-3e41-63512196cbf8@redhat.com>
	<20180427003215.GU29865@localhost.localdomain>
	<87o9i5uplt.fsf@dusky.pond.sub.org>
	<20180507135330.GS25013@localhost.localdomain>
	<87h8njtnok.fsf@dusky.pond.sub.org>
	<20180507182126.GC25013@localhost.localdomain>
	<4bba0be5-a52c-48ad-3df4-4e9be3624dc0@redhat.com>
	<20180507193220.GF25013@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5837d14a-b562-c382-f95a-32ef12a4e25c@redhat.com>
Date: Tue, 8 May 2018 07:33:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180507193220.GF25013@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Running QEMU without default devices / kernel /
 bios (was: Test devices with all machines, not only with "none")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07.05.2018 21:32, Eduardo Habkost wrote:
> On Mon, May 07, 2018 at 09:13:57PM +0200, Thomas Huth wrote:
>> On 07.05.2018 20:21, Eduardo Habkost wrote:
>>> On Mon, May 07, 2018 at 06:50:35PM +0200, Markus Armbruster wrote:
>>>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>>>
>>>>> On Fri, Apr 27, 2018 at 08:31:58AM +0200, Markus Armbruster wrote:
>>>>>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>>>>>
>>>>>>> On Thu, Apr 26, 2018 at 05:20:25PM +0200, Thomas Huth wrote:
>>>>>>>> On 26.04.2018 13:45, Markus Armbruster wrote:
>>>>>>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>>>>> [...]
>>>>>>>>>> @@ -260,6 +263,26 @@ static void test_abstract_interfaces(void=
)
>>>>>>>>>>      qtest_end();
>>>>>>>>>>  }
>>>>>>>>>> =20
>>>>>>>>>> +static void add_machine_test_case(const char *mname)
>>>>>>>>>> +{
>>>>>>>>>> +    char *path, *args;
>>>>>>>>>> +
>>>>>>>>>> +    /* Ignore blacklisted machines */
>>>>>>>>>> +    if (g_str_equal("xenfv", mname) || g_str_equal("xenpv", m=
name)) {
>>>>>>>>>> +        return;
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>> +    path =3D g_strdup_printf("device/introspect/concrete-defa=
ults-%s", mname);
>>>>>>>>>> +    args =3D g_strdup_printf("-machine %s", mname);
>>>>>>>>>> +    qtest_add_data_func(path, args, test_device_intro_concret=
e);
>>>>>>>>>
>>>>>>>>> This runs test_device_intro_concrete() with "-machine M" for al=
l machine
>>>>>>>>> types M, in SPEED=3Dslow mode.
>>>>>>>>>
>>>>>>>>>> +    g_free(path);
>>>>>>>>>> +
>>>>>>>>>> +    path =3D g_strdup_printf("device/introspect/concrete-node=
faults-%s", mname);
>>>>>>>>>> +    args =3D g_strdup_printf("-nodefaults -machine %s", mname=
);
>>>>>>>>>> +    qtest_add_data_func(path, args, test_device_intro_concret=
e);
>>>>>>>>>
>>>>>>>>> This runs test_device_intro_concrete() with "-nodefaults -machi=
ne M" for
>>>>>>>>> all machine types M, in SPEED=3Dslow mode.
>>>>>>>>>
>>>>>>>>> Has "without -nodefaults" exposed additional bugs?
>>>>>>>>
>>>>>>>> After testing this with all machines, I had to discover that
>>>>>>>> "-nodefaults" does not work so easily: A lot of the embedded mac=
hines
>>>>>>>> (especially the ARM machines) simply refuse to work with "-nodef=
aults"
>>>>>>>> and exit immediately instead. E.g.:
>>>>>>>>
>>>>>>>> $ arm-softmmu/qemu-system-arm -nodefaults -nographic -M n810,acc=
el=3Dqtest
>>>>>>>> qemu-system-arm: missing SecureDigital device
>>>>>>
>>>>>> These are all bugs.  --nodefaults is supposed to suppress *optiona=
l*
>>>>>> devices, not mandatory ones.
>>>>>
>>>>> I'm not sure I understand the requirements.  What exactly is the
>>>>> definition of "mandatory"?
>>>>>
>>>>> A machine created by "qemu-system-x86_64 -machine pc -nodefaults"
>>>>> is useless because it has no any device to boot from.  How is
>>>>> that different from a n810 machine not booting because there's no
>>>>> SD device?
>>>>
>>>> I propose:
>>>>
>>>> * Stuff that's required for QEMU to run is not suppressed by -nodefa=
ults
>>>>
>>>> * Stuff that a real machine has soldered on is also not suppressed
>>>>
>>>> * Stuff that can be pulled out of a real machine may be suppressed, =
even
>>>>   when that means the guest won't run
>>>
>>> Makes sense to me.  It looks like the only obstacle for
>>> tests/device-introspect and device-crash-test is the first rule.
>>> "Guest won't boot" isn't a problem, but "QEMU won't run" is.
>>>
>>> The first rule is easily testable, too: running
>>> "$QEMU -machine $MACHINE -nodefaults" and not having a working
>>> QMP monitor should be reported as a bug by automated tests.
>>
>> You mean with "-accel qtest" or without? With "-accel qtest" we should
>> pretty soon be fine, after Peter's current PULL request has been merge=
d
>> (which contains a patch from me for fixing these SD card problems with
>> ARM machines).
>> Without "-accel qtest", things are not that easy, unfortunately. Lots =
of
>> boards require "-kernel" or "-bios" and refuse to work without. So you
>> can hardly test "-nodefaults" automatically in the normal tcg mode. (B=
ut
>> maybe all boards should allow to start QEMU in case you've at least al=
so
>> specified "-S" ? ... in that case we've got plenty of work for
>> BiteSizeTasks ;-) )
>=20
> Hmm, maybe it's not a bite-sized task after all.  :)
>=20
> Should we do this gradually?
>=20
> * Working with -accel qtest is useful, and sounds like an easier goal;

We're pretty much there already. Apart from the SD card problem (and the
xen boards), all machines should work with -nodefaults in qtest mode now.

> * working with -S seems desirable too;

Yes, it could be interesting to load the firmware / OS via HMP or GDB
after QEMU has been started.

Maybe we'd simply need a new function a la:

bool cpu_starts_automatically()
{
    return autostart && !qtest_enabled();
}

And then replace all spots where we exit due to missing -kernel or -bios
parameters, e.g.:

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -286,7 +286,7 @@ static void mcf5208evb_init(MachineState *machine)

     /* Load kernel.  */
     if (!kernel_filename) {
-        if (qtest_enabled()) {
+        if (!cpu_starts_automatically()) {
             return;
         }
         error_report("Kernel image must be specified");

Does that sound like a plan?

> * working without -S (even if the emulated CPU crashes and burns)
>   would be interesting.

Not sure whether we really need this. It's likely better to give the
user a proper error message to use "-kernel" instead of just showing a
crash.

> Related question: what are the use cases where we require
> "-accel qtest" and "-S" wouldn't work?

Maybe there are some boards where you can not load code via HMP or GDB
once you've started QEMU with "-S"? You'd end up with a mostly useless
HMP prompt in that case, which is a little bit ugly, but not fatal.
Apart from that ... I can't think of a case where "-S" would not work at
all once we've introduce something like cpu_starts_automatically().

> Are the requirements and goals of "-accel qtest" documented
> somewhere?  Without documentation, it's hard to say when a given
> qtest_enabled() call in the code is reasonable, or a hack we want
> to get rid of.

There's some few documentation in docs/devel/testing.rst and
https://wiki.qemu.org/Features/QTest - but the quintessence is that
qtest basically rips out the CPU of the emulated machine and replaces it
with the qtest stub. So in this case there is no CPU that can run code
automatically. Thus I think if we abstract this with a function a la
cpu_starts_automatically(), we should be fine.

 Thomas

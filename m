Received: from eggs.gnu.org ([2001:4830:134:3::10]:37933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFjWp-0005cw-QH
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFjWo-0006Ow-Oz
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:02:23 -0400
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87bme62nu0.fsf@dusky.pond.sub.org>
	<068649bc-1546-6fc5-3e41-63512196cbf8@redhat.com>
	<20180427003215.GU29865@localhost.localdomain>
	<87o9i5uplt.fsf@dusky.pond.sub.org>
	<20180507135330.GS25013@localhost.localdomain>
	<87h8njtnok.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4d960efd-e31b-efdd-35d8-ec9e27cb3f9e@redhat.com>
Date: Mon, 7 May 2018 19:02:14 +0200
MIME-Version: 1.0
In-Reply-To: <87h8njtnok.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test devices
 with all machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 07.05.2018 18:50, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
>> On Fri, Apr 27, 2018 at 08:31:58AM +0200, Markus Armbruster wrote:
>>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>>
>>>> On Thu, Apr 26, 2018 at 05:20:25PM +0200, Thomas Huth wrote:
>>>>> On 26.04.2018 13:45, Markus Armbruster wrote:
>>>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>> [...]
>>>>>>> @@ -260,6 +263,26 @@ static void test_abstract_interfaces(void)
>>>>>>>      qtest_end();
>>>>>>>  }
>>>>>>> =20
>>>>>>> +static void add_machine_test_case(const char *mname)
>>>>>>> +{
>>>>>>> +    char *path, *args;
>>>>>>> +
>>>>>>> +    /* Ignore blacklisted machines */
>>>>>>> +    if (g_str_equal("xenfv", mname) || g_str_equal("xenpv", mnam=
e)) {
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    path =3D g_strdup_printf("device/introspect/concrete-default=
s-%s", mname);
>>>>>>> +    args =3D g_strdup_printf("-machine %s", mname);
>>>>>>> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>>>>>>
>>>>>> This runs test_device_intro_concrete() with "-machine M" for all m=
achine
>>>>>> types M, in SPEED=3Dslow mode.
>>>>>>
>>>>>>> +    g_free(path);
>>>>>>> +
>>>>>>> +    path =3D g_strdup_printf("device/introspect/concrete-nodefau=
lts-%s", mname);
>>>>>>> +    args =3D g_strdup_printf("-nodefaults -machine %s", mname);
>>>>>>> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>>>>>>
>>>>>> This runs test_device_intro_concrete() with "-nodefaults -machine =
M" for
>>>>>> all machine types M, in SPEED=3Dslow mode.
>>>>>>
>>>>>> Has "without -nodefaults" exposed additional bugs?
>>>>>
>>>>> After testing this with all machines, I had to discover that
>>>>> "-nodefaults" does not work so easily: A lot of the embedded machin=
es
>>>>> (especially the ARM machines) simply refuse to work with "-nodefaul=
ts"
>>>>> and exit immediately instead. E.g.:
>>>>>
>>>>> $ arm-softmmu/qemu-system-arm -nodefaults -nographic -M n810,accel=3D=
qtest
>>>>> qemu-system-arm: missing SecureDigital device
>>>
>>> These are all bugs.  --nodefaults is supposed to suppress *optional*
>>> devices, not mandatory ones.
>>
>> I'm not sure I understand the requirements.  What exactly is the
>> definition of "mandatory"?
>>
>> A machine created by "qemu-system-x86_64 -machine pc -nodefaults"
>> is useless because it has no any device to boot from.  How is
>> that different from a n810 machine not booting because there's no
>> SD device?
>=20
> I propose:
>=20
> * Stuff that's required for QEMU to run is not suppressed by -nodefault=
s
>=20
> * Stuff that a real machine has soldered on is also not suppressed
>=20
> * Stuff that can be pulled out of a real machine may be suppressed, eve=
n
>   when that means the guest won't run
>=20
> Does that make some sense?

Makes sense. On a real machine, you could likely also remove the SD card
and load a kernel by other means, e.g. with a JTAG debug connector. So
it makes sense that you could also start the machine in QEMU without SD
card and load a kernel e.g. with the gdb stub instead.

 Thomas

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBuRe-0007MB-V3
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBuRd-0003Ws-Tt
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:53:15 -0400
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87bme62nu0.fsf@dusky.pond.sub.org>
	<068649bc-1546-6fc5-3e41-63512196cbf8@redhat.com>
	<20180427003215.GU29865@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0f69501c-f7cb-864a-3aa5-710fbe769f82@redhat.com>
Date: Fri, 27 Apr 2018 05:52:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180427003215.GU29865@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 27.04.2018 02:32, Eduardo Habkost wrote:
> On Thu, Apr 26, 2018 at 05:20:25PM +0200, Thomas Huth wrote:
>> On 26.04.2018 13:45, Markus Armbruster wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>> [...]
>>>> @@ -260,6 +263,26 @@ static void test_abstract_interfaces(void)
>>>>      qtest_end();
>>>>  }
>>>> =20
>>>> +static void add_machine_test_case(const char *mname)
>>>> +{
>>>> +    char *path, *args;
>>>> +
>>>> +    /* Ignore blacklisted machines */
>>>> +    if (g_str_equal("xenfv", mname) || g_str_equal("xenpv", mname))=
 {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    path =3D g_strdup_printf("device/introspect/concrete-defaults-%=
s", mname);
>>>> +    args =3D g_strdup_printf("-machine %s", mname);
>>>> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>>>
>>> This runs test_device_intro_concrete() with "-machine M" for all mach=
ine
>>> types M, in SPEED=3Dslow mode.
>>>
>>>> +    g_free(path);
>>>> +
>>>> +    path =3D g_strdup_printf("device/introspect/concrete-nodefaults=
-%s", mname);
>>>> +    args =3D g_strdup_printf("-nodefaults -machine %s", mname);
>>>> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>>>
>>> This runs test_device_intro_concrete() with "-nodefaults -machine M" =
for
>>> all machine types M, in SPEED=3Dslow mode.
>>>
>>> Has "without -nodefaults" exposed additional bugs?
>>
>> After testing this with all machines, I had to discover that
>> "-nodefaults" does not work so easily: A lot of the embedded machines
>> (especially the ARM machines) simply refuse to work with "-nodefaults"
>> and exit immediately instead. E.g.:
>>
>> $ arm-softmmu/qemu-system-arm -nodefaults -nographic -M n810,accel=3Dq=
test
>> qemu-system-arm: missing SecureDigital device
>>
>> So we'd either need a rather big black list for the machines that do n=
ot
>> work, or simply drop the "-nodefaults" tests from this patch.
>=20
> Or we could try to test all machines anyway, but not consider it
> an error if QEMU just does exit(1).  Can the qtest C API give us
> that information?

At a first glance, I haven't seen an easy way to do this. I guess we
could do some polling with waitid() or do something with SIGCHLD, but...

> (Or we could simply let -nodefaults aside by now, and do this
> after we implement this test case in Python.)

... I'd rather prefer that for now, assuming that the test will later
get replaced by the python test anyway.

 Thomas

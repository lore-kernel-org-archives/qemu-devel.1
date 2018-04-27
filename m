Received: from eggs.gnu.org ([2001:4830:134:3::10]:59181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBxqx-0007YM-Ly
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBxqw-0003LZ-Lz
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:31:35 -0400
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87bme62nu0.fsf@dusky.pond.sub.org>
	<068649bc-1546-6fc5-3e41-63512196cbf8@redhat.com>
	<20180427003215.GU29865@localhost.localdomain>
	<87o9i5uplt.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9ffb47aa-1fe9-0e0a-3013-bf48ff71d695@redhat.com>
Date: Fri, 27 Apr 2018 09:31:25 +0200
MIME-Version: 1.0
In-Reply-To: <87o9i5uplt.fsf@dusky.pond.sub.org>
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 27.04.2018 08:31, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
>> On Thu, Apr 26, 2018 at 05:20:25PM +0200, Thomas Huth wrote:
>>> On 26.04.2018 13:45, Markus Armbruster wrote:
>>>> Thomas Huth <thuth@redhat.com> writes:
>>> [...]
>>>>> @@ -260,6 +263,26 @@ static void test_abstract_interfaces(void)
>>>>>      qtest_end();
>>>>>  }
>>>>> =20
>>>>> +static void add_machine_test_case(const char *mname)
>>>>> +{
>>>>> +    char *path, *args;
>>>>> +
>>>>> +    /* Ignore blacklisted machines */
>>>>> +    if (g_str_equal("xenfv", mname) || g_str_equal("xenpv", mname)=
) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    path =3D g_strdup_printf("device/introspect/concrete-defaults-=
%s", mname);
>>>>> +    args =3D g_strdup_printf("-machine %s", mname);
>>>>> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>>>>
>>>> This runs test_device_intro_concrete() with "-machine M" for all mac=
hine
>>>> types M, in SPEED=3Dslow mode.
>>>>
>>>>> +    g_free(path);
>>>>> +
>>>>> +    path =3D g_strdup_printf("device/introspect/concrete-nodefault=
s-%s", mname);
>>>>> +    args =3D g_strdup_printf("-nodefaults -machine %s", mname);
>>>>> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>>>>
>>>> This runs test_device_intro_concrete() with "-nodefaults -machine M"=
 for
>>>> all machine types M, in SPEED=3Dslow mode.
>>>>
>>>> Has "without -nodefaults" exposed additional bugs?
>>>
>>> After testing this with all machines, I had to discover that
>>> "-nodefaults" does not work so easily: A lot of the embedded machines
>>> (especially the ARM machines) simply refuse to work with "-nodefaults=
"
>>> and exit immediately instead. E.g.:
>>>
>>> $ arm-softmmu/qemu-system-arm -nodefaults -nographic -M n810,accel=3D=
qtest
>>> qemu-system-arm: missing SecureDigital device
>=20
> These are all bugs.  --nodefaults is supposed to suppress *optional*
> devices, not mandatory ones.

Even if we fix all the issues, there is still another cosmetic problem:
Since there are no entries in nd_table[], all the boards with embedded
NICs start to spill out "warning: nic XYZ has no peer". Should we simply
suppress that warning in qtest mode?

 Thomas

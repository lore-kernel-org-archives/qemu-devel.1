Received: from eggs.gnu.org ([2001:4830:134:3::10]:52699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBihS-000815-G5
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBihR-000573-EX
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:20:46 -0400
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87bme62nu0.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <068649bc-1546-6fc5-3e41-63512196cbf8@redhat.com>
Date: Thu, 26 Apr 2018 17:20:25 +0200
MIME-Version: 1.0
In-Reply-To: <87bme62nu0.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>

On 26.04.2018 13:45, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
[...]
>> @@ -260,6 +263,26 @@ static void test_abstract_interfaces(void)
>>      qtest_end();
>>  }
>> =20
>> +static void add_machine_test_case(const char *mname)
>> +{
>> +    char *path, *args;
>> +
>> +    /* Ignore blacklisted machines */
>> +    if (g_str_equal("xenfv", mname) || g_str_equal("xenpv", mname)) {
>> +        return;
>> +    }
>> +
>> +    path =3D g_strdup_printf("device/introspect/concrete-defaults-%s"=
, mname);
>> +    args =3D g_strdup_printf("-machine %s", mname);
>> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>=20
> This runs test_device_intro_concrete() with "-machine M" for all machin=
e
> types M, in SPEED=3Dslow mode.
>=20
>> +    g_free(path);
>> +
>> +    path =3D g_strdup_printf("device/introspect/concrete-nodefaults-%=
s", mname);
>> +    args =3D g_strdup_printf("-nodefaults -machine %s", mname);
>> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>=20
> This runs test_device_intro_concrete() with "-nodefaults -machine M" fo=
r
> all machine types M, in SPEED=3Dslow mode.
>=20
> Has "without -nodefaults" exposed additional bugs?

After testing this with all machines, I had to discover that
"-nodefaults" does not work so easily: A lot of the embedded machines
(especially the ARM machines) simply refuse to work with "-nodefaults"
and exit immediately instead. E.g.:

$ arm-softmmu/qemu-system-arm -nodefaults -nographic -M n810,accel=3Dqtes=
t
qemu-system-arm: missing SecureDigital device

So we'd either need a rather big black list for the machines that do not
work, or simply drop the "-nodefaults" tests from this patch.

> Please mention "with and without -nodefaults" in the commit message.
>=20
> I'd try "with -nodefaults" before "without", because "with" is the
> simpler test case.

For most boards, it seems rather to be the more "difficult" setting
since most boards are only tested without "-nodefaults" obviously.

>> +    g_free(path);
>> +}
>> +
>>  int main(int argc, char **argv)
>>  {
>>      g_test_init(&argc, &argv, NULL);
>> @@ -268,8 +291,12 @@ int main(int argc, char **argv)
>>      qtest_add_func("device/introspect/list-fields", test_qom_list_fie=
lds);
>>      qtest_add_func("device/introspect/none", test_device_intro_none);
>>      qtest_add_func("device/introspect/abstract", test_device_intro_ab=
stract);
>> -    qtest_add_func("device/introspect/concrete", test_device_intro_co=
ncrete);
>>      qtest_add_func("device/introspect/abstract-interfaces", test_abst=
ract_interfaces);
>> +    qtest_add_data_func("device/introspect/concrete", g_strdup(common=
_args),
>> +                        test_device_intro_concrete);
>=20
> This runs test_device_intro_concrete() with "-nodefaults -machine
> none".  Duplicate in SPEED=3Dslow mode?

Yes, it's a duplicate, we should skip that in SPEED=3Dslow mode.

 Thomas

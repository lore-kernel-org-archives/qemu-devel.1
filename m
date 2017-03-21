Received: from eggs.gnu.org ([2001:4830:134:3::10]:53932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqKNu-0004vw-OH
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqKNk-00071q-JQ
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:03:38 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cqKNk-000710-5G
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:03:28 -0400
Received: by mail-wm0-f45.google.com with SMTP id t189so13229766wmt.1
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 07:03:28 -0700 (PDT)
From: Vinzenz Feenstra <vfeenstr@redhat.com>
Message-Id: <0342808A-63C6-40BE-91AB-B6088AD62CD2@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Tue, 21 Mar 2017 15:03:25 +0100
In-Reply-To: <1a5dab83-40ce-e747-6399-ca693ccf278e@redhat.com>
References: <20170316102351.25056-1-vfeenstr@redhat.com>
	<1a5dab83-40ce-e747-6399-ca693ccf278e@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: add guest-get-osinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com


> On Mar 21, 2017, at 2:39 PM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 03/16/2017 05:23 AM, Vinzenz 'evilissimo' Feenstra wrote:
>> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>>=20
>> Add a new 'guest-get-osinfo' command for reporting basic information =
of
>> the guest operating system (hereafter just 'OS'). This information
>> includes the type of the OS, the version, and the architecture.
>> Additionally reported would be a name, distribution type and kernel
>> version where applicable.
>>=20
>> Here an example for a Fedora 25 VM:
>>=20
>> $ virsh -c qemu:////system qemu-agent-command F25 \
>>    '{ "execute": "guest-get-osinfo" }'
>>  {"return":{"arch":"x86_64","codename":"Server =
Edition","version":"25",
>>   =
"kernel":"4.8.6-300.fc25.x86_64","type":"linux","distribution":"Fedora"}}
>>=20
>> And an example for a Windows 2012 R2 VM:
>>=20
>> $ virsh -c qemu:////system qemu-agent-command Win2k12R2 \
>>    '{ "execute": "guest-get-osinfo" }'
>>  {"return":{"arch":"x86_64","codename":"Win 2012 R2",
>>   "version":"6.3","kernel":"","type":"windows","distribution":""}}
>>=20
>> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
>> ---
>=20
>=20
>> +static void ga_get_linux_distribution_info(GuestOSInfo *info)
>> +{
>> +    FILE *fp =3D NULL;
>> +    fp =3D fopen("/etc/os-release", "r");
>=20
> Rather than read random files, I'm thinking that the uname() syscall =
is
> a better approach.  It is portable to more guests (since uname is a
> POSIX interface), even if it is somewhat more limited on the =
information
> it provides.

How about using it as a fallback option only but still use the =
information available
on the other places. I think it=E2=80=99s useful information what can be =
found there.

>=20
>> +++ b/qga/commands-win32.c
>> @@ -1536,3 +1536,108 @@ void ga_command_state_init(GAState *s, =
GACommandState *cs)
>>         ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
>>     }
>> }
>=20
>> +static char *ga_get_win_ver(void)
>> +{
>> +    OSVERSIONINFOEXW os_version;
>> +    ga_get_version(&os_version);
>> +    char buf[64] =3D {};
>> +    int major =3D (int)os_version.dwMajorVersion;
>> +    int minor =3D (int)os_version.dwMinorVersion;
>> +    sprintf(buf, "%d.%d", major, minor);
>> +    return strdup(buf);
>=20
> Instead of using strdup() (which uses malloc()), you should be using
> g_strdup_printf() (which uses g_malloc().  In general, we prefer
> g_malloc/g_free over raw malloc.  And once you use g_strdup_printf, =
you
> no longer have to worry about whether buf is allocated large enough to
> avoid overflow with sprintf.
Will do with the next version. Thanks for that hint with sprintf I =
didn=E2=80=99t know about that.

>=20
>=20
>> +++ b/qga/qapi-schema.json
>> @@ -1042,3 +1042,43 @@
>>   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>>                '*input-data': 'str', '*capture-output': 'bool' },
>>   'returns': 'GuestExec' }
>> +
>> +##
>> +# @GuestOSType:
>> +#
>> +# @linux:    Indicator for linux distributions
>> +# @windows:  Indicator for windows versions
>> +# @other:    Indicator for any other operating system that is not =
yet
>> +#            explicitly supported
>> +#
>> +# Since: 2.8
>=20
> You've missed 2.8 by a long shot. In fact, you've missed hard freeze =
for
> 2.9, so this needs to be 2.10.

I don=E2=80=99t even know where I was looking for finding that number.

>=20
>> +##
>> +{ 'enum': 'GuestOSType', 'data': ['linux', 'windows', 'other'] }
>> +
>> +##
>> +# @GuestOSInfo:
>> +#
>> +# @version:      OS version, e.g. 25 for FC25 etc.
>> +# @distribution: Fedora, Ubuntu, Debian, CentOS...
>> +# @codename:     Code name of the OS. e.g. Ubuntu has Xenial Xerus =
etc.
>> +# @arch:         Architecture of the OS e.g. x86, x86_64, ppc64, =
aarch64...
>> +# @type:         Specifies the type of the OS.
>> +# @kernel:       Linux kernel version (Might be used by other OS =
types too).
>> +#                May be empty.
>=20
> Rather than printing an empty string, would it be better to make the
> fields optional, and omit them when there is nothing useful to supply?

I tried to keep it as stable as possible, but optional would work for me =
too, if it is preferred.

>=20
> --=20
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org =
<http://libvirt.org/>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1csjSg-0002bV-So
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1csjSd-0001wS-KN
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:14:30 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1csjSd-0001vc-4a
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:14:27 -0400
Received: by mail-wr0-f177.google.com with SMTP id u1so86087039wra.2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 22:14:27 -0700 (PDT)
From: Vinzenz Feenstra <vfeenstr@redhat.com>
Message-Id: <4EA4009B-C060-4700-BB32-60F9A5254C0F@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Tue, 28 Mar 2017 07:14:25 +0200
In-Reply-To: <2267A6B3-1C16-406A-B83A-34F17E8D3F98@redhat.com>
References: <0342808A-63C6-40BE-91AB-B6088AD62CD2@redhat.com>
	<20170316145045.10840-1-vfeenstr@redhat.com>
	<20170316145045.10840-2-vfeenstr@redhat.com>
	<05ad6588-58c5-796c-48b5-05bb6c2dc612@redhat.com>
	<2267A6B3-1C16-406A-B83A-34F17E8D3F98@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-ga: add guest-get-osinfo command
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


> On Mar 24, 2017, at 10:48 AM, Vinzenz Feenstra <vfeenstr@redhat.com> =
wrote:
>=20
>>=20
>> On Mar 23, 2017, at 3:58 PM, Eric Blake <eblake@redhat.com =
<mailto:eblake@redhat.com>> wrote:
>>=20
>> On 03/16/2017 09:50 AM, Vinzenz 'evilissimo' Feenstra wrote:
>>> From: Vinzenz Feenstra <vfeenstr@redhat.com =
<mailto:vfeenstr@redhat.com>>
>>>=20
>>> Add a new 'guest-get-osinfo' command for reporting basic information =
of
>>> the guest operating system (hereafter just 'OS'). This information
>>> includes the type of the OS, the version, and the architecture.
>>> Additionally reported would be a name, distribution type and kernel
>>> version where applicable.
>>>=20
>>> Here an example for a Fedora 25 VM:
>>>=20
>>> $ virsh -c qemu:////system <qemu:////system> qemu-agent-command F25 =
\
>>>    '{ "execute": "guest-get-osinfo" }'
>>>  {"return":{"arch":"x86_64","codename":"Server =
Edition","version":"25",
>>>   =
"kernel":"4.8.6-300.fc25.x86_64","type":"linux","distribution":"Fedora"}}
>>>=20
>>> And an example for a Windows 2012 R2 VM:
>>>=20
>>> $ virsh -c qemu:////system <qemu:////system> qemu-agent-command =
Win2k12R2 \
>>>    '{ "execute": "guest-get-osinfo" }'
>>>  {"return":{"arch":"x86_64","codename":"Win 2012 R2",
>>>   "version":"6.3","kernel":"","type":"windows","distribution":""}}
>>>=20
>>> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com =
<mailto:vfeenstr@redhat.com>>
>>> ---
>>=20
>> Let's make sure we get the interface right, before I even bother =
looking
>> at the code.
>=20
> Sure
>=20
>>=20
>>> +++ b/qga/qapi-schema.json
>>> @@ -1042,3 +1042,43 @@
>>>   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>>>                '*input-data': 'str', '*capture-output': 'bool' },
>>>   'returns': 'GuestExec' }
>>> +
>>> +##
>>> +# @GuestOSType:
>>> +#
>>> +# @linux:    Indicator for linux distributions
>>> +# @windows:  Indicator for windows versions
>>> +# @other:    Indicator for any other operating system that is not =
yet
>>> +#            explicitly supported
>>> +#
>>> +# Since: 2.10
>>> +##
>>> +{ 'enum': 'GuestOSType', 'data': ['linux', 'windows', 'other'] }
>>> +
>>> +##
>>> +# @GuestOSInfo:
>>> +#
>>> +# @version:      OS version, e.g. 25 for FC25 etc.
>>> +# @distribution: Fedora, Ubuntu, Debian, CentOS...
>>> +# @codename:     Code name of the OS. e.g. Ubuntu has Xenial Xerus =
etc.
>>> +# @arch:         Architecture of the OS e.g. x86, x86_64, ppc64, =
aarch64...
>>> +# @type:         Specifies the type of the OS.
>>> +# @kernel:       Linux kernel version (Might be used by other OS =
types too).
>>> +#                May be empty.
>>=20
>> Why would it be empty, instead of just omitted?
> That=E2=80=99s a relict of v1 where this was still the case and all =
fields were supposed to be there all the time.
>>=20
>>> +# Since: 2.10
>>> +##
>>> +{ 'struct': 'GuestOSInfo',
>>> +  'data': { '*version': 'str', '*distribution': 'str', '*codename': =
'str',
>>> +            '*arch': 'str', 'type': 'GuestOSType', '*kernel': =
'str'} }
>>=20
>> So everything except 'type' is optional?  Is there anything a client =
can
>> actually rely on being always present?
>>=20
>> uname() is probably the lowest-common-denominator interface for
>> describing a system (in that it is implemented on more OSs than =
anything
>> else, and Windows information can be mapped to uname concepts).  =
Let's
>> compare:
>>=20
>> POSIX says:
>> =
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_utsname.h.htm=
l#tag_13_70 =
<http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_utsname.h.ht=
ml#tag_13_70>
>>=20
>>    The <sys/utsname.h> header shall define the structure utsname =
which
>> shall include at least the following members:
>>=20
>>    char  sysname[]  Name of this implementation of the operating =
system.
>>    char  nodename[] Name of this node within the communications
>>                     network to which this node is attached, if any.
>>    char  release[]  Current release level of this implementation.
>>    char  version[]  Current version level of this release.
>>    char  machine[]  Name of the hardware type on which the system is
>> running.
>>=20
>> So you both have version; your 'arch' maps somewhat to machine, your
>> 'type' maps somewhat to sysname, your 'kernel' probably matches =
release,
>> and then you are adding 'distribution' and 'codename' which don't =
appear
>> in uname output.  Is it worth naming your members after the uname()
>> names, for less confusion?

Eric, what you think of this below way, instead?

>=20
> OK So how about something like this:
>=20
> {=E2=80=98struct=E2=80=99: =E2=80=98GuestWindowsVersionInfo=E2=80=99,
>  =E2=80=98data=E2=80=99: {
> 	=E2=80=98version=E2=80=99: =E2=80=98str=E2=80=99,
>         =E2=80=98name=E2=80=99: =E2=80=98str=E2=80=99,
> } }
>=20
> {=E2=80=98struct=E2=80=99: =E2=80=98GuestLinuxOSRelease=E2=80=99,
>  =E2=80=98data=E2=80=99: {
>         =E2=80=98id=E2=80=99: =E2=80=98str=E2=80=99,
>         =E2=80=98name=E2=80=99: =E2=80=98str'
> 	=E2=80=98*version=E2=80=99: =E2=80=98str=E2=80=99,
>         =E2=80=98*variant=E2=80=99: =E2=80=98str=E2=80=99
>         =E2=80=98*codename=E2=80=99: =E2=80=98str=E2=80=99
> } }
>=20
> {=E2=80=98enum=E2=80=99: =E2=80=98GuestOSVersionInfo=E2=80=99,
>  =E2=80=98data=E2=80=99: {=E2=80=98linux=E2=80=99: =E2=80=98 =
GuestLinuxOSRelease=E2=80=99,
>              =E2=80=98win=E2=80=99: =E2=80=98 =
GuestWindowsVersionInfo=E2=80=99
> }}
>=20
> { 'struct': 'GuestOSInfo=E2=80=99,
>     'data': {=20
> 	=E2=80=98machine': 'str=E2=80=99,
> 	=E2=80=99sysname': 'GuestOSType=E2=80=99,=20
> 	=E2=80=98release': =E2=80=98str=E2=80=99,
> 	=E2=80=98*version_info=E2=80=99: =E2=80=98GuestOSVersionInfo=E2=80=
=99,
> } }
>=20
>>=20
>>> +
>>> +##
>>> +# @guest-get-osinfo:
>>> +#
>>> +# Retrieve guest operating system information
>>> +#
>>> +# Returns: operating system information on success
>>> +#
>>> +# Since 2.10
>>> +##
>>> +{ 'command': 'guest-get-osinfo',
>>> +  'returns': 'GuestOSInfo' }
>>>=20
>>=20
>> --=20
>> Eric Blake   eblake redhat com    +1-919-301-3266
>> Libvirt virtualization library http://libvirt.org =
<http://libvirt.org/>

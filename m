Received: from eggs.gnu.org ([2001:4830:134:3::10]:56069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gIaoY-0006Ih-6H
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gIaoX-0002Tv-B3
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:52:46 -0400
References: <20181102085800.21860-1-philmd@redhat.com>
	<20181102110734.GE7521@dhcp-200-186.str.redhat.com>
	<6d96d96b-21f7-d5fc-9313-8ede0f6a745c@redhat.com>
	<20181102141030.GH7521@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b2d802d-4b58-30de-44a8-9f04dc968b1b@redhat.com>
Date: Fri, 2 Nov 2018 09:52:25 -0500
MIME-Version: 1.0
In-Reply-To: <20181102141030.GH7521@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu/units: Move out QCow2 specific
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Leonid Bloch <lbloch@janustech.com>, Max Reitz <mreitz@redhat.com>

On 11/2/18 9:10 AM, Kevin Wolf wrote:
> Am 02.11.2018 um 13:37 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>> Hi Kevin,
>>
>> On 2/11/18 12:07, Kevin Wolf wrote:
>>> Am 02.11.2018 um 09:58 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>>>> This definitions are QCow2 specific, there is no need to expose them
>>>> in the global namespace.
>>>>
>>>> This partially reverts commit 540b8492618eb.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>> If we don't want this globally, I think we also don't want it in qcow=
2.

Agreed. I didn't want it in the first place, arguing that if we want=20
stringification of defaults, it would be better to have a runtime=20
function do that, rather than adding a set of near-duplicate macro names.

>>
>> I only see this definitions used by block/qcow2.h (b6a95c6d1007).
>>
>> Per 540b8492618eb description "This is needed when a size has to be
>> stringified" but I can't find other code requiring these definitions i=
n the
>> codebase.
>=20
> I guess the real question is: Is qcow2 the only place that needs
> stringification of sizes?

Probably not. It seems like stringifying a default value is a common desi=
re.

>=20
> The only value where this actually seems to be used in qcow2 is for
> DEFAULT_CLUSTER_SIZE, as the default value for QemuOpts. Other drivers
> still use plain numbers, but this is less readable.
>=20
> Then there is VDI which uses (1 * MiB), but that is compiled out and if
> you enable it, it breaks. So it needs the same fix.
>=20
> Are block drivers the only places where we stringify a size? I imagine
> some device models might use something like it, too?

Indeed, I would prefer a patch that makes it possible for QemuOpts to=20
pretty-print a default value using a generic runtime stringifier, rather=20
than keeping these S_ macros around.

>=20
> I don't mind too much which solution we end up using, but I'd prefer it
> to be universal.

Agree.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

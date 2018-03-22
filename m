Received: from eggs.gnu.org ([2001:4830:134:3::10]:50622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez2wg-00005z-MT
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez2wf-0004c9-Bw
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:20:06 -0400
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-5-vsementsov@virtuozzo.com>
	<8b6eccd8-90ee-3475-5005-df9f59f59709@redhat.com>
	<f3f02fac-35d9-2a4d-0fef-ba66f75aa929@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb213846-5a39-fcae-4a1b-ca10fced25b8@redhat.com>
Date: Thu, 22 Mar 2018 11:19:57 -0500
MIME-Version: 1.0
In-Reply-To: <f3f02fac-35d9-2a4d-0fef-ba66f75aa929@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] qapi: new qmp command
 nbd-server-add-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 03/22/2018 10:43 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> +# Returns: error on one of the following conditions:
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - the =
server is not running
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - expo=
rt is not found
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - bitm=
ap is not found
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - bitm=
ap is disabled
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - bitm=
ap is locked
>>
>> Do we really need to list all the error conditions?=C2=A0 My worry is =
that=20
>> a list this specific might go stale, compared to the obvious default=20
>> that the command succeeds only if it was able to expose the bitmap and=
=20
>> that the error message is specific enough for a human to figure out=20
>> what to fix if it failed.
>=20
>=20
> Hmm, I've just doing it similar with other commands in the file. Is=20
> there any requirements on this part of qapi documentation? I can write=20
> only "# Returns: nothing on success" line, is it appropriate?=20
> blockdev-mirror do so, but other commands tries to describe errors.=20
> Looks like we lack some specified format for return code description=20
> like we have for parameters..

Yeah, for returns, it's been very ad hoc.  My personal feel (although=20
it's not very well documented and certainly not enforced): all commands=20
can reasonably return errors, presumably for a good reason; but=20
exhaustively auditing WHICH errors is a huge task with little benefits.=20
A few commands return non-generic errors, but if all error paths used=20
error_setg(), there's nothing that a machine can do to tell the=20
difference between the errors, so documenting different error reasons=20
doesn't add much.

Thus, if a command returns nothing on success, I'm fine with omitting=20
'Returns:' entirely, and the doc generator permits that.  But if you=20
have bothered to list Returns: for certain errors, I'm not going to=20
blindly throw away the documentation work, even though the list may=20
become incomplete over time.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

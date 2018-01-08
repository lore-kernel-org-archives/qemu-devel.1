Received: from eggs.gnu.org ([2001:4830:134:3::10]:52010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eYdYN-0006ol-Kh
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eYdYM-0000Ca-9r
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:57:51 -0500
From: Jack Schwartz <jack.schwartz@oracle.com>
References: <1513901496-13538-1-git-send-email-jack.schwartz@oracle.com>
	<1513901496-13538-2-git-send-email-jack.schwartz@oracle.com>
	<20171222135208.GI3763@localhost.localdomain>
Message-ID: <edf5c1d0-c899-be0c-f4f2-b4e6eec0193b@oracle.com>
Date: Mon, 8 Jan 2018 11:57:48 -0800
MIME-Version: 1.0
In-Reply-To: <20171222135208.GI3763@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] block: Add numeric errno field to
 BLOCK_IO_ERROR events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com
Cc: qemu-block@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, Karl Heubaum <karl.heubaum@oracle.com>

Hi Kevin.

On 2017-12-22 05:52, Kevin Wolf wrote:
> Am 22.12.2017 um 01:11 hat Jack Schwartz geschrieben:
>> BLOCK_IO_ERROR events currently contain a "reason" string which is
>> strerror(errno) of the error.  This enhancement provides those events =
with
>> the numeric errno value as well, since it is easier to parse for error=
 type
>> than a string.
>>
>> Signed-off-by: Jack Schwartz<jack.schwartz@oracle.com>
>> Reviewed-by: Konrad Rzeszutek Wilk<konrad.wilk@oracle.com>
>> Reviewed-by: Karl Heubaum<karl.heubaum@oracle.com>
> Apart from the technical details that Eric mentioed, I wonder what is
> your use case for this?
We have thousands of servers in our cloud, and would like to closely=20
monitor for different kinds of disk errors without parsing the=20
non-machine-readable error string.
> Exposing errors in a machine readable form was discussed earlier,
OK, found it.=C2=A0 April of 2010.

Upshot of discussion: exposing naked errnos are platform dependent.
>   and
> the result was that nobody had an actual use for error codes other than
> presenting the right error message to the user - which the error string
> already achieves.
Given the platform independence requirement, exposing errors to clients=20
is not that simple given that different OSs use different errno values.=C2=
=A0=20
Other options/considerations than exposing naked errno values:

- Having a platform-independent enumeration of errors, as Eric=20
suggested.=C2=A0 This would have to explicitly set an enumerated value fo=
r=20
each individual errno we are interested in.=C2=A0 It would be returned in=
 a=20
field that ~parallels the "reason" string.=C2=A0 This should be OK since =
for=20
BLOCK_IO_ERROR events we could limit values to just storage device=20
errors plus a default "other"; otherwise this could be hard to maintain.

- The strerror strings cannot be used because they can change with=20
locale. (This also assumes the strings are identical for given errnos=20
cross-platform, and that there are no typos - which are not=20
automatically checked-for.)

 =C2=A0=C2=A0=C2=A0 Thanks,
 =C2=A0=C2=A0=C2=A0 Jack

P.S.=C2=A0 Please excuse the delayed reply due to vacation / company shut=
down.
> The only exception so far was ENOSPC, which some management tools like
> oVirt respond to by increasing the volume size, so this was mapped into
> a bool.
>
> Kevin
>

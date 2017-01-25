Received: from eggs.gnu.org ([2001:4830:134:3::10]:51653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWIgi-0005Np-V0
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWIgf-0005D2-NL
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:12:16 -0500
References: <Pine.NEB.4.64.1701241855380.2138@sdf.lonestar.org>
	<4b93a2b8-097e-a502-875e-21ea394c617a@redhat.com>
	<Pine.NEB.4.64.1701242127070.28647@sdf.lonestar.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3743fb8d-99cf-1016-facf-a5be3c0b0fdd@redhat.com>
Date: Wed, 25 Jan 2017 09:12:07 +0100
MIME-Version: 1.0
In-Reply-To: <Pine.NEB.4.64.1701242127070.28647@sdf.lonestar.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] PPC: MMU compatibility check.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Valentin Plotkin <caliborn@SDF.ORG>
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 24.01.2017 22:41, Valentin Plotkin wrote:
> On Tue, 24 Jan 2017, Thomas Huth wrote:
>=20
>> Date: Tue, 24 Jan 2017 21:32:44 +0100
>> From: Thomas Huth <thuth@redhat.com>
>> To: Valentin Plotkin <caliborn@SDF.ORG>, qemu-trivial@nongnu.org
>> Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
>> Subject: Re: [Qemu-ppc] [PATCH] PPC: MMU compatibility check.
>>
>> On 24.01.2017 19:56, Valentin Plotkin wrote:
>>>
>>> Hi everyone,
>>>
>>> I looked at the "qemu-system-ppc -nographic -cpu G2leGP3 -M ppce500" =
on
>>> the BiteSizedTasks page. The segfault was caused by machine
>>> initialization code which expected a certain MMU model, checked, so
>>> unused SPR were read, returning zeros. bamboo and virtex machines are
>>> affected as well, but it doesn't always cause segfault, usually runni=
ng
>>> into unmapped memory and failing somewhat more nicely.
>>>
>>> I added the checks. It would be possible to add support for other MMU
>>> models, but I'm not sure if there is any point (would any guest OS
>>> support mutually exclusive CPU and machine)?
>>
>> Hi,
>>
>> great to have a fix for this crash! I don't think it make much sense t=
o
>> add support for other MMU models here, so the simple checks should be
>> good enough.
>> However, your new code obviously does not follow the QEMU coding style=
.
>> Could you please run your patch through scripts/checkpatch.pl and fix
>> all issues that it reports? And when you resubmit, please make sure to
>> copy the maintainers on CC: as well (scripts/get_maintainers.pl is you=
r
>> friend here).
>=20
> Here is fengshuised version (at least I hope so). Thanks for guiding me=
.

Thanks, code looks better now!
Now to get your patch included, you've got to send it in a separate
mail, with only the patch description in it, i.e. not as a reply to
another mail with the history of the mail thread. Reason for this is
simply that the maintainers can pick up your patch with "git am" without
having to edit things manually. Please see also
http://qemu-project.org/Contribute/SubmitAPatch#Write_a_meaningful_commit=
_message
if you haven't read that page yet.

Ah, and two more things that came to my mind:

1) Please use "exit(1)" (or "exit(EXIT_FAILURE)") instead of "exit(-1)",
since that's the more common way to do that (since AFAIK the -1 will be
cast to 255 at the shell level, which is just ugly).

2) Maybe it would also be better to do the check right after the
cpu_ppc_init() in the machine's init function already, instead of doing
it in the mmubooke_create_initial_mapping() function? That way we could
be sure that wrong CPUs are blocked right from the start.

 Thanks,
  Thomas

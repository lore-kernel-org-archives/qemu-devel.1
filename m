Received: from eggs.gnu.org ([209.51.188.92]:44774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hDa72-00030f-32
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hDa70-00082v-Ub
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:39:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1hDa70-00082m-Id
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:39:22 -0400
References: <e5fb5172-983a-c8a0-1d86-8406fe8ff99c@redhat.com>
	<ef6ca1d8-50ac-5239-34eb-be05fad7af69@reactos.org>
	<87o95hjbtu.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <cca2f2c2-6916-8db9-ef4c-72cd2a79c9ef@redhat.com>
Date: Mon, 8 Apr 2019 15:30:46 -0400
MIME-Version: 1.0
In-Reply-To: <87o95hjbtu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] How to correctly use more than 2 floppy drives?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>



On 4/8/19 1:38 AM, Markus Armbruster wrote:
> Herv=C3=A9 Poussineau <hpoussin@reactos.org> writes:
>=20
>> Le 05/04/2019 =C3=A0 12:29, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>>> Hi,
>>>
>>> I am trying to understand the possible values for the MAX_FD variable
>>> used by the floppy controller model (hw/block/fdc.c).
>>>
>>> Looking at git history:
>>>
>>> - 2004-01-05 7138fcfbf7dd + 8977f3c107ef (Jocelyn Mayer):
>>>    FDC introduced with "#define MAX_FD 2"
>>>
>>> - 2008-04-29 78ae820cfeb0 (Herv=C3=A9 Poussineau):
>>>    Supports up to 4 floppy drives if MAX_FD is set to 4
>>>    Migration stream knows about runtime value of MAX_FD
>>>
>>> - 2009-09-10 d7a6c2703577 (Juan Quintela):
>>>    FDC vmstate-ified
>>>    Migration stream use compile time value of MAX_FD
>>>
>>> Since 7138fcfbf7dd MAX_FD has always been defined as 2.
>>>
>>> Since d7a6c2703577 MAX_FD can not be different than 2 without breakin=
g
>>> migration.
>>>
>>> If I understand correctly migration, first we should change in
>>> vmstate_fdc the user-definable MAX_FD by a constant 2 value.
>>>
>>> Then to be able to use >2 floppy disks I have to modify the the
>>> vmstate.version_id, and
>>>
>>> 1/ add a new field in the vmstate_fdc containing the number of drives
>>> and add code to check >2 and adapt
>>>
>>> or
>>>
>>> 2/ change MAX_FD to 4 for all the codebase, adding some code to migra=
te
>>> to older FDC with only 2 disks...
>>>
>>> Another option I don't like is:
>>>
>>> 3/ get ride of MAX_FD !=3D 2 and clean the codebase...
>>>
>>> $ git grep '#if MAX_FD'
>>> hw/block/fdc.c:744:#if MAX_FD =3D=3D 4
>>> hw/block/fdc.c:758:#if MAX_FD =3D=3D 4
>>> hw/block/fdc.c:1317:#if MAX_FD =3D=3D 4
>>> hw/block/fdc.c:1340:#if MAX_FD =3D=3D 4
>>> hw/block/fdc.c:2041:#if MAX_FD =3D=3D 4
>>> hw/block/fdc.c:2079:#if MAX_FD =3D=3D 4
>>> hw/block/fdc.c:2104:#if MAX_FD =3D=3D 4
>>>
>>> Herv=C3=A9, what board are/were you using with 4 floppy drives?
>>
>> That was only an attempt to support 4 drives in code, as controller wa=
s able to do it.
>> However, no emulated board took advantage of it, so that's why it kind=
-of regressed.
>>
>> Feel free to choose the solution you prefer.
>=20
> Since no user has appeared since 2008, it feels safe enough to assume
> that none will appear going forward.  I lean towards your "3/ get ride
> of MAX_FD !=3D 2 and clean the codebase..."  Explain in a comment that =
we
> emulate only a 2-drive floppy controller, not the genuine IBM PC 4-driv=
e
> floppy controller.
>=20

I think I'd rather have MAX_FD set to 2 and a cleaner codebase than a
half-working implementation for 4.

Or, does it actually work with four? I think if Herv=C3=A9 wants to prese=
rve
this feature it should be formalized as a device property and made to
work with migration ... or I am content to remove it.

--js

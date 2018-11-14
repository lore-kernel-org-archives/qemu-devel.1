Received: from eggs.gnu.org ([2001:4830:134:3::10]:43540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gN103-0004FE-EU
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gN101-0008HX-HY
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:38:55 -0500
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<CAMRbyysA2h5MbJM8LyyYfFOOttH_D+Fc=Nb51vcvk=o+=hJsbA@mail.gmail.com>
	<7e6da1d6-68bf-913d-6eaf-9acff0623218@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5faca2e2-e56d-012c-01e4-d76accc1f482@redhat.com>
Date: Wed, 14 Nov 2018 14:38:43 -0500
MIME-Version: 1.0
In-Reply-To: <7e6da1d6-68bf-913d-6eaf-9acff0623218@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, den@openvz.org



On 11/12/18 10:25 AM, Max Reitz wrote:
> On 12.11.18 00:36, Nir Soffer wrote:
>> On Mon, Nov 12, 2018 at 12:25 AM Max Reitz <mreitz@redhat.com
>> <mailto:mreitz@redhat.com>> wrote:
>>
>>     This is what I=E2=80=99ve taken from two or three BoF-like get-tog=
ethers on
>>     blocky things.=C2=A0 Amendments are more than welcome, of course.
>>
>> ...=C2=A0
>>
>>     Bitmaps
>>
>>     =3D=3D=3D=3D=3D=3D=3D
>>
>>     (Got this section from sneaking into a BoF I wasn=E2=80=99t invite=
d to.=C2=A0 Oh
>>     well.=C2=A0 Won=E2=80=99t hurt to include them here.)
>>
>>     Currently, when dirty bitmaps are loaded, all IN_USE bitmaps are j=
ust
>>     not loaded at all and completely ignored.=C2=A0 That isn=E2=80=99t=
 correct, though,
>>     they should either still be loaded (and automatically treated and
>>     written back as fully dirty), or at least qemu-img check should
>>     =E2=80=9Crepair=E2=80=9D them (i.e. fully dirtying them).
>>
>>
>> I'm not sure making bitmaps dirty is better.
>>
>> When bitmap is marked IN_USE, it means that we cannot use it for
>> backup. Deleting the bitmap or making it as bad so it cannot be used
>> for the next backup is the same. Making the bitmap as dirty will full
>> the management layer that everything was fine when the next backup
>> includes the entire disk. It is better to cause the next backup to fai=
l
>> in a verbose way, since the backup software can recover by doing
>> a full backup.
>=20
> But making the dirty bitmap fully dirty will automatically enforce a
> full backup.
>=20

I lean towards just deleting the bitmap in these cases but *not*
automatically.

If you do check -r, though, deleting them seems correct. This way you
don't get any nasty surprises when the cronjob goes to make an
incremental and it's accidentally 2TB and still running when you arrive
on Monday morning.

>>     Sometimes qemu (running in a mode as bare as possible) is better t=
han
>>     using qemu-img convert, for instance.=C2=A0 It gives you more cont=
rol
>>     (through QMP; you get e.g. better progress reporting), you get all=
 of
>>     the mirror optimizations (we do have optimizations for convert, to=
o,
>>     but whether it=E2=80=99s any good to write the same (or different?=
)
>>     optimizations twice is another question), and you get a common
>>     interface for everything (online and offline).
>>     Note that besides a bare qemu we=E2=80=99ve also always wanted to =
convert as
>>     many qemu-img operations into frontends for block jobs as possible=
.
>>     We have only done this for commit, however, even though convert lo=
oked
>>     like basically the ideal target.=C2=A0 It was just too hard with t=
oo little
>>     apparent gain, like always (and convert supports additional featur=
es
>>     like concatenation which we don=E2=80=99t have in the runtime bloc=
k layer
>>     yet).
>>
>>
>> I'm not sure it is better to run qemu and use qemu-img as thin wrapper
>> over qmp.
>>
>> For example, management system may ascociate qemu-img
>> with a sanlock lease, and sanlock may try to terminate qemu-img when
>> a lease is invalidated. In this case sanlock will succeed while qemu i=
s till
>> accessing storage it should not access.
>> ...
>=20
> The point was not to run two processes, but to link the necessary bits
> of qemu into qemu-img and then use them inside the single qemu-img
> process itself.  As hinted at above, we've been doing this for qemu-img
> commit for quite some time; that command actually runs a block job unde=
r
> the hood (inside of qemu-img).
>=20
> Max
>=20

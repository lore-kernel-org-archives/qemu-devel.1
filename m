Received: from eggs.gnu.org ([2001:4830:134:3::10]:50876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqlBS-0000Qv-1E
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 16:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqlBQ-0004Xg-Vm
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 16:17:21 -0400
References: <20180725151011.25951-1-armbru@redhat.com>
	<5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
	<20180725160144.GJ12855@redhat.com>
	<20180728043238.GC1325070@localhost.localdomain>
	<371fc437-1330-6873-7f6d-99af8d56c5df@redhat.com>
	<87ftzgnj4z.fsf@dusky.pond.sub.org>
	<8b037e11-87bf-9258-2615-ae17e34ab353@redhat.com>
	<87zhxmerwd.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b3ac50ed-f464-e471-de0e-7c22e3873730@redhat.com>
Date: Fri, 17 Aug 2018 22:17:08 +0200
MIME-Version: 1.0
In-Reply-To: <87zhxmerwd.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="syUeBKfHWSARhIFeeLHxA8USisplZo2cO"
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON
 and back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--syUeBKfHWSARhIFeeLHxA8USisplZo2cO
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, qemu-block@nongnu.org,
 Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b3ac50ed-f464-e471-de0e-7c22e3873730@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON and
 back
References: <20180725151011.25951-1-armbru@redhat.com>
 <5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
 <20180725160144.GJ12855@redhat.com>
 <20180728043238.GC1325070@localhost.localdomain>
 <371fc437-1330-6873-7f6d-99af8d56c5df@redhat.com>
 <87ftzgnj4z.fsf@dusky.pond.sub.org>
 <8b037e11-87bf-9258-2615-ae17e34ab353@redhat.com>
 <87zhxmerwd.fsf@dusky.pond.sub.org>
In-Reply-To: <87zhxmerwd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-16 08:40, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 2018-08-15 10:12, Markus Armbruster wrote:
>>> Max Reitz <mreitz@redhat.com> writes:
>>
>> [...]
>>
>>>> To me personally the issue is that if you can specify a plain filena=
me,
>>>> bdrv_refresh_filename() should give you that plain filename back.  S=
o
>>>> rbd's implementation of that is lacking.  Well, it just doesn't exis=
t.
>>>
>>> I'm not even sure I understand what you're talking about.
>>
>> We have this bdrv_refresh_filename() thing which can do this:
>>
>> $ qemu-img info \
>>     "json:{'driver':'raw',
>>            'file':{'driver':'nbd','host':'localhost'}}"
>> image: nbd://localhost:10809
>> [...]
>>
>> So it can reconstruct a plain filename even if you specify it as optio=
ns
>> instead of just using a plain filename.
>>
>>
>> Now here's my fault: I thought it might be necessary for a driver to
>> implement that function (which rbd doesn't) so that you'd get a nice
>> filename back (instead of just json:{} garbled things).   But you don'=
t.
>>  For protocol drivers, you'll just get the initial filename back.  (So=

>> my comment was just wrong.)
>>
>> So what I was thinking about was some case where you specified a norma=
l
>> plain filename and qemu would give you back json:{}.  (If rbd
>> implemented bdrv_refresh_filename(), that wouldn't happen, because it
>> would reconstruct a nice normal filename.)  It turns out, I don't thin=
k
>> that can happen so easily.  You'll just get your filename back.
>>
>> Because here's what I'm thinking: If someone uses an option that is
>> undocumented and starts with =3D, well, too bad.  If someone uses a no=
rmal
>> filename, but gets back a json:{} filename...  Then they are free to u=
se
>> that anywhere, and their use of "=3D" is legitimized.
>>
>>
>> Now that issue kind of reappears when you open an RBD volume, and then=

>> e.g. take a blockdev-snapshot.  Then your overlay has an overridden
>> backing file (one that may be different from what its image header say=
s)
>> and its filename may well become a json:{} one (to arrange for the
>> overridden backing file options).  Of course, if you opened the RBD
>> volume with a filename with some of the options warranting
>> =3Dkeyvalue-pairs, then your json:{} filename will contain those optio=
ns
>> under =3Dkeyvalue-pairs.
>>
>> So...  I'm not quite sure what I want to say?  I think there are edge
>> cases where the user may not have put any weird option into qemu, but
>> they do get a json:{} filename with =3Dkeyvalue-pairs out of it.  And =
I
>> think users are free to use json:{} filenames qemu spews at them, and =
we
>> can't blame them for it.
>=20
> Makes sense.
>=20
> More reason to deprecate key-value pairs in pseudo-filenames.
>=20
> The only alternative would be to also provide them in QAPI
> BlockdevOptionsRbd.  I find that as distasteful as ever, but if the
> block maintainers decide we need it, I'll hold my nose.
>=20
>>>>> If so, and we are comfortable changing the output the way this patc=
h does
>>>>> (technically altering ABI anyway), we might as well go all the way =
and
>>>>> filter it out completely.  That would be preferable to cleaning up =
the json
>>>>> output of the internal key/value pairs, IMO.
>>>>
>>>> Well, this filtering at least is done by my "Fix some filename
>>>> generation issues" series.
>>>
>>> Likewise.
>>
>> The series overhauls quite a bit of the bdrv_refresh_filename()
>> infrastructure.  That function is also responsible for generating
>> json:{} filenames.
>>
>> One thing it introduces is a BlockDriver field where a driver can
>> specify which of the runtime options are actually important.  The rest=

>> is omitted from the generated json:{} filename.
>>
>> I may have taken the liberty not to include =3Dkeyvalue-pairs in RBD's=

>> "strong runtime options" list.
>=20
> I see.
>=20
> Permit me to digress a bit.
>=20
> I understand one application for generating a json: filename is for
> putting it into an image file header (say as a COW's backing image).

Yes.

(And it's not completely pointless, as there are options you may want to
specify, but cannot do so in a plain filename.  Like host-key-check for
https.)

(And technically you need a string filename to point to when doing
block-commit (Kevin sent patches to remedy this, though), so that could
be called an application as well.)

> Having image file headers point to other images is not as simple as it
> may look at first glance.  The basic case of image format plus plain
> filename (not containing '/') is straightforward enough.  But if I make=

> the filename absolute (with a leading '/'), the image becomes less easy=

> to move to another machine.

That assumes that we correctly implement relative backing file names.
Believe me, we don't.

For example, say you did this:

$ qemu-img create -f qcow2 foo/bot.qcow2 1M
$ qemu-img create -f qcow2 -b bot.qcow2 foo/mid.qcow2
$ qemu-img create -f qcow2 -b mid.qcow2 foo/top.qcow2

Now try committing top to mid.

You're right, it's impossible right now.

(Not via -b mid.qcow2, nor via -b foo/mid.qcow2, nor via
$PWD/foo/mid.qcow2.  Short of CD-ing to foo/ and then committing to
mid.qcow2, it's just impossible.)

((I've send patches to fix this, but still, it's not like we even got
the case right that's "straightforward enough". :-)))

> Similarly, certain Ceph configuration bits may make no sense on another=

> machine, and putting them into an image file header may not be a good
> idea.

On one hand, sure.  Adding json:{} filenames really wasn't one of my
finest hours.  It looked like a simple enough idea at the time, but
they're just not really useful and just keep on biting us.

On another, well, but they may indeed make sense on another machine.
It's like specifying an ssh URL (or absolute mount point on a local
machine, like you describe above).  It may make sense to some (say, you
have a global "content server" or something), so, well.

I mean, our ideal model is that the user just configures the whole
backing chain at runtime and nothing is our fault.  At least that's my
ideal model.  It's always the management layer's fault. O:-)

Max


--syUeBKfHWSARhIFeeLHxA8USisplZo2cO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt3LUQACgkQ9AfbAGHV
z0B2hwgAjzg+w6qTCP2kJvfzsSAOn42Ve3Uq4K7F6LRuJkQwS0tOXbJYzTRamQvv
1QD7fw9uWQ2E/4xiP0TwL+tYFjVDSVE21CKhq8ChhaCl/oLPbJDDI4tYqX/8Hlej
UOUM3iSZiUTuAky+Bm0TM6paW7lyG2i13OEgOQaEtuR1Dd/CaGJfCKUhm68H8Yx8
ItZtEVFtWHzs7DxhOU2MILzrAj9zOqEMW0u5SOxiVsHjYCiF955hvBGvY4wRkfbc
iilldOBLIxbKOA/XeDQJz7n0sMEGcUUVqok7PV5XQbPWw6gJycB8jfM6hlw0ygDV
RgqWvctQWXy79VT+KZBcs+l+L+Cl1A==
=ti8q
-----END PGP SIGNATURE-----

--syUeBKfHWSARhIFeeLHxA8USisplZo2cO--

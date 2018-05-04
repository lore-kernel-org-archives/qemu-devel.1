Received: from eggs.gnu.org ([2001:4830:134:3::10]:53139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEd1r-0006nc-Lk
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEd1p-0005ip-Pz
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:53:51 -0400
References: <20180502213219.7842-1-mreitz@redhat.com>
	<871setrw5v.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2efd29b6-de41-2896-7a9f-021e12214f0e@redhat.com>
Date: Fri, 4 May 2018 17:53:41 +0200
MIME-Version: 1.0
In-Reply-To: <871setrw5v.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Er6VssyblhlQ0TJoqcINECiOYUM2htsJK"
Subject: Re: [Qemu-devel] [RFC 0/7] block: Try to use correctly typed
 blockdev options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Er6VssyblhlQ0TJoqcINECiOYUM2htsJK
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Message-ID: <2efd29b6-de41-2896-7a9f-021e12214f0e@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/7] block: Try to use correctly typed blockdev
 options
References: <20180502213219.7842-1-mreitz@redhat.com>
 <871setrw5v.fsf@dusky.pond.sub.org>
In-Reply-To: <871setrw5v.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-03 10:16, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> (Sorry, Markus, sorry, Kevin, if this series makes you angry.)
>=20
> Anger?  Nah.  Gallows humor :)

Good!  I like to make people happy wherever I can.

>> The subject says it all, I think.  The original issue I was assigned t=
o
>> solve is this:
>>
>>     $ ./qemu-img info --image-opts driver=3Dnull-co,size=3D42
>>     image: json:{"driver": "null-co", "size": "42"}
>>     [...]
>>
>> As you can see, "size" gets a string value in the json:{} object
>> although it is an integer, according to the QAPI schema.  (Buglink:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1534396)
>>
>> My first approach to fix this was to try to pipe the full_open_options=

>> dict generated in bdrv_refresh_filename() through a keyval input visit=
or
>> and then an output visitor (which would have depended on my filename
>> series).  This did not work out because bs->options (where all of the
>> reconstructed options come from) may either be correctly typed or not,=

>> and keyval chokes on non-string values.  I could have probably convert=
ed
>> bs->options to fully string values before trying to pipe it through
>> keyval, but I decided I didn't like that very much.  (I suppose I can =
be
>> convinced otherwise, though.)
>=20
> See also thread
>=20
>     [RFC][BROKEN] rbd: Allow configuration of authentication scheme"
>     Message-Id: <20180405170619.20480-1-kwolf@redhat.com>
>     https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00618.html=

>=20
> in particular the qdict_stringify_entries() proposal and its discussion=
=2E

Ah, right.

So if I did that I should note that the limitation below "works for the
more common cases" would still apply, of course.  The main difference is
that it wouldn't be so important anymore because at least it wouldn't
affect other parts of the block layer's option parsing, but only
generation of json:{} filenames.

>> So I decided to venture into the territory of what we actually want at=

>> some point: Correctly typed bs->options.  Or, rather, in the end we wa=
nt
>> bs->options to be BlockdevOptions, but let's not be too hasty here.
>>
>> So it turns out that with really just a bit of work we can separate th=
e
>> interfaces that generate correctly typed options (e.g. blockdev-add)
>> from the ones that generate pure string-valued options (e.g. qemu-img
>> --image-opts) rather well.  Once we have done that, we can pipe all of=

>> the pure string options through keyval and back to get correctly typed=

>> options.
>>
>> So far the theory.  Now, in practice we of course have pitfalls, and
>> those are not addressed by this series, which is the main reason this =
is
>> an RFC.
>>
>> The first pitfall (I can see...) is that json:{} allows you to specify=

>> mixed options -- some values are incorrectly strings, others are
>> non-strings.  keyval cannot cope with that, so the result after this
>> series is that those options end up in bs->options just like that.  I
>> suppose we could just forbid that mixed-typed case, though, and call i=
t
>> a bug fix.
>=20
> Related: QMP device_add and netdev_add convert their arguments from
> QDict to QemuOpts with qemu_opts_from_qdict(), and therefore accept
> string in addition to number / bool.  If I remember correctly, Eric
> Blake's patches to QAPIfy netdev_add got stuck because they didn't
> replicate that behavior.
>=20
> I think we should reject inappropriate strings.  If we think nobody's
> relying on it, we can call it a bug and just fix it.  If we don't dare,=

> we need to go through the deprecation ritual.  We should've done that
> long ago, but better now than never.

Sure we should reject them, but we can only do that once either
everything well-formed is converted automatically correctly, or once we
have deprecated the rest (which implies having a QAPI alternative).

> Same for json:{}.

Right.

>> The second problem (and I think the big reason why we have not
>> approached this issue so far) is that there are options which you can
>> give as strings, but which are not covered by the schema.  In such a
>> case, the input visitor will reject the QDict and we will just use it
>> as-is, that is, full of strings.  Now that is not what we want in the
>> end, of course -- we want everything to be converted into something th=
at
>> is covered by the schema.
>=20
> Can you give an example?

I looked into qcow2's overlap checking the other day but I was amazed
that someone actually managed to convert my mess into a proper QAPI
definition.

Well, rbd's password-secret comes to mind.  I think we should be good
apart from that...?

Oh no, I just stumbled over bdrv_parse_filename(). m(
I totally missed that.  This has the following effect:

$ ./qemu-img info --image-opts \
    driver=3Dblkdebug,image.driver=3Dnull-co,align=3D512
image: json:{"image": {"driver": "null-co"}, "driver": "blkdebug",
"align": 512}

$ ./qemu-img info --image-opts \
    driver=3Dblkdebug,x-image=3Dnull-co://,align=3D512
image: json:{"image": {"driver": "null-co"}, "driver": "blkdebug",
"align": "512"}

x-image (which is usually set by blkdebug_parse_filename()) is taken by
blkdebug_open() to open the "image" child.  But before that it breaks
conversion of the whole thing into BlockdevOptions, of course...

Of course that is cheating.  You're not allowed to use x-image like
that, actually, qemu just doesn't complain about it (yet).

So if you use it the "proper" way:

$ x86_64-softmmu/qemu-system-x86_64 -nodefaults \
    -drive if=3Dnone,driver=3Draw,file=3Dblkdebug::null-co://,file.align=3D=
512 \
    -monitor stdio
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) info block
none0 (#block238): json:{"driver": "raw", "file": {"image": {"driver":
"null-co"}, "driver": "blkdebug", "align": "512"}} (raw)

Well... Looks like the same issue, but it's different, actually.
blkdebug_parse_filename() only adds "x-image" after the conversion to
BlockdevOptions and back, so that can't be the thing that breaks the
conversion here.  No, the thing here is the "filename" option which is
not something that blkdebug supports according to the QAPI schema...

(And there are many protocol drivers like this, where the filename can
be very complex and is decomposed into proper QAPI options by
bdrv_parse_filename().  Those filenames of course are not part of the
QAPI schema, then.)

Of course the fun doesn't end here.  rbd for instance has a filename
that is decomposed into things that cannot be represented with QAPI at
all[1].  It has these great arbitrary "keyvalue-pairs" that just bypass
everything and go right into rados_conf_set().

The rest is rather tame, they just produce correct QAPI options
(although sometimes stringified) from their filename.


[1] Well, technically the same is true for blkdebug and blkverify.  The
options their filenames are decomposed into are again complex filenames
which need to go through bdrv_parse_filename() themselves.  But the
difference is that after they have opened their children, they can
discard those non-QAPI options because opening those child nodes
automatically produces the proper QAPI equivalent.

So all they need to do is keep the child filenames around somewhere
until their bdrv_open() implementation, and then they can discard it
because we now know the proper QAPI options for their children.

>> My reasoning for sending this series anyway is that it doesn't make
>> things worse (bs->options is a mess already, you can never be certain
>> that it contains correctly typed values or just strings or both), and
>> that it at least gives a starting point from which we can continue on.=

>> After this series, we have a clear separation between the interfaces
>> that use purely string values and the ones that provide correct typing=

>> (well, and json:{}).
>>
>> Oh, and it fixes the above BZ for the more common cases.
>=20
> "for the more common cases", ha!

Yeah...  Well, if it had been only for the two cases I mentioned in the
cover letter (mixed-type json:{} and string options we don't have a QAPI
equivalent for yet), it would have been pretty much fine.  But now with
the filename chaos...  That's a bit different.


OK, collection time.

Option 1: Implement qdict_stringify() and do the whole magic in
bdrv_refresh_filename(), only for expressing json:{} filenames.  One
issue with this is that it would completely choke on rbd's
keyvalue-pairs.  (But really, who cares.)
OK, I've just seen that we could handle null just well...  Although
floats seem like a funny thing to do (albeit not impossible).

Option 2: Do the whole bdrv_parse_filename() thing before typing the
QDict.  Will choke on rbd's keyvalue-pairs as well, so not better in any
way.

Option 3: Keep doing what this series did.  Find out why "filename" is
an option in the QDict in the first place, because I would have assumed
that you need to specify it as the @filename parameter of bdrv_open()
instead of through the QDict.  Secondly, bdrv_parse_filename()
implementations would need to always put correctly typed values into the
QDict (easy fix).
The advantage of this is that it could cope with the keyvalue-pairs
option because it doesn't exist when the typing is done; and it would
just end up as a string in the json:{} object (which qemu could
interpret).  The question is whether this effort would be worth it.

I suppose I'll look into #3 for a bit if only out of curiosity, and if
that doesn't work, fall back to #1.

Max


--Er6VssyblhlQ0TJoqcINECiOYUM2htsJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrsggUACgkQ9AfbAGHV
z0CYIwf9E8ylB3LdmkqRld+Rb6eSZmAW/dGF3+34eMU5xwE2bQ/nvKsLGhVY5rv8
8/3qkURwgGvTpLpIKRghL/a1eTTUu/bxvqFHtdhdEaI16TWYKx95YmthVE4Z8DbK
NXg2UNg3M+UsgN8+zfFkAJn7DOKEMgWu93moBBo7Nd5Nmuq4MMvKFC+siNPwpkYo
CEYlbDGfnSv/zh4EiC9WK1sRM5WP5sqgh/qtrQcgsfrgYM3VdHO9O3XM6PTO8IXq
uB4OPUTpzeq20vHLkOz+lrIUKkcaPOCICb2DMxSTvFA0h26ulCJm6GbPeo45Ttqo
2J3eJLQ5skfOZ6b9OYEqSt0Mu+5e9Q==
=gPK9
-----END PGP SIGNATURE-----

--Er6VssyblhlQ0TJoqcINECiOYUM2htsJK--

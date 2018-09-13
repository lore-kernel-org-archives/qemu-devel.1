Received: from eggs.gnu.org ([2001:4830:134:3::10]:38437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0YTY-0003gm-C4
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 16:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0YTU-0005wL-Dz
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 16:44:32 -0400
References: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
	<ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
	<f7c8ab1d-c752-29ce-bcd1-64a5598a41b4@redhat.com>
	<56133002-7a79-bf6a-8835-fba043638224@redhat.com>
	<31456c31-7a74-7df2-40d3-2a5841f39996@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9af35c5f-1d84-c336-a565-c2e1acb8704e@redhat.com>
Date: Thu, 13 Sep 2018 22:44:09 +0200
MIME-Version: 1.0
In-Reply-To: <31456c31-7a74-7df2-40d3-2a5841f39996@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0MPLHdU69qTZ9fKZMq4wKbe9vL8R6b6Oe"
Subject: Re: [Qemu-devel] Can I only commit from active image to
 corresponding range of its backing file by qemu cmd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, lampahome <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0MPLHdU69qTZ9fKZMq4wKbe9vL8R6b6Oe
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, lampahome <pahome.chen@mirlab.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <9af35c5f-1d84-c336-a565-c2e1acb8704e@redhat.com>
Subject: Re: [Qemu-devel] Can I only commit from active image to corresponding
 range of its backing file by qemu cmd?
References: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
 <ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
 <f7c8ab1d-c752-29ce-bcd1-64a5598a41b4@redhat.com>
 <56133002-7a79-bf6a-8835-fba043638224@redhat.com>
 <31456c31-7a74-7df2-40d3-2a5841f39996@redhat.com>
In-Reply-To: <31456c31-7a74-7df2-40d3-2a5841f39996@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 22:01, Eric Blake wrote:
> On 9/13/18 1:37 PM, Max Reitz wrote:
>> On 13.09.18 19:05, Eric Blake wrote:

[...]

>>> $ qemu-io -c 'discard 0 1m' --image-opts
>>> driver=3Dqcow2,backing=3D,file.driver=3Dfile,file.filename=3Dimg.003
>>> warning: Use of "backing": "" is deprecated; use "backing": null inst=
ead
>>> discard 1048576/1048576 bytes at offset 0
>>> 1 MiB, 1 ops; 0.0002 sec (4.399 GiB/sec and 4504.5045 ops/sec)
>>>
>>> doesn't work, as 'discard' causes img.003 to now make things read as
>>> zero rather than deferring to the backing chain,
>>
>> Which is intentional because making data re-appear from the backing
>> chain can be a security issue, as far as I remember.
>=20
> It can be a potential issue if there is a backing file (exposing data
> that you thought was wiped is not fun).=C2=A0 But where there is NO bac=
king
> file, it's overly cautious, and gets in our way (we read all zeros from=

> a file with no backing, whether the cluster is marked as 0 or as
> defer-to-backing).=C2=A0 I'm okay if we still keep the overly cautious =
way by
> default, but having a knob to say "discard this, and I really do mean
> discard rather than read back as 0" would be useful in qemu (after all,=

> that's what fallocate(FALLOC_FL_NO_HIDE_STALE) has recently been used
> for in the kernel, as the knob for whether discarding on a block device=

> must read back as zero or may go faster [2]).
>=20
> [2] https://lore.kernel.org/patchwork/patch/953421/

Maybe, but I don't see how this would improve anything for qcow2 v3.
Fully unmapping a cluster or making it a zero cluster is basically the
same.  Why would we make qcow2 present effectively random data, when we
can easily make it well-defined?

(It may make a difference for raw images, but this discussion is mainly
about qcow2 and how you could abuse such a feature for making backing
file content reappear. :-))

I just realized I myself have a need to punch such holes, though.  Deep
on my todo list there's this point of making active commit punch holes
in the overlay, because currently, it writes data twice: Once to the
overlay, once to the backing file (like every mirror).  But if for the
respective cluster the backing file is visible from the overlay, we
could simply punch a hole in it and could skip writing the data there.

[...]

>> Basically, there is only one way to reliably make an image pass throug=
h
>> data from its backing files again.=C2=A0 Well, two, actually.=C2=A0 On=
e is
>> qemu-img commit, which (for compatibility, mainly) makes the image emp=
ty
>> after the commit.
>=20
> And only if you did NOT use the -b option (in other words, it only
> empties the file if you are committing to the immediate backing file,
> not deep in the chain).

Yep, because all images between base and top will possibly become
garbage due to that operation.  So if we emptied top, it'd become
garbage, too.  Which is why we don't empty it, so it it stays valid.

And technically, also only if you did not use the -d option, because
that skips the emptying.  Which is useful if you're just going to delete
the image anyway (as in the example I gave here).

>> =C2=A0The other is just throwing the image away and
>> re-creating it from scratch.
>=20
> Well yeah, there's that. But now you have a transient problem of extra
> pressure on your storage, while you have duplicated blocks between old
> and new images, prior to being able to remove the old image.=C2=A0 If t=
he
> goal is to make img.000 not grow during the commit, I was assuming that=

> we are already storage-constrained, and any solution that does in-place=

> modification is therefore better than one that has to create yet anothe=
r
> copy of data, even if the end result is the same once all operations
> have finished.

What if you use qemu-img create -n to overwrite it?

(But it's all just academic anyway.  What you'd want is a way to discard
parts of an image, and we just don't have that.)

[...]

>>
>> Now let's set the backing files.=C2=A0 img.003.commit.000 has only dat=
a that
>> goes into img.000, so that goes there, and img.003.nocommit is going t=
o
>> replace our old img.003, so that goes where that was:
>>
>> $ qemu-img rebase -u -b img.000 img.003.commit.000
>> $ qemu-img rebase -u -b img.002 img.003.nocommit
>>
>> And now let's commit:
>>
>> $ qemu-img commit img.003.commit.000
>>
>> And let's clean up:
>>
>> $ rm img.003.commit.000
>> $ mv img.003.nocommit img.003
>>
>> Done.
>=20
> Done, but with temporary storage usage higher than doing it in place.

Yes, that's true.

>> (If you want to commit all three parts of img.003 into the three
>> different base images, you would create img.003.commit.001 and
>> img.003.commit.002 similarly as above, and then commit those into the
>> respective base images.=C2=A0 Then you'd just rm img.003* and you're b=
ack to
>> the original state.)
>=20
> Your solution of qemu-img convert to concatenate null-co with an offset=

> of img.003 is nice.

I'm not sure whether I'd call it "nice".  "Interesting" probably, yes.

But it is rather obscure, probably nobody outside of qemu-img developers
know that you can do something like that.  Also, it's only an offline
solution that doesn't readily translate into an online one.

Maybe you could mirror img.003 (filtered) to img.003.nocommit, then
complete the mirror, so the latter replaces the former, and then mirror
the to-be-committed part of img.003 (which is no longer in use) to
img.003.commit.000?  And then...  Well, what exactly.  The right thing
would probably to attach img.003.commit.000 as an overlay of img.000
(currently requires a blockdev-del and blockdev-add with backing=3Dimg.00=
0
(or backing=3Dnull and then blockdev-snapshot, but why)).  And then you'd=

commit it down, if blockers allow it.

In that time, img.003.nocommit could have received new data in the
img.000 area, though, but that's probably OK.

Max


--0MPLHdU69qTZ9fKZMq4wKbe9vL8R6b6Oe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluazBkACgkQ9AfbAGHV
z0DPiwf/Rcki77xhEYIKiWpCNhpDfA/HAWmmvl1uK1Wzrrx+6Q6KYn61CJAcm3Y5
naJ9XQnMEE6KSKhcT3IXlGpNzNk31tbHnpcRj6/KQOQ1EOJLPDftDp+09s2a3NfG
nu1ZsyGc+QVzXc7gBoF4vNQ8x0T49fVnTVFAtyMw9deWVRAeYget3rbYgJeFFDy8
6Ik0rWP6bTo33y3WUqeaWR0s4ZT1I/GUsVTJbDOBn0IyGyRN/C9alKM2MJGCJq8y
rzliKw3IXOPyKphlbirjN9Qi8xlPoMqyurn3O1efShoGwCz5FFPChU/P/2twGVwL
SRjpXnqpZe7HSIWqxF0Iu5mzacxt+A==
=2gti
-----END PGP SIGNATURE-----

--0MPLHdU69qTZ9fKZMq4wKbe9vL8R6b6Oe--

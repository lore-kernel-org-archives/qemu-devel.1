Received: from eggs.gnu.org ([2001:4830:134:3::10]:49094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq8MX-0000SF-IP
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq8MP-0002MT-9r
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:50:09 -0400
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-3-eblake@redhat.com>
	<48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
	<4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d8c5df8d-7ae2-8ddc-aa71-38ec06b79988@redhat.com>
Date: Thu, 16 Aug 2018 04:49:49 +0200
MIME-Version: 1.0
In-Reply-To: <4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zT6Nh9uNZnzQtcV9aAdl4AxlfG8jMDWb5"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zT6Nh9uNZnzQtcV9aAdl4AxlfG8jMDWb5
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <d8c5df8d-7ae2-8ddc-aa71-38ec06b79988@redhat.com>
Subject: Re: [PATCH 2/2] qemu-img: Add dd seek= option
References: <20180815025614.53588-1-eblake@redhat.com>
 <20180815025614.53588-3-eblake@redhat.com>
 <48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
 <4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
In-Reply-To: <4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-16 04:39, Eric Blake wrote:
> On 08/15/2018 09:20 PM, Max Reitz wrote:
>> On 2018-08-15 04:56, Eric Blake wrote:
>>> For feature parity with dd, we want to be able to specify
>>> the offset within the output file, just as we can specify
>>> the offset for the input (in particular, this makes copying
>>> a subset range of guest-visible bytes from one file to
>>> another much easier).
>>
>> In my opinion, we do not want feature parity with dd.=C2=A0 What we do=
 want
>> is feature parity with convert.
>=20
> Well, convert is lacking a way to specify a subset of one file to move
> to a (possibly different) subset of the other.=C2=A0 I'm fine if we wan=
t to
> enhance convert to do the things that right now require a dd-alike
> interface (namely, limiting the copying to less than the full file, and=

> choosing the offset at which to start [before this patch] or write to
> [with this patch]).

Yes, I would want that.

> If convert were more powerful, I'd be fine dropping 'qemu-img dd' after=

> a proper deprecation period.

Technically it has those features already, with the raw block driver's
offset and size parameters.

>>> The code style for 'qemu-img dd' was pretty hard to read;
>>> unfortunately this patch focuses only on adding the new
>>> feature in the existing style rather than trying to improve
>>> the overall flow, other than switching octal constants to
>>> hex.=C2=A0 Oh well.
>>
>> No, the real issue is that dd is still not implemented just as a
>> frontend to convert.=C2=A0 Which it should be.=C2=A0 I'm not sure dd w=
as a very
>> good idea from the start, and now it should ideally be a frontend to
>> convert.
>>
>> (My full opinion on the matter: dd has a horrible interface.=C2=A0 I d=
on't
>> quite see why we replicated that inside qemu-img.=C2=A0 Also, if you w=
ant to
>> use dd, why not use qemu-nbd + Linux nbd device + real dd?)
>=20
> Because of performance: qemu-nbd + Linux nbd device + real dd is one
> more layer of data copying (each write() from dd goes to kernel, then i=
s
> sent to qemu-nbd in userspace as a socket message before being sent bac=
k
> to the kernel to actually write() to the final destination) compared to=

> just doing it all in one process (write() lands in the final destinatio=
n
> with no further user space bouncing).=C2=A0 And because the additional =
steps
> to set it up are awkward (see my other email where I rant about losing
> the better part of today to realizing that 'dd ...; qemu-nbd -d
> /dev/nbd1' loses data if you omit conv=3Dfdatasync).

I can see the sync problems, but is the performance really that much wors=
e?

>> ((That gave me a good idea.=C2=A0 Actually, it's probably not such a g=
ood
>> idea, but I guess I'll do it in my spare time anyway.=C2=A0 A qemu-img=
 fuse
>> might be nice which represents an image as a raw image at some mount
>> point.=C2=A0 Benefits over qemu-nbd: (1) You don't need root, (2) you =
don't
>> need to type modprobe nbd.))
>=20
> So the kernel->userspace translation would be happening via the FUSE
> interface instead of the NBD interface.=C2=A0 Data still bounces around=
 just
> as much, but it might be a fun project.=C2=A0 Does fuse behave well whe=
n
> serving exactly one file at the mountpoint, rather than the more typica=
l
> file system rooted in a directory?=C2=A0 NBD at least has the benefit o=
f
> claiming to be a block device all along, rather than complicating the
> user interface with POSIX file system rules (which you'll be bending,
> because you are serving exactly one file instead of a system).

Well, but I can just pretend my FUSE file is a block device, no?

Also, I just discovered something really interesting: FUSE allows you to
specify a single file as a mountpoint.

And you know what?  You can open the original file before you replace it
by the FUSE "filesystem".

So my fun interface is going to looks like this:

$ qemu-img fuse foo.qcow2

And then your foo.qcow2 is a raw image until the next "fusermount -u
foo.qcow2"!  Isn't that fun?

>>> Also, switch the test to use an offset of 0 instead of 1,
>>> to test skip=3D and seek=3D on their own; as it is, this is
>>> effectively quadrupling the test runtime, which starts
>>> to make this test borderline on whether it should still
>>> belong to './check -g quick'.=C2=A0 And I didn't bother to
>>> reindent the test shell code for the new nested loop.
>>
>> In my opinion, it should no longer belong to quick.=C2=A0 It takes 8 s=
 on my
>> tmpfs.=C2=A0 My border is somewhere around 2 or 3; and I haven't yet d=
ecided
>> whether that's on tmpfs or SSD.
>=20
> I took 4 iterations pre-patch, to 8 iterations after patch 1, to 32
> iterations with this patch; my observed times went from 1s to 2s to 7s
> on SSD ext4. Yeah, for v2, I'll drop it from quick.

Thanks!

>>> @@ -4574,7 +4592,14 @@ static int img_dd(int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D dd.co=
unt * in.bsz;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size, &=
error_abort);
>>> +=C2=A0=C2=A0=C2=A0 if (dd.flags & C_SEEK && out.offset * out.bsz > I=
NT64_MAX - size) {
>>
>> What about overflows in out.offset * out.bsz?
>=20
> I've had enough of my eyes bleeding on all the code repeatedly scaling
> things. For v2, I'm strongly considering a cleanup patch that reads all=

> input, then scales all values into bytes, and THEN performs any
> additional math in a single unit, just so the additions become easier t=
o
> reason about.

Haha.  I won't object.

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Seek too la=
rge for '%s'", out.filename);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>
>> Real dd doesn't seem to error out (it just reports an error).=C2=A0 I =
don't
>> know whether that makes any difference, though.
>=20
> But where does the data get written if you can't actually seek that far=

> into the file?

Well, the stats printed say it doesn't write anything.  So that's why I
don't know whether it makes any difference.

>>
>> The test looks good to me.
>=20
> Other than my creative indentation levels ;)

I like them.

I mean, usually I just don't indent anything when adding to a test case.
 I do it like this:


Original code:

=2E..
qemu-img (something) $TEST_IMG
=2E..


Post-my-patch:

for opt in x y; do
=2E..
qemu-img (something) $opt $TEST_IMG
=2E..
done


And I know I'm not the only one.  So, yeah, I liked your more creative
solution.

Max


--zT6Nh9uNZnzQtcV9aAdl4AxlfG8jMDWb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt05k0ACgkQ9AfbAGHV
z0C0mggAsjQ1w2xBOCPHOvPn1mEdI/9nOmk5F6QUU0q/LRM6yLSZq4Ycs44nd/qm
7MrIOAlnvhFHan1gGDjTmGT70PuvAzkphm1/M3XyWyq7D+yfhUJStrULtu4exD3N
o3zfQXbZdF4VMmuMSX7IhiyF/AC+D/GgBAuqczs8bt7zeM4FxoWznQcO5/rjr15+
2siG/ON0t4bhs2hKVAIijqzIiZJ+4yX4NI/PddxDx9hdGQ7UdlXQH6aSVGU/JmHo
pUmiMW2EXYBrWQOnWvl3FkIavHyeolxWWy0saldmyBRKLrmWA1dQqhFPPJlES55I
pmWHcpXO5CRQiFmohuZeNnaBTc9qzQ==
=IrCb
-----END PGP SIGNATURE-----

--zT6Nh9uNZnzQtcV9aAdl4AxlfG8jMDWb5--

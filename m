Received: from eggs.gnu.org ([2001:4830:134:3::10]:52264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWQe9-0002I0-K9
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWQe8-0002cq-DH
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:42:09 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<e10208d6-ade6-f31d-83b1-12a12cff6e7f@redhat.com>
	<20170125162932.GE29006@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d13ff880-3ce4-1b38-3c23-720768d79593@redhat.com>
Date: Wed, 25 Jan 2017 17:41:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170125162932.GE29006@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AN8TvP9dxXIqC73ShktMCtDcqreuXU8BV"
Subject: Re: [Qemu-devel] [PATCH v1 00/15] Convert QCow[2] to QCryptoBlock &
 add LUKS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AN8TvP9dxXIqC73ShktMCtDcqreuXU8BV
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <d13ff880-3ce4-1b38-3c23-720768d79593@redhat.com>
Subject: Re: [PATCH v1 00/15] Convert QCow[2] to QCryptoBlock & add LUKS
 support
References: <20170103182801.9638-1-berrange@redhat.com>
 <e10208d6-ade6-f31d-83b1-12a12cff6e7f@redhat.com>
 <20170125162932.GE29006@redhat.com>
In-Reply-To: <20170125162932.GE29006@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.01.2017 17:29, Daniel P. Berrange wrote:
> On Wed, Jan 25, 2017 at 04:58:32PM +0100, Max Reitz wrote:
>> On 03.01.2017 19:27, Daniel P. Berrange wrote:
>>> This series is a continuation of previous work to support LUKS in
>>> QEMU. The existing merged code supports LUKS as a standalone
>>> driver which can be layered over/under any other QEMU block device
>>> driver. This works well when using LUKS over protocol drivers (file,
>>> rbd, iscsi, etc, etc), but has some downsides when combined with
>>> format drivers like qcow2.
>>
>> When trying out whether compressed images are actually encrypted (whic=
h
>> they are not, as I wrote in my last reply to patch 12), I noticed that=

>> the user interface still has some flaws:
>=20
> The original code explicitly forbids this combination
>=20
>  "qemu-img: Compression and encryption not supported at the same time"
>=20
> but I guess we lost the error check due to changing to use
> encryption-format as the option name

Yes, not supporting it is completely fine, but qemu-img should refuse
that combination then (or at least warn about it).

>> One is that you actually can't convert to encrypted images any more, o=
r
>> if you can, it doesn't seem obvious to me:
>>
>> $ ./qemu-img convert -O qcow2 --object secret,id=3Dsec0,data=3D12345 \=

>>     -o encryption-format=3Dluks,luks-key-secret=3Dsec0 \
>>     foo.qcow2 bar.qcow2
>> qemu-img: Could not open 'bar.qcow2': Parameter 'key-secret' is requir=
ed
>> for cipher
>>
>> The issue is that you have to specify the key secret as a runtime
>> parameter in addition to the creation option. Not only is that a bit
>> cumbersome, but it's also impossible because --image-opts doesn't work=

>> for the output image.
>=20
> Yeah, this is a problem I've not figured out a solutiuon for yet - it
> also affects the previously merged bare luks format code.
>=20
> Somehow qemu-img needs to know which create options are also required
> to be passed when opening the newly created image.
>=20
> Perhaps the BlockDriver struct needs a new callback like
>=20
>   bdrv_create_opts_to_runtime_opts(QemuOpts *copts, QemuOpts *ropts);

Yeah, it's tough. For the moment, I'd be fine with qemu-img convert
working at all, though, even if that means having to specify the secret
twice. But I don't know if fixing the --image-opts issue is any easier
-- maybe we can allow image-opts syntax for the targets when -n is
given? Then you'd have to call qemu-img create and qemu-img convert
separately (or call qemu-img convert twice, once without -n (which
successfully creates the image but then fails when trying to open it)
and once without...), but at least there'd be a way to make it work.

I have to admit that I personally wouldn't mind a hack in qemu-img
convert like "copy every option ending in 'key-secret' to the runtime
opts" too much. But I don't know how much that might infuriate some
other people.

It's ugly, yes, but it would work perfectly well for now. I don't think
it would hurt us in the future. If other parameters appear that we have
to copy over, we can still implement the well-engineered solution.

>> The second flaw is also visible above: The parameter is called
>> "luks-key-secret" here, not just "key-secret". The error message shoul=
d
>> reflect that.
>=20
> This is hard to fix. The "luks-key-secret" parameter refers to the para=
meter
> at the block driver level. The error message though is coming from the =
crypto
> layer whose parameter genuinely is called "key-secret". Fixing it would=

> require the block layer to pre-emptively check parmaeters, duplicating =
what
> the crypto layer does later, which I didn't really like the idea of.

I know that it is hard to fix, but as it stands, the error message
confuses more than it helps. In my opinion, just saying "Key required"
or "key secret must be given" would be better than implying the code
actually knew how the option is called exactly.

Max


--AN8TvP9dxXIqC73ShktMCtDcqreuXU8BV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliI1VcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAikIAIup6psNNbtROZ0vWiXbvpyR+JFTtXJz
0vPBl9/ypn/WKqNR1zXTmMHvv1qS5IyAhc7qx5wMv6wqCubClYX6pf0Mqd1v5Vl/
1RfPp1Z8HDaAgCIwRlX+n3DEorXGx53EaETQUyaKMve8ERsohjeRP5PIrrhU3xjW
Of0xmKh+U9tjxcY9X5Hk/hitZlQU9j+5O7ocmozhP2ChAreprTxF4bjCFg9+bx5F
JG+WnCmUL722PmY13cggVymY9K1PQ1aNvFcMifQuLsPzy8ytfVPxwnmtifiQezcr
qKlF8cjx9EF2FN3Nugap2PH6oT4g9Uk8VtGaHi52xeUZ7ZiV8kcAz1c=
=47fx
-----END PGP SIGNATURE-----

--AN8TvP9dxXIqC73ShktMCtDcqreuXU8BV--

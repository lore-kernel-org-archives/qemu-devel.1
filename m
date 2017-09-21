Received: from eggs.gnu.org ([2001:4830:134:3::10]:51393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv2eg-0007eh-HQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv2ef-00087p-Fd
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:40:42 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-18-mreitz@redhat.com>
	<20170918064613.GG15551@lemon.lan>
	<87b2b2f4-ecc0-3436-a5af-6d2c9d858b8f@redhat.com>
	<20170919080311.GC11534@lemon.lan>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7a0de5bd-5e1e-856b-e2f3-29b1baad7cf2@redhat.com>
Date: Thu, 21 Sep 2017 16:40:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170919080311.GC11534@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nQIcwr9Gkua0KaJ1aL3KLjxaWD4tfb0GR"
Subject: Re: [Qemu-devel] [PATCH 17/18] qemu-io: Add background write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nQIcwr9Gkua0KaJ1aL3KLjxaWD4tfb0GR
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <7a0de5bd-5e1e-856b-e2f3-29b1baad7cf2@redhat.com>
Subject: Re: [PATCH 17/18] qemu-io: Add background write
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-18-mreitz@redhat.com>
 <20170918064613.GG15551@lemon.lan>
 <87b2b2f4-ecc0-3436-a5af-6d2c9d858b8f@redhat.com>
 <20170919080311.GC11534@lemon.lan>
In-Reply-To: <20170919080311.GC11534@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-19 10:03, Fam Zheng wrote:
> On Mon, 09/18 19:53, Max Reitz wrote:
>> On 2017-09-18 08:46, Fam Zheng wrote:
>>> On Wed, 09/13 20:19, Max Reitz wrote:
>>>> Add a new parameter -B to qemu-io's write command.  When used, qemu-=
io
>>>> will not wait for the result of the operation and instead execute it=
 in
>>>> the background.
>>>
>>> Cannot aio_write be used for this purpose?
>>
>> Depends.  I have been trained to dislike *_aio_*, so that's probably t=
he
>> initial reason why I didn't use it.
>>
>> Second, I'd have to fix aio_write before it can be used.  Currently,
>> this aborts:
>>
>> echo 'qemu-io drv0 "aio_write -P 0x11 0 64M"' \
>>     | x86_64-softmmu/qemu-system-x86_64 -monitor stdio \
>>           -blockdev node-name=3Ddrv0,driver=3Dnull-co
>>
>> because aio_write_done thinks it's a good idea to use qemu-io's
>> BlockBackend -- but when qemu-io is executed through the HMP, the
>> BlockBackend is only created for the duration of the qemu-io command
>> (unless there already is a BB).  So what I'd have to do is add a
>> blk_ref()/blk_unref() there, but for some reason I really don't like t=
hat.
>=20
> What is the reason? If it crashes it should be fixed anyway, I assume?

Because the AIO CB (aio_write_done()) continues to use qemu-io's BB --
but in case of HMP's qemu-io, that is pretty much already gone once the
command is done.

That could be fixed, as I said, by blk_ref()ing the BB before aio_write
returns (and then blk_unref()ing it in aio_write_done()).  However, I'm
not even sure whether aio_write_done() is always executed in the main
thread...

Other than that, I just have a bad feeling about adding the pair, not
sure why.  Probably because it means having to carry a temporary BB
around until the command is done, which is weird.  Well, it's not an
issue permission-wise, because the qemu-io BB simply doesn't take the
proper permissions (no, I'm not going to question the fact how it's then
possible to even write to it, considering we have assertions that check
whether the correct permissions have been taken...), and I can't think
of another way.

In any case, you're right, it probably needs to be fixed anyway -- even
if the fix is just not allowing aio_write with a temporary BB (i.e. from
HMP).

Max


--nQIcwr9Gkua0KaJ1aL3KLjxaWD4tfb0GR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnDz1MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+6cIAKryt0jMHPFKrQgIBzwdXaxchvWTpnhF
zH46ZXFyN+ll7uSl0xy2it+053nofls5E5vhvYlYoMsP8HAl6qWsvZcD8oyYe0C/
Y9tY3kT4jQD1LnjUz9tZu4qzW+qy88lNIvPClQfjFcjF0NkGKvmmsdtupY+xoD3G
4Um3GY66pG7MiZLMZyFpregOiT+b8SjrPKNxw+BRamntXmnU4p+pAjWVvc/0ijUI
RpTaR77hU7APitfE6eZcBEapxQGxcASvcd+DWiWNPSPARJLSpkyihakOj8Z8Ph26
yK1rwkp1RrSr6N4smjh0fgTXQlu7SwJswSx8ry5WpuWaqbQw6xRf1T8=
=AJy/
-----END PGP SIGNATURE-----

--nQIcwr9Gkua0KaJ1aL3KLjxaWD4tfb0GR--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv30s-0006bC-R6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv30o-0008Ru-Tk
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:03:38 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-18-mreitz@redhat.com>
	<20170918064613.GG15551@lemon.lan>
	<87b2b2f4-ecc0-3436-a5af-6d2c9d858b8f@redhat.com>
	<20170919080311.GC11534@lemon.lan>
	<7a0de5bd-5e1e-856b-e2f3-29b1baad7cf2@redhat.com>
	<20170921145943.GA28064@lemon.lan>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <97e33f16-7c23-de70-47a9-e4b6f86aa72f@redhat.com>
Date: Thu, 21 Sep 2017 17:03:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170921145943.GA28064@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LWrKcp3LM7JU44I2JFdbHqe615juuKoDF"
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
--LWrKcp3LM7JU44I2JFdbHqe615juuKoDF
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <97e33f16-7c23-de70-47a9-e4b6f86aa72f@redhat.com>
Subject: Re: [PATCH 17/18] qemu-io: Add background write
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-18-mreitz@redhat.com>
 <20170918064613.GG15551@lemon.lan>
 <87b2b2f4-ecc0-3436-a5af-6d2c9d858b8f@redhat.com>
 <20170919080311.GC11534@lemon.lan>
 <7a0de5bd-5e1e-856b-e2f3-29b1baad7cf2@redhat.com>
 <20170921145943.GA28064@lemon.lan>
In-Reply-To: <20170921145943.GA28064@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-21 16:59, Fam Zheng wrote:
> On Thu, 09/21 16:40, Max Reitz wrote:
>> On 2017-09-19 10:03, Fam Zheng wrote:
>>> On Mon, 09/18 19:53, Max Reitz wrote:
>>>> On 2017-09-18 08:46, Fam Zheng wrote:
>>>>> On Wed, 09/13 20:19, Max Reitz wrote:
>>>>>> Add a new parameter -B to qemu-io's write command.  When used, qem=
u-io
>>>>>> will not wait for the result of the operation and instead execute =
it in
>>>>>> the background.
>>>>>
>>>>> Cannot aio_write be used for this purpose?
>>>>
>>>> Depends.  I have been trained to dislike *_aio_*, so that's probably=
 the
>>>> initial reason why I didn't use it.
>>>>
>>>> Second, I'd have to fix aio_write before it can be used.  Currently,=

>>>> this aborts:
>>>>
>>>> echo 'qemu-io drv0 "aio_write -P 0x11 0 64M"' \
>>>>     | x86_64-softmmu/qemu-system-x86_64 -monitor stdio \
>>>>           -blockdev node-name=3Ddrv0,driver=3Dnull-co
>>>>
>>>> because aio_write_done thinks it's a good idea to use qemu-io's
>>>> BlockBackend -- but when qemu-io is executed through the HMP, the
>>>> BlockBackend is only created for the duration of the qemu-io command=

>>>> (unless there already is a BB).  So what I'd have to do is add a
>>>> blk_ref()/blk_unref() there, but for some reason I really don't like=
 that.
>>>
>>> What is the reason? If it crashes it should be fixed anyway, I assume=
?
>>
>> Because the AIO CB (aio_write_done()) continues to use qemu-io's BB --=

>> but in case of HMP's qemu-io, that is pretty much already gone once th=
e
>> command is done.
>=20
> I can see aio_{read,write}_done accesses BB for accounting, we can prob=
ably skip
> this part altogether if issued from HMP (because the BB is gone). This =
way you
> don't need the blk_ref/unref pair.

Yep, and then it'd be functionally the same as this write -B, so that
sounds good.

Well, I fear that someone will have to rewrite it with coroutines
somewhere in the future anyway, but, er, well, not a problem for now!!1! =
:-)

Max


--LWrKcp3LM7JU44I2JFdbHqe615juuKoDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnD1LESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhFYH/2FgI/FrSAXrFmnLi801E5NneNwIFCw4
Xw1jcLmgQRzpibhB3Zv0CUWIeFNbICFQ6VFjri5t/doxmpCZKoI/NLv4USGmqsAT
VlcJnb9ltfkbBxdM8CWwrzKaZuSOBVfjCPIJF3g/F02S4lz8wjq93tXVgFfAAJbL
KMzHaxEYk0uGOcYPXn5MW04aHU2kNxdQzthYbVmhW0avr2XS3fKMiiJdX/mbuYVL
s55uCeN+E7lY6YNQ3dOcIDp64+bU+9sgwQ+jqk1IGynQR4J03jnUC+Zne2810LaH
QxoD3FdBP7k4S+erY23/gCUmE7ymT2+r5N9qbLhJq7zdJaCqYlkyns8=
=wyB2
-----END PGP SIGNATURE-----

--LWrKcp3LM7JU44I2JFdbHqe615juuKoDF--

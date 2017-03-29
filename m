Received: from eggs.gnu.org ([2001:4830:134:3::10]:60126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctKJr-0006Cd-GW
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctKJq-0000Tr-GN
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:35:51 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-9-git-send-email-armbru@redhat.com>
	<a33b1054-201c-9f5e-2c0e-35a86b1262e1@redhat.com>
	<f7c8116c-db13-4aaf-e5e4-60590705a134@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7165e65d-c9bb-78b6-b286-956f55e2e5da@redhat.com>
Date: Wed, 29 Mar 2017 22:35:41 +0200
MIME-Version: 1.0
In-Reply-To: <f7c8116c-db13-4aaf-e5e4-60590705a134@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="45Ppp5FpTDBU7krKvHu9Tj3ITefXJcAP3"
Subject: Re: [Qemu-devel] [for-2.9 8/8] sheepdog: Fix blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--45Ppp5FpTDBU7krKvHu9Tj3ITefXJcAP3
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, pbonzini@redhat.com
Message-ID: <7165e65d-c9bb-78b6-b286-956f55e2e5da@redhat.com>
Subject: Re: [for-2.9 8/8] sheepdog: Fix blockdev-add
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-9-git-send-email-armbru@redhat.com>
 <a33b1054-201c-9f5e-2c0e-35a86b1262e1@redhat.com>
 <f7c8116c-db13-4aaf-e5e4-60590705a134@redhat.com>
In-Reply-To: <f7c8116c-db13-4aaf-e5e4-60590705a134@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.03.2017 22:32, Eric Blake wrote:
> On 03/29/2017 02:59 PM, Max Reitz wrote:
>> On 29.03.2017 18:45, Markus Armbruster wrote:
>>> Commit 831acdc "sheepdog: Implement bdrv_parse_filename()" and commit=

>>> d282f34 "sheepdog: Support blockdev-add" have different ideas on how
>>> the QemuOpts parameters for the server address are named.  Fix that.
>>> While there, rename BlockdevOptionsSheepdog member addr to server, fo=
r
>>> consistency with BlockdevOptionsSsh, BlockdevOptionsGluster,
>>> BlockdevOptionsNbd.
>>>
>>> Commit 831acdc's example becomes
>>>
>>>     --drive driver=3Dsheepdog,server.host=3Dfido,vdi=3Ddolly
>>>
>>> instead of
>>>
>>>     --drive driver=3Dsheepdog,host=3Dfido,vdi=3Ddolly
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  block/sheepdog.c     | 18 +++++++++---------
>>>  qapi/block-core.json |  4 ++--
>>>  2 files changed, 11 insertions(+), 11 deletions(-)
>>
>> OK, so let me get this straight: Before this patch, @addr was advertis=
ed
>> as a runtime parameter that actually wasn't supported at all? (Because=
 I
>> can't see any place in block/sheepdog.c where it would be parsed.)
>=20
> Both commits mentioned in the commit message are new to 2.9, so we
> aren't breaking any back-compat, but are avoiding cementing in a mistak=
e.
>=20
> Before this patch, @addr was the QMP spelling (inconsistent with all th=
e
> others, where ssh, gluster, and nbd spelled it @server); and because it=

> was NOT mentioned in the sheepdog.c QemuOpts code, it was impossible to=

> parse it through -drive.  Which means we have a needless difference
> between -drive and -blockdev-add.
>=20
> After this patch, it is spelled @server for both -drive and
> -blockdev-add, and QMP is consistent (both with the QemuOpts code, and
> with the other network storage drivers).

Yes, right, which is why I agree that in principle this patch is
necessary for 2.9.

>> This patch now renames @addr to @server and instead of actually parsin=
g
>> the option, it just removes the so-far convenience[1] options @host,
>> @port, and @path and just fetches the from @server?
>=20
> But the convenience options have not been released, so fixing them now
> is the right way to go.

Right. My main point was that @server still isn't actually parsed.

>> If that is true, I can't say I like it the least. I guess it works for=

>> 2.9, but there should be a FIXME somewhere in this patch.
>=20
> A fixme to what? Unlike patch 7/8 which has to deal with legacy -drive
> code, here, we have nothing released to break.

A FIXME for parsing @server.

>> Also, if you set any of server.* in bdrv_parse_filename(), you also ha=
ve
>> to set server.type. It's a SocketAddressFlat, .type is a required fiel=
d.
>> I know it's just for internal use, but that doesn't change the fact th=
at
>> it's an invalid SocketAddressFlat object without.
>=20
> That part's true. Also, you can't set server.host and server.path at th=
e
> same time (compare to nbd_process_legacy_socket_options taking pains to=

> make sure that a valid QAPI object is constructed).
>=20
>>
>> Max
>>
>>
>> [1] Originally there were apparently introduced for
>> bdrv_parse_filename() -- but of course you can just use them in -drive=

>> directly...
>=20
> There's a difference between the psuedo-file '-drive sheepdog:...'
> (where you can use them directly, and that doesn't change in this
> patch), and the structured '-drive driver=3Dsheepdog,...' (which didn't=

> exist before 831acdc, and which we want to match to our QMP).
>=20
> I'm in favor of this patch, but think you found a real issue with not
> constructing a valid qapi object.

I agree that this patch is pretty much OK (and definitely necessary) for
2.9, what I'm asking for is some form of acknowledgment that we want to
actually make @server a valid SocketAddressFlat object and parse it as
such in 2.10.

Max


--45Ppp5FpTDBU7krKvHu9Tj3ITefXJcAP3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcGp0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7SsH/2D6k1GB7MrYtS+rf6xgaFiDHJRYcyGF
ZBmj/ZYswU/oZ6H0jZV0AW8ZwxKsCbpgQrNlRPYBTW/RwwaH0us942aCrZ9yhxWr
D3koBgDvNNyBg23HolRe0KgIO6LYO5bavlXoqD5XfLENHSlTMHbr7J01HJRwc61u
nEfSzDlL8BewvT30WdVhZ9ZYWQPsKc/F7yI0U38YfvRZIgMCq+bBqNNiAZrpJ6Js
4wEWLUwcD01hztXUDRZtCAOZh72NHRPH5bHk9uongbbKjZMAyw7jrklXbaIq1nLF
TxVokIK4bN30SNdZe3blMCcea4nfWRIL8LSQtsOsBh068HmwQ18IiOA=
=ccm2
-----END PGP SIGNATURE-----

--45Ppp5FpTDBU7krKvHu9Tj3ITefXJcAP3--

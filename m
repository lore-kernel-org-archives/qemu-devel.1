Received: from eggs.gnu.org ([2001:4830:134:3::10]:36422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG4me-00061H-8l
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG4mZ-00036e-NK
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dG4mZ-000363-ER
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:39:31 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-2-vsementsov@virtuozzo.com>
	<874e184b-3727-3bbc-0169-1073db203736@redhat.com>
	<173a697e-274c-a2a7-63d2-f5dbf93f69e7@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5021317-ec3a-def9-71ea-3dbc947a6e20@redhat.com>
Date: Wed, 31 May 2017 09:39:27 -0500
MIME-Version: 1.0
In-Reply-To: <173a697e-274c-a2a7-63d2-f5dbf93f69e7@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vbWbUTjTVQfntp6H24wfnXTIjJn9HrTMu"
Subject: Re: [Qemu-devel] [PATCH 01/19] nbd/server: get rid of
 nbd_negotiate_read and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vbWbUTjTVQfntp6H24wfnXTIjJn9HrTMu
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <e5021317-ec3a-def9-71ea-3dbc947a6e20@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/19] nbd/server: get rid of
 nbd_negotiate_read and friends
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-2-vsementsov@virtuozzo.com>
 <874e184b-3727-3bbc-0169-1073db203736@redhat.com>
 <173a697e-274c-a2a7-63d2-f5dbf93f69e7@virtuozzo.com>
In-Reply-To: <173a697e-274c-a2a7-63d2-f5dbf93f69e7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 08:12 AM, Vladimir Sementsov-Ogievskiy wrote:
> 30.05.2017 23:10, Eric Blake wrote:
>> On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Functions nbd_negotiate_{read,write,drop_sync} were introduced in
>>> 1a6245a5b, when nbd_wr_syncv was working through qemu_co_sendv_recvv,=

>> There is no qemu_co_sendv_recvv. Did you mean qemu_co_recv/qemu_co_sen=
d?
>=20
> qemu_co_recv is a macro, qemu_co_sendv_recvv - is an actual function,
> which do something.

Oh. I see where I went wrong - I was grepping for 'nbd_co_sendv' and
coming up short.

>=20
> #define qemu_co_recv(sockfd, buf, bytes) \
>   qemu_co_send_recv(sockfd, buf, bytes, false)
>=20
> ssize_t coroutine_fn
> qemu_co_send_recv(int sockfd, void *buf, size_t bytes, bool do_send)
> {
>     struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D bytes };
>     return qemu_co_sendv_recvv(sockfd, &iov, 1, 0, bytes, do_send);
> }

The commit message still makes me chase through several layers of
indirection, so I still wonder if referring to qemu_co_recv/qemu_co_send
(which is what is directly used in that older commit for nbd_wr_syncv)
is any better.  It is probably also worth referring back to commit
ff82911cd as the point in time where we switched to the qio_channel
code, thereby no longer needing to manage coroutine handlers quite as
directly as beforehand.


>>> +int drop_sync(QIOChannel *ioc, size_t size, Error **errp)
>> As part of moving it into nbd/common.c, please rename this function to=

>> an nbd_ prefix, since non-static functions are more likely to collide
>> with the rest of the code base if not properly named.  Better yet: do =
it
>> in multiple patches:
>> - rename the static functions and fallout to callers (all of
>> nbd_drop_sync, nbd_read_sync, and nbd_write_sync)

In fact, does the _sync name buy us anything any more, or can we just go
with the shorter nbd_drop(), nbd_read(), and nbd_write()?

>> - code motion (promote nbd_drop_sync from static in client.c to export=
ed
>> in common.c)
>> - drop nbd_negotiate_ functions in favor of common nbd_*_sync function=
s
>=20
> OK
>=20
>>
>> The idea makes sense, but I think there's too much going on in this on=
e
>> commit.
>>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vbWbUTjTVQfntp6H24wfnXTIjJn9HrTMu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLtWfAAoJEKeha0olJ0NqxiYH/R8NG6OXTXsPrPIBCFBkzQtd
GijQ1ioreNvYkkau3e8GqW8FrA+Vcnuq92PpmgkfxHUjUO048qHZVmusyr6C1bUU
d11FuaRkaCvB7aEBVMPAmg+Lr0U+IJVl1WcPjOchkHFUYgMDzkmZmAbwgXv0H9+b
L4Q0zrbt1WYduy9P5yp6Q1Vv0gVDYxku1FJHC5MkBnzQ6DbEUQSsKRcitBGgm6uI
zPFUJKvfeH89fMedqMjFSOiKpt6oJrnHeVprCJV2JWSQc9i4mzjehkMQCb6HJjEa
qwO6v6at1lnMHv3gloao7dBkGUAQyt3r828ZjbrJEGH55WITPNiuPmYLHl4cZvQ=
=KZXD
-----END PGP SIGNATURE-----

--vbWbUTjTVQfntp6H24wfnXTIjJn9HrTMu--

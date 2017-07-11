Received: from eggs.gnu.org ([2001:4830:134:3::10]:33802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUvxG-00036T-QV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUvxD-0004xa-N4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:15:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dUvxD-0004wK-Dv
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:15:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1582D5AFD9
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 14:15:54 +0000 (UTC)
Date: Tue, 11 Jul 2017 15:15:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170711141543.GW17792@stefanha-x1.localdomain>
References: <20170710072027.7948-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f4arffV+Mc+T1KhS"
Content-Disposition: inline
In-Reply-To: <20170710072027.7948-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/5] Introduce "-object iothread-group"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Eric Blake <eblake@redhat.com>


--f4arffV+Mc+T1KhS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 03:20:22PM +0800, Fam Zheng wrote:
> Last time we've looked at "-object iothread,spawns=3DN" but it was a bit =
abusive.
> A dedicated "iothread-group" class is cleaner from the interface point of=
 view.
> This series does that.
>=20
> It has the same set of poll parameters as the existing "iothread" object,=
 plus
> a "size" option to specify how many threads to start. Using iothread-group
> doesn't require the user to explicitly create the contained IOThreads. The
> IOThreads are created by the group object.
>=20
> Internally, IOThreads share one AioContext.  This is to make it easier to=
 adapt
> this to the current data plane code (see the last patch). But it is an
> implementation detail, and will change depending on the block layer multi=
queue
> needs.
>=20
> TODO:
>=20
> - qmp_query_iothread_groups, in addition to proper QOM @child property fr=
om
>   IOThreadGroup to its IOThread instances.
> - Add virtio-scsi.
> - Variant of iothread_stop_all().
>=20
> Fam Zheng (5):
>   aio: Wrap poll parameters into AioContextPollParams
>   iothread: Don't error on windows
>   iothread: Extract iothread_start
>   Introduce iothread-group
>   virtio-blk: Add iothread-group property

=46rom your TODO note above it looks like you plan to duplicate IOThread
interfaces for IOThreadGroup?  This means existing query-iothreads users
no longer see the full view of all IOThreads.

I think it would be cleaner to define and query IOThreads like they are
today but change virtio-blk/virtio-scsi to accept a list of IOThreads.
That way existing management tool functionality can be used and the only
tweak is that devices can now be added to multiple IOThreads.

It would be nice to express the group relationship in QOM instead of
open coding a new group object.  The majority of the RFC code creates a
child/link list relationship that QOM should support for any type, not
just IOThread.

Adding Eric Blake so we can discuss QMP requirements further.

--f4arffV+Mc+T1KhS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZN2PAAoJEJykq7OBq3PIjjsIAIC7yOcBVC5TBp3IQ5FqbYJD
OI1TaK1kjs/pyaEUnqRlymtWwis/loW+5EiCY3nYubfa5Kt4HE93P5bKudu0Ncma
V8s/2CtHzMjvT4sS9cBeDOcrfudIt68iqB53/0U6dzSwVfNae3miQ+S19l8w/WbD
TOTUlPK70xBfTD7EBekFfNK6NHHROj302uo5kwv6jVHsomkegE5Khurg6bMyAqG7
/A37i8AUUjoAhvS46TE1PKG65VggT8g+/51uvjaxfMpKzw0SQ/cp5jLop8lCCWFp
ddqoWQnUJ+5ATiaRUaIHizzKgRJtetYsDaANIqEYxE79bq4Y4nXsgCpE62hMYW0=
=dgAw
-----END PGP SIGNATURE-----

--f4arffV+Mc+T1KhS--

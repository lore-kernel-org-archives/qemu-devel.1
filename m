Received: from eggs.gnu.org ([2001:4830:134:3::10]:59733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPGEM-0003eY-0v
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPGEI-0002vN-18
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:09:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPGEH-0002v8-OV
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:09:49 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F305461BA0
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 22:09:49 +0000 (UTC)
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-8-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <857b8995-d924-e6a5-b453-e2fed1394b84@redhat.com>
Date: Thu, 5 Jan 2017 16:09:47 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160321.21786-8-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rVbdWrvfAGu1bONGGL79E6PPKSWh4Dw1x"
Subject: Re: [Qemu-devel] [PATCH 7/8] io: remove Error parameter from
 QIOTask thread worker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rVbdWrvfAGu1bONGGL79E6PPKSWh4Dw1x
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <857b8995-d924-e6a5-b453-e2fed1394b84@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/8] io: remove Error parameter from QIOTask
 thread worker
References: <20170105160321.21786-1-berrange@redhat.com>
 <20170105160321.21786-8-berrange@redhat.com>
In-Reply-To: <20170105160321.21786-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> Now that task objects have a directly associated error,
> there's no need for an an Error **errp parameter to
> the QIOTask thread worker function. It already has a
> QIOTask object, so can directly set the error on it.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/task.h    | 19 +++++++++----------
>  io/channel-socket.c  | 47 ++++++++++++++++++++++----------------------=
---
>  io/task.c            | 10 +---------
>  tests/test-io-task.c | 12 +++++-------
>  4 files changed, 37 insertions(+), 51 deletions(-)
>=20
> diff --git a/include/io/task.h b/include/io/task.h
> index 7b5bc43..dca57dc 100644
> --- a/include/io/task.h
> +++ b/include/io/task.h
> @@ -29,9 +29,8 @@ typedef struct QIOTask QIOTask;
>  typedef void (*QIOTaskFunc)(QIOTask *task,
>                              gpointer opaque);
> =20
> -typedef int (*QIOTaskWorker)(QIOTask *task,
> -                             Error **errp,
> -                             gpointer opaque);
> +typedef void (*QIOTaskWorker)(QIOTask *task,
> +                              gpointer opaque);

Hmm, so you're getting rid of the return type here, because the QIOTask
now holds everything. I'm still not sure whether a void* return would be
easier, but I'm not going to reject your patch because of my bikeshedding=
=2E

> =20
>  /**
>   * QIOTask:
> @@ -163,18 +162,18 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
>   * socket listen using QIOTask would require:
>   *
>   * <example>
> - *    static int myobject_listen_worker(QIOTask *task,
> - *                                      Error **errp,
> - *                                      gpointer opaque)
> + *    static void myobject_listen_worker(QIOTask *task,
> + *                                       gpointer opaque)
>   *    {
>   *       QMyObject obj =3D QMY_OBJECT(qio_task_get_source(task));
>   *       SocketAddress *addr =3D opaque;
> + *       Error *err =3D NULL;
>   *
> - *       obj->fd =3D socket_listen(addr, errp);
> - *       if (obj->fd < 0) {
> - *          return -1;
> + *       obj->fd =3D socket_listen(addr, &err);
> + *
> + *       if (err) {
> + *           qio_task_set_error(task, err);

I argued earlier that you can call this unconditionally, dropping the
'if (err)'.  Both here in the doc example...

> +++ b/io/channel-socket.c
> @@ -156,19 +156,18 @@ int qio_channel_socket_connect_sync(QIOChannelSoc=
ket *ioc,
>  }
> =20
> =20
> -static int qio_channel_socket_connect_worker(QIOTask *task,
> -                                             Error **errp,
> -                                             gpointer opaque)
> +static void qio_channel_socket_connect_worker(QIOTask *task,
> +                                              gpointer opaque)
>  {
>      QIOChannelSocket *ioc =3D QIO_CHANNEL_SOCKET(qio_task_get_source(t=
ask));
>      SocketAddress *addr =3D opaque;
> -    int ret;
> +    Error *err =3D NULL;
> =20
> -    ret =3D qio_channel_socket_connect_sync(ioc,
> -                                          addr,
> -                                          errp);
> +    qio_channel_socket_connect_sync(ioc, addr, &err);
> =20
> -    return ret;
> +    if (err) {
> +        qio_task_set_error(task, err);

=2E..and in the actual code.  But I guess leaving it in doesn't hurt much=
,
either.

> @@ -107,10 +102,7 @@ static gpointer qio_task_thread_worker(gpointer op=
aque)
>      struct QIOTaskThreadData *data =3D opaque;
> =20
>      trace_qio_task_thread_run(data->task);
> -    data->ret =3D data->worker(data->task, &data->err, data->opaque);
> -    if (data->ret < 0 && data->err =3D=3D NULL) {
> -        error_setg(&data->err, "Task worker failed but did not set an =
error");
> -    }
> +    data->worker(data->task, data->opaque);

I like that your choice of making the error part of the QIOTask
simplifies the workers.

Up to you whether to simplify the conditionals.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rVbdWrvfAGu1bONGGL79E6PPKSWh4Dw1x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbsQrAAoJEKeha0olJ0NqxDAH/2ETqp1yHBPpGKVbUgW1nN2P
/otavL8xvyH+ZNgNKFS5nxCjTjHSHgQZ+OwwN8Zem7YYvgIoVwh+r0nmFrDueWU9
Ms5GhvzZSSNRK9btE1JzHxgnrVmUFdae+f8cXDJH3dnPgKOdW7oM6Xg0jSRSNtZZ
/i/43T2Z0T/3nfc7xwUnLYH2rmBtdTtw6Iw3sz3jTHMwCNf0X/Wpi4Qhvn/k+mxE
yIEfPBUlLNbJHvxR7PgDXa9084R1x3QzIytzITS82QLyrJiu4GJhf/lO5CrS290W
pQ2vtTndDIWlsPvX+oVVvQEMvC934cRG1ANEKsfzwNiTdcSnXtokrW5n2Y7OCAA=
=3YNf
-----END PGP SIGNATURE-----

--rVbdWrvfAGu1bONGGL79E6PPKSWh4Dw1x--

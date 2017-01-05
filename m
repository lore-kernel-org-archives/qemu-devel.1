Received: from eggs.gnu.org ([2001:4830:134:3::10]:46668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPFBx-0004yW-D3
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPFBs-0003pB-Gn
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:03:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPFBs-0003p6-92
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:03:16 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 498A7285A6
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 21:03:16 +0000 (UTC)
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73e36ee2-081e-4298-bf5b-411cc8d247b7@redhat.com>
Date: Thu, 5 Jan 2017 15:03:08 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160321.21786-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MB4JVVWAVLFUxcRvIWUeqxukTx2IPL9r0"
Subject: Re: [Qemu-devel] [PATCH 5/8] io: add ability to associate an error
 with a task
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
--MB4JVVWAVLFUxcRvIWUeqxukTx2IPL9r0
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <73e36ee2-081e-4298-bf5b-411cc8d247b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/8] io: add ability to associate an error
 with a task
References: <20170105160321.21786-1-berrange@redhat.com>
 <20170105160321.21786-6-berrange@redhat.com>
In-Reply-To: <20170105160321.21786-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> Currently when a task fails, the error is never explicitly
> associated with the task object, it is just passed along
> through the completion callback. This adds ability to

s/adds/adds the/

> explicitly associate an error with the task.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/task.h | 29 +++++++++++++++++++++++++++++
>  io/task.c         | 23 +++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>=20
> diff --git a/include/io/task.h b/include/io/task.h
> index ece1372..244c1a1 100644
> --- a/include/io/task.h
> +++ b/include/io/task.h
> @@ -240,6 +240,35 @@ void qio_task_abort(QIOTask *task,
> =20
> =20
>  /**
> + * qio_task_set_error:
> + * @task: the task struct
> + * @err: pointer to the error
> + *
> + * Associate an error with the task, which can later
> + * be retrieved with the qio_task_propagate_error()
> + * method. This method takes ownership of @err, so
> + * it is not valid to access it after this call
> + * completes.
> + */
> +void qio_task_set_error(QIOTask *task,
> +                        Error *err);

Is it valid for @err to be NULL (or put another way, may callers blindly
call this function whether or not an error has occurred)?...

> +
> +
> +/**
> + * qio_task_propagate_error:
> + * @task: the task struct
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Propagate the error associated with @task
> + * into @errp.
> + *
> + * Returns: true if an error was propagated, false otherwise
> + */
> +gboolean qio_task_propagate_error(QIOTask *task,

Must this return 'gboolean' (in which case the docs should mention
TRUE/FALSE rather than true/false)? Or can we make it return the nicer
'bool'?

> +                                  Error **errp);
> +
> +
> +/**
>   * qio_task_set_result_pointer:
>   * @task: the task struct
>   * @result: pointer to the result data
> diff --git a/io/task.c b/io/task.c
> index 675e196..1136c75 100644
> --- a/io/task.c
> +++ b/io/task.c
> @@ -29,6 +29,7 @@ struct QIOTask {
>      QIOTaskFunc func;
>      gpointer opaque;
>      GDestroyNotify destroy;
> +    Error *err;
>      gpointer result;
>      GDestroyNotify destroyResult;
>  };
> @@ -62,6 +63,9 @@ static void qio_task_free(QIOTask *task)
>      if (task->destroyResult) {
>          task->destroyResult(task->result);
>      }
> +    if (task->err) {
> +        error_free(task->err);
> +    }
>      object_unref(task->source);
> =20
>      g_free(task);
> @@ -159,6 +163,25 @@ void qio_task_abort(QIOTask *task,
>  }
> =20
> =20
> +void qio_task_set_error(QIOTask *task,
> +                        Error *err)
> +{
> +    error_propagate(&task->err, err);

=2E..As written, qio_task_set_error(task, NULL) is thus valid as a no-op;=

and in turn, qio_task_set_error(task, err) is unconditionally valid a
cleanup path regardless of whether the cleanup was reached on success
(err is still NULL) or failure (err is set).  But it's worth documenting.=


In fact, error_propagate() can be called more than once (first call
wins, all later calls silently drop the subsequent error in favor of a
first one already present), and therefore qio_task_set_error() gains
that same property.  Worth documenting?


> +}
> +
> +
> +gboolean qio_task_propagate_error(QIOTask *task,
> +                                  Error **errp)
> +{
> +    if (task->err) {
> +        error_propagate(errp, task->err);
> +        return TRUE;
> +    }
> +
> +    return FALSE;

Again, I think a 'bool' return (and true/false) is nicer.

> +}
> +
> +
>  void qio_task_set_result_pointer(QIOTask *task,
>                                   gpointer result,
>                                   GDestroyNotify destroy)
>=20

The idea makes sense, though.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MB4JVVWAVLFUxcRvIWUeqxukTx2IPL9r0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbrSMAAoJEKeha0olJ0NqdckH+waY8LM1gzkJlIKHUfDot60m
xCqmcqLwnUExvmUSHaXLVq0N4y3regByHegoXwddYLbzk9YjC5wLtKyIf+ux59fE
seGZGsJT6tUe7OaXGQ1YN/dvgi+2uoDUxYMuKtS9SpPDU28PtrFoEJNsUTKHTDUt
3iPBwQqQrWpky0/DxCXXmIDRsJu0w1/+df0T50IIkRPI9DZfbHIs2NU9mhNpQZN+
VTEBrIPi5Tf+Ez+6bBiBGRJ/BYd2Tp3j8wc9G8Sx8UR0fbIvmsiZaOMO5Zx53VqX
TjiAACoNF+agi5uj95oZc/ZS7XC5ATo2DRXb825iTnf8/hTYeyGBTh91kDHlkHU=
=IlFn
-----END PGP SIGNATURE-----

--MB4JVVWAVLFUxcRvIWUeqxukTx2IPL9r0--

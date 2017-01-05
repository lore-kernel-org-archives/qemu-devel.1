Received: from eggs.gnu.org ([2001:4830:134:3::10]:55427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPFtD-0008O9-Lw
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPFtA-0004ZV-F4
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:48:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPFtA-0004ZR-5B
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:48:00 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C81118EB3B
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 21:47:59 +0000 (UTC)
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-7-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51fbdc69-0704-19bd-28b9-fc2310ee2e44@redhat.com>
Date: Thu, 5 Jan 2017 15:47:57 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160321.21786-7-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rs0DQBrqTQEnSLSC0CrGP8QkKxDKOS59V"
Subject: Re: [Qemu-devel] [PATCH 6/8] io: change the QIOTask callback
 signature
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
--rs0DQBrqTQEnSLSC0CrGP8QkKxDKOS59V
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <51fbdc69-0704-19bd-28b9-fc2310ee2e44@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/8] io: change the QIOTask callback
 signature
References: <20170105160321.21786-1-berrange@redhat.com>
 <20170105160321.21786-7-berrange@redhat.com>
In-Reply-To: <20170105160321.21786-7-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> Currently the QIOTaskFunc signature takes an Object * for
> the source, and an Error * for any error. We also need to
> be able to provide a result pointer. Rather than continue
> to add parameters to QIOTaskFunc, remove the existing
> ones and simply pass the QIOTask object instead. This
> has methods to access all the other data items required
> in the callback impl.

Hmmm. If you're going to change the callback signature after all, then
is it worth considering having the callback return void* instead of the
clunky way of passing the result pointer around, with existing callers
updated to return NULL if they have nothing better to do?  Accessing the
error pointer through the QIOTask object seems okay, it's just the
return type that feels clunky.

But that's bike-shedding, so I'll review as written.

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/task.h              | 73 ++++++++++++++++++++++++----------=
--------
>  io/channel-tls.c               | 14 ++++----
>  io/channel-websock.c           |  8 ++---
>  io/task.c                      | 18 +++--------
>  io/trace-events                |  1 -
>  migration/socket.c             | 11 ++++---
>  migration/tls.c                | 19 +++++------
>  nbd/common.c                   |  8 ++---
>  nbd/nbd-internal.h             |  3 +-
>  qemu-char.c                    | 18 ++++++-----
>  tests/test-io-channel-socket.c |  5 ++-
>  tests/test-io-channel-tls.c    |  5 ++-
>  tests/test-io-task.c           | 18 +++++------
>  ui/vnc-auth-vencrypt.c         |  7 ++--
>  ui/vnc-ws.c                    | 14 ++++----
>  15 files changed, 110 insertions(+), 112 deletions(-)
>=20
> diff --git a/include/io/task.h b/include/io/task.h
> index 244c1a1..7b5bc43 100644
> --- a/include/io/task.h
> +++ b/include/io/task.h
> @@ -26,8 +26,7 @@
> =20
>  typedef struct QIOTask QIOTask;
> =20
> -typedef void (*QIOTaskFunc)(Object *source,
> -                            Error *err,
> +typedef void (*QIOTaskFunc)(QIOTask *task,
>                              gpointer opaque);
> =20

>   *
> - * Now, lets say the implementation of this method wants to set
> - * a timer to run once a second checking for completion of some
> - * activity. It would do something like
> + * When the operation completes, the 'func' callback will be
> + * invoked, allowing the calling code to determine the result
> + * of the operation. An example QIOTaskFunc impl may look

Worth spelling out 'implementation' in the docs?

> + * like
>   *
>   * <example>
> - *   <title>Task callback function implementation</title>
> + *   <title>Task callback implementation</title>
> + *   <programlisting>
> + *  static void myobject_operation_notify(QIOTask *task,
> + *                                        gpointer opaque)
> + *  {
> + *      Error *err =3D NULL;
> + *      if (qio_task_propagate_error(task, &err)) {
> + *          ...deal with the failure...
> + *          error_free(err);
> + *      } else {
> + *          QMyObject *src =3D QMY_OBJECT(qio_task_get_source(task));
> + *          ...deal with the completion...
> + *      }
> + *  }
> + *   </programlisting>
> + * </example>
> + *
> + * Now, lets say the implementation of the method using the
> + * task wants to set a timer to run once a second checking
> + * for completion of some  activity. It would do something

Why two spaces after 'some'?

> + * like
> + *
> + * <example>
> + *   <title>Task function implementation</title>
>   *   <programlisting>
>   *    void myobject_operation(QMyObject *obj,
>   *                            QIOTaskFunc *func,
> @@ -102,8 +125,8 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
>   *
>   *      ...check something important...
>   *       if (err) {
> - *           qio_task_abort(task, err);
> - *           error_free(task);
> + *           qio_task_set_error(task, err);
> + *           qio_task_complete(task);

Interesting - by storing the error object directly in the task, you no
longer have to special-case task abort vs. complete (rather, the
notifier checks whether the task completed successfully or in error).

>   *           return FALSE;
>   *       } else if (...work is completed ...) {
>   *           qio_task_complete(task);
> @@ -115,6 +138,10 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
>   *   </programlisting>
>   * </example>
>   *
> + * The 'qio_task_complete' call in this method will trigger
> + * the callback func 'myobject_operation_notify' shown
> + * earlier to deal with the results.
> + *
>   * Once this function returns false, object_unref will be called
>   * automatically on the task causing it to be released and the
>   * ref on QMyObject dropped too.
> @@ -187,8 +214,8 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
>   * 'err' attribute in the task object to determine if
>   * the operation was successful or not.
>   *
> - * The returned task will be released when one of
> - * qio_task_abort() or qio_task_complete() are invoked.
> + * The returned task will be released when qio_task_complete()
> + * is invoked.
>   *
>   * Returns: the task struct
>   */
> @@ -204,10 +231,8 @@ QIOTask *qio_task_new(Object *source,
>   * @opaque: opaque data to pass to @worker
>   * @destroy: function to free @opaque
>   *
> - * Run a task in a background thread. If @worker
> - * returns 0 it will call qio_task_complete() in
> - * the main event thread context. If @worker
> - * returns -1 it will call qio_task_abort() in
> + * Run a task in a background thread. When @worker
> + * returns it will call qio_task_complete() in
>   * the main event thread context.
>   */
>  void qio_task_run_in_thread(QIOTask *task,
> @@ -219,25 +244,11 @@ void qio_task_run_in_thread(QIOTask *task,
>   * qio_task_complete:
>   * @task: the task struct
>   *
> - * Mark the operation as successfully completed
> - * and free the memory for @task.
> + * Invoke the completion callback for @task and
> + * then free its memory.
>   */
>  void qio_task_complete(QIOTask *task);
> =20
> -/**
> - * qio_task_abort:
> - * @task: the task struct
> - * @err: the error to record for the operation
> - *
> - * Mark the operation as failed, with @err providing
> - * details about the failure. The @err may be freed
> - * afer the function returns, as the notification

And you're eliminating a typo :)

> - * callback is invoked synchronously. The @task will
> - * be freed when this call completes.
> - */
> -void qio_task_abort(QIOTask *task,
> -                    Error *err);
> -
> =20
>  /**
>   * qio_task_set_error:
> diff --git a/io/channel-tls.c b/io/channel-tls.c
> index cf3bcca..f25ab0a 100644
> --- a/io/channel-tls.c

> +++ b/tests/test-io-channel-socket.c
> @@ -156,12 +156,11 @@ struct TestIOChannelData {
>  };
> =20
> =20
> -static void test_io_channel_complete(Object *src,
> -                                     Error *err,
> +static void test_io_channel_complete(QIOTask *task,
>                                       gpointer opaque)
>  {
>      struct TestIOChannelData *data =3D opaque;
> -    data->err =3D err !=3D NULL;
> +    data->err =3D qio_task_propagate_error(task, NULL);

Cool way to ignore and free task->err while still tracking if it had
captured an error.  I had to go re-read patch 5/8 to make sure this did
the right thing.

I'm still not sure if there is a better signature to be using, but as
written, your conversion to your choice of signature looks correct
(modulo nits I pointed out above), so you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rs0DQBrqTQEnSLSC0CrGP8QkKxDKOS59V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbr8NAAoJEKeha0olJ0Nqzl8H/iISsCy5eiA0Nh1wiksX7AcB
zLexQEtwZs7XXqDTdMudgreZYLYGgZIlLb0cL4wZD7xJCy0yzinza5iQboVeCkDU
9015u2fqdN+9e4PZw+B8jinx3GIQhMJKAWclSMIPSf6J4fai5NKQrbF0Bp+Pt86/
S50CocMXSABvLt7V42ZDCmd5Ct1UfxdhL2omwvmVbo1/QqaAZTrYIIIKmif34xYm
MN1yx+D5hlZiVPUnkv8LcytC65LdZL8J0Ldtukg+caduIPPTnqs2RTZ8M7JNi7pi
npmuwfeo5cc9Qj8dpwemQmTryMfpcw54V1b66uvA7ju+ZnXNgi1NQXdU9clZnm4=
=0sh1
-----END PGP SIGNATURE-----

--rs0DQBrqTQEnSLSC0CrGP8QkKxDKOS59V--

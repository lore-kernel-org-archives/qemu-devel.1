Received: from eggs.gnu.org ([209.51.188.92]:56566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gx9dU-0000t5-KS
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gx9dT-0000LG-Mo
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gx9dT-00009k-D1
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:08:59 -0500
Date: Fri, 22 Feb 2019 12:08:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190222120846.GN25234@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1550836631.git.berto@igalia.com>
	<0df0773f716140fec012d6778220b8a07067a5c6.1550836631.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0df0773f716140fec012d6778220b8a07067a5c6.1550836631.git.berto@igalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] main-loop: Fix GSource leak in
 qio_task_thread_worker()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

In $SUBJECT  s/main-loop/io/

On Fri, Feb 22, 2019 at 01:59:10PM +0200, Alberto Garcia wrote:
> After g_source_attach() the GMainContext holds a reference to the
> GSource, so the caller does not need to keep it.
>=20
> qio_task_thread_worker() is not releasing its reference so the GSource
> is being leaked since a17536c594bfed94d05667b419f747b692f5fc7f.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  io/task.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/io/task.c b/io/task.c
> index 64c4c7126a..1ae7b86488 100644
> --- a/io/task.c
> +++ b/io/task.c
> @@ -136,6 +136,7 @@ static gpointer qio_task_thread_worker(gpointer opa=
que)
>                            qio_task_thread_result, task, NULL);
>      g_source_attach(task->thread->completion,
>                      task->thread->context);
> +    g_source_unref(task->thread->completion);
>      trace_qio_task_thread_source_attach(task, task->thread->completion=
);
> =20
>      qemu_cond_signal(&task->thread_cond);

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
=20
Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

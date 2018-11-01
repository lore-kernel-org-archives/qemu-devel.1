Received: from eggs.gnu.org ([2001:4830:134:3::10]:40912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gIAjz-0002u7-Pm
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gIAjy-0001Cq-LV
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:02:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gIAjy-0001CL-Eu
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:02:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id l2-v6so979753wmh.3
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 04:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <1541069086-167036-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1541069086-167036-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 1 Nov 2018 15:02:04 +0400
Message-ID: <CAJ+F1CKE56kB+RokaNBwy1zB=xEeo-UaXgqp2-poMsprzY9Osw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ivshmem: fix memory backend leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Nov 1, 2018 at 2:53 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> object_new() returns a new backend with refcount =3D=3D 1 and
> then later object_property_add_child() increases refcount to 2
> So when ivshmem is desroyed, the backend it has created isn't
> destroyed along with it as children cleanup will bring
> backend's refcount only to 1, which leaks backend including
> resources it is using.
>
> Drop the original reference from object_new() once backend
> is attached to its parent.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

I would rather have the unref in finalize, but that is ok too.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/misc/ivshmem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index f88910e..ecfd10a 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -1279,6 +1279,7 @@ static void desugar_shm(IVShmemState *s)
>      object_property_set_bool(obj, true, "share", &error_abort);
>      object_property_add_child(OBJECT(s), "internal-shm-backend", obj,
>                                &error_abort);
> +    object_unref(obj);
>      user_creatable_complete(obj, &error_abort);
>      s->hostmem =3D MEMORY_BACKEND(obj);
>  }
> --
> 2.7.4
>
>


--=20
Marc-Andr=C3=A9 Lureau

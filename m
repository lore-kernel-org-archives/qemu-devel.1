Received: from eggs.gnu.org ([2001:4830:134:3::10]:37021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKSSw-00025N-S9
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKSGn-0006Wv-UR
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:09:38 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gKSGn-000602-MS
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:09:37 -0500
Received: by mail-wm1-x343.google.com with SMTP id b203-v6so16649674wme.5
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 10:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-3-berrange@redhat.com>
In-Reply-To: <20181019133835.16494-3-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 7 Nov 2018 22:09:11 +0400
Message-ID: <CAJ+F1CKZK=aOtHFQJ7EiSuHRzc5SKw1y1hJpxFYFTh3ddgtMpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 02/11] qom: don't require user creatable
 objects to be registered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, philmd@redhat.com

On Fri, Oct 19, 2018 at 5:39 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> When an object is in turn owned by another user object, it is not
> desirable to expose this in the QOM object hierarchy, as it is
> just an internal implementation detail, we should be free to change
> without exposure.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qom/object.c            | 12 ++++++++----
>  qom/object_interfaces.c | 16 ++++++++++------
>  2 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 547dcf97c3..f20f0c45a7 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -607,15 +607,19 @@ Object *object_new_with_propv(const char *typename,
>          goto error;
>      }
>
> -    object_property_add_child(parent, id, obj, &local_err);
> -    if (local_err) {
> -        goto error;
> +    if (id !=3D NULL) {
> +        object_property_add_child(parent, id, obj, &local_err);
> +        if (local_err) {
> +            goto error;
> +        }
>      }
>
>      if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
>          user_creatable_complete(obj, &local_err);
>          if (local_err) {
> -            object_unparent(obj);
> +            if (id !=3D NULL) {
> +                object_unparent(obj);
> +            }
>              goto error;
>          }
>      }
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 941fd63afd..94d5f91d69 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -83,16 +83,20 @@ Object *user_creatable_add_type(const char *type, con=
st char *id,
>          goto out;
>      }
>
> -    object_property_add_child(object_get_objects_root(),
> -                              id, obj, &local_err);
> -    if (local_err) {
> -        goto out;
> +    if (id !=3D NULL) {
> +        object_property_add_child(object_get_objects_root(),
> +                                  id, obj, &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
>      }
>
>      user_creatable_complete(obj, &local_err);
>      if (local_err) {
> -        object_property_del(object_get_objects_root(),
> -                            id, &error_abort);
> +        if (id !=3D NULL) {
> +            object_property_del(object_get_objects_root(),
> +                                id, &error_abort);
> +        }
>          goto out;
>      }
>  out:
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

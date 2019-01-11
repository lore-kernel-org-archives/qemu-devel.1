Received: from eggs.gnu.org ([209.51.188.92]:53947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ghugZ-0008Nc-Gc
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ghugX-0002eY-Om
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:09:10 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ghugX-0002eM-LB
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:09:09 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so18362720qtc.2
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 03:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20190110180458.18762-1-ehabkost@redhat.com>
	<20190110180458.18762-2-ehabkost@redhat.com>
In-Reply-To: <20190110180458.18762-2-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Jan 2019 15:08:57 +0400
Message-ID: <CAMxuvawp=HzfpFyWpu6dLsGvSOykfLqSVaQN_J8a=mV34fVJGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] globals: Allow global properties to
 be optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>

Hi

On Thu, Jan 10, 2019 at 10:05 PM Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
>
> Making some global properties optional will let us simplify
> compat code when a given property works on most (but not all)
> subclasses of a given type.
>
> Device types will be able to opt out from optional compat
> properties by simply not registering those properties.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v2 -> v3:
> * Don't ignore all errors, ignore property only if it doesn't
>   exist
>
> Changes v1 -> v2:
> * (new patch)
>
> Note: the "An error is fatal for non-hotplugged devices [...]"
> comment that appears in the diff scope is inaccurate, but I will
> fix that in a separate patch because I don't want this to get
> into the way of fixing the crash.
> ---
>  include/hw/qdev-core.h | 3 +++
>  qom/object.c           | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index bc014c1c9f..29874c8611 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -250,6 +250,8 @@ struct PropertyInfo {
>  /**
>   * GlobalProperty:
>   * @used: Set to true if property was used when initializing a device.
> + * @optional: If set to true, GlobalProperty will be skipped without err=
ors
> + *            if the property doesn't exist.
>   *
>   * An error is fatal for non-hotplugged devices, when the global is appl=
ied.
>   */
> @@ -258,6 +260,7 @@ typedef struct GlobalProperty {
>      const char *property;
>      const char *value;
>      bool used;
> +    bool optional;

with optional/skip_if_missing

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>  } GlobalProperty;
>
>  static inline void
> diff --git a/qom/object.c b/qom/object.c
> index 4e5226ca12..b8c732063b 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -385,6 +385,9 @@ void object_apply_global_props(Object *obj, const GPt=
rArray *props, Error **errp
>          if (object_dynamic_cast(obj, p->driver) =3D=3D NULL) {
>              continue;
>          }
> +        if (p->optional && !object_property_find(obj, p->property, NULL)=
) {
> +            continue;
> +        }
>          p->used =3D true;
>          object_property_parse(obj, p->value, p->property, &err);
>          if (err !=3D NULL) {
> --
> 2.18.0.rc1.1.g3f1ff2140
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciNOP-0002Uv-RY
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciNOO-0005Pb-Uw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:39:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciNOO-0005PP-Ov
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:39:16 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B42638123E
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:39:16 +0000 (UTC)
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
	<20170227134202.2991-6-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62892df9-9e1e-8e4c-c4f0-f3c6cf0422c7@redhat.com>
Date: Mon, 27 Feb 2017 16:39:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170227134202.2991-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/21] char: add a /chardevs container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 27/02/2017 14:41, Marc-Andr=C3=A9 Lureau wrote:
> =20
> -    chr =3D CHARDEV(object_new(typename));
> +    if (id) {
> +        obj =3D object_new_with_props(typename, get_chardevs_root(),
> +                                    id, &local_err, NULL);
> +    } else {
> +        obj =3D object_new(typename);
> +    }

I think you should open code object_new_with_props.  This can be just
object_new(typename)...

> +    if (local_err) {
> +        assert(!obj);
> +        goto end;
> +    }
> +
> +    chr =3D CHARDEV(obj);
>      chr->label =3D g_strdup(id);
> =20
>      qemu_char_open(chr, backend, &be_opened, &local_err);
>      if (local_err) {
> -        error_propagate(errp, local_err);
> -        object_unref(OBJECT(chr));
> -        return NULL;
> +        goto end;
>      }
> =20
>      if (!chr->filename) {
> @@ -1250,6 +1263,18 @@ Chardev *qemu_chardev_new(const char *id, const =
char *typename,
>          qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>      }
> =20
> +end:
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        if (chr) {
> +            if (id) {
> +                object_unparent(OBJECT(chr));
> +            } else {
> +                object_unref(OBJECT(chr));
> +            }

Then here you do not have a parent object and you can do only unref...

> +        }
> +        return NULL;
> +    }

... while here you do the object_property_add_child+object_unref.  The
object_property_add_child keeps the object alive, while object_unref
drops the reference originally returned by object_new.

Paolo

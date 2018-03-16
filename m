Received: from eggs.gnu.org ([2001:4830:134:3::10]:46423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtk9-0005TD-D2
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtk5-0000Bq-G4
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:06:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewtk5-0000BS-Bt
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:06:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F16CA40201A3
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 18:06:12 +0000 (UTC)
Date: Fri, 16 Mar 2018 18:06:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316180606.GI3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
	<20180316115403.4148-13-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316115403.4148-13-quintela@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 12/15] migration: Transmit initial
 package through the multifd channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Fri, Mar 16, 2018 at 12:54:00PM +0100, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> --
>=20
> Be network agnostic.
> Add error checking for all values.
> ---
>  migration/ram.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
>  1 file changed, 92 insertions(+), 5 deletions(-)
>=20


> +static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
> +{
> +    MultiFDInit_t msg;
> +    int ret;
> +
> +    ret =3D qio_channel_read_all(c, (char *)&msg, sizeof(msg), errp);
> +    if (ret !=3D 0) {
> +        return -1;
> +    }
> +
> +    be32_to_cpus(&msg.magic);
> +    be32_to_cpus(&msg.version);
> +
> +    if (msg.magic !=3D MULTIFD_MAGIC) {
> +        error_setg(errp, "multifd: recevied packet magic %d "

s/recevied/received/

and in few places below too

> +                   "expected %d", msg.magic, MULTIFD_MAGIC);
> +        return -1;
> +    }
> +
> +    if (msg.version !=3D MULTIFD_VERSION) {
> +        error_setg(errp, "multifd: recevied packet version %d "
> +                   "expected %d", msg.version, MULTIFD_VERSION);
> +        return -1;
> +    }
> +
> +    if (memcmp(msg.uuid, &qemu_uuid, sizeof(qemu_uuid))) {
> +        char *uuid =3D qemu_uuid_unparse_strdup(&qemu_uuid);
> +        error_setg(errp, "multifd: received uuid '%s' and expected "
> +                   "uuid '%s' for channel %hhd", msg.uuid, uuid, msg.i=
d);
> +        g_free(uuid);
> +        return -1;
> +    }
> +
> +    if (msg.id > migrate_multifd_channels()) {
> +        error_setg(errp, "multifd: recevied channel version %d "
> +                   "expected %d", msg.version, MULTIFD_VERSION);
> +        return -1;
> +    }
> +
> +    return msg.id;
> +}

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

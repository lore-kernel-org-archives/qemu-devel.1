Received: from eggs.gnu.org ([2001:4830:134:3::10]:54864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePA03-00010q-Se
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP9zz-0008Ca-Rt
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:35:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eP9zz-0008B3-Ix
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:35:11 -0500
Date: Wed, 13 Dec 2017 16:35:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213163500.GA8317@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-11-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 10/26] monitor: allow to use IO thread for
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:44PM +0800, Peter Xu wrote:
> @@ -583,6 +585,7 @@ static void monitor_data_init(Monitor *mon, bool skip=
_flush)
>      /* Use *mon_cmds by default. */
>      mon->cmd_table =3D mon_cmds;
>      mon->skip_flush =3D skip_flush;
> +    mon->use_io_thr =3D use_io_thr;

Why is mon->use_io_thr is a field instead of a monitor_init() argument.

> @@ -4117,19 +4121,37 @@ void monitor_init(Chardev *chr, int flags)
>          monitor_read_command(mon, 0);
>      }
> =20
> +    if (mon->use_io_thr) {
> +        /*
> +         * When use_io_thr is set, we use the global shared dedicated
> +         * IO thread for this monitor to handle input/output.
> +         */
> +        context =3D monitor_io_context_get();
> +        /* We should have inited globals before reaching here. */
> +        assert(context);
> +    } else {
> +        /* The default main loop, which is the main thread */
> +        context =3D NULL;
> +    }
> +
> +    /*
> +     * Add the monitor before running it (which is triggered by
> +     * qemu_chr_fe_set_handlers), otherwise one monitor may find
> +     * itself not on the mon_list when running.
> +     */
> +    qemu_mutex_lock(&monitor_lock);
> +    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
> +    qemu_mutex_unlock(&monitor_lock);
> +
>      if (monitor_is_qmp(mon)) {
>          qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qm=
p_read,
> -                                 monitor_qmp_event, NULL, mon, NULL, tru=
e);
> +                                 monitor_qmp_event, NULL, mon, context, =
true);
>          qemu_chr_fe_set_echo(&mon->chr, true);
>          json_message_parser_init(&mon->qmp.parser, handle_qmp_command, m=
on);

The comment above mentions the race condition between
qemu_chr_fe_set_handlers() and mon_list.  I think that means the order
must be:

  json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon);
  qemu_chr_fe_set_echo(&mon->chr, true);
  qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
                           monitor_qmp_event, NULL, mon, context, true);

>      } else {

assert(!context);  /* HMP does not support IOThreads */

>          qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_re=
ad,
>                                   monitor_event, NULL, mon, NULL, true);
>      }
> -
> -    qemu_mutex_lock(&monitor_lock);
> -    QLIST_INSERT_HEAD(&mon_list, mon, entry);
> -    qemu_mutex_unlock(&monitor_lock);
>  }
> =20
>  void monitor_cleanup(void)
> --=20
> 2.14.3
>=20

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMVa0AAoJEJykq7OBq3PIecsH/AoRGpD7MrKWBaAwmG0CscVf
ZZVmqRIs5HmfIOwG314itm0j6DZsvpiFj1ejsbmwCu//RuOmS3Qj13ZDqyKrQcc3
+uWO8Coex68RGZVXhhaIvai7x1VVp37uAv/+6DjZBRQ0SN0586F11cnaYNjWppqs
7a/Ogn+5QZjYNXU5hhvQrKIJFpptmQl/XuuBeWzYcAzFRSLxfE30oGL89b40wumQ
GBv90kjV1SOIR2WpAPZue6kYfD/uG3opLDYyed7YAn/IVNpLYyWY4S3vOiK7aKFV
GwBJV/Bc4QfzG7XmcPJReOetppY5qQ6C/McV0g8PiU84y95ogXMmPKNuo0HLVWA=
=MSeS
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

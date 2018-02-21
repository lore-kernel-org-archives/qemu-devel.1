Received: from eggs.gnu.org ([2001:4830:134:3::10]:45800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoWoZ-0005DJ-3v
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:00:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoWoU-0000hn-GS
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:00:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoWoU-0000fx-BD
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:00:10 -0500
Date: Wed, 21 Feb 2018 16:00:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221160007.GA21436@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-10-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 09/23] monitor: allow using IO thread
 for parsing
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


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 01:39:43PM +0800, Peter Xu wrote:
> @@ -4034,12 +4044,29 @@ static void sortcmdlist(void)
>      qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
>  }
> =20
> +static GMainContext *monitor_io_context_get(void)
> +{
> +    return iothread_get_g_main_context(mon_global.mon_iothread);
> +}
> +
> +static AioContext *monitor_aio_context_get(void)
> +{
> +    return iothread_get_aio_context(mon_global.mon_iothread);
> +}

Please follow the X_get_Y() naming convention instead of X_Y_get().  For
example, see qemu_get_aio_context() and iothread_get_aio_context().

> @@ -4082,11 +4109,41 @@ void error_vprintf_unless_qmp(const char *fmt, va=
_list ap)
>      }
>  }
> =20
> +static void monitor_list_append(Monitor *mon)
> +{
> +    qemu_mutex_lock(&monitor_lock);
> +    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
> +    qemu_mutex_unlock(&monitor_lock);
> +}
> +
> +static void monitor_qmp_setup_handlers(void *data)

BH functions are usually declared like this:

  static void X_bh(void *opaque)

This way it's immediately clear that this function is invoked as a BH.

I suggest renaming the function to monitor_qmp_setup_handlers_bh().
Using 'opaque' instead of 'data' is common, too.

> @@ -4099,24 +4156,55 @@ void monitor_init(Chardev *chr, int flags)
>      }
> =20
>      if (monitor_is_qmp(mon)) {
> -        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qm=
p_read,
> -                                 monitor_qmp_event, NULL, mon, NULL, tru=
e);
>          qemu_chr_fe_set_echo(&mon->chr, true);
>          json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
> +        if (mon->use_io_thr) {
> +            /*
> +             * It's possible that we already have an IOWatchPoll
> +             * registered for the Chardev during chardev_init_func().

When does this happen?

This seems like a hack that breaks when certain -chardev options are
used.  For example, what happens if the chardev is a TCP connection with
reconnect=3D5.  In that case the socket will be connecting asynchronously
and we cannot just remove the fd watch.

How does this interact with TCP listen chardevs?  It looks like the
listener socket uses the main loop (see tcp_chr_disconnect()).

I'm worried that the chardev layer isn't thread-safe and you haven't
added anything to protect it or at least refuse to run in unsafe
conditions.

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajZeHAAoJEJykq7OBq3PIxpUH/1W1GCQ4E9rvGhksYwc8QNwU
3CMNDHnBEhfw2mKf+00wou3CpcGQ+RHGhQts1fAlYOKITxvePTKZTbcIsr8KJ98O
IO0coKeq8FgDd4aeejkxhnsob2Pd5NUrgOgtjdCNYcNxQxTajte4FNzgSwMH+M9c
TSTeIGpM7XPL6ex8Ml/8axet6PzEOXr7MC130QTItC9CanWIHplc8GOyenMPsacl
lqHT27I7nAp4U2YltmZ4e6bjYscaPn4cjq892K6QG5yebWQ6ZrhPLjj00G0cxhVZ
pQ0mHUgoH3qZa7rlPq1WukJZPoa7cG1jirJn3C42xrulQPq5G0sP/90rceOZ06w=
=B27A
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

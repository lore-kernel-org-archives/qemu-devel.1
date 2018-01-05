Received: from eggs.gnu.org ([2001:4830:134:3::10]:59521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXVhc-0004Of-Dg
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXVhZ-0002jO-8K
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:22:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eXVhY-0002i5-St
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:22:41 -0500
Date: Fri, 5 Jan 2018 17:22:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180105172226.GL28322@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mit9XoPEfICDqq/V"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-11-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 10/27] monitor: allow to use IO thread for
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


--Mit9XoPEfICDqq/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 19, 2017 at 04:45:40PM +0800, Peter Xu wrote:
>      if (monitor_is_qmp(mon)) {
> -        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
> -                                 monitor_qmp_event, NULL, mon, NULL, true);
>          qemu_chr_fe_set_echo(&mon->chr, true);
>          json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
> +        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
> +                                 monitor_qmp_event, NULL, mon, context, true);
>      } else {
> +        assert(!context);       /* HMP does not support IOThreads */
>          qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
>                                   monitor_event, NULL, mon, NULL, true);
>      }

qemu_chr_fe_set_handlers() isn't thread-safe.  It looks like
monitor_can_read()/monitor_qmp_read() can run in the IOThread at the
same time as monitor_qmp_event() runs in the main loop:

  void qemu_chr_fe_set_handlers(CharBackend *b,
                                IOCanReadHandler *fd_can_read,
                                IOReadHandler *fd_read,
                                IOEventHandler *fd_event,
                                BackendChangeHandler *be_change,
                                void *opaque,
                                GMainContext *context,
                                bool set_open)
  {
      ...

      qemu_chr_be_update_read_handlers(s, context);
        ^-- The IOThread may invoke handler functions from now on!

      <-- Everything below races with the IOThread!

      if (set_open) {
          qemu_chr_fe_set_open(b, fe_open);
      }

      if (fe_open) {
          qemu_chr_fe_take_focus(b);
          /* We're connecting to an already opened device, so let's make sure we
             also get the open event */
          if (s->be_open) {
              qemu_chr_be_event(s, CHR_EVENT_OPENED);
          }
      }

      if (CHARDEV_IS_MUX(s)) {
          mux_chr_set_handlers(s, context);
      }
  }

It looks like chr_*() functions must be called from the event loop
thread that monitors the chardev.  You can use aio_bh_schedule_oneshot()
or g_idle_source_new() to execute the last part of monitor_init() in the
GMainContext.

That way there is no race condition because qemu_chr_fe_set_handlers()
is called from within the event loop thread.

--Mit9XoPEfICDqq/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaT7RSAAoJEJykq7OBq3PIhqwH/3PLjEcl7zkDdlh5ZxcCTE6m
fLSHLSU71kw78i1zgISnfq7aYyX2x4rvWszjQsM3AFM8q+khk2IUlsxD5rYuwx1M
9gZu9Fr1bXYfi+heqmw2esWc6BEmYJuN6gccfjg1McYxQyH+d0Eg35VA1VPH6ev5
5MujUWyQBPTliG5VfgPB9Bfr/s2uh6zhAgeLW2lnHABMN60/uOuWmirZuylBxXQx
6juU5GY5ywBxNCJze7KAH/t9qvvmphqNyNhpWSm4T4fb3g2/e5xNXlKAj3xYpwbk
JPINTFVH0iMKA9vFCxafquDWdSwMH0S4ajWyr60Trl7uBwyn9UKefa4EwQyxu9g=
=VNJJ
-----END PGP SIGNATURE-----

--Mit9XoPEfICDqq/V--

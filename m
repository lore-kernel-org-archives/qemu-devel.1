Received: from eggs.gnu.org ([2001:4830:134:3::10]:39535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ35f-0006Og-Bj
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ35c-0006gM-Ld
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:13:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21619)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZ35c-0006fw-CI
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:13:52 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-8-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab1775ac-be60-31cb-3c7c-c698c2adb1e8@redhat.com>
Date: Tue, 9 Jan 2018 17:13:40 -0600
MIME-Version: 1.0
In-Reply-To: <20171219084557.9801-8-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4YOQIWTtfWbzqkj8IqLCMnOvK05fJIuFv"
Subject: Re: [Qemu-devel] [RFC v6 07/27] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4YOQIWTtfWbzqkj8IqLCMnOvK05fJIuFv
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <ab1775ac-be60-31cb-3c7c-c698c2adb1e8@redhat.com>
Subject: Re: [RFC v6 07/27] monitor: unify global init
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-8-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-8-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2017 02:45 AM, Peter Xu wrote:
> There are many places for monitor init its globals, at least:

Reads awkwardly; maybe:

=2E..many places where the monitor initializes its globals,...

>=20
> - monitor_init_qmp_commands() at the very beginning
> - single function to init monitor_lock
> - in the first entry of monitor_init() using "is_first_init"
>=20
> Unify them a bit.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

> +void monitor_init_globals(void)
> +{
> +    monitor_init_qmp_commands();
> +    monitor_qapi_event_init();
> +    sortcmdlist();
> +    qemu_mutex_init(&monitor_lock);
> +}
> +
>  /* These functions just adapt the readline interface in a typesafe way=
=2E  We
>   * could cast function pointers but that discards compiler checks.
>   */
> @@ -4074,23 +4082,10 @@ void error_vprintf_unless_qmp(const char *fmt, =
va_list ap)
>      }
>  }
> =20
> -static void __attribute__((constructor)) monitor_lock_init(void)
> -{
> -    qemu_mutex_init(&monitor_lock);
> -}

The later initialization of the monitor_lock mutex is a potential
semantic change.  Please beef up the commit message to document why it
is safe.  In fact, I requested this back on my review of v1, but it
still hasn't been done. :(

https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg05421.html

If my read of history is correct, I think it is sufficient to point to
commit 05875687 as a place where we no longer care about constructor
semantics because we are no longer dealing with module_call_init().  But
you may find a better place to point to.  You already found that
d622cb587 was what introduced the constructor in the first place, but I
didn't spend time today auditing the state of qemu back at that time to
see if the constructor was really necessary back then or just a
convenience for lack of a better initialization point.

Alternatively, if you can't find a good commit message to point to, at
least document how you (and I) tested things, using gdb watchpoints, to
prove it is a safe delay.

Only if you improve the commit message, you may add:
Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/vl.c
> @@ -3099,7 +3099,6 @@ int main(int argc, char **argv, char **envp)
>      qemu_init_exec_dir(argv[0]);
> =20
>      module_call_init(MODULE_INIT_QOM);
> -    monitor_init_qmp_commands();
> =20
>      qemu_add_opts(&qemu_drive_opts);
>      qemu_add_drive_opts(&qemu_legacy_drive_opts);
> @@ -4645,6 +4644,12 @@ int main(int argc, char **argv, char **envp)
>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
> =20
> +    /*
> +     * Note: qtest_enabled() (which used in monitor_qapi_event_init())=


s/which/which is/

> +     * depend on configure_accelerator() above.

s/depend/depends/

> +     */
> +    monitor_init_globals();
> +
>      if (qemu_opts_foreach(qemu_find_opts("mon"),
>                            mon_init_func, NULL, NULL)) {
>          exit(1);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4YOQIWTtfWbzqkj8IqLCMnOvK05fJIuFv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVTKQACgkQp6FrSiUn
Q2oWxwf/ZugZpK6ritb+acAbkSrEGdlZQ1jHmPbNbQKTfKCh5fw397wO0UR41n7b
j2HlpxUsUA5jHwER4F/kUVDeR3FD0NP84p1MBhRSr7K+7gTojg04FNXWQ+iNLrm9
wmQBWlBdaAOqwC5gM76J6gcpTsE6jF/uWcMzgwXKQC0c1ElEfrj2IDCIfNxyypA+
P9RDGHe5Q/47IKLXdzx0BCZ0BsySgnsAi2XEs420lHHxHZy8pBRFDpLQHS00i9mP
TBsH7FjVn0sjZI6l2BRYRqsHm9eFxUWl/GzFevLb5L5maZva87nxXY4o7ZtmF17E
UMlDIPR8+WInLZ3bvUkrj4MP+qR/NA==
=0xvt
-----END PGP SIGNATURE-----

--4YOQIWTtfWbzqkj8IqLCMnOvK05fJIuFv--

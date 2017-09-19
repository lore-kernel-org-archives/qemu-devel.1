Received: from eggs.gnu.org ([2001:4830:134:3::10]:34382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duQBC-0004gT-Qd
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duQB8-0003Jj-1J
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:35:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duQB7-0003IN-JH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:35:37 -0400
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-8-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c8217a4-c169-c580-f461-e7173a772e31@redhat.com>
Date: Tue, 19 Sep 2017 16:35:28 -0500
MIME-Version: 1.0
In-Reply-To: <1505375436-28439-8-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dMNNCEejEL63WTt6AISou49d6G352fa5a"
Subject: Re: [Qemu-devel] [RFC 07/15] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dMNNCEejEL63WTt6AISou49d6G352fa5a
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <5c8217a4-c169-c580-f461-e7173a772e31@redhat.com>
Subject: Re: [RFC 07/15] monitor: unify global init
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
 <1505375436-28439-8-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-8-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/14/2017 02:50 AM, Peter Xu wrote:
> There are many places for monitor init its globals, at least:
>=20
> - monitor_init_qmp_commands() at the very beginning
> - single function to init monitor_lock
> - in the first entry of monitor_init() using "is_first_init"
>=20
> Unify them a bit.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/monitor/monitor.h |  2 +-
>  monitor.c                 | 25 ++++++++++---------------
>  vl.c                      |  3 ++-
>  3 files changed, 13 insertions(+), 17 deletions(-)
>=20

> =20
> +void monitor_init_globals(void)
> +{
> +    monitor_init_qmp_commands();
> +    monitor_qapi_event_init();
> +    sortcmdlist();
> +    qemu_mutex_init(&monitor_lock);
> +}

Are we sure that this new function is called sooner than any access to
monitor_lock,

> -static void __attribute__((constructor)) monitor_lock_init(void)
> -{
> -    qemu_mutex_init(&monitor_lock);
> -}

especially since the old code initialized the lock REALLY early?

> diff --git a/vl.c b/vl.c
> index fb1f05b..850cf55 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3049,7 +3049,6 @@ int main(int argc, char **argv, char **envp)
>      qemu_init_exec_dir(argv[0]);
> =20
>      module_call_init(MODULE_INIT_QOM);
> -    monitor_init_qmp_commands();
> =20
>      qemu_add_opts(&qemu_drive_opts);
>      qemu_add_drive_opts(&qemu_legacy_drive_opts);
> @@ -4587,6 +4586,8 @@ int main(int argc, char **argv, char **envp)
> =20
>      parse_numa_opts(current_machine);
> =20
> +    monitor_init_globals();
> +

Pre-patch, a breakpoint on main() and on monitor_lock_init() fires on
monitor_lock_init() first, prior to main.

Breakpoint 2, monitor_lock_init () at /home/eblake/qemu/monitor.c:4089
4089	    qemu_mutex_init(&monitor_lock);
(gdb) c
Continuing.
[New Thread 0x7fffce225700 (LWP 26380)]

Thread 1 "qemu-system-x86" hit Breakpoint 1, main (argc=3D5,
    argv=3D0x7fffffffdc88, envp=3D0x7fffffffdcb8) at vl.c:3077
3077	{

Post-patch, the mutex is not initialized until well after main().  So
the real question is what (if anything) is using the lock in between
those two points?

Hmm - it may be that we needed it back before commit 05875687, when we
really did depend on MODULE_INIT_QAPI, but it is something we forgot to
cleanup in the meantime?

If nothing else, the commit message should call out that dropping
__attribute__((constructor)) nonsense is intentional (if it was indeed
nonsense).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dMNNCEejEL63WTt6AISou49d6G352fa5a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBjaAACgkQp6FrSiUn
Q2o47AgAloVUpP9LKN5PS/GRPA7GSYVYGtYzT5ia/aJ8HhkIlnN3vTtQ1YsCG2tz
rvthBpA0rqE/AXeuJ2WEwpNlUyG2r5fQNjzT0zqGGLIBuKdliaDtGUB3yhgYRhIR
47+4JaYWBFmvHquFaaeOTHZlEJ6ctFwxGaDPdHr4tcN3iP8vvsdWEy/XH6aWT8oJ
vn6WT3s/D1eYBbpfLstuJ7U3nxhh6xnf8g+0OizvvywAYdqV6F7vRv0L6cRdqa7H
WoyrIP6UaxAa2td1yLePlvAGM/cIM11GFZ7fQPKMc8mi8MbEwm1lUfcIIHeIFcPf
sohVnaob1U96+rmCrm/GbEBNMqVeoQ==
=brkO
-----END PGP SIGNATURE-----

--dMNNCEejEL63WTt6AISou49d6G352fa5a--

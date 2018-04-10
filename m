Received: from eggs.gnu.org ([2001:4830:134:3::10]:52612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5tjQ-00058I-Ca
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5tjN-00053j-AW
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:54:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f5tjN-00053Q-4Y
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:54:41 -0400
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-3-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8fe4adb8-3f4a-9f2f-59a9-ea6a5468332c@redhat.com>
Date: Tue, 10 Apr 2018 08:54:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180410124913.10832-3-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cofNL1klLD9N2EaHh14JhBIaMHdej6Tvm"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-thread: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cofNL1klLD9N2EaHh14JhBIaMHdej6Tvm
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <8fe4adb8-3f4a-9f2f-59a9-ea6a5468332c@redhat.com>
Subject: Re: [PATCH 2/2] qemu-thread: let cur_mon be per-thread
References: <20180410124913.10832-1-peterx@redhat.com>
 <20180410124913.10832-3-peterx@redhat.com>
In-Reply-To: <20180410124913.10832-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 07:49 AM, Peter Xu wrote:
> cur_mon was only used in main loop so we don't really need that to be
> per-thread variable.  Now it's possible that we have more than one
> thread to operate on it.  Let's start to let it be per-thread variable.=

>=20
> In case we'll create threads within a valid cur_mon setup, we'd better
> let the child threads to inherit the cur_mon from parent thread too.  D=
o
> that for both posix and win32 threads.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/monitor/monitor.h   | 2 +-
>  include/qemu/thread-win32.h | 1 +
>  monitor.c                   | 2 +-
>  stubs/monitor.c             | 2 +-
>  tests/test-util-sockets.c   | 2 +-
>  util/qemu-thread-posix.c    | 6 ++++++
>  util/qemu-thread-win32.c    | 6 ++++++
>  7 files changed, 17 insertions(+), 4 deletions(-)
>=20

> @@ -494,6 +496,9 @@ static void *qemu_thread_start(void *args)
>      void *(*start_routine)(void *) =3D qemu_thread_args->start_routine=
;
>      void *arg =3D qemu_thread_args->arg;
> =20
> +    /* Inherit the cur_mon pointer from father thread */

More typical as s/father/parent/

> +++ b/util/qemu-thread-win32.c

> @@ -339,6 +341,9 @@ static unsigned __stdcall win32_start_routine(void =
*arg)
>      void *(*start_routine)(void *) =3D data->start_routine;
>      void *thread_arg =3D data->arg;
> =20
> +    /* Inherit the cur_mon pointer from father thread */
> +    cur_mon =3D data->current_monitor;

Otherwise makes sense to me.

I agree with your analysis that the set of existing OOB commands (just
'x-oob-test') has no direct use of cur_mon.  I'm a little fuzzier on
whether the OOB changes can cause cur_mon to be modified by two threads
in parallel (monitor_qmp_dispatch_one() is futzing around with 'cur_mon'
around the call to qmp_dispatch(), and at least
qmp_human_monitor_command() is also futzing around with it; is there a
case where handling qmp_human_monitor_command() in the dispatch thread
in parallel with more input on the main thread could break?)  Thus I'm
not sure whether this is needed for 2.12 to avoid a regression.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cofNL1klLD9N2EaHh14JhBIaMHdej6Tvm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrMwhcACgkQp6FrSiUn
Q2pIQwf8CDCR60kFBYj1TF/wrrI7+uddBNAkyUICIZbByXhi8lectXBjiavEZ/TZ
DEYjlWBLnaO1JRWHOqgzsN62gLP4msARJ87arHPevWch3yZqDajzDF7VD4l6M0DM
t1nRJh0JhJeVVcPXsZIXf3nRcnFuvXiFTTJk2x9ibZlTZRKS+0/dAjEBWoo5xnJN
OrRb1ltYMn/mhoxe/g6pD9tfeB8EgPvjBgPs6vMgTRxmDJnYUaLAcUWpK85bXe3S
e/+pR9pPTwdvunzY39rBkbG5mOTpHK6BCmaSpE9FgbCpwwW8GgIgg1uL9SX31UBu
5nSpNWFMeiGqPptsljjAQlTU9leVNQ==
=3sGB
-----END PGP SIGNATURE-----

--cofNL1klLD9N2EaHh14JhBIaMHdej6Tvm--

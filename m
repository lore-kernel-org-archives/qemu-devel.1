Received: from eggs.gnu.org ([2001:4830:134:3::10]:35175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQAeC-0006cG-4n
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQAe2-0003Vf-O5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:01:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQAe2-0003Uk-HI
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:00:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12B99402346D
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 12:00:58 +0000 (UTC)
Date: Tue, 5 Jun 2018 13:00:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180605120054.GZ32286@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-3-berrange@redhat.com>
	<20180604235315.0447d13f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604235315.0447d13f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vl: fix use of --daemonize with
 --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Michal Privoznik <mprivozn@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jun 04, 2018 at 11:53:15PM +0200, Igor Mammedov wrote:
> On Mon,  4 Jun 2018 13:03:45 +0100
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>=20
> > When using --daemonize, the initial lead process will fork a child an=
d
> > then wait to be notified that setup is complete via a pipe, before it
> > exits.  When using --preconfig there is an extra call to main_loop()
> > before the notification is done from os_setup_post(). Thus the parent
> > process won't exit until the mgmt application connects to the monitor
> > and tells QEMU to leave the RUN_STATE_PRECONFIG. The mgmt application
> > won't connect to the monitor until daemonizing has completed though.
> >=20
> > This is a chicken and egg problem, leading to deadlock at startup.
> >=20
> > The only viable way to fix this is to call os_setup_post() before
> > the early main_loop() call when in RUN_STATE_PRECONFIG. This has the
> > downside that any errors from this point onwards won't be handled
> > well by the mgmt application, because it will think QEMU has started
> > successfully, so not be expecting an abrupt exit. The only way to
> > deal with that is to move as much user input validation as possible
> > to before the main_loop() call. This is left as an exercise for
> > future interested developers.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> [...]
>=20
> How about combining ideas from yours and Michal's patches?
> It should fix broken iotests/libvirt sync point and
> we can think about NONE runstate idea at without rushing it.
> If it looks acceptable, I'll post proper patches + test case for it
> after some testing (to ensure that iotests Max pointed out are working
> as expected)
>=20
> diff --git a/vl.c b/vl.c
> index c4fe255..a2062d6 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1953,10 +1953,15 @@ static bool main_loop_should_exit(void)
> =20
>  static void main_loop(void)
>  {
> +    static bool os_setup_post_done =3D false;
>  #ifdef CONFIG_PROFILER
>      int64_t ti;
>  #endif
> -    do {
> +    if (!os_setup_post_done) {
> +        os_setup_post();
> +        os_setup_post_done =3D true;
> +    }

I don't really like hiding the os_setup_post() call in
the main_loop() method, since they're really independant
functionality.

> +    while (!main_loop_should_exit()) {
>  #ifdef CONFIG_PROFILER
>          ti =3D profile_getclock();
>  #endif
> @@ -1964,7 +1969,7 @@ static void main_loop(void)
>  #ifdef CONFIG_PROFILER
>          dev_time +=3D profile_getclock() - ti;
>  #endif
> -    } while (!main_loop_should_exit());
> +    }
>  }
> =20
>  static void version(void)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

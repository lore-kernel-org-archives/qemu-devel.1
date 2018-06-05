Received: from eggs.gnu.org ([2001:4830:134:3::10]:34430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQGie-0007zG-Ln
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQGib-0004Sm-Fs
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:30:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQGib-0004RD-1o
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:30:05 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABA7181DF4
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 18:30:03 +0000 (UTC)
Date: Tue, 5 Jun 2018 15:30:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180605183001.GO7451@localhost.localdomain>
References: <1528207243-268226-1-git-send-email-imammedo@redhat.com>
	<1528207243-268226-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1528207243-268226-3-git-send-email-imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] vl: fix use of --daemonize with
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
Cc: qemu-devel@nongnu.org, berrange@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, ldoktor@redhat.com

On Tue, Jun 05, 2018 at 04:00:43PM +0200, Igor Mammedov wrote:
> When using --daemonize, the initial lead process will fork a child and
> then wait to be notified that setup is complete via a pipe, before it
> exits.  When using --preconfig there is an extra call to main_loop()
> before the notification is done from os_setup_post(). Thus the parent
> process won't exit until the mgmt application connects to the monitor
> and tells QEMU to leave the RUN_STATE_PRECONFIG. The mgmt application
> won't connect to the monitor until daemonizing has completed though.
>=20
> This is a chicken and egg problem, leading to deadlock at startup.
>=20
> The only viable way to fix this is to call os_setup_post() before
> the early main_loop_wait() call when in RUN_STATE_PRECONFIG. This has
> the downside that any errors from this point onwards won't be handled
> well by the mgmt application, because it will think QEMU has started
> successfully, so not be expecting an abrupt exit. The only way to
> deal with that is to move as much user input validation as possible
> to before the main_loop() call. This is left as an exercise for
> future interested developers.
>=20
> Based on:
>   From: Daniel P. Berrang=E9 <berrange@redhat.com>
>   Subject: [PATCH v2 2/2] vl: fix use of --daemonize with --preconfig
>   Message-Id: <20180604120345.12955-3-berrange@redhat.com>
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v3:
>   - rewrite to apply on top of 1/2
> ---
>  os-posix.c | 6 ++++++
>  vl.c       | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/os-posix.c b/os-posix.c
> index 9ce6f74..ee06a8d 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -309,8 +309,14 @@ void os_daemonize(void)
> =20
>  void os_setup_post(void)
>  {
> +    static bool os_setup_post_done =3D false;
>      int fd =3D 0;
> =20
> +    if (os_setup_post_done) {
> +        return;
> +    }
> +    os_setup_post_done =3D true;
> +

This part is nice because it allows the os_setup_post() call in
the second main loop to be unconditional, but:

>      if (daemonize) {
>          if (chdir("/")) {
>              error_report("not able to chdir to /: %s", strerror(errno)=
);
> diff --git a/vl.c b/vl.c
> index fa44138..d6fa67f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1960,6 +1960,7 @@ static void main_loop(void)
>  #ifdef CONFIG_PROFILER
>          ti =3D profile_getclock();
>  #endif
> +        os_setup_post();
>          main_loop_wait(false);

Ensuring the correctness of this os_setup_post() call depends on
reading the whole body of main_loop_should_exit(), which is a
complex and large function.  I think this is too fragile for my
taste.

I prefer Daniel's approach where we have two
os_setup_post()/main_loop() call sites, and the first one is
conditional on --preconfig.


>  #ifdef CONFIG_PROFILER
>          dev_time +=3D profile_getclock() - ti;
> @@ -4707,7 +4708,6 @@ int main(int argc, char **argv, char **envp)
>      }
> =20
>      accel_setup_post(current_machine);
> -    os_setup_post();
> =20
>      main_loop();
> =20
> --=20
> 2.7.4
>=20

--=20
Eduardo

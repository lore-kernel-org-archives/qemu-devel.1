Received: from eggs.gnu.org ([2001:4830:134:3::10]:60065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRHKL-0007VD-Bc
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRHKG-0004lS-9G
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:21:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fRHKG-0004ka-00
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:21:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40B4081DE1
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 13:21:07 +0000 (UTC)
Date: Fri, 8 Jun 2018 10:21:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180608132105.GA24764@localhost.localdomain>
References: <20180606135051.GR7451@localhost.localdomain>
	<1528372809-175770-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1528372809-175770-1-git-send-email-imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/2] vl: fix use of --daemonize with
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
Cc: qemu-devel@nongnu.org, ldoktor@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Jun 07, 2018 at 02:00:09PM +0200, Igor Mammedov wrote:
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
> the early main_loop() call when --preconfig is used. This has the
> downside that any errors from this point onwards won't be handled
> well by the mgmt application, because it will think QEMU has started
> successfully, so not be expecting an abrupt exit. Moving as much user
> input validation as possible to before the main_loop() call might help,
> but mgmt application should stop assuming that QEMU has started
> successfuly and use other means to collect errors from QEMU (logfile).
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v5:
>   * use original Daniel's patch [1], but addapt it to apply on top of
>     "[PATCH v3 1/2] cli: Don't run early event loop if no  --preconfig =
was specified"
>     with extra comment and massage commit message a little bit.
> v6:
>   * hide os_setup_post_done flag inside of os_setup_post() as it was in=
 v4
>=20
> CC: berrange@redhat.com
> CC: mreitz@redhat.com
> CC: pbonzini@redhat.com
> CC: ehabkost@redhat.com
> CC: ldoktor@redhat.com
> CC: eblake@redhat.com
> ---
>  os-posix.c | 6 ++++++
>  vl.c       | 6 ++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/os-posix.c b/os-posix.c
> index 9ce6f74..0246195 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -309,8 +309,14 @@ void os_daemonize(void)
> =20
>  void os_setup_post(void)
>  {
> +    static bool os_setup_post_done;
>      int fd =3D 0;
> =20
> +    if (os_setup_post_done) {
> +        return;
> +    }
> +    os_setup_post_done =3D true;
> +
>      if (daemonize) {
>          if (chdir("/")) {
>              error_report("not able to chdir to /: %s", strerror(errno)=
);
> diff --git a/vl.c b/vl.c
> index fa44138..457ff2a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4578,6 +4578,12 @@ int main(int argc, char **argv, char **envp)
>      parse_numa_opts(current_machine);
> =20
>      /* do monitor/qmp handling at preconfig state if requested */
> +    if (!preconfig_exit_requested && is_daemonized()) {
> +        /* signal parent QEMU to exit, libvirt treats it as a sign
> +         * that monitor socket is ready to accept connections
> +         */
> +        os_setup_post();
> +    }

I was looking at the daemonize logic, and noticed it we have a
huge amount of code between this line and the next
os_setup_post() call that could either:

* call exit() and/or error_report(); or
* be unable to finish machine initialization because of
  chdir("/"), change_root(), or change_process_uid().

Doesn't this make -preconfig and -daemonize fundamentally
incompatible?


>      main_loop();
> =20
>      /* from here on runstate is RUN_STATE_PRELAUNCH */
> --=20
> 2.7.4
>=20
>=20

--=20
Eduardo

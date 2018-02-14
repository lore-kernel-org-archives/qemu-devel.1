Received: from eggs.gnu.org ([2001:4830:134:3::10]:44940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elzeP-0005ku-Im
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elzeJ-0000xu-KY
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:11:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41454 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1elzeJ-0000xk-Ed
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:11:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26F7A4040856
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 16:11:11 +0000 (UTC)
Date: Wed, 14 Feb 2018 16:11:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180214161108.GH5171@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1518624575-7048-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518624575-7048-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] io/channel-command: Do not kill the child
 process after closing the pipe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>

On Wed, Feb 14, 2018 at 05:09:35PM +0100, Thomas Huth wrote:
> We are currently facing some migration failure on s390x when running
> certain avocado-vt tests, e.g. when running the test
> type_specific.io-github-autotest-qemu.migrate.with_reboot.exec.gzip_exe=
c.
> This test is using 'migrate -d "exec:nc localhost 5200"' for the migrat=
ion.
> The problem is detected at the receiving side, where the migration stre=
am
> apparently ends too early. However, the cause for the problem is at the
> sending side: After writing the migration stream into the pipe to netca=
t,
> the source QEMU calls qio_channel_command_close() which closes the pipe
> and immediately (!) kills the child process afterwards (via the functio=
n
> qio_channel_command_abort()). So if the  sending netcat did not read th=
e
> final bytes from the pipe yet, or  if it did not manage to send out all
> its buffers yet, it is killed before the whole migration stream is pass=
ed
> to the destination side.
>=20
> QEMU can not know how much time is required by the child process to sen=
d
> over all migration data, so we should not kill it, neither directly nor
> after a delay. Let's simply wait for the child process to exit graceful=
ly
> instead (this was also the behaviour of pclose() that was used in "exec=
:"
> migration before the QIOChannel rework).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  io/channel-command.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/io/channel-command.c b/io/channel-command.c
> index 319c5ed..3e7eb17 100644
> --- a/io/channel-command.c
> +++ b/io/channel-command.c
> @@ -301,6 +301,9 @@ static int qio_channel_command_close(QIOChannel *io=
c,
>  {
>      QIOChannelCommand *cioc =3D QIO_CHANNEL_COMMAND(ioc);
>      int rv =3D 0;
> +#ifndef WIN32
> +    pid_t wp;
> +#endif
> =20
>      /* We close FDs before killing, because that
>       * gives a better chance of clean shutdown
> @@ -315,11 +318,18 @@ static int qio_channel_command_close(QIOChannel *=
ioc,
>          rv =3D -1;
>      }
>      cioc->writefd =3D cioc->readfd =3D -1;
> +
>  #ifndef WIN32
> -    if (qio_channel_command_abort(cioc, errp) < 0) {
> +    do {
> +        wp =3D waitpid(cioc->pid, NULL, 0);
> +    } while (wp =3D=3D (pid_t)-1 && errno =3D=3D EINTR);
> +    if (wp =3D=3D (pid_t)-1) {
> +        error_setg_errno(errp, errno, "Failed to wait for pid %llu",
> +                         (unsigned long long)cioc->pid);
>          return -1;
>      }
>  #endif
> +
>      if (rv < 0) {
>          error_setg_errno(errp, errno, "%s",
>                           "Unable to close command");

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I'll queue this as i had a PR pending...

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

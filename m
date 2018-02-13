Received: from eggs.gnu.org ([2001:4830:134:3::10]:58342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elbUB-0002Zs-Ee
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elbU8-0003P5-1I
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:23:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1elbU7-0003On-Rv
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:23:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76E3E4040852
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 14:23:03 +0000 (UTC)
Date: Tue, 13 Feb 2018 14:23:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180213142300.GM573@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1518531279-11966-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518531279-11966-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] io/channel-command: Delay the killing of
 the child after closing the pipe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On Tue, Feb 13, 2018 at 03:14:39PM +0100, Thomas Huth wrote:
> We are currently facing some migration failure on s390x when running
> certain avocado tests, e.g. when running the test
> type_specific.io-github-autotest-qemu.migrate.with_reboot.exec.gzip_exe=
c.
> This test is using 'migrate -d "exec:nc localhost 5200"' for the migrat=
ion.
> The problem is detected at the receiving side, where the migration stre=
am
> apparently ends too early. However, the cause for the problem is the
> sending side: After writing the migration stream into the pipe to netca=
t,
> the source QEMU calls qio_channel_command_close() which closes the pipe
> and immediately (!) kills the child process afterwards. So if the
> sending netcat did not read the final bytes from the pipe yet, or
> if it did not manage to send out all its buffers yet, it is killed
> before the whole migration stream is passed to the destination side.

Ok, yes,that makes sense.

> To ease the situation at least a little bit, we should give the child
> process at least some few more time slices before we kill it with
> SIGTERM and then with SIGKILL. With this change, the avocado test now
> succeeds here in 10 out of 10 runs.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  io/channel-command.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/io/channel-command.c b/io/channel-command.c
> index 319c5ed..f64db3e 100644
> --- a/io/channel-command.c
> +++ b/io/channel-command.c
> @@ -177,11 +177,11 @@ static int qio_channel_command_abort(QIOChannelCo=
mmand *ioc,
>              return -1;
>          }
>      } else if (ret =3D=3D 0) {
> -        if (step =3D=3D 0) {
> +        if (step =3D=3D 4) {
>              kill(ioc->pid, SIGTERM);
> -        } else if (step =3D=3D 1) {
> +        } else if (step =3D=3D 8) {
>              kill(ioc->pid, SIGKILL);
> -        } else {
> +        } else if (step >=3D 9) {
>              error_setg(errp,
>                         "Process %llu refused to die",
>                         (unsigned long long)ioc->pid);

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

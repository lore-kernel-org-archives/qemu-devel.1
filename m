Received: from eggs.gnu.org ([2001:4830:134:3::10]:48237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwla9-0006yf-MQ
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwla8-0007ac-MX
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:55:41 -0400
Date: Mon, 3 Sep 2018 10:55:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180903095528.GC3467@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180831145314.14736-1-marcandre.lureau@redhat.com>
	<20180831145314.14736-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180831145314.14736-2-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] util: add qemu_write_pidfile()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, Aug 31, 2018 at 04:53:12PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> There are variants of qemu_create_pidfile() in qemu-pr-helper and
> qemu-ga. Let's have a common implementation in libqemuutil.
>=20
> The code is initially based from pr-helper write_pidfile(), with
> various improvements and suggestions from Daniel Berrang=C3=A9:
>=20
>   QEMU will leave the pidfile existing on disk when it exits which
>   initially made me think it avoids the deletion race. The app
>   managing QEMU, however, may well delete the pidfile after it has
>   seen QEMU exit, and even if the app locks the pidfile before
>   deleting it, there is still a race.
>=20
>   eg consider the following sequence
>=20
>         QEMU 1        libvirtd        QEMU 2
>=20
>   1.    lock(pidfile)
>=20
>   2.    exit()
>=20
>   3.                 open(pidfile)
>=20
>   4.                 lock(pidfile)
>=20
>   5.                                  open(pidfile)
>=20
>   6.                 unlink(pidfile)
>=20
>   7.                 close(pidfile)
>=20
>   8.                                  lock(pidfile)
>=20
>   IOW, at step 8 the new QEMU has successfully acquired the lock, but
>   the pidfile no longer exists on disk because it was deleted after
>   the original QEMU exited.
>=20
>   While we could just say no external app should ever delete the
>   pidfile, I don't think that is satisfactory as people don't read
>   docs, and admins don't like stale pidfiles being left around on
>   disk.
>=20
>   To make this robust, I think we might want to copy libvirt's
>   approach to pidfile acquisition which runs in a loop and checks that
>   the file on disk /after/ acquiring the lock matches the file that
>   was locked. Then we could in fact safely let QEMU delete its own
>   pidfiles on clean exit..
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu/osdep.h  |  3 +-
>  os-posix.c            | 24 ---------------
>  os-win32.c            | 25 ----------------
>  qga/main.c            | 54 +++++++---------------------------
>  scsi/qemu-pr-helper.c | 40 ++++---------------------
>  util/oslib-posix.c    | 68 +++++++++++++++++++++++++++++++++++++++++++
>  util/oslib-win32.c    | 27 +++++++++++++++++
>  vl.c                  |  4 +--
>  8 files changed, 114 insertions(+), 131 deletions(-)

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

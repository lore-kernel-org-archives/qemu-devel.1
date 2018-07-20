Received: from eggs.gnu.org ([2001:4830:134:3::10]:34603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fgXpm-0002HY-FF
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fgXpj-0001Jw-D2
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:00:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59066 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fgXpj-0001Hy-6d
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:00:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 490DA7A7E7
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 16:00:42 +0000 (UTC)
Date: Fri, 20 Jul 2018 17:00:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180720160039.GO16700@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180720154425.31285-1-marcandre.lureau@redhat.com>
	<20180720154425.31285-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720154425.31285-2-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] seccomp: use SIGSYS signal instead of
 killing the thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pmoore@redhat.com, Eduardo Otubo <otubo@redhat.com>

On Fri, Jul 20, 2018 at 05:44:24PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> The seccomp action SCMP_ACT_KILL results in immediate termination of
> the thread that made the bad system call. However, qemu being
> multi-threaded, it keeps running. There is no easy way for parent
> process / management layer (libvirt) to know about that situation.
>=20
> Instead, the default SIGSYS handler when invoked with SCMP_ACT_TRAP
> will terminate the program and core dump.
>=20
> This may not be the most secure solution, but probably better than
> just killing the offending thread. SCMP_ACT_KILL_PROCESS has been
> added in Linux 4.14 to improve the situation, which I propose to use
> by default if available in the next patch.

Note that seccomp doesn't promise to protect against all  types
of vulnerability in a program. It merely aims to stop the program
executing designated system calls.

Using SCMP_ACT_TRAP still prevents syscal execution to exactly the
same extent that SCMP_ACT_KILL does, so its security level is the
same.

What differs is that the userspace app has option to ignore the
syscall and carry on instead of being killed. A malicous attacker
would thus have option to try to influence other parts of QEMU
todo bad stuff, but if they already have control over the userspace
process to this extent, they can likely do such bad stuff even
before executing the syscalls

So I don't think there's any significant difference in security
protection here.  Mostly the difference is just about what the
crash will look like. A full process crash (from the default
signal handler) looks better than a thread crash for the reasons
you've explained.

>=20
> Related to:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1594456
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-seccomp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index 9cd8eb9499..b117a92559 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -125,7 +125,7 @@ static int seccomp_start(uint32_t seccomp_opts)
>              continue;
>          }
> =20
> -        rc =3D seccomp_rule_add_array(ctx, SCMP_ACT_KILL, blacklist[i]=
.num,
> +        rc =3D seccomp_rule_add_array(ctx, SCMP_ACT_TRAP, blacklist[i]=
.num,
>                                      blacklist[i].narg, blacklist[i].ar=
g_cmp);
>          if (rc < 0) {
>              goto seccomp_return;

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

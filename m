Received: from eggs.gnu.org ([2001:4830:134:3::10]:47646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsWrJ-0004XF-5r
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsWrD-0002sd-Ja
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:23:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsWrD-0002sG-Eo
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:23:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 659D640241C0
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 17:23:46 +0000 (UTC)
Date: Wed, 22 Aug 2018 18:23:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822172337.GY12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180822170250.29573-1-marcandre.lureau@redhat.com>
	<20180822170250.29573-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822170250.29573-5-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/4] seccomp: set the seccomp filter to
 all threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pmoore@redhat.com, eblake@redhat.com, Eduardo Otubo <otubo@redhat.com>

On Wed, Aug 22, 2018 at 07:02:50PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> When using "-seccomp on", the seccomp policy is only applied to the
> main thread, the vcpu worker thread and other worker threads created
> after seccomp policy is applied; the seccomp policy is not applied to
> e.g. the RCU thread because it is created before the seccomp policy is
> applied and SECCOMP_FILTER_FLAG_TSYNC isn't used.
>=20
> This can be verified with
> for task in /proc/`pidof qemu`/task/*; do cat $task/status | grep Secc =
; done
> Seccomp:	2
> Seccomp:	0
> Seccomp:	0
> Seccomp:	2
> Seccomp:	2
> Seccomp:	2
>=20
> Starting with libseccomp 2.2.0 and kernel >=3D 3.17, we can use
> seccomp_attr_set(ctx, > SCMP_FLTATR_CTL_TSYNC, 1) to update the policy
> on all threads.
>=20
> libseccomp requirement was bumped to 2.2.0 in previous patch.
> libseccomp should fail to set the filter if it can't honour
> SCMP_FLTATR_CTL_TSYNC (untested), and thus -sandbox will now fail on
> kernel < 3.17.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-seccomp.c | 5 +++++
>  1 file changed, 5 insertions(+)

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

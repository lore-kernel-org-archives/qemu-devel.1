Received: from eggs.gnu.org ([209.51.188.92]:42154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyxel-0002Q7-Ks
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyxek-0006Pg-JH
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:45:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gyxek-0006NO-BX
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:45:46 -0500
Date: Wed, 27 Feb 2019 11:45:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190227114534.GG31688@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAJ+F1CL8Hzns+ffZYGDmk=LjaLeaALyooUaVcQhCWcGz-qbizA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CL8Hzns+ffZYGDmk=LjaLeaALyooUaVcQhCWcGz-qbizA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] seccomp raises on mesa pthread_setaffinity_np()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Otubo <otubo@redhat.com>

On Fri, Feb 22, 2019 at 09:04:53AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> We have another seccomp issue with mesa, leading to SIGSYS bad system
> call (when running a virgl VM with libvirt for example)

To close the circle, this is now also reported on launchpad

https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1815889

> Since commit :
> https://gitlab.freedesktop.org/mesa/mesa/commit/d877451b48a59ab0f9a4210=
fc736f51da5851c9a
> (unfortunately, already in f29)
>=20
> mesa wants to set its thread affinity on all CPU, but I am not sure
> how we can limit the rule to the mesa threads yet... any ideas?

Per my comment on the bug, I think this is not a good default behaviour
for Mesa. It should honour the affinity of the process that is running,
because if that has been given restrictive CPU affinity it is precisely
because the admin or mgmt app doesn't want it to use all CPUs. Mesa
shouldn't unconditionally undo that decision.

> Another reason to consider vhost-user-gpu, to simplify the seccomp rule=
s!

I don't think that's going to help because if anything I expect seccomp
rules to be more restrictive for the vhost processes as they are tailored
to specific functional niches. Even if in a separate process libvirt will
still not want mesa to violate the CPU affinity it has configured. It mus=
t
honour what the process was given.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

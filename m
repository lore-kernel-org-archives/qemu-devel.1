Received: from eggs.gnu.org ([2001:4830:134:3::10]:42015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBFOf-00042p-Rh
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBFOc-0003Og-6H
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:03:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51882 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fBFOc-0003OV-0b
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:03:22 -0400
Date: Wed, 25 Apr 2018 09:03:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180425080306.GC30024@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1524295325-18136-1-git-send-email-wangxinxin.wang@huawei.com>
	<20180424171631.GF2521@work-vm> <20180424182405.GM20310@redhat.com>
	<20180425031423.GH9036@xz-mi> <20180425033131.GI9036@xz-mi>
	<8ADDA2EB7601DA429B6B2A43EF4620A55B76E463@DGGEMA503-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ADDA2EB7601DA429B6B2A43EF4620A55B76E463@DGGEMA503-MBX.china.huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration/fd: abort migration if receive
 POLLHUP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "wangxin (U)" <wangxinxin.wang@huawei.com>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

On Wed, Apr 25, 2018 at 07:29:05AM +0000, wangxin (U) wrote:
>=20
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Wednesday, April 25, 2018 11:32 AM
> > To: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>; wangxin (U)
> > <wangxinxin.wang@huawei.com>; qemu-devel@nongnu.org;
> > quintela@redhat.com; Gonglei (Arei) <arei.gonglei@huawei.com>
> > Subject: Re: [PATCH] migration/fd: abort migration if receive POLLHUP=
 event
> >=20

> > Ah, wait.  I just noticed that Xin mentioned about the loop already -
> > it's an infinite loop of SIGHUP.  I suppose it means that we'll just
> > never go into fd_accept_incoming_migration() at all?
>=20
> Yeah, that's what I want to fix.
>=20
> >=20
> > If so, I'm not sure whether we should just always watch on G_IO_HUP
> > (and possibly G_IO_ERR too) in qio_channel_create_watch():
> >=20
> >   GSource *ret =3D klass->io_create_watch(ioc, condition | G_IO_HUP |
> > G_IO_ERR);
> >=20
> > Otherwise I'm not sure the same loop will happen for other users of
> > qio_channel_add_watch().
>=20
> In my scenario, it's clear the client quit immediately and we
> never got a POLLIN event, otherwise,=20
> the watch should be unregistered when POLLIN event coming.=20
> As Daniel said, normally G_IO_IN will be the first event, we
> need to find why POLLIN event never happened, I'll try it.

Yes, I have always been under the belief that you're guaranteed to get a
POLLIN event when the client closes the connection, in addition to the
POLLHUP event, but it sounds like that is not happening so I guess I'm
mistaken in that.

In this case, it should be sufficient to just add the G_IO_HUP|G_IO_ERR
events when creating the watch - probably no need to add extra code to
the fd_accept_incoming_migration() method.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

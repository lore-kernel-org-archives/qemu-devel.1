Received: from eggs.gnu.org ([2001:4830:134:3::10]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gP4pq-00076g-38
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gP4pk-0001tP-4u
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:08:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gP4pj-0001t6-V7
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:08:48 -0500
Received: by mail-wr1-x444.google.com with SMTP id 96so1721036wrb.2
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 04:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20181107151311.1058-1-marcandre.lureau@redhat.com>
	<20181112160124.GT3602@redhat.com>
In-Reply-To: <20181112160124.GT3602@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 20 Nov 2018 16:08:34 +0400
Message-ID: <CAJ+F1CKdGfDas5jynuUD35CCyNVNavJnsAnitZDk4d8EMk17=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v2] vhost-user: define conventions
 for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, "Liu, Changpeng" <changpeng.liu@intel.com>

Hi
On Mon, Nov 12, 2018 at 8:03 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Wed, Nov 07, 2018 at 07:13:11PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
> > review, let's define a common set of backend conventions to help with
> > management layer implementation, and interoperability.
> >
> > v2:
> >  - use a vhost-user.json schema to discover backends and describe
> >    capability format
> >  - drop --pidfile
> >  - add some notes about daemonizing & stdin/out/err
> >
> > Cc: libvir-list@redhat.com
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Cc: Changpeng Liu <changpeng.liu@intel.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: Felipe Franciosi <felipe@nutanix.com>
> > Cc: Gonglei <arei.gonglei@huawei.com>
> > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Victor Kaplansky <victork@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  MAINTAINERS                  |   1 +
> >  docs/interop/vhost-user.json | 219 +++++++++++++++++++++++++++++++++++
> >  docs/interop/vhost-user.txt  | 101 +++++++++++++++-
> >  3 files changed, 319 insertions(+), 2 deletions(-)
> >  create mode 100644 docs/interop/vhost-user.json
>
>
> > diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.jso=
n
> > new file mode 100644
> > index 0000000000..91b5bf499e
> > --- /dev/null
> > +++ b/docs/interop/vhost-user.json
> > @@ -0,0 +1,219 @@
> > +# -*- Mode: Python -*-
> > +#
> > +# Copyright (C) 2018 Red Hat, Inc.
> > +#
> > +# Authors:
> > +#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later. See the COPYING file in the top-level directory.
> > +
> > +##
> > +# =3D vhost user backend discovery & capabilities
> > +##
> > +
> > +##
> > +# @VHostUserBackendType:
> > +#
> > +# List the various vhost user backend types.
> > +#
> > +# @net: virtio net
> > +# @block: virtio block
> > +# @console: virtio console
> > +# @rng: virtio rng
> > +# @balloon: virtio balloon
> > +# @rpmsg: virtio remote processor messaging
> > +# @scsi: virtio scsi
> > +# @9p: 9p virtio console
> > +# @rproc-serial: virtio remoteproc serial link
> > +# @caif: virtio caif
> > +# @gpu: virtio gpu
> > +# @input: virtio input
> > +# @vsock: virtio vsock transport
> > +# @crypto: virtio crypto
>
> Is it possible to actually use an external backend process with
> all these yet ?  If not, perhaps we should only start with the
> backends that will be usable immediately ?

No, most of them don't have vhost-user support in qemu. Nevertheless,
I think the vhost-user spec should cover existing virtio devices, and
not be limited to what qemu can do today, for interoperability.

>
> > +#
> > +# Since: 3.2
> > +##
> > +{
> > +  'enum': 'VHostUserBackendType',
> > +  'data': [ 'net', 'block', 'console', 'rng', 'balloon', 'rpmsg',
> > +            'scsi', '9p', 'rproc-serial', 'caif', 'gpu', 'input', 'vso=
ck',
> > +            'crypto' ]
> > +}
>
> Regardless of the answer to the above question,
>
>   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

thanks

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


--=20
Marc-Andr=C3=A9 Lureau

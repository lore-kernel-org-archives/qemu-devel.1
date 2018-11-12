Received: from eggs.gnu.org ([2001:4830:134:3::10]:35826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMEfJ-0001BK-DW
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMEfD-0003Hy-De
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:02:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMEf9-0002xW-Oy
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:02:09 -0500
Date: Mon, 12 Nov 2018 16:01:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181112160124.GT3602@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181107151311.1058-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181107151311.1058-1-marcandre.lureau@redhat.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Gonglei <arei.gonglei@huawei.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

On Wed, Nov 07, 2018 at 07:13:11PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
> review, let's define a common set of backend conventions to help with
> management layer implementation, and interoperability.
>=20
> v2:
>  - use a vhost-user.json schema to discover backends and describe
>    capability format
>  - drop --pidfile
>  - add some notes about daemonizing & stdin/out/err
>=20
> Cc: libvir-list@redhat.com
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Changpeng Liu <changpeng.liu@intel.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Felipe Franciosi <felipe@nutanix.com>
> Cc: Gonglei <arei.gonglei@huawei.com>
> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Victor Kaplansky <victork@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS                  |   1 +
>  docs/interop/vhost-user.json | 219 +++++++++++++++++++++++++++++++++++
>  docs/interop/vhost-user.txt  | 101 +++++++++++++++-
>  3 files changed, 319 insertions(+), 2 deletions(-)
>  create mode 100644 docs/interop/vhost-user.json


> diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.jso=
n
> new file mode 100644
> index 0000000000..91b5bf499e
> --- /dev/null
> +++ b/docs/interop/vhost-user.json
> @@ -0,0 +1,219 @@
> +# -*- Mode: Python -*-
> +#
> +# Copyright (C) 2018 Red Hat, Inc.
> +#
> +# Authors:
> +#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +
> +##
> +# =3D vhost user backend discovery & capabilities
> +##
> +
> +##
> +# @VHostUserBackendType:
> +#
> +# List the various vhost user backend types.
> +#
> +# @net: virtio net
> +# @block: virtio block
> +# @console: virtio console
> +# @rng: virtio rng
> +# @balloon: virtio balloon
> +# @rpmsg: virtio remote processor messaging
> +# @scsi: virtio scsi
> +# @9p: 9p virtio console
> +# @rproc-serial: virtio remoteproc serial link
> +# @caif: virtio caif
> +# @gpu: virtio gpu
> +# @input: virtio input
> +# @vsock: virtio vsock transport
> +# @crypto: virtio crypto

Is it possible to actually use an external backend process with
all these yet ?  If not, perhaps we should only start with the
backends that will be usable immediately ?

> +#
> +# Since: 3.2
> +##
> +{
> +  'enum': 'VHostUserBackendType',
> +  'data': [ 'net', 'block', 'console', 'rng', 'balloon', 'rpmsg',
> +            'scsi', '9p', 'rproc-serial', 'caif', 'gpu', 'input', 'vso=
ck',
> +            'crypto' ]
> +}

Regardless of the answer to the above question,

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

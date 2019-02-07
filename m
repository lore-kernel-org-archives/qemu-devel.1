Received: from eggs.gnu.org ([209.51.188.92]:42916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grofl-0006Q7-Mt
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:45:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grofk-0005Rr-Gu
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:45:17 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1grofk-0005R9-CI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:45:16 -0500
Received: by mail-qk1-f196.google.com with SMTP id x6so571313qki.6
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20190207165449.6125-1-marcandre.lureau@redhat.com>
	<20190207165449.6125-2-marcandre.lureau@redhat.com>
	<a89d56aa-2f16-093f-a406-35db0e0c69f8@redhat.com>
In-Reply-To: <a89d56aa-2f16-093f-a406-35db0e0c69f8@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 7 Feb 2019 19:45:03 +0100
Message-ID: <CAMxuvazy8Jwy9sDWXYEuyRoJ0Tx3iqH-NxfPQipjKvLcnqXGZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/12] vhost-user: define conventions
 for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Thu, Feb 7, 2019 at 6:42 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 2/7/19 10:54 AM, Marc-Andr=C3=A9 Lureau wrote:
> > As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
> > review, let's define a common set of backend conventions to help with
> > management layer implementation, and interoperability.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  MAINTAINERS                  |   1 +
> >  docs/interop/vhost-user.json | 219 +++++++++++++++++++++++++++++++++++
> >  docs/interop/vhost-user.txt  | 101 +++++++++++++++-
> >  3 files changed, 319 insertions(+), 2 deletions(-)
> >  create mode 100644 docs/interop/vhost-user.json
>
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
> > +#
> > +# Since: 3.2
>
> s/3.2/4.0/g in your patch series

done

>
> > +##
> > +{
> > +  'enum': 'VHostUserBackendType',
> > +  'data': [ 'net', 'block', 'console', 'rng', 'balloon', 'rpmsg',
> > +            'scsi', '9p', 'rproc-serial', 'caif', 'gpu', 'input', 'vso=
ck',
> > +            'crypto' ]
> > +}
>
> Worth alphabetizing? Not a strong requirement, though, if this order
> makes more sense.

It's in the VIRTIO_ID* order. But there is no reason to keep it that
way. Well, if we keep it alphabetically sorted, we should put one on
each line, to avoid churn..

>
>
> > +#
> > +# Top-down, the list of directories goes from general to specific.
> > +#
> > +# Management software should build a list of files from all three
> > +# locations, then sort the list by filename (i.e., last pathname
>
> perhaps s/filename/basename/

ok

> > +# component). Management software should choose the first JSON file on
> > +# the sorted list that matches the search criteria. If a more specific
> > +# directory has a file with same name as a less specific directory, th=
en
> > +# the file in the more specific directory takes effect. If the more
> > +# specific file is zero length, it hides the less specific one.
> > +#
>
> > +++ b/docs/interop/vhost-user.txt
> > @@ -17,8 +17,13 @@ The protocol defines 2 sides of the communication, m=
aster and slave. Master is
> >  the application that shares its virtqueues, in our case QEMU. Slave is=
 the
> >  consumer of the virtqueues.
> >
> > -In the current implementation QEMU is the Master, and the Slave is int=
ended to
> > -be a software Ethernet switch running in user space, such as Snabbswit=
ch.
> > +In the current implementation QEMU is the Master, and the Slave is the
> > +external process consuming the virtio queues, for example a software
> > +Ethernet switch running in user space, such as Snabbswitch, or a block
>
> Is 'slirp' any better than 'Snabbswitch' as a demonstration of
> user-space networking?

pre-existing, skip

>
> > +device backend processing read & write to a virtual disk. In order to
> > +facilitate interoperability between various backend implementations,
> > +it is recommended to follow the "Backend program conventions"
> > +described in this document.
> >
>
> > +
> > +The backend program must end (as quickly and cleanly as possible) when
> > +the SIGTERM signal is received. Eventually, it may be SIGKILL by the
>
> s/be/receive/

ok

>
> > +management layer after a few seconds.
> > +
> > +The following command line options have an expected behaviour. They
> > +are mandatory, unless explicitly said differently:
> > +
> > +* --socket-path=3DPATH
> > +
> > +This option specify the location of the vhost-user Unix domain socket.
> > +It is incompatible with --fd.
> > +
> > +* --fd=3DFDNUM
> > +
> > +When this argument is given, the backend program is started with the
> > +vhost-user socket as file descriptor FDNUM. It is incompatible with
> > +--socket-path.
>
> Do we also want to require support for systemd-style
> LISTEN_PID/LISTEN_FDS socket activation?

what is the difference with --fd=3D here? This would allow all
vhost-user-backend to be started on demand by systemd I suppose, but
do we need it? Could it be added later?

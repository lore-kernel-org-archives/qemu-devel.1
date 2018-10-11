Received: from eggs.gnu.org ([2001:4830:134:3::10]:40983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gAdD4-00058Y-Fm
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gAdCy-0006ob-Ts
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:49:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gAdCx-0006kk-4K
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:49:03 -0400
Date: Thu, 11 Oct 2018 16:48:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181011154834.GA10122@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180914135230.15178-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: define conventions for
 vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Gonglei <arei.gonglei@huawei.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>, Markus Armbruster <armbru@redhat.com>

Adding Markus since we're talking about new CLI argument and capability
reporting standards.

On Fri, Sep 14, 2018 at 05:52:30PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
> review, let's define a common set of backend conventions to help with
> management layer implementation, and interoperability.
>=20
> v2:
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
>  docs/interop/vhost-user.txt | 109 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index ba5e37d714..339b335e9c 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -17,8 +17,13 @@ The protocol defines 2 sides of the communication, m=
aster and slave. Master is
>  the application that shares its virtqueues, in our case QEMU. Slave is=
 the
>  consumer of the virtqueues.
> =20
> -In the current implementation QEMU is the Master, and the Slave is int=
ended to
> -be a software Ethernet switch running in user space, such as Snabbswit=
ch.
> +In the current implementation QEMU is the Master, and the Slave is the
> +external process consuming the virtio queues, for example a software
> +Ethernet switch running in user space, such as Snabbswitch, or a block
> +device backend processing read & write to a virtual disk. In order to
> +facilitate interoperability between various backend implementations,
> +it is recommended to follow the "Backend program conventions"
> +described in this document.
> =20
>  Master and slave can be either a client (i.e. connecting) or server (l=
istening)
>  in the socket communication.
> @@ -859,3 +864,103 @@ resilient for selective requests.
>  For the message types that already solicit a reply from the client, th=
e
>  presence of VHOST_USER_PROTOCOL_F_REPLY_ACK or need_reply bit being se=
t brings
>  no behavioural change. (See the 'Communication' section for details.)
> +
> +Backend program conventions
> +---------------------------
> +
> +vhost-user backends provide various services and they may need to be
> +configured manually depending on the use case. However, it is a good
> +idea to follow the conventions listed here when possible. Users, QEMU
> +or libvirt, can then rely on some common behaviour to avoid
> +heterogenous configuration and management of the backend program and
> +facilitate interoperability.
> +
> +In order to be discoverable, default vhost-user backends should be
> +located under "/usr/libexec", and be named "vhost-user-$device" where
> +"$device" is the device name in lower-case following the name listed
> +in the Linux virtio_ids.h header (ex: the VIRTIO_ID_RPROC_SERIAL
> +backend would be named "vhost-user-rproc-serial").
> +
> +Mechanisms to list, and to select among alternatives implementations
> +or modify the default backend are not described at this point (a
> +distribution may use update-alternatives, for example, to list and to
> +pick a different default backend).

I don't think that update-alternatives is a good thing as it presumes
that each host only needs a single preferred impl at a time.

I think we need to be able to discover all impls for a given device
type.

This feels like the same problem we tackled recently with enumerating
and choosing between multiple firmware impls.

In $git/docs/interop/firmware.json we defined a way to drop config files
into a standard directory, providing info about the firmware in a well
defined QAPI based data format.

Rather than requiring a special file naming convention I think we just
need to register config files in a particular directory, letting the
mgmt app enumerate them.

eg

  /etc/qemu/vhost-user/50-rproc-serial.json  (a default imp from QEMU)
  /etc/qemu/vhost-user/10-my-rproc-serial.json (my replacenment impl)

a file could be something pretty simple like

   {
       "name": "my-rproc-serial",
       "description": "My rproc serial impl doing foo, bar, wizz",
       "device": "rproc-serial",
       "binary": "/usr/libexec/my-awesome-rproc-serial",
   }

Mgmt apps can simply load all files in that directory to learn about
the possible impls. The file load order gives a prioritization if
multiple matches exist, or a specific impl can be requested by
name "my-rproc-serial".

This shouldn't provide full capabilities reporting though, just
enough to identify viable binaries. Capabilities should still be
via the binary itself so it can be dynamically tailored based on
other environmental factors

> +
> +The backend program must not daemonize itself, but it may be
> +daemonized by the management layer. It may also have a restricted
> +access to the system.
> +
> +File descriptors 0, 1 and 2 will exist, and have regular
> +stdin/stdout/stderr usage (they may be redirected to /dev/null by the
> +management layer, or to a log handler).
> +
> +The backend program must end (as quickly and cleanly as possible) when
> +the SIGTERM signal is received. Eventually, it may be SIGKILL by the
> +management layer after a few seconds.
> +
> +The following command line options have an expected behaviour. They
> +are mandatory, unless explicitly said differently:
> +
> +* --socket-path=3DPATH
> +
> +This option specify the location of the vhost-user Unix domain socket.
> +It is incompatible with --fd.
> +
> +* --fd=3DFDNUM
> +
> +When this argument is given, the backend program is started with the
> +vhost-user socket as file descriptor FDNUM. It is incompatible with
> +--socket-path.
> +
> +* --print-capabilities
> +
> +Output to stdout a line-seperated list of backend capabilities, and
> +then exit successfully. Other options and arguments should be ignored,
> +and the backend program should not perform its normal function.

This is going to repeat the mistakes we've had with every other
binary in QEMU. A "simple" flag list or args sounds appealing,
but we've always been burnt by it in the medium-long term, which
is why we created QAPI.

If we're doing to have any capabilities reporting, we should
model it in QAPI schema, so any '--print-capabilities' arg
should print a JSON doc following the documented schema.

While talking about QAPI, I think this is an opportunity to
also avoid the problems of CLI arg values becoming more
complex than just scalars. eg

  --socket-path=3DPATH

may inevitably grow more options  - eg to perhaps say whether
to use it in listen or connect mode. Or to indicate a reconnect
timeout. etc

I know Markus wants to replace QemuOpts with something that
is again driven by QAPI, so that "-arg $VALUE" can handle
$VALUE being complex  non-scalar data following a QAPI
schema with well defined semantics for parsing. Since we
are defining a new standard, I think we should go todo
something better than scalar values right from the start.

> +
> +At the time of writing, there are no common capabilities. Some
> +device-specific capabilities are listed in the respective sections. By
> +convention, device-specific capabilities are prefixed by their device
> +name.
> +
> +vhost-user-input program conventions
> +------------------------------------
> +
> +Capabilities:
> +
> +input-evdev-path
> +
> +    The --evdev-path command line option is supported.
> +
> +input-no-grab
> +
> +    The --no-grab command line option is supported.
> +
> +* --evdev-path=3DPATH (optional)
> +
> +Specify the linux input device.
> +
> +* --no-grab (optional)
> +
> +Do no request exclusive access to the input device.
> +
> +vhost-user-gpu program conventions
> +----------------------------------
> +
> +Capabilities:
> +
> +gpu-render-node
> +
> +    The --render-node command line option is supported.
> +
> +gpu-virgl
> +
> +    The --virgl command line option is supported.
> +
> +* --render-node=3DPATH (optional)
> +
> +Specify the GPU DRM render node.
> +
> +* --virgl (optional)
> +
> +Enable virgl rendering support.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

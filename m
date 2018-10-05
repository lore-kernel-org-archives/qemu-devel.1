Received: from eggs.gnu.org ([2001:4830:134:3::10]:55519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1g8QW2-0000d4-5o
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1g8QVt-0004pm-9s
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:51:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1g8QVn-0004i5-NE
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:51:24 -0400
Date: Fri, 5 Oct 2018 15:50:52 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20181005135052.GA4113@lpt>
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20180914135230.15178-1-marcandre.lureau@redhat.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Victor Kaplansky <victork@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Changpeng Liu <changpeng.liu@intel.com>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2018 at 05:52:30PM +0400, Marc-Andr=E9 Lureau wrote:
>As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
>review, let's define a common set of backend conventions to help with
>management layer implementation, and interoperability.
>
>v2:
> - drop --pidfile
> - add some notes about daemonizing & stdin/out/err
>
>Cc: libvir-list@redhat.com
>Cc: Gerd Hoffmann <kraxel@redhat.com>
>Cc: Daniel P. Berrang=E9 <berrange@redhat.com>
>Cc: Changpeng Liu <changpeng.liu@intel.com>
>Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>Cc: Felipe Franciosi <felipe@nutanix.com>
>Cc: Gonglei <arei.gonglei@huawei.com>
>Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
>Cc: Michael S. Tsirkin <mst@redhat.com>
>Cc: Victor Kaplansky <victork@redhat.com>
>Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>---
> docs/interop/vhost-user.txt | 109 +++++++++++++++++++++++++++++++++++-
> 1 file changed, 107 insertions(+), 2 deletions(-)
>
>diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
>index ba5e37d714..339b335e9c 100644
>--- a/docs/interop/vhost-user.txt
>+++ b/docs/interop/vhost-user.txt
>@@ -17,8 +17,13 @@ The protocol defines 2 sides of the communication, mast=
er and slave. Master is
> the application that shares its virtqueues, in our case QEMU. Slave is the
> consumer of the virtqueues.
>
>-In the current implementation QEMU is the Master, and the Slave is intend=
ed to
>-be a software Ethernet switch running in user space, such as Snabbswitch.
>+In the current implementation QEMU is the Master, and the Slave is the
>+external process consuming the virtio queues, for example a software
>+Ethernet switch running in user space, such as Snabbswitch, or a block
>+device backend processing read & write to a virtual disk. In order to
>+facilitate interoperability between various backend implementations,
>+it is recommended to follow the "Backend program conventions"
>+described in this document.
>
> Master and slave can be either a client (i.e. connecting) or server (list=
ening)
> in the socket communication.
>@@ -859,3 +864,103 @@ resilient for selective requests.
> For the message types that already solicit a reply from the client, the
> presence of VHOST_USER_PROTOCOL_F_REPLY_ACK or need_reply bit being set b=
rings
> no behavioural change. (See the 'Communication' section for details.)
>+
>+Backend program conventions
>+---------------------------
>+
>+vhost-user backends provide various services and they may need to be
>+configured manually depending on the use case. However, it is a good
>+idea to follow the conventions listed here when possible. Users, QEMU
>+or libvirt, can then rely on some common behaviour to avoid
>+heterogenous configuration and management of the backend program and
>+facilitate interoperability.
>+
>+In order to be discoverable, default vhost-user backends should be
>+located under "/usr/libexec", and be named "vhost-user-$device" where
>+"$device" is the device name in lower-case following the name listed
>+in the Linux virtio_ids.h header (ex: the VIRTIO_ID_RPROC_SERIAL
>+backend would be named "vhost-user-rproc-serial").
>+
>+Mechanisms to list, and to select among alternatives implementations
>+or modify the default backend are not described at this point (a
>+distribution may use update-alternatives, for example, to list and to
>+pick a different default backend).
>+
>+The backend program must not daemonize itself, but it may be
>+daemonized by the management layer. It may also have a restricted
>+access to the system.
>+
>+File descriptors 0, 1 and 2 will exist, and have regular
>+stdin/stdout/stderr usage (they may be redirected to /dev/null by the
>+management layer, or to a log handler).
>+
>+The backend program must end (as quickly and cleanly as possible) when
>+the SIGTERM signal is received. Eventually, it may be SIGKILL by the
>+management layer after a few seconds.
>+
>+The following command line options have an expected behaviour. They
>+are mandatory, unless explicitly said differently:
>+
>+* --socket-path=3DPATH
>+
>+This option specify the location of the vhost-user Unix domain socket.

Will the backend program listen on this socket or connect to it?

>+It is incompatible with --fd.
>+
>+* --fd=3DFDNUM
>+
>+When this argument is given, the backend program is started with the
>+vhost-user socket as file descriptor FDNUM. It is incompatible with
>+--socket-path.
>+
>+* --print-capabilities
>+
>+Output to stdout a line-seperated list of backend capabilities, and
>+then exit successfully. Other options and arguments should be ignored,
>+and the backend program should not perform its normal function.
>+
>+At the time of writing, there are no common capabilities. Some
>+device-specific capabilities are listed in the respective sections. By
>+convention, device-specific capabilities are prefixed by their device
>+name.

Ideally, this would not be needed by libvirt.
QEMU capability probing is nice to have when we need to provide a
helpful error message (and avoid the lengthy preparation and cleanup
in case it fails), but absolutely necessary if we need to supply
different command line arguments to maintain the same functionality.

I was really happy to be able to delete qemu-img help parsing when
we dropped support for QEMU < 1.5.0 in upstream libvirt,
see commit e5261d8fe382483a85b86bfad7ba1d28dc939687

So unless the helper's command line arguments get new meaning in new
versions, libvirt can just pass on all the options requested in domain
XML and expect the helper to fail if it cannot satisfy them.

Jano

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAlu3bDQACgkQ+YPwO/Ma
t52kZAf+Jjs6VTcLBN89hYs+q2D3KsBQ/wYtijpTrBrDbM1Lmk3x4oWH4aOu9l+s
AAVN+XlQDT3oR25F/1Uq8PCRZQUVVwJL6z3h1vK6Nh62E0F8apCJ42p9F7oXYZTw
zFDyf/K2dK4q/zrg9PuZJhZqCA17qu0VAh3JGg14lxNnf0sG8cye7hEzqVE35000
W/c4duz+NjHtvgsVsmTe2hjvuBsWeChreHU3fLkV1sFeaBlHtLA1gH8TpLJSP8WF
1AxUBnaRpmWHPAdmkLFMC4uXTvfILXVRxbcat1mlfN+yB9PRt2crIc89IjEDTy52
udR/+c+vuNFebYBcmUQk95iqT2aNXg==
=A9Sf
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

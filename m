Received: from eggs.gnu.org ([2001:4830:134:3::10]:37167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g8RBl-0001uY-Qk
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g8R1A-0000UQ-Th
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:23:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1g8R1A-0000Sr-5z
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:23:48 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so10779221ioa.10
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 07:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
	<20181005135052.GA4113@lpt>
In-Reply-To: <20181005135052.GA4113@lpt>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Oct 2018 18:23:33 +0400
Message-ID: <CAMxuvawF+5=GyP70FNzS3zWfoe7Ca667hMKqmjWkhCe_bNCCMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Kaplansky,
	Victor" <victork@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, libvir-list <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Gonglei <arei.gonglei@huawei.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, "Liu,
	Changpeng" <changpeng.liu@intel.com>

Hi

On Fri, Oct 5, 2018 at 5:51 PM J=C3=A1n Tomko <jtomko@redhat.com> wrote:
>
> On Fri, Sep 14, 2018 at 05:52:30PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> >As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
> >review, let's define a common set of backend conventions to help with
> >management layer implementation, and interoperability.
> >
> >v2:
> > - drop --pidfile
> > - add some notes about daemonizing & stdin/out/err
> >
> >Cc: libvir-list@redhat.com
> >Cc: Gerd Hoffmann <kraxel@redhat.com>
> >Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >Cc: Changpeng Liu <changpeng.liu@intel.com>
> >Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >Cc: Felipe Franciosi <felipe@nutanix.com>
> >Cc: Gonglei <arei.gonglei@huawei.com>
> >Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> >Cc: Michael S. Tsirkin <mst@redhat.com>
> >Cc: Victor Kaplansky <victork@redhat.com>
> >Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >---
> > docs/interop/vhost-user.txt | 109 +++++++++++++++++++++++++++++++++++-
> > 1 file changed, 107 insertions(+), 2 deletions(-)
> >
> >diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> >index ba5e37d714..339b335e9c 100644
> >--- a/docs/interop/vhost-user.txt
> >+++ b/docs/interop/vhost-user.txt
> >@@ -17,8 +17,13 @@ The protocol defines 2 sides of the communication, ma=
ster and slave. Master is
> > the application that shares its virtqueues, in our case QEMU. Slave is =
the
> > consumer of the virtqueues.
> >
> >-In the current implementation QEMU is the Master, and the Slave is inte=
nded to
> >-be a software Ethernet switch running in user space, such as Snabbswitc=
h.
> >+In the current implementation QEMU is the Master, and the Slave is the
> >+external process consuming the virtio queues, for example a software
> >+Ethernet switch running in user space, such as Snabbswitch, or a block
> >+device backend processing read & write to a virtual disk. In order to
> >+facilitate interoperability between various backend implementations,
> >+it is recommended to follow the "Backend program conventions"
> >+described in this document.
> >
> > Master and slave can be either a client (i.e. connecting) or server (li=
stening)
> > in the socket communication.
> >@@ -859,3 +864,103 @@ resilient for selective requests.
> > For the message types that already solicit a reply from the client, the
> > presence of VHOST_USER_PROTOCOL_F_REPLY_ACK or need_reply bit being set=
 brings
> > no behavioural change. (See the 'Communication' section for details.)
> >+
> >+Backend program conventions
> >+---------------------------
> >+
> >+vhost-user backends provide various services and they may need to be
> >+configured manually depending on the use case. However, it is a good
> >+idea to follow the conventions listed here when possible. Users, QEMU
> >+or libvirt, can then rely on some common behaviour to avoid
> >+heterogenous configuration and management of the backend program and
> >+facilitate interoperability.
> >+
> >+In order to be discoverable, default vhost-user backends should be
> >+located under "/usr/libexec", and be named "vhost-user-$device" where
> >+"$device" is the device name in lower-case following the name listed
> >+in the Linux virtio_ids.h header (ex: the VIRTIO_ID_RPROC_SERIAL
> >+backend would be named "vhost-user-rproc-serial").
> >+
> >+Mechanisms to list, and to select among alternatives implementations
> >+or modify the default backend are not described at this point (a
> >+distribution may use update-alternatives, for example, to list and to
> >+pick a different default backend).
> >+
> >+The backend program must not daemonize itself, but it may be
> >+daemonized by the management layer. It may also have a restricted
> >+access to the system.
> >+
> >+File descriptors 0, 1 and 2 will exist, and have regular
> >+stdin/stdout/stderr usage (they may be redirected to /dev/null by the
> >+management layer, or to a log handler).
> >+
> >+The backend program must end (as quickly and cleanly as possible) when
> >+the SIGTERM signal is received. Eventually, it may be SIGKILL by the
> >+management layer after a few seconds.
> >+
> >+The following command line options have an expected behaviour. They
> >+are mandatory, unless explicitly said differently:
> >+
> >+* --socket-path=3DPATH
> >+
> >+This option specify the location of the vhost-user Unix domain socket.
>
> Will the backend program listen on this socket or connect to it?

Connect (if we ever need to support the listen mode, we can have another op=
tion)

>
> >+It is incompatible with --fd.
> >+
> >+* --fd=3DFDNUM
> >+
> >+When this argument is given, the backend program is started with the
> >+vhost-user socket as file descriptor FDNUM. It is incompatible with
> >+--socket-path.
> >+
> >+* --print-capabilities
> >+
> >+Output to stdout a line-seperated list of backend capabilities, and
> >+then exit successfully. Other options and arguments should be ignored,
> >+and the backend program should not perform its normal function.
> >+
> >+At the time of writing, there are no common capabilities. Some
> >+device-specific capabilities are listed in the respective sections. By
> >+convention, device-specific capabilities are prefixed by their device
> >+name.
>
> Ideally, this would not be needed by libvirt.
> QEMU capability probing is nice to have when we need to provide a
> helpful error message (and avoid the lengthy preparation and cleanup
> in case it fails), but absolutely necessary if we need to supply
> different command line arguments to maintain the same functionality.
>
> I was really happy to be able to delete qemu-img help parsing when
> we dropped support for QEMU < 1.5.0 in upstream libvirt,
> see commit e5261d8fe382483a85b86bfad7ba1d28dc939687
>
> So unless the helper's command line arguments get new meaning in new
> versions, libvirt can just pass on all the options requested in domain
> XML and expect the helper to fail if it cannot satisfy them.

qemu-img is not exchangeable, and provides a fixed/growing set of functions=
.

Here the goal is to allow vhost-user backend to be implemented by
various parties, with various capabilities.

For example, "virgl" support may not be implemented. This
--print-capabilities is a simple way to check what the backend
implements.

All the capabilities currently have a corresponding program argument,
which should be listed in --help. But it's not necessarily the case
for all future capabilities (for example, migration, etc..)

I agree that libvirt may not need to check the capabilities for now,
and instead rely on a runtime/starting error.

thanks

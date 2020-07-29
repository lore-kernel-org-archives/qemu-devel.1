Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FE9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 23:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83023207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 23:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AB7RbCpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83023207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0vsZ-0007hP-P9
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 19:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k0vra-00070C-KY
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 19:51:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k0vrV-0005xM-RY
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 19:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596066712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ttdmk8Xb7/XvDb7zJfClwIoUmT2UzgzvcS+2HiGGRP0=;
 b=AB7RbCpqHwyIcSyVRPzleAc1fn339vOoazDwJDv+s1xGyZKfKgfzsAM9ajdE9sUTh9lRSD
 AfgaR7qyd2hWIjuFnQdYKM/pK7bQXb6Xga8etwcR+XnLm+zlStTT0WhCJQX7xWPCqbK1GD
 M4D8Uykzb3Rzhp9e7Ksx0SG5QtP23Iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-JWTBh9d7P4S138p0GXpd8A-1; Wed, 29 Jul 2020 19:51:46 -0400
X-MC-Unique: JWTBh9d7P4S138p0GXpd8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60F9510059A8;
 Wed, 29 Jul 2020 23:51:44 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6807719C71;
 Wed, 29 Jul 2020 23:51:37 +0000 (UTC)
Date: Wed, 29 Jul 2020 17:51:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH] introduce VFIO-over-socket protocol specificaion
Message-ID: <20200729175136.6c545802@x1.home>
In-Reply-To: <1594913503-52271-1-git-send-email-thanos.makatos@nutanix.com>
References: <1594913503-52271-1-git-send-email-thanos.makatos@nutanix.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 13:17:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: benjamin.walker@intel.com, elena.ufimtseva@oracle.com,
 tomassetti.andrea@gmail.com, John G Johnson <john.g.johnson@oracle.com>,
 jag.raman@oracle.com, james.r.harris@intel.com, swapnil.ingle@nutanix.com,
 konrad.wilk@oracle.com, yuvalkashtan@gmail.com, qemu-devel@nongnu.org,
 raphael.norwitz@nutanix.com, ismael@linux.com, Kanth.Ghatraju@oracle.com,
 stefanha@redhat.com, felipe@nutanix.com, marcandre.lureau@redhat.com,
 tina.zhang@intel.com, changpeng.liu@intel.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 08:31:43 -0700
Thanos Makatos <thanos.makatos@nutanix.com> wrote:

> This patch introduces the VFIO-over-socket protocol specification, which
> is designed to allow devices to be emulated outside QEMU, in a separate
> process. VFIO-over-socket reuses the existing VFIO defines, structs and
> concepts.
>=20
> It has been earlier discussed as an RFC in:
> "RFC: use VFIO over a UNIX domain socket to implement device offloading"
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> ---
>  docs/devel/vfio-over-socket.rst | 1135 +++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 1135 insertions(+), 0 deletions(-)
>  create mode 100644 docs/devel/vfio-over-socket.rst
>=20
> diff --git a/docs/devel/vfio-over-socket.rst b/docs/devel/vfio-over-socke=
t.rst
> new file mode 100644
> index 0000000..723b944
> --- /dev/null
> +++ b/docs/devel/vfio-over-socket.rst
> @@ -0,0 +1,1135 @@
> +***************************************
> +VFIO-over-socket Protocol Specification
> +***************************************
> +
> +Version 0.1
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +VFIO-over-socket, also known as vfio-user, is a protocol that allows a d=
evice
> +to be virtualized in a separate process outside of QEMU. VFIO-over-socke=
t
> +devices consist of a generic VFIO device type, living inside QEMU, which=
 we
> +call the client, and the core device implementation, living outside QEMU=
, which
> +we call the server. VFIO-over-socket can be the main transport mechanism=
 for
> +multi-process QEMU, however it can be used by other applications offerin=
g
> +device virtualization. Explaining the advantages of a
> +disaggregated/multi-process QEMU, and device virtualization outside QEMU=
 in
> +general, is beyond the scope of this document.
> +
> +This document focuses on specifying the VFIO-over-socket protocol. VFIO =
has
> +been chosen for the following reasons:
> +
> +1) It is a mature and stable API, backed by an extensively used framewor=
k.
> +2) The existing VFIO client implementation (qemu/hw/vfio/) can be largel=
y
> +   reused.
> +
> +In a proof of concept implementation it has been demonstrated that using=
 VFIO
> +over a UNIX domain socket is a viable option. VFIO-over-socket is design=
ed with
> +QEMU in mind, however it could be used by other client applications. The
> +VFIO-over-socket protocol does not require that QEMU's VFIO client
> +implementation is used in QEMU. None of the VFIO kernel modules are requ=
ired
> +for supporting the protocol, neither in the client nor the server, only =
the
> +source header files are used.
> +
> +The main idea is to allow a virtual device to function in a separate pro=
cess in
> +the same host over a UNIX domain socket. A UNIX domain socket (AF_UNIX) =
is
> +chosen because we can trivially send file descriptors over it, which in =
turn
> +allows:
> +
> +* Sharing of guest memory for DMA with the virtual device process.
> +* Sharing of virtual device memory with the guest for fast MMIO.
> +* Efficient sharing of eventfd's for triggering interrupts.
> +
> +However, other socket types could be used which allows the virtual devic=
e
> +process to run in a separate guest in the same host (AF_VSOCK) or remote=
ly
> +(AF_INET). Theoretically the underlying transport doesn't necessarily ha=
ve to
> +be a socket, however we don't examine such alternatives. In this documen=
t we
> +focus on using a UNIX domain socket and introduce basic support for the =
other
> +two types of sockets without considering performance implications.
> +
> +This document does not yet describe any internal details of the server-s=
ide
> +implementation, however QEMU's VFIO client implementation will have to b=
e
> +adapted according to this protocol in order to support VFIO-over-socket =
virtual
> +devices.
> +
> +VFIO
> +=3D=3D=3D=3D
> +VFIO is a framework that allows a physical device to be securely passed =
through
> +to a user space process; the kernel does not drive the device at all.
> +Typically, the user space process is a VM and the device is passed throu=
gh to
> +it in order to achieve high performance. VFIO provides an API and the re=
quired
> +functionality in the kernel. QEMU has adopted VFIO to allow a guest virt=
ual
> +machine to directly access physical devices, instead of emulating them i=
n
> +software
> +
> +VFIO-over-socket reuses the core VFIO concepts defined in its API, but
> +implements them as messages to be sent over a UNIX-domain socket. It doe=
s not
> +change the kernel-based VFIO in any way, in fact none of the VFIO kernel
> +modules need to be loaded to use VFIO-over-socket. It is also possible f=
or QEMU
> +to concurrently use the current kernel-based VFIO for one guest device, =
and use
> +VFIO-over-socket for another device in the same guest.
> +
> +VFIO Device Model
> +-----------------
> +A device under VFIO presents a standard VFIO model to the user process. =
Many
> +of the VFIO operations in the existing kernel model use the ioctl() syst=
em
> +call, and references to the existing model are called the ioctl()
> +implementation in this document.
> +
> +The following sections describe the set of messages that implement the V=
FIO
> +device model over a UNIX domain socket. In many cases, the messages are =
direct
> +translations of data structures used in the ioctl() implementation. Mess=
ages
> +derived from ioctl()s will have a name derived from the ioctl() command =
name.
> +E.g., the VFIO_GET_INFO ioctl() command becomes a VFIO_USER_GET_INFO mes=
sage.
> +The purpose for this reuse is to share as much code as feasible with the
> +ioctl() implementation.
> +
> +Client and Server
> +^^^^^^^^^^^^^^^^^
> +The socket connects two processes together: a client process and a serve=
r
> +process. In the context of this document, the client process is the proc=
ess
> +emulating a guest virtual machine, such as QEMU. The server process is a
> +process that provides device emulation.
> +
> +Connection Initiation
> +^^^^^^^^^^^^^^^^^^^^^
> +After the client connects to the server, the initial server message is
> +VFIO_USER_VERSION to propose a protocol version and set of capabilities =
to
> +apply to the session. The client replies with a compatible version and s=
et of
> +capabilities it will support, or closes the connection if it cannot supp=
ort the
> +advertised version.
> +
> +Guest Memory Configuration
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +The client uses VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP messages to in=
form
> +the server of the valid guest DMA ranges that the server can access on b=
ehalf
> +of a device. Guest memory may be accessed by the server via VFIO_USER_DM=
A_READ
> +and VFIO_USER_DMA_WRITE messages over the socket.
> +
> +An optimization for server access to guest memory is for the client to p=
rovide
> +file descriptors the server can mmap() to directly access guest memory. =
Note
> +that mmap() privileges cannot be revoked by the client, therefore file
> +descriptors should only be exported in environments where the client tru=
sts the
> +server not to corrupt guest memory.
> +
> +Device Information
> +^^^^^^^^^^^^^^^^^^
> +The client uses a VFIO_USER_DEVICE_GET_INFO message to query the server =
for
> +information about the device. This information includes:
> +
> +* The device type and capabilities,
> +* the number of memory regions, and
> +* the device presents to the guest the number of interrupt types the dev=
ice
> +  supports.
> +
> +Region Information
> +^^^^^^^^^^^^^^^^^^
> +The client uses VFIO_USER_DEVICE_GET_REGION_INFO messages to query the s=
erver
> +for information about the device's memory regions. This information desc=
ribes:
> +
> +* Read and write permissions, whether it can be memory mapped, and wheth=
er it
> +  supports additional capabilities.
> +* Region index, size, and offset.
> +
> +When a region can be mapped by the client, the server provides a file
> +descriptor which the client can mmap(). The server is responsible for po=
lling
> +for client updates to memory mapped regions.
> +
> +Region Capabilities
> +"""""""""""""""""""
> +Some regions have additional capabilities that cannot be described adequ=
ately
> +by the region info data structure. These capabilities are returned in th=
e
> +region info reply in a list similar to PCI capabilities in a PCI device'=
s
> +configuration space.=20
> +
> +Sparse Regions
> +""""""""""""""
> +A region can be memory-mappable in whole or in part. When only a subset =
of a
> +region can be mapped by the client, a VFIO_REGION_INFO_CAP_SPARSE_MMAP
> +capability is included in the region info reply. This capability describ=
es
> +which portions can be mapped by the client.
> +
> +For example, in a virtual NVMe controller, sparse regions can be used so=
 that
> +accesses to the NVMe registers (found in the beginning of BAR0) are trap=
ped (an
> +infrequent an event), while allowing direct access to the doorbells (an
> +extremely frequent event as every I/O submission requires a write to BAR=
0),
> +found right after the NVMe registers in BAR0.
> +
> +Interrupts
> +^^^^^^^^^^
> +The client uses VFIO_USER_DEVICE_GET_IRQ_INFO messages to query the serv=
er for
> +the device's interrupt types. The interrupt types are specific to the bu=
s the
> +device is attached to, and the client is expected to know the capabiliti=
es of
> +each interrupt type. The server can signal an interrupt either with
> +VFIO_USER_VM_INTERRUPT messages over the socket, or can directly inject
> +interrupts into the guest via an event file descriptor. The client confi=
gures
> +how the server signals an interrupt with VFIO_USER_SET_IRQS messages.


Given that in-kernel VFIO uses eventfds exclusively for interrupts
to the client, what's the use case of the VFIO_USER_VM_INTERRUPT message
over the socket to generate an interrupt?  If a client wanted to know
about it, wouldn't they have used VFIO_USER_SET_IRQS to configure an
eventfd?

> +
> +Device Read and Write
> +^^^^^^^^^^^^^^^^^^^^^
> +When the guest executes load or store operations to device memory, the c=
lient
> +forwards these operations to the server with VFIO_USER_REGION_READ or
> +VFIO_USER_REGION_WRITE messages. The server will reply with data from th=
e
> +device on read operations or an acknowledgement on write operations.
> +
> +DMA
> +^^^
> +When a device performs DMA accesses to guest memory, the server will for=
ward
> +them to the client with VFIO_USER_DMA_READ and VFIO_USER_DMA_WRITE messa=
ges.
> +These messages can only be used to access guest memory the client has
> +configured into the server.
> +
> +Protocol Specification
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +To distinguish from the base VFIO symbols, all VFIO-over-socket symbols =
are
> +prefixed with vfio_user or VFIO_USER. In revision 0.1, all data is in th=
e
> +little-endian format, although this may be relaxed in future revision in=
 cases
> +where the client and server are both big-endian. The messages are format=
ted
> +for seamless reuse of the native VFIO structs. A server can serve:
> +
> +1) multiple clients, and/or
> +2) multiple virtual devices, belonging to one or more clients.
> +
> +Therefore each message requires a header that uniquely identifies the vi=
rtual
> +device. It is a server-side implementation detail whether a single serve=
r
> +handles multiple virtual devices from the same or multiple guests.
>
> +Socket
> +------
> +A single UNIX domain socket is assumed to be used for each device. The l=
ocation
> +of the socket is implementation-specific. Multiplexing clients, devices,=
 and
> +servers over the same socket is not supported in this version of the pro=
tocol,
> +but a device ID field exists in the message header so that a future supp=
ort can
> +be added without a major version change.


If we were to make use of that, we really start to stray from the
in-kernel model where a file descriptor is the representation of a
device to the user.  It also seems to invite server exploits if a
client can attempt to spoof devices used by other clients through their
socket.  How do you imagine this being used?


> +Authentication
> +--------------
> +For AF_UNIX, we rely on OS mandatory access controls on the socket files=
,
> +therefore it is up to the management layer to set up the socket as requi=
red.
> +Socket types than span guests or hosts will require a proper authenticat=
ion


s/than/that/


> +mechanism. Defining that mechanism is deferred to a future version of th=
e
> +protocol.
> +
> +Request Concurrency
> +-------------------
> +There can be multiple outstanding requests per virtual device, e.g. a
> +frame buffer where the guest does multiple stores to the virtual device.=
 The
> +server can execute and reorder non-conflicting requests in parallel, dep=
ending
> +on the device semantics.
> +
> +Socket Disconnection Behavior
> +-----------------------------
> +The server and the client can disconnect from each other, either intenti=
onally
> +or unexpectedly. Both the client and the server need to know how to hand=
le such
> +events.
> +
> +Server Disconnection
> +^^^^^^^^^^^^^^^^^^^^
> +A server disconnecting from the client may indicate that:
> +
> +1) A virtual device has been restarted, either intentionally (e.g. becau=
se of a
> +device update) or unintentionally (e.g. because of a crash). In any case=
, the
> +virtual device will come back so the client should not do anything (e.g.=
 simply
> +reconnect and retry failed operations).
> +
> +2) A virtual device has been shut down with no intention to be restarted=
.
> +
> +It is impossible for the client to know whether or not a failure is
> +intermittent or innocuous and should be retried, therefore the client sh=
ould
> +attempt to reconnect to the socket. Since an intentional server restart =
(e.g.
> +due to an upgrade) might take some time, a reasonable timeout should be =
used.
> +In cases where the disconnection is expected (e.g. the guest shutting do=
wn), no
> +new requests will be sent anyway so this situation doesn't pose a proble=
m. The
> +control stack will clean up accordingly.


The theory sounds reasonable, the practice sounds much more difficult.
For example if we're emulating a PCI device in the client, a blocked
read or write could be problematic to the guest.


> +Parametrizing this behaviour by having the virtual device advertise a
> +reasonable reconnect is deferred to a future version of the protocol.
> +
> +Client Disconnection
> +^^^^^^^^^^^^^^^^^^^^
> +The client disconnecting from the server primarily means that the QEMU p=
rocess
> +has exited. Currently this means that the guest is shut down so the devi=
ce is
> +no longer needed therefore the server can automatically exit. However, t=
here
> +can be cases where a client disconnect should not result in a server exi=
t:
> +
> +1) A single server serving multiple clients.
> +2) A multi-process QEMU upgrading itself step by step, which isn't yet
> +   implemented.
> +
> +Therefore in order for the protocol to be forward compatible the server =
should
> +take no action when the client disconnects. If anything happens to the c=
lient
> +process the control stack will know about it and can clean up resources
> +accordingly.


This seems to invite complication, if QEMU crashes, the device is gone
and the server should release the resources.  If we're in this mythical
second scenario, wouldn't it make sense to implement a suspend and
resume sequence such that the sever will exit or free resources unless
it's been told otherwise.  Maybe the suspend operation could also
indicate a timeout such that the server would consider the client dead
after some period and do cleanup.


> +Request Retry and Response Timeout
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +QEMU's VFIO retries certain operations if they fail. While this makes se=
nse for
> +real HW, we don't know for sure whether it makes sense for virtual devic=
es. A
> +failed request is a request that has been successfully sent and has been
> +responded to with an error code. Failure to send the request in the firs=
t place
> +(e.g. because the socket is disconnected) is a different type of error e=
xamined
> +earlier in the disconnect section.
> +
> +Defining a retry and timeout scheme if deferred to a future version of t=
he
> +protocol.
> +
> +Commands
> +--------
> +The following table lists the VFIO message command IDs, and whether the
> +message request is sent from the client or the server.
> +
> ++----------------------------------+---------+-------------------+
> +| Name                             | Command | Request Direction |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| VFIO_USER_VERSION                | 1       | server =C3=A2=E2=80=A0=E2=
=80=99 client   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DMA_MAP                | 2       | client =C3=A2=E2=80=A0=E2=
=80=99 server   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DMA_UNMAP              | 3       | client =C3=A2=E2=80=A0=E2=
=80=99 server   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DEVICE_GET_INFO        | 4       | client =C3=A2=E2=80=A0=E2=
=80=99 server   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DEVICE_GET_REGION_INFO | 5       | client =C3=A2=E2=80=A0=E2=
=80=99 server   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DEVICE_GET_IRQ_INFO    | 6       | client =C3=A2=E2=80=A0=E2=
=80=99 server   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DEVICE_SET_IRQS        | 7       | client =C3=A2=E2=80=A0=E2=
=80=99 server   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_REGION_READ            | 8       | client =C3=A2=E2=80=A0=E2=
=80=99 server   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_REGION_WRITE           | 9       | client =C3=A2=E2=80=A0=E2=
=80=99 server   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DMA_READ               | 10      | server =C3=A2=E2=80=A0=E2=
=80=99 client   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_DMA_READ               | 11      | server =C3=A2=E2=80=A0=E2=
=80=99 client   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_USER_VM_INTERRUPT           | 12      | server =C3=A2=E2=80=A0=E2=
=80=99 client   |
> ++----------------------------------+---------+-------------------+
> +| VFIO_DEVICE_RESET                | 13      | client =C3=A2=E2=80=A0=E2=
=80=99 server   |
> ++----------------------------------+---------+-------------------+


The only one not to use _USER_?


> +
> +Header
> +------
> +All messages are preceded by a 16 byte header that contains basic inform=
ation
> +about the message. The header is followed by message-specific data descr=
ibed
> +in the sections below.
> +
> ++----------------+--------+-------------+
> +| Name           | Offset | Size        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID      | 0      | 2           |
> ++----------------+--------+-------------+
> +| Message ID     | 2      | 2           |
> ++----------------+--------+-------------+
> +| Command        | 4      | 4           |
> ++----------------+--------+-------------+
> +| Message size   | 8      | 4           |
> ++----------------+--------+-------------+
> +| Flags          | 12     | 4           |
> ++----------------+--------+-------------+
> +|                | +-----+------------+ |
> +|                | | Bit | Definition | |
> +|                | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+ |
> +|                | | 0   | Reply      | |
> +|                | +-----+------------+ |
> +|                | | 1   | No_reply   | |
> +|                | +-----+------------+ |=20
> ++----------------+--------+-------------+
> +| <message data> | 16     | variable    |
> ++----------------+--------+-------------+
> +
> +* Device ID identifies the destination device of the message. This field=
 is
> +  reserved when the server only supports one device per socket.
> +* Message ID identifies the message, and is used in the message acknowle=
dgement.


I don't find any protocol for managing this.  Is the client expected to
increment per message and wrap around?


> +* Command specifies the command to be executed, listed in the Command Ta=
ble.
> +* Message size contains the size of the entire message, including the he=
ader.
> +* Flags contains attributes of the message:
> +
> +  * The reply bit differentiates request messages from reply messages. A=
 reply
> +    message acknowledges a previous request with the same message ID.
> +  * No_reply indicates that no reply is needed for this request. This is
> +    commonly used when multiple requests are sent, and only the last nee=
ds
> +    acknowledgement.


I wish I could think of better terminology, I had to delete my question
of why we need two bits for flags that at a casual read appear to be
opposites ;)


> +
> +VFIO_USER_VERSION
> +-----------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | 0                      |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 1                      |
> ++--------------+------------------------+
> +| Message size | 16 + version length    |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +| Version      | JSON byte array        |
> ++--------------+------------------------+
> +
> +This is the initial message sent by the server after the socket connecti=
on is
> +established. The version is in JSON format, and the following objects mu=
st be
> +included:
> +
> ++--------------+--------+-----------------------------------------------=
----+
> +| Name         | Type   | Description                                   =
    |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+
> +| version      | object | {=C3=A2=E2=82=AC=C5=93major=C3=A2=E2=82=AC=EF=
=BF=BD: <number>, =C3=A2=E2=82=AC=C5=93minor=C3=A2=E2=82=AC=EF=BF=BD: <numb=
er>}            |
> +|              |        | Version supported by the sender, e.g. =C3=A2=
=E2=82=AC=C5=930.1=C3=A2=E2=82=AC=EF=BF=BD.      |
> ++--------------+--------+-----------------------------------------------=
----+
> +| type         | string | Fixed to =C3=A2=E2=82=AC=C5=93vfio-user=C3=A2=
=E2=82=AC=EF=BF=BD.                             |
> ++--------------+--------+-----------------------------------------------=
----+
> +| capabilities | array  | Reserved. Can be omitted for v0.1, otherwise m=
ust |
> +|              |        | be empty.                                     =
    |
> ++--------------+--------+-----------------------------------------------=
----+
> +
> +Versioning and Feature Support
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +Upon accepting a connection, the server must send a VFIO_USER_VERSION me=
ssage
> +proposing a protocol version and a set of capabilities. The client compa=
res
> +these with the versions and capabilities it supports and sends a
> +VFIO_USER_VERSION reply according to the following rules.
> +
> +* The major version in the reply must be the same as proposed. If the cl=
ient
> +  does not support the proposed major, it closes the connection.
> +* The minor version in the reply must be equal to or less than the minor
> +  version proposed.
> +* The capability list must be a subset of those proposed. If the client
> +  requires a capability the server did not include, it closes the connec=
tion.
> +* If type is not =C3=A2=E2=82=AC=C5=93vfio-user=C3=A2=E2=82=AC=EF=BF=BD,=
 the client closes the connection.
> +
> +The protocol major version will only change when incompatible protocol c=
hanges
> +are made, such as changing the message format. The minor version may cha=
nge
> +when compatible changes are made, such as adding new messages or capabil=
ities,
> +Both the client and server must support all minor versions less than the
> +maximum minor version it supports. E.g., an implementation that supports
> +version 1.3 must also support 1.0 through 1.2.
> +
> +VFIO_USER_DMA_MAP
> +-----------------
> +
> +VFIO_USER_DMA_UNMAP
> +-------------------
> +
> +Message Format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | 0                      |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | MAP=3D2, UNMAP=3D3         |
> ++--------------+------------------------+
> +| Message size | 16 + table size        |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +| Table        | array of table entries |
> ++--------------+------------------------+
> +
> +This message is sent by the client to the server to inform it of the gue=
st
> +memory regions the device can access. It must be sent before the device =
can
> +perform any DMA to the guest. It is normally sent directly after the ver=
sion
> +handshake is completed, but may also occur when memory is added or subtr=
acted
> +in the guest.
> +
> +The table is an array of the following structure. This structure is 32 b=
ytes
> +in size, so the message size will be 16 + (# of table entries * 32). If =
a
> +region being added can be directly mapped by the server, an array of fil=
e
> +descriptors will be sent as part of the message meta-data. Each region e=
ntry
> +will have a corresponding file descriptor. On AF_UNIX sockets, the file
> +descriptors will be passed as SCM_RIGHTS type ancillary data.
> +
> +Table entry format
> +^^^^^^^^^^^^^^^^^^
> +
> ++-------------+--------+-------------+
> +| Name        | Offset | Size        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Address     | 0      | 8           |
> ++-------------+--------+-------------+
> +| Size        | 8      | 8           |
> ++-------------+--------+-------------+
> +| Offset      | 16     | 8           |
> ++-------------+--------+-------------+
> +| Protections | 24     | 4           |
> ++-------------+--------+-------------+
> +| Flags       | 28     | 4           |
> ++-------------+--------+-------------+
> +|             | +-----+------------+ |
> +|             | | Bit | Definition | |
> +|             | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+ |
> +|             | | 0   | Mappable   | |
> +|             | +-----+------------+ |
> ++-------------+--------+-------------+
> +
> +* Address is the base DMA address of the region.
> +* Size is the size of the region.
> +* Offset is the file offset of the region with respect to the associated=
 file
> +  descriptor.
> +* Protections are the region's protection attributes as encoded in
> +  ``<sys/mman.h>``.
> +* Flags contain the following region attributes:
> +
> +  * Mappable indicate the region can be mapped via the mmap() system cal=
l using
> +    the file descriptor provided in the message meta-data.
> +
> +VFIO_USER_DEVICE_GET_INFO
> +-------------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+----------------------------+
> +| Name         | Value                      |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                       |


The previous commands were specified with Device ID 0, which made me
think that's the reserved value, but here we indicate it as a variable.
Does this imply that VFIO_USER_DMA_MAP/UNMAP are per socket rather than
per device?


> ++--------------+----------------------------+
> +| Message ID   | <ID>                       |
> ++--------------+----------------------------+
> +| Command      | 4                          |
> ++--------------+----------------------------+
> +| Message size | 16 in request, 32 in reply |
> ++--------------+----------------------------+
> +| Flags        | Reply bit set in reply     |
> ++--------------+----------------------------+
> +| Device info  | VFIO device info           |
> ++--------------+----------------------------+
> +
> +This message is sent by the client to the server to query for basic info=
rmation
> +about the device. Only the message header is needed in the request messa=
ge.
> +The VFIO device info structure is defined in ``<sys/vfio.h>`` (``struct


<linux/vfio.h>?


> +vfio_device_info``).
> +
> +VFIO device info format
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-------------+--------+--------------------------+
> +| Name        | Offset | Size                     |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| argsz       | 16     | 4                        |
> ++-------------+--------+--------------------------+
> +| flags       | 20     | 4                        |
> ++-------------+--------+--------------------------+
> +|             | +-----+-------------------------+ |
> +|             | | Bit | Definition              | |
> +|             | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+ |
> +|             | | 0   | VFIO_DEVICE_FLAGS_RESET | |
> +|             | +-----+-------------------------+ |
> +|             | | 1   | VFIO_DEVICE_FLAGS_PCI   | |
> +|             | +-----+-------------------------+ |
> ++-------------+--------+--------------------------+
> +| num_regions | 24     | 4                        |
> ++-------------+--------+--------------------------+
> +| num_irqs    | 28     | 4                        |
> ++-------------+--------+--------------------------+
> +
> +* argz is reserved in vfio-user, it is only used in the ioctl() VFIO
> +  implementation.


This seems strange, why not use it throughout?  It seems this makes it
more difficult for the client if it wants to unwrap the reply and send
it through code common with in-kernel vfio usage.


> +* flags contains the following device attributes.
> +
> +  * VFIO_DEVICE_FLAGS_RESET indicates the device supports the
> +    VFIO_USER_DEVICE_RESET message.
> +  * VFIO_DEVICE_FLAGS_PCI indicates the device is a PCI device.
> +
> +* num_regions is the number of memory regions the device exposes.
> +* num_irqs is the number of distinct interrupt types the device supports=
.
> +
> +This version of the protocol only supports PCI devices. Additional devic=
es may
> +be supported in future versions.=20
> +
> +VFIO_USER_DEVICE_GET_REGION_INFO
> +--------------------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------+
> +| Name         | Value            |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>             |
> ++--------------+------------------+
> +| Message ID   | <ID>             |
> ++--------------+------------------+
> +| Command      | 5                |=20
> ++--------------+------------------+
> +| Message size | 48 + any caps    |
> ++--------------+------------------+
> +| Flags Reply  | bit set in reply |
> ++--------------+------------------+
> +| Region info  | VFIO region info |
> ++--------------+------------------+
> +
> +This message is sent by the client to the server to query for informatio=
n about
> +device memory regions. The VFIO region info structure is defined in
> +``<sys/vfio.h>`` (``struct vfio_region_info``).
> +
> +VFIO region info format
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> ++------------+--------+------------------------------+
> +| Name       | Offset | Size                         |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> +| argsz      | 16     | 4                            |
> ++------------+--------+------------------------------+
> +| flags      | 20     | 4                            |
> ++------------+--------+------------------------------+
> +|            | +-----+-----------------------------+ |
> +|            | | Bit | Definition                  | |
> +|            | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+ |
> +|            | | 0   | VFIO_REGION_INFO_FLAG_READ  | |
> +|            | +-----+-----------------------------+ |
> +|            | | 1   | VFIO_REGION_INFO_FLAG_WRITE | |
> +|            | +-----+-----------------------------+ |
> +|            | | 2   | VFIO_REGION_INFO_FLAG_MMAP  | |
> +|            | +-----+-----------------------------+ |
> +|            | | 3   | VFIO_REGION_INFO_FLAG_CAPS  | |
> +|            | +-----+-----------------------------+ |
> ++------------+--------+------------------------------+
> +| index      | 24     | 4                            |
> ++------------+--------+------------------------------+
> +| cap_offset | 28     | 4                            |
> ++------------+--------+------------------------------+
> +| size       | 32     | 8                            |
> ++------------+--------+------------------------------+
> +| offset     | 40     | 8                            |
> ++------------+--------+------------------------------+
> +
> +* argz is reserved in vfio-user, it is only used in the ioctl() VFIO
> +  implementation.
> +* flags are attributes of the region:
> +
> +  * VFIO_REGION_INFO_FLAG_READ allows client read access to the region.
> +  * VFIO_REGION_INFO_FLAG_WRITE allows client write access region.
> +  * VFIO_REGION_INFO_FLAG_MMAP specifies the client can mmap() the regio=
n. When
> +    this flag is set, the reply will include a file descriptor in its me=
ta-data.
> +    On AF_UNIX sockets, the file descriptors will be passed as SCM_RIGHT=
S type
> +    ancillary data.
> +  * VFIO_REGION_INFO_FLAG_CAPS indicates additional capabilities found i=
n the
> +    reply.
> +
> +* index is the index of memory region being queried, it is the only fiel=
d that
> +  is required to be set in the request message.
> +* cap_offset describes where additional region capabilities can be found=
.
> +  cap_offset is relative to the beginning of the VFIO region info struct=
ure.
> +  The data structure it points is a VFIO cap header defined in ``<sys/vf=
io.h>``.
> +* size is the size of the region.
> +* offset is the offset given to the mmap() system call for regions with =
the
> +  MMAP attribute. It is also used as the base offset when mapping a VFIO
> +  sparse mmap area, described below.
> +
> +VFIO Region capabilities
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +The VFIO region information can also include a capabilities list. This l=
ist is
> +similar to a PCI capability list - each entry has a common header that
> +identifies a capability and where the next capability in the list can be=
 found.
> +The VFIO capability header format is defined in ``<sys/vfio.h>`` (``stru=
ct
> +vfio_info_cap_header``).
> +
> +VFIO cap header format
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> ++---------+--------+------+
> +| Name    | Offset | Size |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
+
> +| id      | 0      | 2    |
> ++---------+--------+------+
> +| version | 2      | 2    |
> ++---------+--------+------+
> +| next    | 4      | 4    |
> ++---------+--------+------+
> +
> +* id is the capability identity.
> +* version is a capability-specific version number.
> +* next specifies the offset of the next capability in the capability lis=
t. It
> +  is relative to the beginning of the VFIO region info structure.
> +
> +VFIO sparse mmap
> +^^^^^^^^^^^^^^^^
> +
> ++------------------+----------------------------------+
> +| Name             | Value                            |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> +| id               | VFIO_REGION_INFO_CAP_SPARSE_MMAP |
> ++------------------+----------------------------------+
> +| version          | 0x1                              |
> ++------------------+----------------------------------+
> +| next             | <next>                           |
> ++------------------+----------------------------------+
> +| sparse mmap info | VFIO region info sparse mmap     |
> ++------------------+----------------------------------+
> +
> +The only capability supported in this version of the protocol is for spa=
rse
> +mmap. This capability is defined when only a subrange of the region supp=
orts
> +direct access by the client via mmap(). The VFIO sparse mmap area is def=
ined in
> +``<sys/vfio.h>`` (``struct vfio_region_sparse_mmap_area``).
> +
> +VFIO region info cap sparse mmap
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ++----------+--------+------+
> +| Name     | Offset | Size |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D+
> +| nr_areas | 0      | 4    |
> ++----------+--------+------+
> +| reserved | 4      | 4    |
> ++----------+--------+------+
> +| offset   | 8      | 8    |
> ++----------+--------+------+
> +| size     | 16     | 9    |
> ++----------+--------+------+
> +| ...      |        |      |
> ++----------+--------+------+
> +
> +* nr_areas is the number of sparse mmap areas in the region.
> +* offset and size describe a single area that can be mapped by the clien=
t.
> +  There will be nr_areas pairs of offset and size. The offset will be ad=
ded to
> +  the base offset given in the VFIO_USER_DEVICE_GET_REGION_INFO to form =
the
> +  offset argument of the subsequent mmap() call.
> +
> +The VFIO sparse mmap area is defined in ``<sys/vfio.h>`` (``struct
> +vfio_region_info_cap_sparse_mmap``).
> +
> +VFIO_USER_DEVICE_GET_IRQ_INFO
> +-----------------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                   |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 6                      |
> ++--------------+------------------------+
> +| Message size | 32                     |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +| IRQ info     | VFIO IRQ info          |
> ++--------------+------------------------+
> +
> +This message is sent by the client to the server to query for informatio=
n about
> +device interrupt types. The VFIO IRQ info structure is defined in
> +``<sys/vfio.h>`` (``struct vfio_irq_info``).
> +
> +VFIO IRQ info format
> +^^^^^^^^^^^^^^^^^^^^
> +
> ++-------+--------+---------------------------+
> +| Name  | Offset | Size                      |
> ++=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| argsz | 16     | 4                         |
> ++-------+--------+---------------------------+
> +| flags | 20     | 4                         |
> ++-------+--------+---------------------------+
> +|       | +-----+--------------------------+ |
> +|       | | Bit | Definition               | |
> +|       | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+ |
> +|       | | 0   | VFIO_IRQ_INFO_EVENTFD    | |
> +|       | +-----+--------------------------+ |
> +|       | | 1   | VFIO_IRQ_INFO_MASKABLE   | |
> +|       | +-----+--------------------------+ |
> +|       | | 2   | VFIO_IRQ_INFO_AUTOMASKED | |
> +|       | +-----+--------------------------+ |
> +|       | | 3   | VFIO_IRQ_INFO_NORESIZE   | |
> +|       | +-----+--------------------------+ |
> ++-------+--------+---------------------------+
> +| index | 24     | 4                         |
> ++-------+--------+---------------------------+
> +| count | 28     | 4                         |
> ++-------+--------+---------------------------+
> +
> +* argz is reserved in vfio-user, it is only used in the ioctl() VFIO
> +  implementation.
> +* flags defines IRQ attributes:
> +
> +  * VFIO_IRQ_INFO_EVENTFD indicates the IRQ type can support server even=
tfd
> +    signalling.
> +  * VFIO_IRQ_INFO_MASKABLE indicates that the IRQ type supports the MASK=
 and
> +    UNMASK actions in a VFIO_USER_DEVICE_SET_IRQS message.
> +  * VFIO_IRQ_INFO_AUTOMASKED indicates the IRQ type masks itself after b=
eing
> +    triggered, and the client must send an UNMASK action to receive new
> +    interrupts.
> +  * VFIO_IRQ_INFO_NORESIZE indicates VFIO_USER_SET_IRQS operations setup
> +    interrupts as a set, and new subindexes cannot be enabled without di=
sabling
> +    the entire type.
> +
> +* index is the index of IRQ type being queried, it is the only field tha=
t is
> +  required to be set in the request message.
> +* count describes the number of interrupts of the queried type.
> +
> +VFIO_USER_DEVICE_SET_IRQS
> +-------------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> +| Device ID    | <ID>                   |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 7                      |
> ++--------------+------------------------+
> +| Message size | 36 + any data          |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +| IRQ set      | VFIO IRQ set           |
> ++--------------+------------------------+
> +
> +This message is sent by the client to the server to set actions for devi=
ce
> +interrupt types. The VFIO IRQ set structure is defined in ``<sys/vfio.h>=
``
> +(``struct vfio_irq_set``).
> +
> +VFIO IRQ info format
> +^^^^^^^^^^^^^^^^^^^^
> +
> ++-------+--------+------------------------------+
> +| Name  | Offset | Size                         |
> ++=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| argsz | 6      | 4                            |
> ++-------+--------+------------------------------+
> +| flags | 20     | 4                            |
> ++-------+--------+------------------------------+
> +|       | +-----+-----------------------------+ |
> +|       | | Bit | Definition                  | |
> +|       | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+ |
> +|       | | 0   | VFIO_IRQ_SET_DATA_NONE      | |
> +|       | +-----+-----------------------------+ |
> +|       | | 1   | VFIO_IRQ_SET_DATA_BOOL      | |
> +|       | +-----+-----------------------------+ |
> +|       | | 2   | VFIO_IRQ_SET_DATA_EVENTFD   | |
> +|       | +-----+-----------------------------+ |
> +|       | | 3   | VFIO_IRQ_SET_ACTION_MASK    | |
> +|       | +-----+-----------------------------+ |
> +|       | | 4   | VFIO_IRQ_SET_ACTION_UNMASK  | |
> +|       | +-----+-----------------------------+ |
> +|       | | 5   | VFIO_IRQ_SET_ACTION_TRIGGER | |
> +|       | +-----+-----------------------------+ |
> ++-------+--------+------------------------------+
> +| index | 24     | 4                            |
> ++-------+--------+------------------------------+
> +| start | 28     | 4                            |
> ++-------+--------+------------------------------+
> +| count | 32     | 4                            |
> ++-------+--------+------------------------------+
> +| data  | 36     | variable                     |
> ++-------+--------+------------------------------+
> +
> +* argz is reserved in vfio-user, it is only used in the ioctl() VFIO
> +  implementation.
> +* flags defines the action performed on the interrupt range. The DATA fl=
ags
> +  describe the data field sent in the message; the ACTION flags describe=
 the
> +  action to be performed. The flags are mutually exclusive for both sets=
.
> +
> +  * VFIO_IRQ_SET_DATA_NONE indicates there is no data field in the reque=
st. The
> +    action is performed unconditionally.
> +  * VFIO_IRQ_SET_DATA_BOOL indicates the data field is an array of boole=
an
> +    bytes. The action is performed if the corresponding boolean is true.
> +  * VFIO_IRQ_SET_DATA_EVENTFD indicates an array of event file descripto=
rs was
> +    sent in the message meta-data. These descriptors will be signalled w=
hen the
> +    action defined by the action flags occurs. In AF_UNIX sockets, the
> +    descriptors are sent as SCM_RIGHTS type ancillary data.
> +  * VFIO_IRQ_SET_ACTION_MASK indicates a masking event. It can be used w=
ith
> +    VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE to mask an interrup=
t, or
> +    with VFIO_IRQ_SET_DATA_EVENTFD to generate an event when the guest m=
asks
> +    the interrupt.=20
> +  * VFIO_IRQ_SET_ACTION_UNMASK indicates an unmasking event. It can be u=
sed
> +    with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE to unmask an
> +    interrupt, or with VFIO_IRQ_SET_DATA_EVENTFD to generate an event wh=
en the
> +    guest unmasks the interrupt.=20
> +  * VFIO_IRQ_SET_ACTION_TRIGGER indicates a triggering event. It can be =
used
> +    with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE to trigger an
> +    interrupt, or with VFIO_IRQ_SET_DATA_EVENTFD to generate an event wh=
en the
> +    guest triggers the interrupt.
> +
> +* index is the index of IRQ type being setup.
> +* start is the start of the subindex being set.
> +* count describes the number of sub-indexes being set. As a special case=
, a
> +  count of 0 with data flags of VFIO_IRQ_SET_DATA_NONE disables all inte=
rrupts
> +  of the index data is an optional field included when the
                 ^
                 |
                 +-  Missing period?=20

> +  VFIO_IRQ_SET_DATA_BOOL flag is present. It contains an array of boolea=
ns
> +  that specify whether the action is to be performed on the correspondin=
g
> +  index. It's used when the action is only performed on a subset of the =
range
> +  specified.
> +
> +Not all interrupt types support every combination of data and action fla=
gs.
> +The client must know the capabilities of the device and IRQ index before=
 it
> +sends a VFIO_USER_DEVICE_SET_IRQ message.
> +
> +Read and Write Operations
> +-------------------------
> +
> +Not all I/O operations between the client and server can be done via dir=
ect
> +access of memory mapped with an mmap() call. In these cases, the client =
and
> +server use messages sent over the socket. It is expected that these oper=
ations
> +will have lower performance than direct access.
> +
> +The client can access device memory with VFIO_USER_REGION_READ and
> +VFIO_USER_REGION_WRITE requests. These share a common data structure tha=
t
> +appears after the 16 byte message header.=20
> +
> +REGION Read/Write Data
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> ++--------+--------+----------+
> +| Name   | Offset | Size     |
> ++=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> +| Offset | 16     | 8        |
> ++--------+--------+----------+
> +| Region | 24     | 4        |
> ++--------+--------+----------+
> +| Count  | 28     | 4        |
> ++--------+--------+----------+
> +| Data   | 32     | variable |
> ++--------+--------+----------+
> +
> +* Offset into the region being accessed.
> +* Region is the index of the region being accessed.
> +* Count is the size of the data to be transferred.
> +* Data is the data to be read or written.
> +
> +The server can access guest memory with VFIO_USER_DMA_READ and
> +VFIO_USER_DMA_WRITE messages. These also share a common data structure t=
hat
> +appears after the 16 byte message header.
> +
> +DMA Read/Write Data
> +^^^^^^^^^^^^^^^^^^^
> +
> ++---------+--------+----------+
> +| Name    | Offset | Size     |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> +| Address | 16     | 8        |
> ++---------+--------+----------+
> +| Count   | 24     | 4        |
> ++---------+--------+----------+
> +| Data    | 28     | variable |
> ++---------+--------+----------+
> +
> +* Address is the area of guest memory being accessed. This address must =
have
> +  been exported to the server with a VFIO_USER_DMA_MAP message.
> +* Count is the size of the data to be transferred.
> +* Data is the data to be read or written.
> +
> +Address and count can also be accessed as ``struct iovec`` from ``<sys/u=
io.h>``.
> +
> +VFIO_USER_REGION_READ
> +---------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                   |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 8                      |
> ++--------------+------------------------+
> +| Message size | 32 + data size         |
> ++--------------+------------------------+
> +| Flags Reply  | bit set in reply       |
> ++--------------+------------------------+
> +| Read info    | REGION read/write data |
> ++--------------+------------------------+
> +
> +This request is sent from the client to the server to read from device m=
emory.
> +In the request messages, there will be no data, and the count field will=
 be the
> +amount of data to be read. The reply will include the data read, and its=
 count
> +field will be the amount of data read.
> +
> +VFIO_USER_REGION_WRITE
> +----------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                   |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 9                      |
> ++--------------+------------------------+
> +| Message size | 32 + data size         |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +| Write info   | REGION read write data |
> ++--------------+------------------------+
> +
> +This request is sent from the client to the server to write to device me=
mory.
> +The request message will contain the data to be written, and its count f=
ield
> +will contain the amount of write data. The count field in the reply will=
 be
> +zero.
> +
> +VFIO_USER_DMA_READ
> +------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+---------------------+
> +| Name         | Value               |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                |
> ++--------------+---------------------+
> +| Message ID   | <ID>                |
> ++--------------+---------------------+
> +| Command      | 10                  |
> ++--------------+---------------------+
> +| Message size | 28 + data size      |
> ++--------------+---------------------+
> +| Flags Reply  | bit set in reply    |
> ++--------------+---------------------+
> +| DMA info     | DMA read/write data |
> ++--------------+---------------------+
> +
> +This request is sent from the server to the client to read from guest me=
mory.
> +In the request messages, there will be no data, and the count field will=
 be the
> +amount of data to be read. The reply will include the data read, and its=
 count
> +field will be the amount of data read.
> +
> +VFIO_USER_DMA_WRITE
> +-------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                   |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 11                     |
> ++--------------+------------------------+
> +| Message size | 28 + data size         |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +| DMA info     | DMA read/write data    |
> ++--------------+------------------------+
> +
> +This request is sent from the server to the client to write to guest mem=
ory.
> +The request message will contain the data to be written, and its count f=
ield
> +will contain the amount of write data. The count field in the reply will=
 be
> +zero.
> +
> +VFIO_USER_VM_INTERRUPT
> +----------------------
> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++----------------+------------------------+
> +| Name           | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID      | <ID>                   |
> ++----------------+------------------------+
> +| Message ID     | <ID>                   |
> ++----------------+------------------------+
> +| Command        | 12                     |
> ++----------------+------------------------+
> +| Message size   | 24                     |
> ++----------------+------------------------+
> +| Flags          | Reply bit set in reply |
> ++----------------+------------------------+
> +| Interrupt info | <interrupt>            |
> ++----------------+------------------------+
> +
> +This request is sent from the server to the client to signal the device =
has
> +raised an interrupt.
> +
> +Interrupt info format
> +^^^^^^^^^^^^^^^^^^^^^
> +
> ++----------+--------+------+
> +| Name     | Offset | Size |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D+
> +| Index    | 16     | 4    |
> ++----------+--------+------+
> +| Subindex | 20     | 4    |
> ++----------+--------+------+
> +
> +* Index is the interrupt index; it is the same value used in VFIO_USER_S=
ET_IRQS.
> +* Subindex is relative to the index, e.g., the vector number used in PCI=
 MSI/X
> +  type interrupts.


I'm still not sure why we need this, but why is a reply required?
Wouldn't an edge interrupt not require a reply?  For a level interrupt,
does the reply imply an EOI?  But really, why are we sending interrupts
through anything other than eventfds?  SET_IRQS is used to configure
the active interrupt on the device, it allows the client to provide
eventfds, so when would we ever need to send an unsolicited,
unconfigured interrupt?


> +
> +VFIO_USER_DEVICE_RESET
> +----------------------


Aha, just a typo above to missing _USER_

Thanks,
Alex

> +
> +Message format
> +^^^^^^^^^^^^^^
> +
> ++--------------+------------------------+
> +| Name         | Value                  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Device ID    | <ID>                   |
> ++--------------+------------------------+
> +| Message ID   | <ID>                   |
> ++--------------+------------------------+
> +| Command      | 13                     |
> ++--------------+------------------------+
> +| Message size | 16                     |
> ++--------------+------------------------+
> +| Flags        | Reply bit set in reply |
> ++--------------+------------------------+
> +
> +This request is sent from the client to the server to reset the device.
> +
> +Appendices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Unused VFIO ioctl() commands
> +----------------------------
> +
> +The following commands must be handled by the client and not sent to the=
 server:
> +
> +* VFIO_GET_API_VERSION
> +* VFIO_CHECK_EXTENSION
> +* VFIO_SET_IOMMU
> +* VFIO_GROUP_GET_STATUS
> +* VFIO_GROUP_SET_CONTAINER
> +* VFIO_GROUP_UNSET_CONTAINER
> +* VFIO_GROUP_GET_DEVICE_FD
> +* VFIO_IOMMU_GET_INFO
> +
> +However, once support for live migration for VFIO devices is finalized s=
ome
> +of the above commands might have to be handled by the client. This will =
be
> +addressed in a future protocol version.
> +
> +Live Migration
> +--------------
> +Currently live migration is not supported for devices passed through via=
 VFIO,
> +therefore it is not supported for VFIO-over-socket, either. This is bein=
g
> +actively worked on in the "Add migration support for VFIO devices" (v25)=
 patch
> +series.
> +
> +VFIO groups and containers
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The current VFIO implementation includes group and container idioms that
> +describe how a device relates to the host IOMMU. In the VFIO over socket
> +implementation, the IOMMU is implemented in SW by the client, and isn't =
visible
> +to the server. The simplest idea is for the client is to put each device=
 into
> +its own group and container.



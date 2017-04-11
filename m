Received: from eggs.gnu.org ([2001:4830:134:3::10]:47862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cxvVs-0005C8-HF
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cxvVq-0003Gu-7E
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:07:16 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cxvVp-0003GL-Fg
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:07:13 -0400
Received: by mail-lf0-x241.google.com with SMTP id 75so5780063lfs.3
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 06:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20170411101002.28451-1-maxime.coquelin@redhat.com>
	<20170411101002.28451-2-maxime.coquelin@redhat.com>
In-Reply-To: <20170411101002.28451-2-maxime.coquelin@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 11 Apr 2017 13:06:59 +0000
Message-ID: <CAJ+F1CL8kK0XcMwueX8+kbDF=aVhBiRJ66gGoUNcUOmk=Yg7og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/2] spec/vhost-user: Introduce secondary
 channel for slave initiated requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, peterx@redhat.com, yuanhan.liu@linux.intel.com, virtio-comment@lists.oasis-open.org, qemu-devel@nongnu.org

Hi

On Tue, Apr 11, 2017 at 12:10 PM Maxime Coquelin <maxime.coquelin@redhat.co=
m>
wrote:

> This vhost-user specification update aims at enabling the
> slave to send requests to the master using a dedicated socket
> created by the master.
>
> It can be used for example when the slave implements a device
> IOTLB to send cache miss requests to the master.
>
> The message types list is updated with an "Initiator" field to
> indicate for each type whether the master and/or slave can
> initiate the request.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>

This is very similar to a patch I proposed for shutdown slave initiated
requests:
https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.html


> ---
>  docs/specs/vhost-user.txt | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
> index 036890f..b365047 100644
> --- a/docs/specs/vhost-user.txt
> +++ b/docs/specs/vhost-user.txt
> @@ -139,6 +139,7 @@ in the ancillary data:
>   * VHOST_USER_SET_VRING_KICK
>   * VHOST_USER_SET_VRING_CALL
>   * VHOST_USER_SET_VRING_ERR
> + * VHOST_USER_SET_SLAVE_REQ_FD
>
>
I like "slave-req-fd" better than "slave-fd"


>  If Master is unable to send the full message or receives a wrong reply i=
t
> will
>  close the connection. An optional reconnection mechanism can be
> implemented.
> @@ -150,6 +151,11 @@ As older slaves don't support negotiating protocol
> features,
>  a feature bit was dedicated for this purpose:
>  #define VHOST_USER_F_PROTOCOL_FEATURES 30
>
> +If the slave supports VHOST_USER_PROTOCOL_F_SLAVE_REQ protocol feature,
> the
> +master may create a secondary Unix domain socket and send its file
> descriptor
> +to the slave using VHOST_USER_SET_SLAVE_REQ_FD request. This new channel
> enables
> +the slave to send message requests and master to send message replies.
> +
>  Starting and stopping rings
>  ----------------------
>  Client must only process each ring when it is started.
> @@ -260,6 +266,7 @@ Protocol features
>  #define VHOST_USER_PROTOCOL_F_RARP           2
>  #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
>  #define VHOST_USER_PROTOCOL_F_MTU            4
> +#define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
>
>  Message types
>  -------------
> @@ -268,6 +275,7 @@ Message types
>
>        Id: 1
>        Equivalent ioctl: VHOST_GET_FEATURES
> +      Initiator: Master
>        Master payload: N/A
>        Slave payload: u64
>
> @@ -279,6 +287,7 @@ Message types
>
>        Id: 2
>        Ioctl: VHOST_SET_FEATURES
> +      Initiator: Master
>        Master payload: u64
>
>        Enable features in the underlying vhost implementation using a
> bitmask.
> @@ -289,6 +298,7 @@ Message types
>
>        Id: 15
>        Equivalent ioctl: VHOST_GET_FEATURES
> +      Initiator: Master
>        Master payload: N/A
>        Slave payload: u64
>
> @@ -302,6 +312,7 @@ Message types
>
>        Id: 16
>        Ioctl: VHOST_SET_FEATURES
> +      Initiator: Master
>        Master payload: u64
>
>        Enable protocol features in the underlying vhost implementation.
> @@ -314,6 +325,7 @@ Message types
>
>        Id: 3
>        Equivalent ioctl: VHOST_SET_OWNER
> +      Initiator: Master
>        Master payload: N/A
>
>        Issued when a new connection is established. It sets the current
> Master
> @@ -323,6 +335,7 @@ Message types
>   * VHOST_USER_RESET_OWNER
>
>        Id: 4
> +      Initiator: Master
>        Master payload: N/A
>
>        This is no longer used. Used to be sent to request disabling
> @@ -335,6 +348,7 @@ Message types
>
>        Id: 5
>        Equivalent ioctl: VHOST_SET_MEM_TABLE
> +      Initiator: Master
>        Master payload: memory regions description
>
>        Sets the memory map regions on the slave so it can translate the
> vring
> @@ -346,6 +360,7 @@ Message types
>
>        Id: 6
>        Equivalent ioctl: VHOST_SET_LOG_BASE
> +      Initiator: Master
>        Master payload: u64
>        Slave payload: N/A
>
> @@ -360,6 +375,7 @@ Message types
>
>        Id: 7
>        Equivalent ioctl: VHOST_SET_LOG_FD
> +      Initiator: Master
>        Master payload: N/A
>
>        Sets the logging file descriptor, which is passed as ancillary dat=
a.
> @@ -368,6 +384,7 @@ Message types
>
>        Id: 8
>        Equivalent ioctl: VHOST_SET_VRING_NUM
> +      Initiator: Master
>        Master payload: vring state description
>
>        Set the size of the queue.
> @@ -376,6 +393,7 @@ Message types
>
>        Id: 9
>        Equivalent ioctl: VHOST_SET_VRING_ADDR
> +      Initiator: Master
>        Master payload: vring address description
>        Slave payload: N/A
>
> @@ -385,6 +403,7 @@ Message types
>
>        Id: 10
>        Equivalent ioctl: VHOST_SET_VRING_BASE
> +      Initiator: Master
>        Master payload: vring state description
>
>        Sets the base offset in the available vring.
> @@ -393,6 +412,7 @@ Message types
>
>        Id: 11
>        Equivalent ioctl: VHOST_USER_GET_VRING_BASE
> +      Initiator: Master
>        Master payload: vring state description
>        Slave payload: vring state description
>
> @@ -402,6 +422,7 @@ Message types
>
>        Id: 12
>        Equivalent ioctl: VHOST_SET_VRING_KICK
> +      Initiator: Master
>        Master payload: u64
>
>        Set the event file descriptor for adding buffers to the vring. It
> @@ -415,6 +436,7 @@ Message types
>
>        Id: 13
>        Equivalent ioctl: VHOST_SET_VRING_CALL
> +      Initiator: Master
>        Master payload: u64
>
>        Set the event file descriptor to signal when buffers are used. It
> @@ -428,6 +450,7 @@ Message types
>
>        Id: 14
>        Equivalent ioctl: VHOST_SET_VRING_ERR
> +      Initiator: Master
>        Master payload: u64
>
>        Set the event file descriptor to signal when error occurs. It
> @@ -440,6 +463,7 @@ Message types
>
>        Id: 17
>        Equivalent ioctl: N/A
> +      Initiator: Master
>        Master payload: N/A
>        Slave payload: u64
>
> @@ -451,6 +475,7 @@ Message types
>
>        Id: 18
>        Equivalent ioctl: N/A
> +      Initiator: Master
>        Master payload: vring state description
>
>        Signal slave to enable or disable corresponding vring.
> @@ -461,6 +486,7 @@ Message types
>
>        Id: 19
>        Equivalent ioctl: N/A
> +      Initiator: Master
>        Master payload: u64
>
>        Ask vhost user backend to broadcast a fake RARP to notify the
> migration
> @@ -475,6 +501,7 @@ Message types
>
>        Id: 20
>        Equivalent ioctl: N/A
> +      Initiator: Master
>        Master payload: u64
>
>        Set host MTU value exposed to the guest.
> @@ -486,6 +513,17 @@ Message types
>        If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, slave must respo=
nd
>        with zero in case the specified MTU is valid, or non-zero otherwis=
e.
>
> + * VHOST_USER_SET_SLAVE_REQ_FD
> +
> +      Id: 21
> +      Equivalent ioctl: N/A
> +      Initiator: Master
> +
> +      Set the socket file descriptor for slave initiated requests.
> +      This request should be sent only when VHOST_USER_F_PROTOCOL_FEATUR=
ES
> +      has been negotiated, and protocol feature bit
> VHOST_USER_PROTOCOL_F_SLAVE_REQ
> +      bit is present in VHOST_USER_GET_PROTOCOL_FEATURES.
> +
>

looks good to me


>  VHOST_USER_PROTOCOL_F_REPLY_ACK:
>  -------------------------------
>  The original vhost-user specification only demands replies for certain
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau

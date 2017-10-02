Received: from eggs.gnu.org ([2001:4830:134:3::10]:54742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dz9KB-0005Xd-HF
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 18:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dz9KA-0007C8-EM
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 18:36:31 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dz9KA-0007Ba-96
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 18:36:30 -0400
Received: by mail-oi0-x242.google.com with SMTP id s145so4004478oie.5
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 15:36:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002191521.15748-5-dgilbert@redhat.com>
References: <20171002191521.15748-1-dgilbert@redhat.com>
	<20171002191521.15748-5-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Oct 2017 00:36:28 +0200
Message-ID: <CAJ+F1CLOMAchtdLZer00vTKmM75M3gQ24MxF=Or-B4TssfyzQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] libvhost-user: Support
 VHOST_USER_SET_SLAVE_REQ_FD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On Mon, Oct 2, 2017 at 9:15 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Allow the qemu to pass us a slave fd.  We don't do anything
> with it yet.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  contrib/libvhost-user/libvhost-user.c | 27 ++++++++++++++++++++++++++-
>  contrib/libvhost-user/libvhost-user.h |  1 +
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 1901311a70..756b60c4b3 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -703,7 +703,8 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
>  static bool
>  vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
> -    uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
> +    uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
> +                        1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ;
>
>      if (dev->iface->get_protocol_features) {
>          features |=3D dev->iface->get_protocol_features(dev);
> @@ -757,6 +758,23 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *v=
msg)
>  }
>
>  static bool
> +vu_set_slave_req_fd(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    if (vmsg->fd_num !=3D 1) {
> +        vu_panic(dev, "Invalid slave_req_fd message (%d fd's)", vmsg->fd=
_num);
> +        return false;
> +    }
> +
> +    if (dev->slave_fd !=3D -1) {
> +        close(dev->slave_fd);
> +    }
> +    dev->slave_fd =3D vmsg->fds[0];
> +    DPRINT("Got slave_fd: %d\n", vmsg->fds[0]);
> +
> +    return false;
> +}
> +
> +static bool
>  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>  {
>      int do_reply =3D 0;
> @@ -819,6 +837,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>          return vu_get_queue_num_exec(dev, vmsg);
>      case VHOST_USER_SET_VRING_ENABLE:
>          return vu_set_vring_enable_exec(dev, vmsg);
> +    case VHOST_USER_SET_SLAVE_REQ_FD:
> +        return vu_set_slave_req_fd(dev, vmsg);
>      case VHOST_USER_NONE:
>          break;
>      default:
> @@ -892,6 +912,10 @@ vu_deinit(VuDev *dev)
>
>
>      vu_close_log(dev);
> +    if (dev->slave_fd !=3D -1) {
> +        close(dev->slave_fd);
> +        dev->slave_fd =3D -1;
> +    }
>
>      if (dev->sock !=3D -1) {
>          close(dev->sock);
> @@ -922,6 +946,7 @@ vu_init(VuDev *dev,
>      dev->remove_watch =3D remove_watch;
>      dev->iface =3D iface;
>      dev->log_call_fd =3D -1;
> +    dev->slave_fd =3D -1;
>      for (i =3D 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
>          dev->vq[i] =3D (VuVirtq) {
>              .call_fd =3D -1, .kick_fd =3D -1, .err_fd =3D -1,
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index c2fc6da720..7534e97f92 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -226,6 +226,7 @@ struct VuDev {
>      VuDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
>      VuVirtq vq[VHOST_MAX_NR_VIRTQUEUE];
>      int log_call_fd;
> +    int slave_fd;
>      uint64_t log_size;
>      uint8_t *log_table;
>      uint64_t features;
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau

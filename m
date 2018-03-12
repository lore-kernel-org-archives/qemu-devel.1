Received: from eggs.gnu.org ([2001:4830:134:3::10]:35075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evQAV-0003Qt-7n
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evQAU-0006F0-2a
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:19:23 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evQAT-0006Cm-Ox
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:19:21 -0400
Received: by mail-wm0-x242.google.com with SMTP id e194so17714768wmd.3
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:19:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-25-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-25-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 17:19:19 +0100
Message-ID: <CAJ+F1CJJsF_gb3Sg80Xk937YO91owkTaMyke=uGntLboP+yrBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 24/29] vhost-user: Add
 VHOST_USER_POSTCOPY_END message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Mar 8, 2018 at 8:58 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> This message is sent just before the end of postcopy to get the
> client to stop using userfault since we wont respond to any more
> requests.  It should close userfaultfd so that any other pages
> get mapped to the backing file automatically by the kernel, since
> at this point we know we've received everything.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  contrib/libvhost-user/libvhost-user.c | 23 +++++++++++++++++++++++
>  contrib/libvhost-user/libvhost-user.h |  1 +
>  docs/interop/vhost-user.txt           | 11 +++++++++++
>  hw/virtio/vhost-user.c                |  1 +
>  4 files changed, 36 insertions(+)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 1b224af706..1f988ab787 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -99,6 +99,7 @@ vu_request_to_string(unsigned int req)
>          REQ(VHOST_USER_SET_CONFIG),
>          REQ(VHOST_USER_POSTCOPY_ADVISE),
>          REQ(VHOST_USER_POSTCOPY_LISTEN),
> +        REQ(VHOST_USER_POSTCOPY_END),
>          REQ(VHOST_USER_MAX),
>      };
>  #undef REQ
> @@ -1095,6 +1096,26 @@ vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *v=
msg)
>      vmsg->payload.u64 =3D 0; /* Success */
>      return true;
>  }
> +
> +static bool
> +vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    DPRINT("%s: Entry\n", __func__);
> +    dev->postcopy_listening =3D false;
> +    if (dev->postcopy_ufd > 0) {
> +        close(dev->postcopy_ufd);
> +        dev->postcopy_ufd =3D -1;
> +        DPRINT("%s: Done close\n", __func__);
> +    }
> +
> +    vmsg->fd_num =3D 0;
> +    vmsg->payload.u64 =3D 0;
> +    vmsg->size =3D sizeof(vmsg->payload.u64);
> +    vmsg->flags =3D VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
> +    DPRINT("%s: exit\n", __func__);
> +    return true;
> +}
> +
>  static bool
>  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>  {
> @@ -1170,6 +1191,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>          return vu_set_postcopy_advise(dev, vmsg);
>      case VHOST_USER_POSTCOPY_LISTEN:
>          return vu_set_postcopy_listen(dev, vmsg);
> +    case VHOST_USER_POSTCOPY_END:
> +        return vu_set_postcopy_end(dev, vmsg);
>      default:
>          vmsg_close_fds(vmsg);
>          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index ed505cf0c1..79f7a53ee8 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -87,6 +87,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
>      VHOST_USER_POSTCOPY_ADVISE  =3D 28,
>      VHOST_USER_POSTCOPY_LISTEN  =3D 29,
> +    VHOST_USER_POSTCOPY_END     =3D 30,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index cc049196c9..5a31e4234e 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -729,6 +729,17 @@ Master message types
>        This is always sent sometime after a VHOST_USER_POSTCOPY_ADVISE, a=
nd
>        thus only when VHOST_USER_PROTOCOL_F_PAGEFAULT is supported.
>
> + * VHOST_USER_POSTCOPY_END
> +      Id: 30
> +      Slave payload: u64
> +
> +      Master advises that postcopy migration has now completed.  The
> +      slave must disable the userfaultfd. The response is an acknowledge=
ment
> +      only.

I guess 0 for success, non-zero otherwise - please update the spec.


> +      When VHOST_USER_PROTOCOL_F_PAGEFAULT is supported, this message
> +      is sent at the end of the migration, after VHOST_USER_POSTCOPY_LIS=
TEN
> +      was previously sent
> +
>  Slave message types
>  -------------------
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index b304bc475e..45de6d8a53 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -82,6 +82,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
>      VHOST_USER_POSTCOPY_ADVISE  =3D 28,
>      VHOST_USER_POSTCOPY_LISTEN  =3D 29,
> +    VHOST_USER_POSTCOPY_END     =3D 30,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fSigZ-0001VE-EH
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fSigV-00049q-5h
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:46:07 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fSigU-00049T-Uo
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:46:03 -0400
Received: by mail-io0-f196.google.com with SMTP id g7-v6so27819367ioh.11
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 05:46:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604095917.GA2628@work-vm>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-7-marcandre.lureau@redhat.com>
	<20180604090746.GA2629@work-vm>
	<CAMxuvayhQPPkFbFUE+Onbe7=AEnVuJ3+dFkDiuQyLA2F0tmW_w@mail.gmail.com>
	<20180604095917.GA2628@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 12 Jun 2018 14:46:01 +0200
Message-ID: <CAMxuvayYB=EeZ1mHLXKpyk0hMfw923YrnCvtisx1Cfo++CVpWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 06/12] vhost-user: add
 vhost_user_input_get_config()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Mon, Jun 4, 2018 at 11:59 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
>> Hi
>>
>> On Mon, Jun 4, 2018 at 11:07 AM, Dr. David Alan Gilbert
>> <dgilbert@redhat.com> wrote:
>> > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
>> >> Ask vhost user input backend the list of virtio_input_config.
>> >
>> > Why is this vhost-user specific; shouldn't the vhost-input
>> > behaviour be the same irrespective of if it's vhost-user or plain vhos=
t?
>> >
>>
>> A similar message could be used for plain vhost, in some ioctl form.
>> Here we are documenting vhost-user protocol only.
>
> The vhost-user protocol seems to be mostly independent of the device
> it's carrying; for example I see there's a 'net_set_mtu' and 'send_rarp'
> but I don't think there's anything for disk storage;  what are the cases
> whether these have to be done through a change to the vhost-user
> protocol as opposed to stuff carried over it?

It's necessary for whatever is out-of-band, like configuring the
device, notifying of device/qemu events,... Thanks to virtio design,
most of the messages are generic. But some of them are more specific
(like here for input config, or later to hand over the gpu socket).
The gpu socket/channel/protocol is seperated from "main" vhost-user
protocol, because it's quite orthogonal to virtio/vhost: it's only
used for the gpu/display updates, and it's driven by the backend.

I hope that answer your question.

> Dave
>
>>
>> Thanks
>>
>> > Dave
>> >
>> >
>> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> ---
>> >>  include/hw/virtio/vhost-backend.h |  4 +++
>> >>  hw/virtio/vhost-user.c            | 59 +++++++++++++++++++++++++++++=
++
>> >>  docs/interop/vhost-user.txt       |  6 ++++
>> >>  3 files changed, 69 insertions(+)
>> >>
>> >> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vh=
ost-backend.h
>> >> index 5dac61f9ea..6cc2edacc5 100644
>> >> --- a/include/hw/virtio/vhost-backend.h
>> >> +++ b/include/hw/virtio/vhost-backend.h
>> >> @@ -12,6 +12,7 @@
>> >>  #define VHOST_BACKEND_H
>> >>
>> >>  #include "exec/memory.h"
>> >> +#include "standard-headers/linux/virtio_input.h"
>> >>
>> >>  typedef enum VhostBackendType {
>> >>      VHOST_BACKEND_TYPE_NONE =3D 0,
>> >> @@ -156,4 +157,7 @@ int vhost_backend_invalidate_device_iotlb(struct =
vhost_dev *dev,
>> >>  int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
>> >>                                            struct vhost_iotlb_msg *im=
sg);
>> >>
>> >> +int vhost_user_input_get_config(struct vhost_dev *dev,
>> >> +                                struct virtio_input_config **config)=
;
>> >> +
>> >>  #endif /* VHOST_BACKEND_H */
>> >> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> >> index a87db01e55..19ed87d07c 100644
>> >> --- a/hw/virtio/vhost-user.c
>> >> +++ b/hw/virtio/vhost-user.c
>> >> @@ -84,6 +84,7 @@ typedef enum VhostUserRequest {
>> >>      VHOST_USER_POSTCOPY_ADVISE  =3D 28,
>> >>      VHOST_USER_POSTCOPY_LISTEN  =3D 29,
>> >>      VHOST_USER_POSTCOPY_END     =3D 30,
>> >> +    VHOST_USER_INPUT_GET_CONFIG,
>> >>      VHOST_USER_MAX
>> >>  } VhostUserRequest;
>> >>
>> >> @@ -324,6 +325,64 @@ static int vhost_user_write(struct vhost_dev *de=
v, VhostUserMsg *msg,
>> >>      return 0;
>> >>  }
>> >>
>> >> +static void *vhost_user_read_size(struct vhost_dev *dev, uint32_t si=
ze)
>> >> +{
>> >> +    struct vhost_user *u =3D dev->opaque;
>> >> +    CharBackend *chr =3D u->chr;
>> >> +    int r;
>> >> +    uint8_t *p =3D g_malloc(size);
>> >> +
>> >> +    r =3D qemu_chr_fe_read_all(chr, p, size);
>> >> +    if (r !=3D size) {
>> >> +        error_report("Failed to read msg payload."
>> >> +                     " Read %d instead of %d.", r, size);
>> >> +        return NULL;
>> >> +    }
>> >> +
>> >> +    return p;
>> >> +}
>> >> +
>> >> +int vhost_user_input_get_config(struct vhost_dev *dev,
>> >> +                                struct virtio_input_config **config)
>> >> +{
>> >> +    void *p =3D NULL;
>> >> +    VhostUserMsg msg =3D {
>> >> +        .hdr.request =3D VHOST_USER_INPUT_GET_CONFIG,
>> >> +        .hdr.flags =3D VHOST_USER_VERSION,
>> >> +    };
>> >> +
>> >> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
>> >> +        goto err;
>> >> +    }
>> >> +
>> >> +    if (vhost_user_read_header(dev, &msg) < 0) {
>> >> +        goto err;
>> >> +    }
>> >> +
>> >> +    p =3D vhost_user_read_size(dev, msg.hdr.size);
>> >> +    if (!p) {
>> >> +        goto err;
>> >> +    }
>> >> +
>> >> +    if (msg.hdr.request !=3D VHOST_USER_INPUT_GET_CONFIG) {
>> >> +        error_report("Received unexpected msg type. Expected %d rece=
ived %d",
>> >> +                     VHOST_USER_INPUT_GET_CONFIG, msg.hdr.request);
>> >> +        goto err;
>> >> +    }
>> >> +
>> >> +    if (msg.hdr.size % sizeof(struct virtio_input_config)) {
>> >> +        error_report("Invalid msg size");
>> >> +        goto err;
>> >> +    }
>> >> +
>> >> +    *config =3D p;
>> >> +    return msg.hdr.size / sizeof(struct virtio_input_config);
>> >> +
>> >> +err:
>> >> +    g_free(p);
>> >> +    return -1;
>> >> +}
>> >> +
>> >>  static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t b=
ase,
>> >>                                     struct vhost_log *log)
>> >>  {
>> >> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.tx=
t
>> >> index 534caab18a..3df9927386 100644
>> >> --- a/docs/interop/vhost-user.txt
>> >> +++ b/docs/interop/vhost-user.txt
>> >> @@ -744,6 +744,12 @@ Master message types
>> >>        was previously sent.
>> >>        The value returned is an error indication; 0 is success.
>> >>
>> >> + * VHOST_USER_INPUT_GET_CONFIG
>> >> +
>> >> +      Slave payload: (struct virtio_input_config)*
>> >> +
>> >> +      Ask vhost user input backend the list of virtio_input_config.
>> >> +
>> >>  Slave message types
>> >>  -------------------
>> >>
>> >> --
>> >> 2.17.1.906.g10fd178552
>> >>
>> >>
>> > --
>> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

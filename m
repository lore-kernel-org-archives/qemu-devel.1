Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C61BC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1CA21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqDgX6T+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1CA21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bdc-0007TD-2A
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6bcz-0006zj-4S
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6bcw-0001tS-Ul
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:56:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27027
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6bcw-0001s0-QI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582642561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljkXlFVFJ54E7DivYAOSSraP5hdqjy29xTCua4oEVcg=;
 b=aqDgX6T+83l2FoRF918lU8Jb2+7fq37oyPCqTUPDDzGdYu69ilRneVIA+h2Qd7gnYbGvgU
 D48fimYUfobdl8WvYTmycwb4nY55T3Ppqr4tP9OUwcUjwYS7XsRGYuZMNGMXZCtoUavgOC
 hGgknc6XLFRNvquVq80XuGFIbXqZYW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-3iXnb4ejPuqnBqn5mUz5RA-1; Tue, 25 Feb 2020 09:55:59 -0500
X-MC-Unique: 3iXnb4ejPuqnBqn5mUz5RA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D8FF8018B7;
 Tue, 25 Feb 2020 14:55:58 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF5D8909E9;
 Tue, 25 Feb 2020 14:55:54 +0000 (UTC)
Date: Tue, 25 Feb 2020 15:55:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v4 1/5] extend libvhost to support IOThread and coroutine
Message-ID: <20200225145553.GB7632@linux.fritz.box>
References: <20200218050711.8133-1-coiby.xu@gmail.com>
 <20200218050711.8133-2-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200218050711.8133-2-coiby.xu@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.02.2020 um 06:07 hat Coiby Xu geschrieben:
> Previously libvhost dispatch events in its own GMainContext. Now vhost-us=
er
> client's kick event can be dispatched in block device drive's AioContext
> thus IOThread is supported. And also allow vu_message_read and
> vu_kick_cb to be replaced so QEMU can run them as coroutines.
>=20
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 54 ++++++++++++++++++++++++---
>  contrib/libvhost-user/libvhost-user.h | 38 ++++++++++++++++++-
>  2 files changed, 85 insertions(+), 7 deletions(-)
>=20
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 5cb7708559..6aadeaa0f2 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -30,6 +30,8 @@
> =20
>  #define VHOST_MEMORY_MAX_NREGIONS 8
> =20
> +#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
> +
>  typedef enum VhostSetConfigType {
>      VHOST_SET_CONFIG_TYPE_MASTER =3D 0,
>      VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,
> @@ -201,6 +203,7 @@ typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
>  typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
>  typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
>                                    int *do_reply);
> +typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg=
);
>  typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool star=
ted);
>  typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx)=
;
>  typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t l=
en);
> @@ -208,6 +211,20 @@ typedef int (*vu_set_config_cb) (VuDev *dev, const u=
int8_t *data,
>                                   uint32_t offset, uint32_t size,
>                                   uint32_t flags);
> =20
> +typedef void (*vu_watch_cb_packed_data) (void *packed_data);
> +
> +typedef void (*vu_set_watch_cb_packed_data) (VuDev *dev, int fd, int con=
dition,
> +                                             vu_watch_cb_packed_data cb,
> +                                             void *data);
> +/*
> + * allowing vu_read_msg_cb and kick_callback to be replaced so QEMU
> + * can run them as coroutines
> + */
> +typedef struct CoIface {
> +    vu_read_msg_cb read_msg;
> +    vu_watch_cb_packed_data kick_callback;
> +} CoIface;

I think this should be part of VuDevIface, so that it becomes a properly
integrated part of the design instead of an adapter hacked on top.

>  typedef struct VuDevIface {
>      /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
>      vu_get_features_cb get_features;
> @@ -372,7 +389,8 @@ struct VuDev {
>      /* @set_watch: add or update the given fd to the watch set,
>       * call cb when condition is met */
>      vu_set_watch_cb set_watch;
> -
> +    /* AIO dispatch will only one data pointer to callback function */
> +    vu_set_watch_cb_packed_data set_watch_packed_data;
>      /* @remove_watch: remove the given fd from the watch set */
>      vu_remove_watch_cb remove_watch;
> =20
> @@ -380,7 +398,7 @@ struct VuDev {
>       * re-initialize */
>      vu_panic_cb panic;
>      const VuDevIface *iface;
> -
> +    const CoIface *co_iface;
>      /* Postcopy data */
>      int postcopy_ufd;
>      bool postcopy_listening;
> @@ -417,6 +435,22 @@ bool vu_init(VuDev *dev,
>               const VuDevIface *iface);
> =20
> =20
> +/**
> + * vu_init_packed_data:
> + * Same as vu_init except for set_watch_packed_data which will pack
> + * two parameters into a struct

Be specific: Which two parameters and which struct?

I think it would be more helpful to name the function after the
additional piece of information that it uses rather than the fact that
it stores it internally in a struct.

We have:

typedef void (*vu_set_watch_cb) (VuDev *dev, int fd, int condition,
                                 vu_watch_cb cb, void *data);
typedef void (*vu_set_watch_cb_packed_data) (VuDev *dev, int fd, int condit=
ion,
                                             vu_watch_cb_packed_data cb,
                                             void *data);

Without looking at the implementation, they have the same set of
parameters. I suspect that the difference is in the content of *data,
but since it is declared void*, I suppose it's treated as an opaque data
type and will only be passed unchanged (and uninspected) to cb.

If so, there is no differene between both types.

> thus QEMU aio_dispatch can pass the
> + * required data to callback function.
> + *
> + * Returns: true on success, false on failure.
> + **/
> +bool vu_init_packed_data(VuDev *dev,
> +                         uint16_t max_queues,
> +                         int socket,
> +                         vu_panic_cb panic,
> +                         vu_set_watch_cb_packed_data set_watch_packed_da=
ta,
> +                         vu_remove_watch_cb remove_watch,
> +                         const VuDevIface *iface,
> +                         const CoIface *co_iface);
>  /**
>   * vu_deinit:
>   * @dev: a VuDev context
> --=20
> 2.25.0
>=20
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index b89bf18501..f95664bb22 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -67,8 +67,6 @@
>  /* The version of inflight buffer */
>  #define INFLIGHT_VERSION 1
> =20
> -#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
> -
>  /* The version of the protocol we support */
>  #define VHOST_USER_VERSION 1
>  #define LIBVHOST_USER_DEBUG 0
> @@ -260,7 +258,7 @@ have_userfault(void)
>  }
> =20
>  static bool
> -vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
> +vu_message_read_(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)

Just adding a trailing underscore isn't a good name. It doesn't tell the
reader what the difference between vu_message_read_ and vu_message_read
is.

>  {
>      char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] =
=3D { };
>      struct iovec iov =3D {
> @@ -328,6 +326,17 @@ fail:
>      return false;
>  }
> =20
> +static bool vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
> +{
> +    vu_read_msg_cb read_msg;
> +    if (dev->co_iface) {
> +        read_msg =3D dev->co_iface->read_msg;
> +    } else {
> +        read_msg =3D vu_message_read_;
> +    }
> +    return read_msg(dev, conn_fd, vmsg);
> +}

If you change VuDevIface so that it contains the fields of CoIface
directly, you can just initialise dev->iface->read_msg with what is
called vu_message_read_() now for the non-QEMU case, and this whole
wrapper becomes unnecessary because the code path is the same for both
cases.

>  static bool
>  vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
>  {
> @@ -1075,9 +1084,14 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *v=
msg)
>      }
> =20
>      if (dev->vq[index].kick_fd !=3D -1 && dev->vq[index].handler) {
> +        if (dev->set_watch_packed_data) {
> +            dev->set_watch_packed_data(dev, dev->vq[index].kick_fd, VU_W=
ATCH_IN,
> +                                       dev->co_iface->kick_callback,
> +                                       (void *)(long)index);
> +        } else {
>          dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
>                         vu_kick_cb, (void *)(long)index);
> -
> +        }

Indentation is off here.

Also, this is almost exactly the same code for both cases. If you
generalise things to have a dev->iface->kick_callback that can be
initialised with vu_kick_cb in the non-QEMU case, you get rid of this
duplication, too.

>          DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
>                 dev->vq[index].kick_fd, index);
>      }
> @@ -1097,8 +1111,14 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
>      vq->handler =3D handler;
>      if (vq->kick_fd >=3D 0) {
>          if (handler) {
> +            if (dev->set_watch_packed_data) {
> +                dev->set_watch_packed_data(dev, vq->kick_fd, VU_WATCH_IN=
,
> +                                           dev->co_iface->kick_callback,
> +                                           (void *)(long)qidx);
> +            } else {
>              dev->set_watch(dev, vq->kick_fd, VU_WATCH_IN,
>                             vu_kick_cb, (void *)(long)qidx);
> +            }

Same as above. (Indentation and duplicated code.)

>          } else {
>              dev->remove_watch(dev, vq->kick_fd);
>          }
> @@ -1627,6 +1647,12 @@ vu_deinit(VuDev *dev)
>          }
> =20
>          if (vq->kick_fd !=3D -1) {
> +            /* remove watch for kick_fd
> +             * When client process is running in gdb and
> +             * quit command is run in gdb, QEMU will still dispatch the =
event
> +             * which will cause segment fault in the callback function
> +             */

Reformat this comment to use a consistent line width, maybe like this:

            /*
             * remove watch for kick_fd.
             *
             * When client process is running in gdb and quit command is
             * run in gdb, QEMU will still dispatch the event which will
             * cause segment fault in the callback function
             */

I'm not sure what the comment wants to tell me: Is this an existing
problem in the code that we can run into segfaults, or do we remove the
watch to avoid segfaults?

> +            dev->remove_watch(dev, vq->kick_fd);
>              close(vq->kick_fd);
>              vq->kick_fd =3D -1;
>          }
> @@ -1682,7 +1708,7 @@ vu_init(VuDev *dev,
> =20
>      assert(max_queues > 0);
>      assert(socket >=3D 0);
> -    assert(set_watch);
> +    /* assert(set_watch); */

Don't leave commented code around. Either leave it in, or remove it
completely.

I think this one should be left in. If you integrate CoIface into
VuDevIface, the assertion will hold true again.

>      assert(remove_watch);
>      assert(iface);
>      assert(panic);
> @@ -1715,6 +1741,24 @@ vu_init(VuDev *dev,
>      return true;
>  }
> =20
> +bool
> +vu_init_packed_data(VuDev *dev,
> +        uint16_t max_queues,
> +        int socket,
> +        vu_panic_cb panic,
> +        vu_set_watch_cb_packed_data set_watch_packed_data,
> +        vu_remove_watch_cb remove_watch,
> +        const VuDevIface *iface,
> +        const CoIface *co_iface)
> +{
> +    if (vu_init(dev, max_queues, socket, panic, NULL, remove_watch, ifac=
e)) {
> +        dev->set_watch_packed_data =3D set_watch_packed_data;
> +        dev->co_iface =3D co_iface;
> +        return true;
> +    }
> +    return false;
> +}

With the integrated VuDevIface, this wrapper becomes unnecessary.

Kevin



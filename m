Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0BBC432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 17:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACC62168B
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 17:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZAQfGBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACC62168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iW27a-0006gO-St
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 12:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iW26M-00069Q-QP
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 12:43:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iW26K-0003Vl-3e
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 12:43:14 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iW26J-0003Ut-OL
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 12:43:12 -0500
Received: by mail-wr1-x442.google.com with SMTP id z10so14585912wrs.12
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2019 09:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iBYz+mX55sb7iup44H+bqCVMnKnM+a7WVgPdThrWWZo=;
 b=DZAQfGBDqTt4Pwhtqv45iTMbqAE2blZk3KM9F9NxmITf8RtQ8zYPLM1Z0aUvN4lcdD
 QwvSePzaK1+BPw5LAqh8/d9A0cqxAqJ6BFE72JiDXRrvQeeJd9r/bhmkPOxVZOF58nNB
 EhwK5IwR8EdQBEkWyFvK0h/QCmEJHxdec1ISMIJtsUj4XkaskTuOPhiJ8CivqmZIbrTZ
 uwi+KhaPs60CVvkbWMIPZNoFKwDXCiAhd7UEiuBMDNRHfRxoKPFAgtZSKmcdtJvp32Qz
 +wkltcf3WcvHq+aQ8YUOIGUvZWaAg06q20gfUkX16ljdXD2NEM/Z7EJYx23qDias5Kja
 Sccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iBYz+mX55sb7iup44H+bqCVMnKnM+a7WVgPdThrWWZo=;
 b=WRlqSwmXxfFl/jVCA2Z6dfbEVr/rKvoTcZ1YTfg11XmYSzYTYcf4rH8pLnAfs2a+dd
 GFjugKIYGyrmgQqFFJ1wnreO1DdMglIQAOI6qA3ZMsh5s3ySWhRPgYfd9Q4cc+IRLgOK
 VszFCsVM6T+LlHDSxBJ0O1zlHNr/nat17e7zH6YNy9Fo8qLDlyGb64vBUlvpjFTBSxE1
 4f1NhahNbZSSyjNbR0tl2+AzUyx/YD2kIFNJrhTso9agaB1cuKYBAXXqMDWUVbL54jDN
 +/2V8Vn2eF1b/rNNrCZx3ygB42tFGiDWZP+aSgMvyfQvNZyR+ZvNuDzhQDTrpl1Si+Kr
 TxMQ==
X-Gm-Message-State: APjAAAWxY3dRlNGvpXefpItSIIxcAx+gEB2/K6BdBzqU+cIg+xsbmHh8
 cmKeBtYAwvouV3KJVn752ztAZ+Q97+WsIikwIkI=
X-Google-Smtp-Source: APXvYqzEJNmg3mla6+3DKArw3D9Y2WsGCJMdNBvAloy87o+2sSeeCP0LWVepoXA+OrwQR6yjg4P6VTgL0ZlnJpuble0=
X-Received: by 2002:adf:ed4e:: with SMTP id u14mr22578122wro.132.1573926189912; 
 Sat, 16 Nov 2019 09:43:09 -0800 (PST)
MIME-Version: 1.0
References: <20190313025418.8292-1-mst@redhat.com>
 <20190228085355.9614-5-xieyongji@baidu.com>
In-Reply-To: <20190228085355.9614-5-xieyongji@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 16 Nov 2019 21:42:55 +0400
Message-ID: <CAJ+F1CK0ePybYjrTCESaxWBru04Bh6ZzVB1CdHo-vfJmA-UNvg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 22/26] libvhost-user: Support tracking
 inflight I/O in shared memory
To: "Michael S. Tsirkin" <mst@redhat.com>, Xie Yongji <xieyongji@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhang Yu <zhangyu31@baidu.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 13, 2019 at 6:59 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Xie Yongji <xieyongji@baidu.com>
>
> This patch adds support for VHOST_USER_GET_INFLIGHT_FD and
> VHOST_USER_SET_INFLIGHT_FD message to set/get shared buffer
> to/from qemu. Then backend can track inflight I/O in this buffer.
>
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Message-Id: <20190228085355.9614-5-xieyongji@baidu.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  Makefile                              |   2 +-
>  contrib/libvhost-user/libvhost-user.h |  70 ++++++
>  contrib/libvhost-user/libvhost-user.c | 349 ++++++++++++++++++++++++--
>  3 files changed, 400 insertions(+), 21 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 6ccb8639b0..abd78a9826 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -497,7 +497,7 @@ Makefile: $(version-obj-y)
>  # Build libraries
>
>  libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
> -libvhost-user.a: $(libvhost-user-obj-y)
> +libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
>
>  ######################################################################
>
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 3de8414898..414ceb0a2f 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -53,6 +53,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_CONFIG =3D 9,
>      VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD =3D 10,
>      VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,
> +    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
>
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> @@ -91,6 +92,8 @@ typedef enum VhostUserRequest {
>      VHOST_USER_POSTCOPY_ADVISE  =3D 28,
>      VHOST_USER_POSTCOPY_LISTEN  =3D 29,
>      VHOST_USER_POSTCOPY_END     =3D 30,
> +    VHOST_USER_GET_INFLIGHT_FD =3D 31,
> +    VHOST_USER_SET_INFLIGHT_FD =3D 32,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>
> @@ -138,6 +141,13 @@ typedef struct VhostUserVringArea {
>      uint64_t offset;
>  } VhostUserVringArea;
>
> +typedef struct VhostUserInflight {
> +    uint64_t mmap_size;
> +    uint64_t mmap_offset;
> +    uint16_t num_queues;
> +    uint16_t queue_size;
> +} VhostUserInflight;
> +
>  #if defined(_WIN32)
>  # define VU_PACKED __attribute__((gcc_struct, packed))
>  #else
> @@ -163,6 +173,7 @@ typedef struct VhostUserMsg {
>          VhostUserLog log;
>          VhostUserConfig config;
>          VhostUserVringArea area;
> +        VhostUserInflight inflight;
>      } payload;
>
>      int fds[VHOST_MEMORY_MAX_NREGIONS];
> @@ -234,9 +245,61 @@ typedef struct VuRing {
>      uint32_t flags;
>  } VuRing;
>
> +typedef struct VuDescStateSplit {
> +    /* Indicate whether this descriptor is inflight or not.
> +     * Only available for head-descriptor. */
> +    uint8_t inflight;
> +
> +    /* Padding */
> +    uint8_t padding[5];
> +
> +    /* Maintain a list for the last batch of used descriptors.
> +     * Only available when batching is used for submitting */
> +    uint16_t next;
> +
> +    /* Used to preserve the order of fetching available descriptors.
> +     * Only available for head-descriptor. */
> +    uint64_t counter;
> +} VuDescStateSplit;
> +
> +typedef struct VuVirtqInflight {
> +    /* The feature flags of this region. Now it's initialized to 0. */
> +    uint64_t features;
> +
> +    /* The version of this region. It's 1 currently.
> +     * Zero value indicates a vm reset happened. */
> +    uint16_t version;
> +
> +    /* The size of VuDescStateSplit array. It's equal to the virtqueue
> +     * size. Slave could get it from queue size field of VhostUserInflig=
ht. */
> +    uint16_t desc_num;
> +
> +    /* The head of list that track the last batch of used descriptors. *=
/
> +    uint16_t last_batch_head;
> +
> +    /* Storing the idx value of used ring */
> +    uint16_t used_idx;
> +
> +    /* Used to track the state of each descriptor in descriptor table */
> +    VuDescStateSplit desc[0];
> +} VuVirtqInflight;
> +
> +typedef struct VuVirtqInflightDesc {
> +    uint16_t index;
> +    uint64_t counter;
> +} VuVirtqInflightDesc;
> +
>  typedef struct VuVirtq {
>      VuRing vring;
>
> +    VuVirtqInflight *inflight;
> +
> +    VuVirtqInflightDesc *resubmit_list;
> +
> +    uint16_t resubmit_num;
> +
> +    uint64_t counter;
> +
>      /* Next head to pop */
>      uint16_t last_avail_idx;
>
> @@ -279,11 +342,18 @@ typedef void (*vu_set_watch_cb) (VuDev *dev, int fd=
, int condition,
>                                   vu_watch_cb cb, void *data);
>  typedef void (*vu_remove_watch_cb) (VuDev *dev, int fd);
>
> +typedef struct VuDevInflightInfo {
> +    int fd;
> +    void *addr;
> +    uint64_t size;
> +} VuDevInflightInfo;
> +
>  struct VuDev {
>      int sock;
>      uint32_t nregions;
>      VuDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
>      VuVirtq vq[VHOST_MAX_NR_VIRTQUEUE];
> +    VuDevInflightInfo inflight_info;
>      int log_call_fd;
>      int slave_fd;
>      uint64_t log_size;
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index ddd15d79cf..e08d6c7b97 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -41,6 +41,8 @@
>  #endif
>
>  #include "qemu/atomic.h"
> +#include "qemu/osdep.h"
> +#include "qemu/memfd.h"
>
>  #include "libvhost-user.h"
>
> @@ -53,6 +55,18 @@
>              _min1 < _min2 ? _min1 : _min2; })
>  #endif
>
> +/* Round number down to multiple */
> +#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
> +
> +/* Round number up to multiple */
> +#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
> +
> +/* Align each region to cache line size in inflight buffer */
> +#define INFLIGHT_ALIGNMENT 64
> +
> +/* The version of inflight buffer */
> +#define INFLIGHT_VERSION 1
> +
>  #define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
>
>  /* The version of the protocol we support */
> @@ -66,6 +80,20 @@
>          }                                       \
>      } while (0)
>
> +static inline
> +bool has_feature(uint64_t features, unsigned int fbit)
> +{
> +    assert(fbit < 64);
> +    return !!(features & (1ULL << fbit));
> +}
> +
> +static inline
> +bool vu_has_feature(VuDev *dev,
> +                    unsigned int fbit)
> +{
> +    return has_feature(dev->features, fbit);
> +}
> +
>  static const char *
>  vu_request_to_string(unsigned int req)
>  {
> @@ -100,6 +128,8 @@ vu_request_to_string(unsigned int req)
>          REQ(VHOST_USER_POSTCOPY_ADVISE),
>          REQ(VHOST_USER_POSTCOPY_LISTEN),
>          REQ(VHOST_USER_POSTCOPY_END),
> +        REQ(VHOST_USER_GET_INFLIGHT_FD),
> +        REQ(VHOST_USER_SET_INFLIGHT_FD),
>          REQ(VHOST_USER_MAX),
>      };
>  #undef REQ
> @@ -890,6 +920,91 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vm=
sg)
>      return true;
>  }
>
> +static int
> +inflight_desc_compare(const void *a, const void *b)
> +{
> +    VuVirtqInflightDesc *desc0 =3D (VuVirtqInflightDesc *)a,
> +                        *desc1 =3D (VuVirtqInflightDesc *)b;
> +
> +    if (desc1->counter > desc0->counter &&
> +        (desc1->counter - desc0->counter) < VIRTQUEUE_MAX_SIZE * 2) {
> +        return 1;
> +    }
> +
> +    return -1;
> +}
> +
> +static int
> +vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
> +{
> +    int i =3D 0;
> +
> +    if (!has_feature(dev->protocol_features,
> +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> +        return 0;
> +    }
> +
> +    if (unlikely(!vq->inflight)) {
> +        return -1;
> +    }
> +
> +    if (unlikely(!vq->inflight->version)) {
> +        /* initialize the buffer */
> +        vq->inflight->version =3D INFLIGHT_VERSION;
> +        return 0;
> +    }
> +
> +    vq->used_idx =3D vq->vring.used->idx;
> +    vq->resubmit_num =3D 0;
> +    vq->resubmit_list =3D NULL;
> +    vq->counter =3D 0;
> +
> +    if (unlikely(vq->inflight->used_idx !=3D vq->used_idx)) {
> +        vq->inflight->desc[vq->inflight->last_batch_head].inflight =3D 0=
;
> +
> +        barrier();
> +
> +        vq->inflight->used_idx =3D vq->used_idx;
> +    }
> +
> +    for (i =3D 0; i < vq->inflight->desc_num; i++) {
> +        if (vq->inflight->desc[i].inflight =3D=3D 1) {
> +            vq->inuse++;
> +        }
> +    }
> +
> +    vq->shadow_avail_idx =3D vq->last_avail_idx =3D vq->inuse + vq->used=
_idx;
> +
> +    if (vq->inuse) {
> +        vq->resubmit_list =3D malloc(sizeof(VuVirtqInflightDesc) * vq->i=
nuse);
> +        if (!vq->resubmit_list) {
> +            return -1;
> +        }
> +
> +        for (i =3D 0; i < vq->inflight->desc_num; i++) {
> +            if (vq->inflight->desc[i].inflight) {
> +                vq->resubmit_list[vq->resubmit_num].index =3D i;
> +                vq->resubmit_list[vq->resubmit_num].counter =3D
> +                                        vq->inflight->desc[i].counter;
> +                vq->resubmit_num++;
> +            }
> +        }
> +
> +        if (vq->resubmit_num > 1) {
> +            qsort(vq->resubmit_list, vq->resubmit_num,
> +                  sizeof(VuVirtqInflightDesc), inflight_desc_compare);
> +        }
> +        vq->counter =3D vq->resubmit_list[0].counter + 1;

scan-build reports that vq->resubmit_list[0].counter may be garbage
value, if it's not initialized in the loop above.
Xie, could you provide a fix?

> +    }
> +
> +    /* in case of I/O hang after reconnecting */
> +    if (eventfd_write(vq->kick_fd, 1)) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  static bool
>  vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
> @@ -923,6 +1038,10 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vm=
sg)
>                 dev->vq[index].kick_fd, index);
>      }
>
> +    if (vu_check_queue_inflights(dev, &dev->vq[index])) {
> +        vu_panic(dev, "Failed to check inflights for vq: %d\n", index);
> +    }
> +
>      return false;
>  }
>
> @@ -995,6 +1114,11 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vm=
sg)
>
>      dev->vq[index].call_fd =3D vmsg->fds[0];
>
> +    /* in case of I/O hang after reconnecting */
> +    if (eventfd_write(vmsg->fds[0], 1)) {
> +        return -1;
> +    }
> +
>      DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
>
>      return false;
> @@ -1209,6 +1333,116 @@ vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vms=
g)
>      return true;
>  }
>
> +static inline uint64_t
> +vu_inflight_queue_size(uint16_t queue_size)
> +{
> +    return ALIGN_UP(sizeof(VuDescStateSplit) * queue_size +
> +           sizeof(uint16_t), INFLIGHT_ALIGNMENT);
> +}
> +
> +static bool
> +vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    int fd;
> +    void *addr;
> +    uint64_t mmap_size;
> +    uint16_t num_queues, queue_size;
> +
> +    if (vmsg->size !=3D sizeof(vmsg->payload.inflight)) {
> +        vu_panic(dev, "Invalid get_inflight_fd message:%d", vmsg->size);
> +        vmsg->payload.inflight.mmap_size =3D 0;
> +        return true;
> +    }
> +
> +    num_queues =3D vmsg->payload.inflight.num_queues;
> +    queue_size =3D vmsg->payload.inflight.queue_size;
> +
> +    DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
> +    DPRINT("set_inflight_fd queue_size: %"PRId16"\n", queue_size);
> +
> +    mmap_size =3D vu_inflight_queue_size(queue_size) * num_queues;
> +
> +    addr =3D qemu_memfd_alloc("vhost-inflight", mmap_size,
> +                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> +                            &fd, NULL);
> +
> +    if (!addr) {
> +        vu_panic(dev, "Failed to alloc vhost inflight area");
> +        vmsg->payload.inflight.mmap_size =3D 0;
> +        return true;
> +    }
> +
> +    memset(addr, 0, mmap_size);
> +
> +    dev->inflight_info.addr =3D addr;
> +    dev->inflight_info.size =3D vmsg->payload.inflight.mmap_size =3D mma=
p_size;
> +    dev->inflight_info.fd =3D vmsg->fds[0] =3D fd;
> +    vmsg->fd_num =3D 1;
> +    vmsg->payload.inflight.mmap_offset =3D 0;
> +
> +    DPRINT("send inflight mmap_size: %"PRId64"\n",
> +           vmsg->payload.inflight.mmap_size);
> +    DPRINT("send inflight mmap offset: %"PRId64"\n",
> +           vmsg->payload.inflight.mmap_offset);
> +
> +    return true;
> +}
> +
> +static bool
> +vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    int fd, i;
> +    uint64_t mmap_size, mmap_offset;
> +    uint16_t num_queues, queue_size;
> +    void *rc;
> +
> +    if (vmsg->fd_num !=3D 1 ||
> +        vmsg->size !=3D sizeof(vmsg->payload.inflight)) {
> +        vu_panic(dev, "Invalid set_inflight_fd message size:%d fds:%d",
> +                 vmsg->size, vmsg->fd_num);
> +        return false;
> +    }
> +
> +    fd =3D vmsg->fds[0];
> +    mmap_size =3D vmsg->payload.inflight.mmap_size;
> +    mmap_offset =3D vmsg->payload.inflight.mmap_offset;
> +    num_queues =3D vmsg->payload.inflight.num_queues;
> +    queue_size =3D vmsg->payload.inflight.queue_size;
> +
> +    DPRINT("set_inflight_fd mmap_size: %"PRId64"\n", mmap_size);
> +    DPRINT("set_inflight_fd mmap_offset: %"PRId64"\n", mmap_offset);
> +    DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
> +    DPRINT("set_inflight_fd queue_size: %"PRId16"\n", queue_size);
> +
> +    rc =3D mmap(0, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> +              fd, mmap_offset);
> +
> +    if (rc =3D=3D MAP_FAILED) {
> +        vu_panic(dev, "set_inflight_fd mmap error: %s", strerror(errno))=
;
> +        return false;
> +    }
> +
> +    if (dev->inflight_info.fd) {
> +        close(dev->inflight_info.fd);
> +    }
> +
> +    if (dev->inflight_info.addr) {
> +        munmap(dev->inflight_info.addr, dev->inflight_info.size);
> +    }
> +
> +    dev->inflight_info.fd =3D fd;
> +    dev->inflight_info.addr =3D rc;
> +    dev->inflight_info.size =3D mmap_size;
> +
> +    for (i =3D 0; i < num_queues; i++) {
> +        dev->vq[i].inflight =3D (VuVirtqInflight *)rc;
> +        dev->vq[i].inflight->desc_num =3D queue_size;
> +        rc =3D (void *)((char *)rc + vu_inflight_queue_size(queue_size))=
;
> +    }
> +
> +    return false;
> +}
> +
>  static bool
>  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>  {
> @@ -1287,6 +1521,10 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>          return vu_set_postcopy_listen(dev, vmsg);
>      case VHOST_USER_POSTCOPY_END:
>          return vu_set_postcopy_end(dev, vmsg);
> +    case VHOST_USER_GET_INFLIGHT_FD:
> +        return vu_get_inflight_fd(dev, vmsg);
> +    case VHOST_USER_SET_INFLIGHT_FD:
> +        return vu_set_inflight_fd(dev, vmsg);
>      default:
>          vmsg_close_fds(vmsg);
>          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> @@ -1354,8 +1592,24 @@ vu_deinit(VuDev *dev)
>              close(vq->err_fd);
>              vq->err_fd =3D -1;
>          }
> +
> +        if (vq->resubmit_list) {
> +            free(vq->resubmit_list);
> +            vq->resubmit_list =3D NULL;
> +        }
> +
> +        vq->inflight =3D NULL;
>      }
>
> +    if (dev->inflight_info.addr) {
> +        munmap(dev->inflight_info.addr, dev->inflight_info.size);
> +        dev->inflight_info.addr =3D NULL;
> +    }
> +
> +    if (dev->inflight_info.fd > 0) {
> +        close(dev->inflight_info.fd);
> +        dev->inflight_info.fd =3D -1;
> +    }
>
>      vu_close_log(dev);
>      if (dev->slave_fd !=3D -1) {
> @@ -1682,20 +1936,6 @@ vu_queue_empty(VuDev *dev, VuVirtq *vq)
>      return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
>  }
>
> -static inline
> -bool has_feature(uint64_t features, unsigned int fbit)
> -{
> -    assert(fbit < 64);
> -    return !!(features & (1ULL << fbit));
> -}
> -
> -static inline
> -bool vu_has_feature(VuDev *dev,
> -                    unsigned int fbit)
> -{
> -    return has_feature(dev->features, fbit);
> -}
> -
>  static bool
>  vring_notify(VuDev *dev, VuVirtq *vq)
>  {
> @@ -1824,12 +2064,6 @@ virtqueue_map_desc(VuDev *dev,
>      *p_num_sg =3D num_sg;
>  }
>
> -/* Round number down to multiple */
> -#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
> -
> -/* Round number up to multiple */
> -#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
> -
>  static void *
>  virtqueue_alloc_element(size_t sz,
>                                       unsigned out_num, unsigned in_num)
> @@ -1930,9 +2164,68 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigne=
d int idx, size_t sz)
>      return elem;
>  }
>
> +static int
> +vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
> +{
> +    if (!has_feature(dev->protocol_features,
> +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> +        return 0;
> +    }
> +
> +    if (unlikely(!vq->inflight)) {
> +        return -1;
> +    }
> +
> +    vq->inflight->desc[desc_idx].counter =3D vq->counter++;
> +    vq->inflight->desc[desc_idx].inflight =3D 1;
> +
> +    return 0;
> +}
> +
> +static int
> +vu_queue_inflight_pre_put(VuDev *dev, VuVirtq *vq, int desc_idx)
> +{
> +    if (!has_feature(dev->protocol_features,
> +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> +        return 0;
> +    }
> +
> +    if (unlikely(!vq->inflight)) {
> +        return -1;
> +    }
> +
> +    vq->inflight->last_batch_head =3D desc_idx;
> +
> +    return 0;
> +}
> +
> +static int
> +vu_queue_inflight_post_put(VuDev *dev, VuVirtq *vq, int desc_idx)
> +{
> +    if (!has_feature(dev->protocol_features,
> +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> +        return 0;
> +    }
> +
> +    if (unlikely(!vq->inflight)) {
> +        return -1;
> +    }
> +
> +    barrier();
> +
> +    vq->inflight->desc[desc_idx].inflight =3D 0;
> +
> +    barrier();
> +
> +    vq->inflight->used_idx =3D vq->used_idx;
> +
> +    return 0;
> +}
> +
>  void *
>  vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>  {
> +    int i;
>      unsigned int head;
>      VuVirtqElement *elem;
>
> @@ -1941,6 +2234,18 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>          return NULL;
>      }
>
> +    if (unlikely(vq->resubmit_list && vq->resubmit_num > 0)) {
> +        i =3D (--vq->resubmit_num);
> +        elem =3D vu_queue_map_desc(dev, vq, vq->resubmit_list[i].index, =
sz);
> +
> +        if (!vq->resubmit_num) {
> +            free(vq->resubmit_list);
> +            vq->resubmit_list =3D NULL;
> +        }
> +
> +        return elem;
> +    }
> +
>      if (vu_queue_empty(dev, vq)) {
>          return NULL;
>      }
> @@ -1971,6 +2276,8 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>
>      vq->inuse++;
>
> +    vu_queue_inflight_get(dev, vq, head);
> +
>      return elem;
>  }
>
> @@ -2131,5 +2438,7 @@ vu_queue_push(VuDev *dev, VuVirtq *vq,
>                const VuVirtqElement *elem, unsigned int len)
>  {
>      vu_queue_fill(dev, vq, elem, len, 0);
> +    vu_queue_inflight_pre_put(dev, vq, elem->index);
>      vu_queue_flush(dev, vq, 1);
> +    vu_queue_inflight_post_put(dev, vq, elem->index);
>  }
> --
> MST
>
>


--=20
Marc-Andr=C3=A9 Lureau


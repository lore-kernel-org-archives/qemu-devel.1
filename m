Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6458C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A132067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+ItD9TJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A132067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWdAi-00055U-62
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elohimes@gmail.com>) id 1iWd8p-00041V-UB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1iWd8m-0003vr-JC
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:16:15 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:34715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1iWd8m-0003vO-Dy
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:16:12 -0500
Received: by mail-qk1-x742.google.com with SMTP id 205so13774448qkk.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 01:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FfSAUgpxWT2Jwwy5zFSOPjnbDkCRlWHjHOmy0QsSEsw=;
 b=j+ItD9TJxhw/S0U9ERhlQriHzBb5QoFd4gOGS67GBcNlOBvVP8YoCaQDySk79I4sO/
 /D/7CDBn6UYs3Htev5z0DhAoyMrpK6cjtoTIYlBr8I7TQAWb7ELkB07X6+76w5VqRx1w
 Pc5Of9i6dfEgQoWvd+aXN8wHlcLRMeS7Afwx4RwQ/x5I7PEDppdmyn5mBaw3vm57Nj9C
 JMqhS6wKpeaQmOiZe/WsL+k+TorHOuGH+2cKT6U0h1Z4Fpo6vktukbra19SUnWW2j38g
 fmW+LqQhdf4TfvlJLX0Us1HI7NeDgLka0jYCkUMoHoLimWevbW72OOW1S405nTk7BLlb
 KU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FfSAUgpxWT2Jwwy5zFSOPjnbDkCRlWHjHOmy0QsSEsw=;
 b=BPuykKzIyU9harBFE67BBx+96tpZue5o07FzCSUhRXFNMoL+7UGc+PoGxHOUoqCxj2
 EyHO3UEMJCuFLtg0jKE6r8Pd8amV2uo9Rvxk1oEJKJVH3znnAWFb5TjKXg4nHfjplvhv
 C/M6YJyqeeEbUh4mqunJjARl0478p5wZjnUjIaI2GzahhaKEdHbcjhsDCnxelmKEuDcE
 6fB02c3qm1qGIIUebD/dXix3QQ49LtDRYYfh6AwabfxIlEF3/MeumEP/IiqGJ07Jotw0
 wEYNOxzhj+rRy8guF4fpqPqsSFmSGIbII6avTWwKIJDLR6Rs2BPGSZGTla8o/CHNT+cj
 +dDg==
X-Gm-Message-State: APjAAAVMdg6Hv+2cBnjhxhqpXwOYlfvgAMcHOQ/gv1QxXw566qGN5Yup
 DjQIovoISeD38CD8teeB1XfGttLaH6MXoRNLC7o=
X-Google-Smtp-Source: APXvYqz3R9m3pQeTyK8s4VgSTBQX0amHjWXZrRaEBHscNT3P6HlLCM1B1wz41iW6gAdnxO8KzTouqHIPDKAaqNdPgng=
X-Received: by 2002:a37:d8e:: with SMTP id 136mr10499034qkn.249.1574068570799; 
 Mon, 18 Nov 2019 01:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20190313025418.8292-1-mst@redhat.com>
 <20190228085355.9614-5-xieyongji@baidu.com>
 <CAJ+F1CK0ePybYjrTCESaxWBru04Bh6ZzVB1CdHo-vfJmA-UNvg@mail.gmail.com>
In-Reply-To: <CAJ+F1CK0ePybYjrTCESaxWBru04Bh6ZzVB1CdHo-vfJmA-UNvg@mail.gmail.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Mon, 18 Nov 2019 17:15:59 +0800
Message-ID: <CAONzpca2aELWsaU9iOVgtas136BLQGjPOwZefnPn2cv+sEpL2w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 22/26] libvhost-user: Support tracking
 inflight I/O in shared memory
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Xie Yongji <xieyongji@baidu.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 17 Nov 2019 at 01:43, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> On Wed, Mar 13, 2019 at 6:59 AM Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > This patch adds support for VHOST_USER_GET_INFLIGHT_FD and
> > VHOST_USER_SET_INFLIGHT_FD message to set/get shared buffer
> > to/from qemu. Then backend can track inflight I/O in this buffer.
> >
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > Message-Id: <20190228085355.9614-5-xieyongji@baidu.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  Makefile                              |   2 +-
> >  contrib/libvhost-user/libvhost-user.h |  70 ++++++
> >  contrib/libvhost-user/libvhost-user.c | 349 ++++++++++++++++++++++++--
> >  3 files changed, 400 insertions(+), 21 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 6ccb8639b0..abd78a9826 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -497,7 +497,7 @@ Makefile: $(version-obj-y)
> >  # Build libraries
> >
> >  libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
> > -libvhost-user.a: $(libvhost-user-obj-y)
> > +libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
> >
> >  ######################################################################
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-u=
ser/libvhost-user.h
> > index 3de8414898..414ceb0a2f 100644
> > --- a/contrib/libvhost-user/libvhost-user.h
> > +++ b/contrib/libvhost-user/libvhost-user.h
> > @@ -53,6 +53,7 @@ enum VhostUserProtocolFeature {
> >      VHOST_USER_PROTOCOL_F_CONFIG =3D 9,
> >      VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD =3D 10,
> >      VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,
> > +    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
> >
> >      VHOST_USER_PROTOCOL_F_MAX
> >  };
> > @@ -91,6 +92,8 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_POSTCOPY_ADVISE  =3D 28,
> >      VHOST_USER_POSTCOPY_LISTEN  =3D 29,
> >      VHOST_USER_POSTCOPY_END     =3D 30,
> > +    VHOST_USER_GET_INFLIGHT_FD =3D 31,
> > +    VHOST_USER_SET_INFLIGHT_FD =3D 32,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >
> > @@ -138,6 +141,13 @@ typedef struct VhostUserVringArea {
> >      uint64_t offset;
> >  } VhostUserVringArea;
> >
> > +typedef struct VhostUserInflight {
> > +    uint64_t mmap_size;
> > +    uint64_t mmap_offset;
> > +    uint16_t num_queues;
> > +    uint16_t queue_size;
> > +} VhostUserInflight;
> > +
> >  #if defined(_WIN32)
> >  # define VU_PACKED __attribute__((gcc_struct, packed))
> >  #else
> > @@ -163,6 +173,7 @@ typedef struct VhostUserMsg {
> >          VhostUserLog log;
> >          VhostUserConfig config;
> >          VhostUserVringArea area;
> > +        VhostUserInflight inflight;
> >      } payload;
> >
> >      int fds[VHOST_MEMORY_MAX_NREGIONS];
> > @@ -234,9 +245,61 @@ typedef struct VuRing {
> >      uint32_t flags;
> >  } VuRing;
> >
> > +typedef struct VuDescStateSplit {
> > +    /* Indicate whether this descriptor is inflight or not.
> > +     * Only available for head-descriptor. */
> > +    uint8_t inflight;
> > +
> > +    /* Padding */
> > +    uint8_t padding[5];
> > +
> > +    /* Maintain a list for the last batch of used descriptors.
> > +     * Only available when batching is used for submitting */
> > +    uint16_t next;
> > +
> > +    /* Used to preserve the order of fetching available descriptors.
> > +     * Only available for head-descriptor. */
> > +    uint64_t counter;
> > +} VuDescStateSplit;
> > +
> > +typedef struct VuVirtqInflight {
> > +    /* The feature flags of this region. Now it's initialized to 0. */
> > +    uint64_t features;
> > +
> > +    /* The version of this region. It's 1 currently.
> > +     * Zero value indicates a vm reset happened. */
> > +    uint16_t version;
> > +
> > +    /* The size of VuDescStateSplit array. It's equal to the virtqueue
> > +     * size. Slave could get it from queue size field of VhostUserInfl=
ight. */
> > +    uint16_t desc_num;
> > +
> > +    /* The head of list that track the last batch of used descriptors.=
 */
> > +    uint16_t last_batch_head;
> > +
> > +    /* Storing the idx value of used ring */
> > +    uint16_t used_idx;
> > +
> > +    /* Used to track the state of each descriptor in descriptor table =
*/
> > +    VuDescStateSplit desc[0];
> > +} VuVirtqInflight;
> > +
> > +typedef struct VuVirtqInflightDesc {
> > +    uint16_t index;
> > +    uint64_t counter;
> > +} VuVirtqInflightDesc;
> > +
> >  typedef struct VuVirtq {
> >      VuRing vring;
> >
> > +    VuVirtqInflight *inflight;
> > +
> > +    VuVirtqInflightDesc *resubmit_list;
> > +
> > +    uint16_t resubmit_num;
> > +
> > +    uint64_t counter;
> > +
> >      /* Next head to pop */
> >      uint16_t last_avail_idx;
> >
> > @@ -279,11 +342,18 @@ typedef void (*vu_set_watch_cb) (VuDev *dev, int =
fd, int condition,
> >                                   vu_watch_cb cb, void *data);
> >  typedef void (*vu_remove_watch_cb) (VuDev *dev, int fd);
> >
> > +typedef struct VuDevInflightInfo {
> > +    int fd;
> > +    void *addr;
> > +    uint64_t size;
> > +} VuDevInflightInfo;
> > +
> >  struct VuDev {
> >      int sock;
> >      uint32_t nregions;
> >      VuDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
> >      VuVirtq vq[VHOST_MAX_NR_VIRTQUEUE];
> > +    VuDevInflightInfo inflight_info;
> >      int log_call_fd;
> >      int slave_fd;
> >      uint64_t log_size;
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-u=
ser/libvhost-user.c
> > index ddd15d79cf..e08d6c7b97 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -41,6 +41,8 @@
> >  #endif
> >
> >  #include "qemu/atomic.h"
> > +#include "qemu/osdep.h"
> > +#include "qemu/memfd.h"
> >
> >  #include "libvhost-user.h"
> >
> > @@ -53,6 +55,18 @@
> >              _min1 < _min2 ? _min1 : _min2; })
> >  #endif
> >
> > +/* Round number down to multiple */
> > +#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
> > +
> > +/* Round number up to multiple */
> > +#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
> > +
> > +/* Align each region to cache line size in inflight buffer */
> > +#define INFLIGHT_ALIGNMENT 64
> > +
> > +/* The version of inflight buffer */
> > +#define INFLIGHT_VERSION 1
> > +
> >  #define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
> >
> >  /* The version of the protocol we support */
> > @@ -66,6 +80,20 @@
> >          }                                       \
> >      } while (0)
> >
> > +static inline
> > +bool has_feature(uint64_t features, unsigned int fbit)
> > +{
> > +    assert(fbit < 64);
> > +    return !!(features & (1ULL << fbit));
> > +}
> > +
> > +static inline
> > +bool vu_has_feature(VuDev *dev,
> > +                    unsigned int fbit)
> > +{
> > +    return has_feature(dev->features, fbit);
> > +}
> > +
> >  static const char *
> >  vu_request_to_string(unsigned int req)
> >  {
> > @@ -100,6 +128,8 @@ vu_request_to_string(unsigned int req)
> >          REQ(VHOST_USER_POSTCOPY_ADVISE),
> >          REQ(VHOST_USER_POSTCOPY_LISTEN),
> >          REQ(VHOST_USER_POSTCOPY_END),
> > +        REQ(VHOST_USER_GET_INFLIGHT_FD),
> > +        REQ(VHOST_USER_SET_INFLIGHT_FD),
> >          REQ(VHOST_USER_MAX),
> >      };
> >  #undef REQ
> > @@ -890,6 +920,91 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *=
vmsg)
> >      return true;
> >  }
> >
> > +static int
> > +inflight_desc_compare(const void *a, const void *b)
> > +{
> > +    VuVirtqInflightDesc *desc0 =3D (VuVirtqInflightDesc *)a,
> > +                        *desc1 =3D (VuVirtqInflightDesc *)b;
> > +
> > +    if (desc1->counter > desc0->counter &&
> > +        (desc1->counter - desc0->counter) < VIRTQUEUE_MAX_SIZE * 2) {
> > +        return 1;
> > +    }
> > +
> > +    return -1;
> > +}
> > +
> > +static int
> > +vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
> > +{
> > +    int i =3D 0;
> > +
> > +    if (!has_feature(dev->protocol_features,
> > +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> > +        return 0;
> > +    }
> > +
> > +    if (unlikely(!vq->inflight)) {
> > +        return -1;
> > +    }
> > +
> > +    if (unlikely(!vq->inflight->version)) {
> > +        /* initialize the buffer */
> > +        vq->inflight->version =3D INFLIGHT_VERSION;
> > +        return 0;
> > +    }
> > +
> > +    vq->used_idx =3D vq->vring.used->idx;
> > +    vq->resubmit_num =3D 0;
> > +    vq->resubmit_list =3D NULL;
> > +    vq->counter =3D 0;
> > +
> > +    if (unlikely(vq->inflight->used_idx !=3D vq->used_idx)) {
> > +        vq->inflight->desc[vq->inflight->last_batch_head].inflight =3D=
 0;
> > +
> > +        barrier();
> > +
> > +        vq->inflight->used_idx =3D vq->used_idx;
> > +    }
> > +
> > +    for (i =3D 0; i < vq->inflight->desc_num; i++) {
> > +        if (vq->inflight->desc[i].inflight =3D=3D 1) {
> > +            vq->inuse++;
> > +        }
> > +    }
> > +
> > +    vq->shadow_avail_idx =3D vq->last_avail_idx =3D vq->inuse + vq->us=
ed_idx;
> > +
> > +    if (vq->inuse) {
> > +        vq->resubmit_list =3D malloc(sizeof(VuVirtqInflightDesc) * vq-=
>inuse);
> > +        if (!vq->resubmit_list) {
> > +            return -1;
> > +        }
> > +
> > +        for (i =3D 0; i < vq->inflight->desc_num; i++) {
> > +            if (vq->inflight->desc[i].inflight) {
> > +                vq->resubmit_list[vq->resubmit_num].index =3D i;
> > +                vq->resubmit_list[vq->resubmit_num].counter =3D
> > +                                        vq->inflight->desc[i].counter;
> > +                vq->resubmit_num++;
> > +            }
> > +        }
> > +
> > +        if (vq->resubmit_num > 1) {
> > +            qsort(vq->resubmit_list, vq->resubmit_num,
> > +                  sizeof(VuVirtqInflightDesc), inflight_desc_compare);
> > +        }
> > +        vq->counter =3D vq->resubmit_list[0].counter + 1;
>
> scan-build reports that vq->resubmit_list[0].counter may be garbage
> value, if it's not initialized in the loop above.
> Xie, could you provide a fix?
>

OK, will fix it soon. Thank you!

Thanks,
Yongji
> > +    }
> > +
> > +    /* in case of I/O hang after reconnecting */
> > +    if (eventfd_write(vq->kick_fd, 1)) {
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static bool
> >  vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> > @@ -923,6 +1038,10 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *=
vmsg)
> >                 dev->vq[index].kick_fd, index);
> >      }
> >
> > +    if (vu_check_queue_inflights(dev, &dev->vq[index])) {
> > +        vu_panic(dev, "Failed to check inflights for vq: %d\n", index)=
;
> > +    }
> > +
> >      return false;
> >  }
> >
> > @@ -995,6 +1114,11 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *=
vmsg)
> >
> >      dev->vq[index].call_fd =3D vmsg->fds[0];
> >
> > +    /* in case of I/O hang after reconnecting */
> > +    if (eventfd_write(vmsg->fds[0], 1)) {
> > +        return -1;
> > +    }
> > +
> >      DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
> >
> >      return false;
> > @@ -1209,6 +1333,116 @@ vu_set_postcopy_end(VuDev *dev, VhostUserMsg *v=
msg)
> >      return true;
> >  }
> >
> > +static inline uint64_t
> > +vu_inflight_queue_size(uint16_t queue_size)
> > +{
> > +    return ALIGN_UP(sizeof(VuDescStateSplit) * queue_size +
> > +           sizeof(uint16_t), INFLIGHT_ALIGNMENT);
> > +}
> > +
> > +static bool
> > +vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
> > +{
> > +    int fd;
> > +    void *addr;
> > +    uint64_t mmap_size;
> > +    uint16_t num_queues, queue_size;
> > +
> > +    if (vmsg->size !=3D sizeof(vmsg->payload.inflight)) {
> > +        vu_panic(dev, "Invalid get_inflight_fd message:%d", vmsg->size=
);
> > +        vmsg->payload.inflight.mmap_size =3D 0;
> > +        return true;
> > +    }
> > +
> > +    num_queues =3D vmsg->payload.inflight.num_queues;
> > +    queue_size =3D vmsg->payload.inflight.queue_size;
> > +
> > +    DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
> > +    DPRINT("set_inflight_fd queue_size: %"PRId16"\n", queue_size);
> > +
> > +    mmap_size =3D vu_inflight_queue_size(queue_size) * num_queues;
> > +
> > +    addr =3D qemu_memfd_alloc("vhost-inflight", mmap_size,
> > +                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > +                            &fd, NULL);
> > +
> > +    if (!addr) {
> > +        vu_panic(dev, "Failed to alloc vhost inflight area");
> > +        vmsg->payload.inflight.mmap_size =3D 0;
> > +        return true;
> > +    }
> > +
> > +    memset(addr, 0, mmap_size);
> > +
> > +    dev->inflight_info.addr =3D addr;
> > +    dev->inflight_info.size =3D vmsg->payload.inflight.mmap_size =3D m=
map_size;
> > +    dev->inflight_info.fd =3D vmsg->fds[0] =3D fd;
> > +    vmsg->fd_num =3D 1;
> > +    vmsg->payload.inflight.mmap_offset =3D 0;
> > +
> > +    DPRINT("send inflight mmap_size: %"PRId64"\n",
> > +           vmsg->payload.inflight.mmap_size);
> > +    DPRINT("send inflight mmap offset: %"PRId64"\n",
> > +           vmsg->payload.inflight.mmap_offset);
> > +
> > +    return true;
> > +}
> > +
> > +static bool
> > +vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
> > +{
> > +    int fd, i;
> > +    uint64_t mmap_size, mmap_offset;
> > +    uint16_t num_queues, queue_size;
> > +    void *rc;
> > +
> > +    if (vmsg->fd_num !=3D 1 ||
> > +        vmsg->size !=3D sizeof(vmsg->payload.inflight)) {
> > +        vu_panic(dev, "Invalid set_inflight_fd message size:%d fds:%d"=
,
> > +                 vmsg->size, vmsg->fd_num);
> > +        return false;
> > +    }
> > +
> > +    fd =3D vmsg->fds[0];
> > +    mmap_size =3D vmsg->payload.inflight.mmap_size;
> > +    mmap_offset =3D vmsg->payload.inflight.mmap_offset;
> > +    num_queues =3D vmsg->payload.inflight.num_queues;
> > +    queue_size =3D vmsg->payload.inflight.queue_size;
> > +
> > +    DPRINT("set_inflight_fd mmap_size: %"PRId64"\n", mmap_size);
> > +    DPRINT("set_inflight_fd mmap_offset: %"PRId64"\n", mmap_offset);
> > +    DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
> > +    DPRINT("set_inflight_fd queue_size: %"PRId16"\n", queue_size);
> > +
> > +    rc =3D mmap(0, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> > +              fd, mmap_offset);
> > +
> > +    if (rc =3D=3D MAP_FAILED) {
> > +        vu_panic(dev, "set_inflight_fd mmap error: %s", strerror(errno=
));
> > +        return false;
> > +    }
> > +
> > +    if (dev->inflight_info.fd) {
> > +        close(dev->inflight_info.fd);
> > +    }
> > +
> > +    if (dev->inflight_info.addr) {
> > +        munmap(dev->inflight_info.addr, dev->inflight_info.size);
> > +    }
> > +
> > +    dev->inflight_info.fd =3D fd;
> > +    dev->inflight_info.addr =3D rc;
> > +    dev->inflight_info.size =3D mmap_size;
> > +
> > +    for (i =3D 0; i < num_queues; i++) {
> > +        dev->vq[i].inflight =3D (VuVirtqInflight *)rc;
> > +        dev->vq[i].inflight->desc_num =3D queue_size;
> > +        rc =3D (void *)((char *)rc + vu_inflight_queue_size(queue_size=
));
> > +    }
> > +
> > +    return false;
> > +}
> > +
> >  static bool
> >  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> > @@ -1287,6 +1521,10 @@ vu_process_message(VuDev *dev, VhostUserMsg *vms=
g)
> >          return vu_set_postcopy_listen(dev, vmsg);
> >      case VHOST_USER_POSTCOPY_END:
> >          return vu_set_postcopy_end(dev, vmsg);
> > +    case VHOST_USER_GET_INFLIGHT_FD:
> > +        return vu_get_inflight_fd(dev, vmsg);
> > +    case VHOST_USER_SET_INFLIGHT_FD:
> > +        return vu_set_inflight_fd(dev, vmsg);
> >      default:
> >          vmsg_close_fds(vmsg);
> >          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> > @@ -1354,8 +1592,24 @@ vu_deinit(VuDev *dev)
> >              close(vq->err_fd);
> >              vq->err_fd =3D -1;
> >          }
> > +
> > +        if (vq->resubmit_list) {
> > +            free(vq->resubmit_list);
> > +            vq->resubmit_list =3D NULL;
> > +        }
> > +
> > +        vq->inflight =3D NULL;
> >      }
> >
> > +    if (dev->inflight_info.addr) {
> > +        munmap(dev->inflight_info.addr, dev->inflight_info.size);
> > +        dev->inflight_info.addr =3D NULL;
> > +    }
> > +
> > +    if (dev->inflight_info.fd > 0) {
> > +        close(dev->inflight_info.fd);
> > +        dev->inflight_info.fd =3D -1;
> > +    }
> >
> >      vu_close_log(dev);
> >      if (dev->slave_fd !=3D -1) {
> > @@ -1682,20 +1936,6 @@ vu_queue_empty(VuDev *dev, VuVirtq *vq)
> >      return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
> >  }
> >
> > -static inline
> > -bool has_feature(uint64_t features, unsigned int fbit)
> > -{
> > -    assert(fbit < 64);
> > -    return !!(features & (1ULL << fbit));
> > -}
> > -
> > -static inline
> > -bool vu_has_feature(VuDev *dev,
> > -                    unsigned int fbit)
> > -{
> > -    return has_feature(dev->features, fbit);
> > -}
> > -
> >  static bool
> >  vring_notify(VuDev *dev, VuVirtq *vq)
> >  {
> > @@ -1824,12 +2064,6 @@ virtqueue_map_desc(VuDev *dev,
> >      *p_num_sg =3D num_sg;
> >  }
> >
> > -/* Round number down to multiple */
> > -#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
> > -
> > -/* Round number up to multiple */
> > -#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
> > -
> >  static void *
> >  virtqueue_alloc_element(size_t sz,
> >                                       unsigned out_num, unsigned in_num=
)
> > @@ -1930,9 +2164,68 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsig=
ned int idx, size_t sz)
> >      return elem;
> >  }
> >
> > +static int
> > +vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
> > +{
> > +    if (!has_feature(dev->protocol_features,
> > +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> > +        return 0;
> > +    }
> > +
> > +    if (unlikely(!vq->inflight)) {
> > +        return -1;
> > +    }
> > +
> > +    vq->inflight->desc[desc_idx].counter =3D vq->counter++;
> > +    vq->inflight->desc[desc_idx].inflight =3D 1;
> > +
> > +    return 0;
> > +}
> > +
> > +static int
> > +vu_queue_inflight_pre_put(VuDev *dev, VuVirtq *vq, int desc_idx)
> > +{
> > +    if (!has_feature(dev->protocol_features,
> > +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> > +        return 0;
> > +    }
> > +
> > +    if (unlikely(!vq->inflight)) {
> > +        return -1;
> > +    }
> > +
> > +    vq->inflight->last_batch_head =3D desc_idx;
> > +
> > +    return 0;
> > +}
> > +
> > +static int
> > +vu_queue_inflight_post_put(VuDev *dev, VuVirtq *vq, int desc_idx)
> > +{
> > +    if (!has_feature(dev->protocol_features,
> > +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> > +        return 0;
> > +    }
> > +
> > +    if (unlikely(!vq->inflight)) {
> > +        return -1;
> > +    }
> > +
> > +    barrier();
> > +
> > +    vq->inflight->desc[desc_idx].inflight =3D 0;
> > +
> > +    barrier();
> > +
> > +    vq->inflight->used_idx =3D vq->used_idx;
> > +
> > +    return 0;
> > +}
> > +
> >  void *
> >  vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
> >  {
> > +    int i;
> >      unsigned int head;
> >      VuVirtqElement *elem;
> >
> > @@ -1941,6 +2234,18 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
> >          return NULL;
> >      }
> >
> > +    if (unlikely(vq->resubmit_list && vq->resubmit_num > 0)) {
> > +        i =3D (--vq->resubmit_num);
> > +        elem =3D vu_queue_map_desc(dev, vq, vq->resubmit_list[i].index=
, sz);
> > +
> > +        if (!vq->resubmit_num) {
> > +            free(vq->resubmit_list);
> > +            vq->resubmit_list =3D NULL;
> > +        }
> > +
> > +        return elem;
> > +    }
> > +
> >      if (vu_queue_empty(dev, vq)) {
> >          return NULL;
> >      }
> > @@ -1971,6 +2276,8 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
> >
> >      vq->inuse++;
> >
> > +    vu_queue_inflight_get(dev, vq, head);
> > +
> >      return elem;
> >  }
> >
> > @@ -2131,5 +2438,7 @@ vu_queue_push(VuDev *dev, VuVirtq *vq,
> >                const VuVirtqElement *elem, unsigned int len)
> >  {
> >      vu_queue_fill(dev, vq, elem, len, 0);
> > +    vu_queue_inflight_pre_put(dev, vq, elem->index);
> >      vu_queue_flush(dev, vq, 1);
> > +    vu_queue_inflight_post_put(dev, vq, elem->index);
> >  }
> > --
> > MST
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>


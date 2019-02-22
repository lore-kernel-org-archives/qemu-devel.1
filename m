Received: from eggs.gnu.org ([209.51.188.92]:53929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gx0sI-00014S-65
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 21:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gx0sG-0001Od-Jo
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 21:47:42 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:42722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gx0sG-0001C0-4V
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 21:47:40 -0500
Received: by mail-qk1-x742.google.com with SMTP id y140so331053qkb.9
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 18:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20190218102748.2242-1-xieyongji@baidu.com>
	<20190218102748.2242-2-xieyongji@baidu.com>
	<20190221120121-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190221120121-mutt-send-email-mst@kernel.org>
From: Yongji Xie <elohimes@gmail.com>
Date: Fri, 22 Feb 2019 10:47:03 +0800
Message-ID: <CAONzpcYHae1fCJLN56ofQ91tSQi_JCXAA6mBhf0NqN=QusV1zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 1/7] vhost-user: Support transferring
 inflight buffer between qemu and backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Fri, 22 Feb 2019 at 01:27, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Feb 18, 2019 at 06:27:42PM +0800, elohimes@gmail.com wrote:
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > This patch introduces two new messages VHOST_USER_GET_INFLIGHT_FD
> > and VHOST_USER_SET_INFLIGHT_FD to support transferring a shared
> > buffer between qemu and backend.
> >
> > Firstly, qemu uses VHOST_USER_GET_INFLIGHT_FD to get the
> > shared buffer from backend. Then qemu should send it back
> > through VHOST_USER_SET_INFLIGHT_FD each time we start vhost-user.
> >
> > This shared buffer is used to track inflight I/O by backend.
> > Qemu should retrieve a new one when vm reset.
> >
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > Signed-off-by: Chai Wen <chaiwen@baidu.com>
> > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > ---
> >  docs/interop/vhost-user.txt       | 264 ++++++++++++++++++++++++++++++
> >  hw/virtio/vhost-user.c            | 107 ++++++++++++
> >  hw/virtio/vhost.c                 |  96 +++++++++++
> >  include/hw/virtio/vhost-backend.h |  10 ++
> >  include/hw/virtio/vhost.h         |  18 ++
> >  5 files changed, 495 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > index c2194711d9..61c6d0e415 100644
> > --- a/docs/interop/vhost-user.txt
> > +++ b/docs/interop/vhost-user.txt
> > @@ -142,6 +142,17 @@ Depending on the request type, payload can be:
> >     Offset: a 64-bit offset of this area from the start of the
> >         supplied file descriptor
> >
> > + * Inflight description
> > +   -----------------------------------------------------
> > +   | mmap size | mmap offset | num queues | queue size |
> > +   -----------------------------------------------------
> > +
> > +   mmap size: a 64-bit size of area to track inflight I/O
> > +   mmap offset: a 64-bit offset of this area from the start
> > +                of the supplied file descriptor
> > +   num queues: a 16-bit number of virtqueues
> > +   queue size: a 16-bit size of virtqueues
> > +
> >  In QEMU the vhost-user message is implemented with the following struct:
> >
> >  typedef struct VhostUserMsg {
> > @@ -157,6 +168,7 @@ typedef struct VhostUserMsg {
> >          struct vhost_iotlb_msg iotlb;
> >          VhostUserConfig config;
> >          VhostUserVringArea area;
> > +        VhostUserInflight inflight;
> >      };
> >  } QEMU_PACKED VhostUserMsg;
> >
> > @@ -175,6 +187,7 @@ the ones that do:
> >   * VHOST_USER_GET_PROTOCOL_FEATURES
> >   * VHOST_USER_GET_VRING_BASE
> >   * VHOST_USER_SET_LOG_BASE (if VHOST_USER_PROTOCOL_F_LOG_SHMFD)
> > + * VHOST_USER_GET_INFLIGHT_FD (if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)
> >
> >  [ Also see the section on REPLY_ACK protocol extension. ]
> >
> > @@ -188,6 +201,7 @@ in the ancillary data:
> >   * VHOST_USER_SET_VRING_CALL
> >   * VHOST_USER_SET_VRING_ERR
> >   * VHOST_USER_SET_SLAVE_REQ_FD
> > + * VHOST_USER_SET_INFLIGHT_FD (if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)
> >
> >  If Master is unable to send the full message or receives a wrong reply it will
> >  close the connection. An optional reconnection mechanism can be implemented.
> > @@ -382,6 +396,235 @@ If VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD protocol feature is negotiated,
> >  slave can send file descriptors (at most 8 descriptors in each message)
> >  to master via ancillary data using this fd communication channel.
> >
> > +Inflight I/O tracking
> > +---------------------
> > +
> > +To support reconnecting after restart or crash, slave may need to resubmit
> > +inflight I/Os. If virtqueue is processed in order, we can easily achieve
> > +that by getting the inflight descriptors from descriptor table (split virtqueue)
> > +or descriptor ring (packed virtqueue). However, it can't work when we process
> > +descriptors out-of-order because some entries which store the information of
> > +inflight descriptors in available ring (split virtqueue) or descriptor
> > +ring (packed virtqueue) might be overrided by new entries. To solve this
> > +problem, slave need to allocate an extra buffer to store this information of inflight
> > +descriptors and share it with master for persistent. VHOST_USER_GET_INFLIGHT_FD and
> > +VHOST_USER_SET_INFLIGHT_FD are used to transfer this buffer between master
> > +and slave. And the format of this buffer is described below:
> > +
> > +-------------------------------------------------------
> > +| queue0 region | queue1 region | ... | queueN region |
> > +-------------------------------------------------------
> > +
> > +N is the number of available virtqueues. Slave could get it from num queues
> > +field of VhostUserInflight.
> > +
> > +For split virtqueue, queue region can be implemented as:
> > +
> > +typedef struct DescStateSplit {
> > +    /* Indicate whether this descriptor is inflight or not.
> > +     * Only available for head-descriptor. */
> > +    uint8_t inflight;
> > +
> > +    /* Padding */
> > +    uint8_t padding;
> > +
> > +    /* Link to the last processed entry */
> > +    uint16_t next;
> > +} DescStateSplit;
> > +
> > +typedef struct QueueRegionSplit {
> > +    /* The feature flags of this region. Now it's initialized to 0. */
> > +    uint64_t features;
> > +
> > +    /* The version of this region. It's 1 currently.
> > +     * Zero value indicates an uninitialized buffer */
> > +    uint16_t version;
> > +
> > +    /* The size of DescStateSplit array. It's equal to the virtqueue
> > +     * size. Slave could get it from queue size field of VhostUserInflight. */
> > +    uint16_t desc_num;
> > +
> > +    /* The head of processed DescStateSplit entry list */
> > +    uint16_t process_head;
> > +
> > +    /* Storing the idx value of used ring */
> > +    uint16_t used_idx;
> > +
> > +    /* Used to track the state of each descriptor in descriptor table */
> > +    DescStateSplit desc[0];
> > +} QueueRegionSplit;
>
>
> What is the endian-ness of multibyte fields?
>

Native endian is OK here. Right?

>
> > +
> > +To track inflight I/O, the queue region should be processed as follows:
> > +
> > +When receiving available buffers from the driver:
> > +
> > +    1. Get the next available head-descriptor index from available ring, i
> > +
> > +    2. Set desc[i].inflight to 1
> > +
> > +When supplying used buffers to the driver:
> > +
> > +    1. Get corresponding used head-descriptor index, i
> > +
> > +    2. Set desc[i].next to process_head
> > +
> > +    3. Set process_head to i
> > +
> > +    4. Steps 1,2,3 may be performed repeatedly if batching is possible
> > +
> > +    5. Increase the idx value of used ring by the size of the batch
> > +
> > +    6. Set the inflight field of each DescStateSplit entry in the batch to 0
> > +
> > +    7. Set used_idx to the idx value of used ring
> > +
> > +When reconnecting:
> > +
> > +    1. If the value of used_idx does not match the idx value of used ring,
> > +
> > +        (a) Subtract the value of used_idx from the idx value of used ring to get
> > +        the number of in-progress DescStateSplit entries
> > +
> > +        (b) Set the inflight field of the in-progress DescStateSplit entries which
> > +        start from process_head to 0
> > +
> > +        (c) Set used_idx to the idx value of used ring
> > +
> > +    2. Resubmit each inflight DescStateSplit entry
>
> I re-read a couple of time and I still don't understand what it says.
>
> For simplicity consider split ring. So we want a list of heads that are
> outstanding. Fair enough. Now device finishes a head. What now? I needs
> to drop head from the list. But list is unidirectional (just next, no
> prev). So how can you drop an entry from the middle?
>

The process_head is only used when slave crash between increasing the
idx value of used ring and updating used_idx. We use it to find the
in-progress DescStateSplit entries before the crash and complete them
when reconnecting. Make sure guest and slave have the same view for
inflight I/Os.

In other case, the inflight field is enough to track inflight I/O.
When reconnecting, we go through all DescStateSplit entries and
re-submit the entry whose inflight field is equal to 1.

> > +For packed virtqueue, queue region can be implemented as:
> > +
> > +typedef struct DescStatePacked {
> > +    /* Indicate whether this descriptor is inflight or not.
> > +     * Only available for head-descriptor. */
> > +    uint8_t inflight;
> > +
> > +    /* Padding */
> > +    uint8_t padding;
> > +
> > +    /* Link to the next free entry */
> > +    uint16_t next;
> > +
> > +    /* Link to the last entry of descriptor list.
> > +     * Only available for head-descriptor. */
> > +    uint16_t last;
> > +
> > +    /* The length of descriptor list.
> > +     * Only available for head-descriptor. */
> > +    uint16_t num;
> > +
> > +    /* The buffer id */
> > +    uint16_t id;
> > +
> > +    /* The descriptor flags */
> > +    uint16_t flags;
> > +
> > +    /* The buffer length */
> > +    uint32_t len;
> > +
> > +    /* The buffer address */
> > +    uint64_t addr;
>
> Do we want an extra u64 here to make it a power of two?
>

Looks good to me.

Thanks,
Yongji

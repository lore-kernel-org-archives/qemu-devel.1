Received: from eggs.gnu.org ([2001:4830:134:3::10]:43720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmiJN-0003l2-O4
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmiJK-0006zL-J3
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:20:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dmiJK-0006yw-9N
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:20:14 -0400
Date: Tue, 29 Aug 2017 18:20:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170829181921-mutt-send-email-mst@kernel.org>
References: <20170829144805.28872-1-marcandre.lureau@redhat.com>
	<20170829144805.28872-2-marcandre.lureau@redhat.com>
	<20170829175820-mutt-send-email-mst@kernel.org>
	<CAJ+F1CLYGyJyfNB26iyiaRbf5Pq9HveW_h+rFp_ZFrrvkmATDA@mail.gmail.com>
	<20170829180900-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJ5-s-wqWgiHTNQ_a6AvPkG4RyXy8xbCCQQHsSmhhXpNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJ5-s-wqWgiHTNQ_a6AvPkG4RyXy8xbCCQQHsSmhhXpNQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] libvhost-user: support resuming
 vq->last_avail_idx based on used_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Victor Kaplansky <victork@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Tue, Aug 29, 2017 at 05:18:11PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Aug 29, 2017 at 5:09 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > On Tue, Aug 29, 2017 at 05:04:34PM +0200, Marc-Andr=E9 Lureau wrote:
> >> Hi
> >>
> >> On Tue, Aug 29, 2017 at 5:01 PM, Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> >> > On Tue, Aug 29, 2017 at 04:48:04PM +0200, Marc-Andr=E9 Lureau wrot=
e:
> >> >> This is the same workaround as commit 523b018dde3b765, which was =
lost
> >> >> with libvhost-user transition in commit e10e798c85c2331.
> >> >>
> >> >> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >> >> ---
> >> >>  contrib/libvhost-user/libvhost-user.h |  5 +++++
> >> >>  contrib/libvhost-user/libvhost-user.c | 13 +++++++++++++
> >> >>  2 files changed, 18 insertions(+)
> >> >>
> >> >> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libv=
host-user/libvhost-user.h
> >> >> index 53ef222c0b..aca71717c1 100644
> >> >> --- a/contrib/libvhost-user/libvhost-user.h
> >> >> +++ b/contrib/libvhost-user/libvhost-user.h
> >> >> @@ -132,6 +132,7 @@ typedef void (*vu_set_features_cb) (VuDev *de=
v, uint64_t features);
> >> >>  typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg=
,
> >> >>                                    int *do_reply);
> >> >>  typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, b=
ool started);
> >> >> +typedef bool (*vu_queue_resume_to_used_cb) (VuDev *dev, int qidx=
);
> >> >>
> >> >>  typedef struct VuDevIface {
> >> >>      /* called by VHOST_USER_GET_FEATURES to get the features bit=
mask */
> >> >> @@ -148,6 +149,10 @@ typedef struct VuDevIface {
> >> >>      vu_process_msg_cb process_msg;
> >> >>      /* tells when queues can be processed */
> >> >>      vu_queue_set_started_cb queue_set_started;
> >> >> +    /* If the queue must be resumed to vring.used->idx. */
> >> >> +    /* This can help to support resuming on unmanaged exit/crash=
 when
> >> >> +     * the slave/driver processes elements in order. */
> >> >> +    vu_queue_resume_to_used_cb queue_resume_to_used;
> >> >>  } VuDevIface;
> >> >>
> >> >>  typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
> >> >
> >> > Let's consider: this is only safe if queue is processed in order.
> >> > So I think that would be a better name for the field.
> >> >
> >> That's what the comment say already :)
> >>
> >> Which name do you suggest? vu_queue_is_processed_in_order?
> >
> > Something like this.
> >
> >> Does that
> >> imply it should always resume?
> >
> > Not sure I understand the question.
>=20
> If a "queue_is_processed_in_order", does that imply libvhost-user
> should always resume it based on used_idx? I think it does, but the
> correlation is less obvious than explicitly saying "resume_to_used".

Just add a comment then. You do not want low level details
like used index in all backends.


>=20
> --=20
> Marc-Andr=E9 Lureau

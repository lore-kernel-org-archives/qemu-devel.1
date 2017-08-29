Received: from eggs.gnu.org ([2001:4830:134:3::10]:41240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmi97-0000BP-VF
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmi93-0002T1-T5
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:09:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dmi93-0002SI-Jf
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:09:37 -0400
Date: Tue, 29 Aug 2017 18:09:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170829180900-mutt-send-email-mst@kernel.org>
References: <20170829144805.28872-1-marcandre.lureau@redhat.com>
	<20170829144805.28872-2-marcandre.lureau@redhat.com>
	<20170829175820-mutt-send-email-mst@kernel.org>
	<CAJ+F1CLYGyJyfNB26iyiaRbf5Pq9HveW_h+rFp_ZFrrvkmATDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLYGyJyfNB26iyiaRbf5Pq9HveW_h+rFp_ZFrrvkmATDA@mail.gmail.com>
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

On Tue, Aug 29, 2017 at 05:04:34PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Aug 29, 2017 at 5:01 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > On Tue, Aug 29, 2017 at 04:48:04PM +0200, Marc-Andr=E9 Lureau wrote:
> >> This is the same workaround as commit 523b018dde3b765, which was los=
t
> >> with libvhost-user transition in commit e10e798c85c2331.
> >>
> >> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  contrib/libvhost-user/libvhost-user.h |  5 +++++
> >>  contrib/libvhost-user/libvhost-user.c | 13 +++++++++++++
> >>  2 files changed, 18 insertions(+)
> >>
> >> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhos=
t-user/libvhost-user.h
> >> index 53ef222c0b..aca71717c1 100644
> >> --- a/contrib/libvhost-user/libvhost-user.h
> >> +++ b/contrib/libvhost-user/libvhost-user.h
> >> @@ -132,6 +132,7 @@ typedef void (*vu_set_features_cb) (VuDev *dev, =
uint64_t features);
> >>  typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
> >>                                    int *do_reply);
> >>  typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool=
 started);
> >> +typedef bool (*vu_queue_resume_to_used_cb) (VuDev *dev, int qidx);
> >>
> >>  typedef struct VuDevIface {
> >>      /* called by VHOST_USER_GET_FEATURES to get the features bitmas=
k */
> >> @@ -148,6 +149,10 @@ typedef struct VuDevIface {
> >>      vu_process_msg_cb process_msg;
> >>      /* tells when queues can be processed */
> >>      vu_queue_set_started_cb queue_set_started;
> >> +    /* If the queue must be resumed to vring.used->idx. */
> >> +    /* This can help to support resuming on unmanaged exit/crash wh=
en
> >> +     * the slave/driver processes elements in order. */
> >> +    vu_queue_resume_to_used_cb queue_resume_to_used;
> >>  } VuDevIface;
> >>
> >>  typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
> >
> > Let's consider: this is only safe if queue is processed in order.
> > So I think that would be a better name for the field.
> >
> That's what the comment say already :)
>=20
> Which name do you suggest? vu_queue_is_processed_in_order?

Something like this.

> Does that
> imply it should always resume?

Not sure I understand the question.

> >
> >> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhos=
t-user/libvhost-user.c
> >> index 35fa0c5e56..36439caed6 100644
> >> --- a/contrib/libvhost-user/libvhost-user.c
> >> +++ b/contrib/libvhost-user/libvhost-user.c
> >> @@ -521,6 +521,19 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg=
 *vmsg)
> >>
> >>      vq->used_idx =3D vq->vring.used->idx;
> >>
> >> +    if (vq->last_avail_idx !=3D vq->used_idx) {
> >> +        bool resume =3D dev->iface->queue_resume_to_used &&
> >> +            dev->iface->queue_resume_to_used(dev, index);
> >> +
> >> +        DPRINT("Last avail index !=3D used index: %u !=3D %u%s\n",
> >> +               vq->last_avail_idx, vq->used_idx,
> >> +               resume ? ", resuming" : "");
> >> +
> >> +        if (resume) {
> >> +            vq->shadow_avail_idx =3D vq->last_avail_idx =3D vq->use=
d_idx;
> >> +        }
> >> +    }
> >> +
> >>      return false;
> >>  }
> >>
> >> --
> >> 2.14.1.146.gd35faa819
> >
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau

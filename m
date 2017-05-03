Received: from eggs.gnu.org ([2001:4830:134:3::10]:33505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5tXL-0002pG-H7
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5tXK-0005ca-0S
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:37:43 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5tXJ-0005cK-LH
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:37:41 -0400
Received: by mail-wm0-x243.google.com with SMTP id u65so12427632wmu.3
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 05:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <1493363372-16861-1-git-send-email-zhiyong.yang@intel.com>
	<4b14ac87-f96b-0dac-73b7-b3209b01120a@redhat.com>
	<E182254E98A5DA4EB1E657AC7CB9BD2A3EBAB599@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <E182254E98A5DA4EB1E657AC7CB9BD2A3EBAB599@BGSMSX101.gar.corp.intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 03 May 2017 12:37:28 +0000
Message-ID: <CAJ+F1C+JLDqs97=9m9kDksh5u=Vdi9Kjun-PPLROWePkKjKjdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/virtio: fix vhost user fails to startup
 when MQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Yang, Zhiyong" <zhiyong.yang@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yuanhan" <yuanhan.liu@intel.com>, "mst@redhat.com" <mst@redhat.com>

Hi

On Wed, May 3, 2017 at 7:09 AM Yang, Zhiyong <zhiyong.yang@intel.com> wrote=
:

> Hi=EF=BC=8CMaxime:
>
> > -----Original Message-----
> > From: Maxime Coquelin [mailto:maxime.coquelin@redhat.com]
> > Sent: Tuesday, May 2, 2017 8:23 PM
> > To: Yang, Zhiyong <zhiyong.yang@intel.com>; qemu-devel@nongnu.org
> > Cc: mst@redhat.com
> > Subject: Re: [Qemu-devel] [PATCH] hw/virtio: fix vhost user fails to
> startup when
> > MQ
> >
> >
> >
> > On 04/28/2017 09:09 AM, Zhiyong Yang wrote:
> > >     Qemu2.7~2.9 and vhost user for dpdk 17.02 release work together t=
o
> > > cause failures of new connection when negotiating to set MQ.
> > > (one queue pair works well).
> > >     Because there exist some bugs in qemu code when introducing
> > > VHOST_USER_PROTOCOL_F_REPLY_ACK to qemu. When
> > vhost_user_set_mem_table
> > > is invoked to deal with the vhost message VHOST_USER_SET_MEM_TABLE fo=
r
> > > the second time, qemu indeed doesn't send the messge (The message
> > > needs to be sent only once)but still will be waiting for dpdk's reply
> > > ack, then, qemu is always freezing, while DPDK is always waiting for
> > > next vhost message from qemu.
> > >    The patch aims to fix the bug, MQ can work well.
> > >    The same bug is found in function vhost_user_net_set_mtu, it is
> > > fixed at the same time.
> > >    DPDK related patch is as following:
> > >    http://www.dpdk.org/dev/patchwork/patch/23955/
> > >
> > > Signed-off-by: Zhiyong Yang <zhiyong.yang@intel.com>
> > > ---
> > >   hw/virtio/vhost-user.c | 18 +++++++++++-------
> > >   1 file changed, 11 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c index
> > > 9334a8a..c2c54ce 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -205,10 +205,11 @@ static int vhost_user_write(struct vhost_dev
> *dev,
> > VhostUserMsg *msg,
> > >       /*
> > >        * For non-vring specific requests, like
> VHOST_USER_SET_MEM_TABLE,
> > >        * we just need send it once in the first time. For later such
> > > -     * request, we just ignore it.
> > > +     * request, we just ignore it. In this case, return value is 1
> which is
> > > +     * different from 0 that stands for message written successfully=
.
> > >        */
> > >       if (vhost_user_one_time_request(msg->request) && dev->vq_index
> !=3D 0) {
> > > -        return 0;
> > > +        return 1;
> >
> > I personally prefer the fix I suggested in the DPDK mail thread, as
> returning a
> > random positive value does look like a workaround:
>
> I think that for vhost_user_write(), it's behaving in a different way for
> some specific vhost messages.
> So, it should not return the same returen value 0 which stands for succes=
s.
>

But you need to do the special handling for every caller.


> >
> > "
> > I think the problem must be fixed generally and not per request.
> > Maybe in vhost_user_write() if one-time request, just clear the
> > VHOST_USER_NEED_REPLY flag. Then, in process_message_reply(), return
> early
> > if this flag isn't set.
> > "
> It's another choise. Either this one nor that one,  not a big deal. :)
> Fixing these  existing bugs is the most important.
>
>
While the suggestion from Maxime would work transparently, similar to
one-time request are transparent to caller today. I also prefer that
solution.

thanks
--=20
Marc-Andr=C3=A9 Lureau

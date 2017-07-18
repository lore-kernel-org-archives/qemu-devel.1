Received: from eggs.gnu.org ([2001:4830:134:3::10]:37870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXXn5-0003eo-1E
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXXn0-0002TX-5J
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:04:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dXXmz-0002SZ-WA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:04:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AAEEFC04B939
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 19:04:08 +0000 (UTC)
Date: Tue, 18 Jul 2017 20:04:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170718190402.GG2106@work-vm>
References: <20170717110936.23314-1-dgilbert@redhat.com>
	<20170717110936.23314-4-dgilbert@redhat.com>
	<20170718012042.GW27284@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170718012042.GW27284@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v4 3/6] migration/rdma: fix
 qemu_rdma_block_for_wrid error paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Mon, Jul 17, 2017 at 12:09:33PM +0100, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > The two places that 'goto err_block_for_wrid' weren't setting ret
> > and so would end up returning 0 even though we've failed.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  migration/rdma.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index 6111e10c70..59810aec2e 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -1521,14 +1521,16 @@ static int qemu_rdma_block_for_wrid(RDMAContext=
 *rdma, int wrid_requested,
> >              yield_until_fd_readable(rdma->comp_channel->fd);
> >          }
> > =20
> > -        if (ibv_get_cq_event(rdma->comp_channel, &cq, &cq_ctx)) {
> > +        ret =3D ibv_get_cq_event(rdma->comp_channel, &cq, &cq_ctx);
> > +        if (ret) {
> >              perror("ibv_get_cq_event");
> >              goto err_block_for_wrid;
> >          }
> > =20
> >          num_cq_events++;
> > =20
> > -        if (ibv_req_notify_cq(cq, 0)) {
> > +        ret =3D -ibv_req_notify_cq(cq, 0);
>=20
> (I didn't really notice that it is returning a positive value for
>  error...)

Yes, the manpage said that and I followed it into the source to check;
none of the ibv interfaces are in any way consistent.

=46rom the manpage:
   ibv_get_cq_event() returns 0 on success, and -1 on error.
   ibv_ack_cq_events() returns no value.
   ibv_req_notify_cq() returns 0 on success, or the value of errno on failu=
re

   etc

(and -1 will do as a ret value if we havent got a real errno)

Dave

> Reviewed-by: Peter Xu <peterx@redhat.com>
>=20
> > +        if (ret) {
> >              goto err_block_for_wrid;
> >          }
> > =20
> > @@ -1564,6 +1566,8 @@ err_block_for_wrid:
> >      if (num_cq_events) {
> >          ibv_ack_cq_events(cq, num_cq_events);
> >      }
> > +
> > +    rdma->error_state =3D ret;
> >      return ret;
> >  }
> > =20
> > --=20
> > 2.13.0
> >=20
>=20
> --=20
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

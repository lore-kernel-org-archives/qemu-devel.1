Received: from eggs.gnu.org ([209.51.188.92]:38909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gji3b-0001fI-66
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gji3M-0003ME-D6
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:04:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gji3L-0002sn-Vx
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:04:08 -0500
Date: Wed, 16 Jan 2019 12:03:58 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190116100357.GA7260@lap1>
References: <20190114141006.1841-1-yuval.shaia@oracle.com>
	<ad603032-6658-a1db-06fc-80ffa4dbd682@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ad603032-6658-a1db-06fc-80ffa4dbd682@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: Verify that ptr is not NULL
 before freeing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

On Mon, Jan 14, 2019 at 04:11:22PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Yuval,
>=20
> On 1/14/19 3:10 PM, Yuval Shaia wrote:
> > Make sure objects are not NULL before calling to non-nulll-safe
>=20
> null

will fix

>=20
> > destructors.
> >=20
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >  hw/rdma/rdma_backend.c | 6 ++++--
> >  hw/rdma/rdma_rm.c      | 7 ++++++-
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index b49edaacaf..3ee5172c96 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> > @@ -1066,8 +1066,10 @@ static void mad_fini(RdmaBackendDev *backend_d=
ev)
> >      pr_dbg("Stopping MAD\n");
> >      disable_rdmacm_mux_async(backend_dev);
> >      qemu_chr_fe_disconnect(backend_dev->rdmacm_mux.chr_be);
> > -    qlist_destroy_obj(QOBJECT(backend_dev->recv_mads_list.list));
> > -    qemu_mutex_destroy(&backend_dev->recv_mads_list.lock);
> > +    if (backend_dev->recv_mads_list.list) {
>=20
> This is only reachable when the backend didn't success at initializing,
> right?

Yes, just to cover the case where fini() was called even when init() fail=
s.

>=20
> > +        qlist_destroy_obj(QOBJECT(backend_dev->recv_mads_list.list))=
;
> > +        qemu_mutex_destroy(&backend_dev->recv_mads_list.lock);
> > +    }
> >  }
> > =20
> >  int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
> > diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> > index f5b1295890..8bf241e91f 100644
> > --- a/hw/rdma/rdma_rm.c
> > +++ b/hw/rdma/rdma_rm.c
> > @@ -41,6 +41,9 @@ static inline void res_tbl_init(const char *name, R=
dmaRmResTbl *tbl,
> > =20
> >  static inline void res_tbl_free(RdmaRmResTbl *tbl)
> >  {
> > +    if (!tbl->bitmap) {
> > +        return;
> > +    }
> >      qemu_mutex_destroy(&tbl->lock);
> >      g_free(tbl->tbl);
> >      g_free(tbl->bitmap);
> > @@ -655,5 +658,7 @@ void rdma_rm_fini(RdmaDeviceResources *dev_res, R=
dmaBackendDev *backend_dev,
> >      res_tbl_free(&dev_res->cq_tbl);
> >      res_tbl_free(&dev_res->pd_tbl);
> > =20
> > -    g_hash_table_destroy(dev_res->qp_hash);
> > +    if (dev_res->qp_hash) {
> > +        g_hash_table_destroy(dev_res->qp_hash);
> > +    }
> >  }
> >=20

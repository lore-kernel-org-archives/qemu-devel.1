Received: from eggs.gnu.org ([2001:4830:134:3::10]:48041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWAEN-0005VR-Sa
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWAEJ-00061H-Rr
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:10:27 -0500
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:52742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cWAEJ-000610-LV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:10:23 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id B897D16F08
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 00:10:20 +0100 (CET)
Date: Wed, 25 Jan 2017 00:10:16 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170125001016.27c420e5@bahia.lan>
In-Reply-To: <alpine.DEB.2.10.1701241337140.10192@sstabellini-ThinkPad-X260>
References: <148500887769.19567.3784247823786701992.stgit@bahia.lan>
	<alpine.DEB.2.10.1701231200240.10192@sstabellini-ThinkPad-X260>
	<20170124084128.2a9a14ca@bahia.lan>
	<alpine.DEB.2.10.1701241337140.10192@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix offset error in v9fs_xattr_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On Tue, 24 Jan 2017 14:24:23 -0800 (PST)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> On Tue, 24 Jan 2017, Greg Kurz wrote:
> > On Mon, 23 Jan 2017 12:20:57 -0800 (PST)
> > Stefano Stabellini <sstabellini@kernel.org> wrote:
> >   
> > > On Sat, 21 Jan 2017, Greg Kurz wrote:  
> > > > The current code tries to copy `read_count' bytes starting at offset
> > > > `offset' from a `read_count`-sized iovec. This causes v9fs_pack() to
> > > > fail with ENOBUFS.
> > > > 
> > > > Since the PDU iovec is already partially filled with `offset' bytes,
> > > > let's skip them when creating `qiov_full' and have v9fs_pack() to
> > > > copy the whole of it. Moreover, this is consistent with the other
> > > > places where v9fs_init_qiov_from_pdu() is called.
> > > > 
> > > > This fixes commit "bcb8998fac16 9pfs: call v9fs_init_qiov_from_pdu
> > > > before v9fs_pack".    
> > > 
> > > Sorry about that!
> > > 
> > >   
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >  hw/9pfs/9p.c |    4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > > index fa58877570f6..f0eef1a3ef53 100644
> > > > --- a/hw/9pfs/9p.c
> > > > +++ b/hw/9pfs/9p.c
> > > > @@ -1685,8 +1685,8 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
> > > >      }
> > > >      offset += err;
> > > >  
> > > > -    v9fs_init_qiov_from_pdu(&qiov_full, pdu, 0, read_count, false);
> > > > -    err = v9fs_pack(qiov_full.iov, qiov_full.niov, offset,
> > > > +    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, read_count, false);    
> > > 
> > > v9fs_init_qiov_from_pdu calls init_in_iov_from_pdu passing read_count as
> > > size argument. offset is not passed to init_in_iov_from_pdu, it is only
> > > used to initialized qiov_full.
> > > 
> > > In other words, don't we need to:
> > > 
> > >     v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, read_count + offset, false);
> > > 
> > > To make sure that qiov_full has "read_count + offset" bytes in it, and
> > > qiov_full is initialized skipping the first "offset" bytes?
> > >   
> > 
> > If we do that then qemu_iovec_concat() will skip offset bytes and then copy
> > read_count + offset bytes or am I missing something ?  
> 
> You are right, sorry. qemu_iovec_concat didn't do what I thought it
> would. In that case, I think we need to change v9fs_init_qiov_from_pdu
> (in addition to the changes already in this patch):
> 
> @@ -1659,12 +1659,14 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
>      if (is_write) {
>          pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov);
>      } else {
> -        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size);
> +        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size + skip);
>      }
>  
> The reason is the same as before: iov needs to have offset+read_count
> bytes in it, for qemu_iovec_concat to skip offset and iov still have
> read_count bytes left.
> 

Ah! I had missed that since virtio_init_in_iov_from_pdu doesn't use
the size argument, but I now understand :)

Thanks for the clarification.

> 
> > > > +    err = v9fs_pack(qiov_full.iov, qiov_full.niov, 0,
> > > >                      ((char *)fidp->fs.xattr.value) + off,
> > > >                      read_count);
> > > >      qemu_iovec_destroy(&qiov_full);
> > > >     
> > 
> >   

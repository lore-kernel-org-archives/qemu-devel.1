Received: from eggs.gnu.org ([209.51.188.92]:46615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gjEWu-0001vt-Qb
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gjEWt-0005II-QX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:32:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:53749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1gjEWt-0005Ea-G7
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:32:39 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 15 Jan 2019 02:32:31 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B79D50F@SHSMSX103.ccr.corp.intel.com>
References: <1547451317-21375-1-git-send-email-changpeng.liu@intel.com>
	<20190114104147.GC7038@stefanha-x1.localdomain>
In-Reply-To: <20190114104147.GC7038@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vhost-user-blk: enable discard/write
 zeroes features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "sgazare@redhat.com" <sgazare@redhat.com>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Monday, January 14, 2019 6:42 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: qemu-devel@nongnu.org; stefanha@redhat.com; mst@redhat.com;
> sgazare@redhat.com
> Subject: Re: [Qemu-devel] [PATCH] vhost-user-blk: enable discard/write ze=
roes
> features
>=20
> On Mon, Jan 14, 2019 at 03:35:17PM +0800, Changpeng Liu wrote:
> > Linux commit 1f23816b8 "virtio_blk: add discard and write zeroes suppor=
t"
> > added the support in the Guest kernel, while here enable the feature bi=
ts
> > support with vhost-user-blk driver.  Also enable the test example utili=
ty
> > with DISCARD command support.
>=20
> The commit message mentions write zeroes but this patch only covers
> discard.  Will you send a separate patch for write zeros?
Not really, I don't have such plan at first, I can add it in next version.
>=20
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
>=20
> CCed Stefano, who is working on hw/block/virtio-blk.c emulation support.
>=20
> > @@ -157,6 +161,29 @@ vub_writev(VubReq *req, struct iovec *iov, uint32_=
t
> iovcnt)
> >      return rc;
> >  }
> >
> > +static int
> > +vub_discard(VubReq *req, struct iovec *iov, uint32_t iovcnt)
> > +{
> > +    if (iovcnt !=3D 1) {
>=20
> This is a virtio specification violation.  The iovec layout is
> intentionally not part of the specification, leaving the guest driver
> free to choose its preferred layout.
>=20
> The device backend must accept any layout, including splitting a struct
> across iovecs or even many small iovecs of just 1 byte!
I see, the original intention here is just using 1 descriptor, which is 16 =
bytes.
>=20
> > +        fprintf(stderr, "Invalid Discard IOV count\n");
> > +        return -1;
> > +    }
> > +
> > +    #if defined(__linux__) && defined(BLKDISCARD)
> > +    VubDev *vdev_blk =3D req->vdev_blk;
> > +    struct virtio_blk_discard_write_zeroes *desc =3D
> > +                       (struct virtio_blk_discard_write_zeroes *)iov->=
iov_base;
>=20
> Missing input size check.  Even if this example isn't used in
> production, it's important to validate inputs since other people will
> implement their vhost-user backend based on this example.
>=20
> Please check that sizeof(*desc) bytes are really available before
> accessing it.
Ok, will fix it.
>=20
> > +    case VIRTIO_BLK_T_DISCARD: {
> > +        int rc;
> > +        rc =3D vub_discard(req, &elem->out_sg[1], out_num);
> > +        if (rc =3D=3D 0) {
> >              req->in->status =3D VIRTIO_BLK_S_OK;
> > -            req->size =3D elem->in_sg[0].iov_len;
> > -            vub_req_complete(req);
> > -            break;
> > -        }
> > -        default: {
> > +        } else {
> >              req->in->status =3D VIRTIO_BLK_S_UNSUPP;
>=20
> Is there no IOERR case?  BLKDISCARD can probably fail due to an I/O
> error and that shouldn't be reported as UNSUPP.
Yes, should include both UNSUPP and ERR status here, will fix it.
>=20
> > @@ -454,7 +492,7 @@ vub_get_blocksize(int fd)
> >
> >  #if defined(__linux__) && defined(BLKSSZGET)
> >      if (ioctl(fd, BLKSSZGET, &blocksize) =3D=3D 0) {
> > -        return blocklen;
> > +        return blocksize;
> >      }
> >  #endif
>=20
> Unrelated bug fix?  Please submit a separate patch.
Ok.
>=20
> Do you know why the patchew, Travis, etc continuous integration systems
> didn't detect the compile error?  Please ensure that
> contrib/vhost-user-blk/ is covered by CI.
I don't include the header file before, so it will return hardcoded 512 byt=
es, which works for most devices.

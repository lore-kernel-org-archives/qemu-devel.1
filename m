Received: from eggs.gnu.org ([2001:4830:134:3::10]:46485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5vhu-0006zn-2H
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5vhp-0006eB-6u
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:56:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d5vho-0006cq-Uz
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:56:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C256581229
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 14:56:39 +0000 (UTC)
Date: Wed, 3 May 2017 15:56:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170503145631.GE2657@work-vm>
References: <20170503121143.14925-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170503121143.14925-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] libvhost-user: fix
 vu_queue_get_avail_bytes() crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Calling vu_queue_get_avail_bytes() when the queue doesn't yet have
> addresses will result in the following crash:
>=20
> Program received signal SIGSEGV, Segmentation fault.
> 0x000055c414112ce4 in vring_avail_idx (vq=3D0x55c41582fd68, vq=3D0x55c4=
1582fd68)
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:94=
0
> 940            vq->shadow_avail_idx =3D vq->vring.avail->idx;
> (gdb) p vq
> $1 =3D (VuVirtq *) 0x55c41582fd68
> (gdb) p vq->vring
> $2 =3D {num =3D 0, desc =3D 0x0, avail =3D 0x0, used =3D 0x0, log_guest=
_addr =3D 0, flags =3D 0}
>=20
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:94=
0
> No locals.
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:96=
0
>         num_heads =3D <optimized out>
>     out_bytes=3Dout_bytes@entry=3D0x7fffd035d7c4, max_in_bytes=3Dmax_in=
_bytes@entry=3D0,
>     max_out_bytes=3Dmax_out_bytes@entry=3D0) at /home/dgilbert/git/qemu=
/contrib/libvhost-user/libvhost-user.c:1034
>=20
> Check if vring.avail !=3D null before accessing it.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>


This doesn't seem to fully solve it, it's now failing at:

#0  vring_used_idx_set (val=3D0, vq=3D0x5570fcb49d68, dev=3D0x5570fcb49c2=
0)
    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:1472
No locals.
#1  vu_queue_flush (dev=3D0x5570fcb49c20, vq=3D0x5570fcb49d68, count=3D0)
    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:1494
        old =3D 0
        new =3D 0
#2  0x00005570fb8d9639 in vubr_backend_recv_cb (sock=3D<optimized out>, c=
tx=3D0x5570fcb49c20)
    at /home/dgilbert/git/qemu/tests/vhost-user-bridge.c:349
        vubr =3D 0x5570fcb49c20
        dev =3D 0x5570fcb49c20
        vq =3D 0x5570fcb49d68
        elem =3D <optimized out>
        mhdr_sg =3D {{iov_base =3D 0x0, iov_len =3D 0} <repeats 740 times=
>, {iov_base =3D 0x0, iov_len =3D 139877843420656}, {

            iov_len =3D 0}...}
        mhdr =3D {hdr =3D {flags =3D 0 '\000', gso_type =3D 0 '\000', hdr=
_len =3D 0, gso_size =3D 0, csum_start =3D 0,=20
            csum_offset =3D 0}, num_buffers =3D 0}
        mhdr_cnt =3D <optimized out>
        hdrlen =3D 0
        i =3D <optimized out>
        hdr =3D {flags =3D 0 '\000', gso_type =3D 0 '\000', hdr_len =3D 0=
, gso_size =3D 0, csum_start =3D 0, csum_offset =3D 0}
        __PRETTY_FUNCTION__ =3D "vubr_backend_recv_cb"
#3  0x00005570fb8d8ad3 in dispatcher_wait (timeout=3D200000, dispr=3D0x55=
70fcb4a0b8)
    at /home/dgilbert/git/qemu/tests/vhost-user-bridge.c:154
        e =3D 0x5570fcb4a180
        tv =3D {tv_sec =3D 0, tv_usec =3D 199998}
        fdset =3D {fds_bits =3D {48, 0 <repeats 15 times>}}
        rc =3D <optimized out>
        sock =3D 4
#4  vubr_run (dev=3D<optimized out>) at /home/dgilbert/git/qemu/tests/vho=
st-user-bridge.c:624
No locals.
#5  main (argc=3D<optimized out>, argv=3D<optimized out>) at /home/dgilbe=
rt/git/qemu/tests/vhost-user-bridge.c:697
        opt =3D <optimized out>
        client =3D <optimized out>

Dave

> ---
>  contrib/libvhost-user/libvhost-user.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-u=
ser/libvhost-user.c
> index af4faad60b..f9680b6279 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -1031,6 +1031,10 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq=
, unsigned int *in_bytes,
>      idx =3D vq->last_avail_idx;
> =20
>      total_bufs =3D in_total =3D out_total =3D 0;
> +    if (!vq->vring.avail) {
> +        goto done;
> +    }
> +
>      while ((rc =3D virtqueue_num_heads(dev, vq, idx)) > 0) {
>          unsigned int max, num_bufs, indirect =3D 0;
>          struct vring_desc *desc;
> --=20
> 2.12.0.191.gc5d8de91d
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

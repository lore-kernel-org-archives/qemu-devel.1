Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42996C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CD024672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="nnojoTGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CD024672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzKT-0006sE-1z
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ihzHw-0002tN-F4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ihzHu-0001Pp-OD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:08:36 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:44519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ihzHt-0001Kw-Pz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Kolc2fi/RY1CiU1IkM8PAXhFnBRYNV5b/Je1nUlIolo=; b=nnojoTGbX64RNs2CBDCp3tCsEh
 agVxor6fYjwETog/FYkz8B+BudP1DrTNvyiEUta8sq9fH1sk2f54LifhFXabC/4rDQ8bDRPATlKn0
 A045C0+KgN+mt2RZLvMahFAFbBkUl9Hlg/2PnJWjDKCS19yu95B4mD0ZsPQqZ6b0H1e6NBm7tDyMj
 ZwcB25ZXAqyb6beZ/L+sjV1AQUTS6yUEBkYRJBI83d9cWzBAw32UR/14nzCwANgTIdD2Kj0KFJvti
 dsWKu18FcCWIRvcOfNfwrERRWpKCgj7Hj5e9p+Gv5yriBpLuLJpes4xvcHpglbAx1/chE6w9in8/6
 D5uo57/dm//AhcE0h1i4EjquD+x6hClQytZ81LXaliGfFTp9PrsybKzhid0WEMikFJ2iNNuLIaewu
 nMIwyIn7FGmA9JeatXWGy0nNZPvSlQ5mLjEgE0tXqN9zioVGofozN26LbumtE7ILPzQl/aL3KP13j
 YJI1L8wr4uJRDRD1xdzUlLtc6tvA5OI+hDHgPjMLMHfj+AUZV3cuKySG4qlQ60AtIm9XR/VR8yQ8M
 CzsvRBJwQe+35nDD3EUwSFeKPK4KUcvYkIIt04Ve+gmppu/cmB6XQgzGplPUo7GtazKSOE9DEQs3U
 ZTt0F3mS0pi6OZOHk3pJxmama6iyiu/7QRnK85Cps=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, anthony.perard@citrix.com,
 Stefano Stabellini <stefano.stabellini@xilinx.com>, groug@kaod.org
Subject: Re: [PATCH] 9p: init_in_iov_from_pdu can truncate the size
Date: Thu, 19 Dec 2019 18:08:26 +0100
Message-ID: <2734053.qHGH40kZ6z@silver>
In-Reply-To: <20191219004251.23763-1-sstabellini@kernel.org>
References: <20191219004251.23763-1-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 19. Dezember 2019 01:42:51 CET Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> init_in_iov_from_pdu might not be able to allocate the full buffer size
> requested, which comes from the client and could be larger than the
> transport has available at the time of the request. Specifically, this
> can happen with read operations, with the client requesting a read up to
> the max allowed, which might be more than the transport has available at
> the time.

I haven't looked thoroughly at this yet, but that's about addressing a 
temporary, not a permanent transport buffer size limitation, right? Because if 
it was a permanent one, then probably an adjusted (lowered) msize should be 
returned on R_version response to client as well.

I wonder why I never triggered this issue, because I was experimenting with 
huge msize values for 9pfs performance checks. Was there anything specific to 
trigger this issue?

> Today the implementation of init_in_iov_from_pdu throws an error, both
> Xen and Virtio.
> 
> Instead, change the V9fsTransport interface so that the size becomes a
> pointer and can be limited by the implementation of
> init_in_iov_from_pdu.
> 
> Change both the Xen and Virtio implementations to set the size to the
> size of the buffer they managed to allocate, instead of throwing an
> error.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> CC: groug@kaod.org
> CC: anthony.perard@citrix.com
> ---
>  hw/9pfs/9p.c               | 22 +++++++++++++++-------
>  hw/9pfs/9p.h               |  2 +-
>  hw/9pfs/virtio-9p-device.c | 10 +++-------
>  hw/9pfs/xen-9p-backend.c   | 12 ++++--------
>  4 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index bdf7919abf..d6c89ce608 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1682,22 +1682,30 @@ out_nofid:
>   * with qemu_iovec_destroy().
>   */
>  static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
> -                                    size_t skip, size_t size,
> +                                    size_t skip, size_t *size,
>                                      bool is_write)
>  {
>      QEMUIOVector elem;
>      struct iovec *iov;
>      unsigned int niov;
> +    size_t alloc_size = *size + skip;
> 
>      if (is_write) {
> -        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, size +
> skip); +        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov,
> alloc_size); } else {
> -        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size +
> skip); +        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov,
> &alloc_size); +    }
> +
> +    if (alloc_size < skip)
> +    {
> +        *size = 0;
> +    } else {
> +        *size = alloc_size - skip;
>      }
>

Code style nitpicking:  

ERROR: that open brace { should be on the previous line
#56: FILE: hw/9pfs/9p.c:1699:
+    if (alloc_size < skip)
+    {

> 
>  static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
> @@ -1722,7 +1730,7 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu,
> V9fsFidState *fidp, }
>      offset += err;
> 
> -    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, read_count, false);
> +    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &read_count, false);
>      err = v9fs_pack(qiov_full.iov, qiov_full.niov, 0,
>                      ((char *)fidp->fs.xattr.value) + off,
>                      read_count);
> @@ -1852,7 +1860,7 @@ static void coroutine_fn v9fs_read(void *opaque)
>          QEMUIOVector qiov;
>          int32_t len;
> 
> -        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, max_count,
> false); +        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4,
> &max_count, false); qemu_iovec_init(&qiov, qiov_full.niov);
>          do {
>              qemu_iovec_reset(&qiov);
> @@ -2085,7 +2093,7 @@ static void coroutine_fn v9fs_write(void *opaque)
>          return;
>      }
>      offset += err;
> -    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, count, true);
> +    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &count, true);
>      trace_v9fs_write(pdu->tag, pdu->id, fid, off, count, qiov_full.niov);
> 
>      fidp = get_fid(pdu, fid);
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 8883761b2c..50f7e21da6 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -365,7 +365,7 @@ struct V9fsTransport {
>      ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const char
> *fmt, va_list ap);
>      void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
> -                                        unsigned int *pniov, size_t size);
> +                                        unsigned int *pniov, size_t *size);
> void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
> unsigned int *pniov, size_t size); void        (*push_and_notify)(V9fsPDU
> *pdu);
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 775e8ff766..68873c3f5f 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -145,19 +145,15 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu,
> size_t offset, }
> 
>  static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
> -                                        unsigned int *pniov, size_t size)
> +                                        unsigned int *pniov, size_t *size)
>  {
>      V9fsState *s = pdu->s;
>      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem = v->elems[pdu->idx];
>      size_t buf_size = iov_size(elem->in_sg, elem->in_num);
> 
> -    if (buf_size < size) {
> -        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> -
> -        virtio_error(vdev,
> -                     "VirtFS reply type %d needs %zu bytes, buffer has
> %zu", -                     pdu->id + 1, size, buf_size);
> +    if (buf_size < *size) {
> +        *size = buf_size;
>      }
> 
>      *piov = elem->in_sg;
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 3f54a21c76..3994a356d4 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -187,7 +187,7 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
> static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
>                                            struct iovec **piov,
>                                            unsigned int *pniov,
> -                                          size_t size)
> +                                          size_t *size)
>  {
>      Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
>      Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
> @@ -197,15 +197,11 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU
> *pdu, g_free(ring->sg);
> 
>      ring->sg = g_malloc0(sizeof(*ring->sg) * 2);
> -    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
> +    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
> 
>      buf_size = iov_size(ring->sg, num);
> -    if (buf_size  < size) {
> -        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
> -                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
> -                buf_size);
> -        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> +    if (buf_size  < *size) {
> +        *size = buf_size;
>      }
> 
>      *piov = ring->sg;

Best regards,
Christian Schoenebeck




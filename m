Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC6DC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 22:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865BD206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 22:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIwN3W/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865BD206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYGdV-0003TP-Lb
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 18:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jYGcQ-0002M7-Fu
 for qemu-devel@nongnu.org; Mon, 11 May 2020 18:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jYGcP-00049r-66
 for qemu-devel@nongnu.org; Mon, 11 May 2020 18:09:50 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E100206F5;
 Mon, 11 May 2020 22:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589234986;
 bh=ThCeQZnvEygoCOy5OCMucgQEHXrkLNnPYS6u2guRa4A=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=JIwN3W/eqx8YQF32skQG/jqJu7l3JQXw7GPPy7GoqpZVNBBCrIRRDRZOaHqIjBZ2N
 IijNT7UoG68q4T4Qv2dcMcBqNXwGj6/3lUhqFhEqS+rcIZPM+prFIqifqrc+013WnU
 92hgfBenOh5wjHM9hUyXqf58iyQpGSUx/9jnyoLU=
Date: Mon, 11 May 2020 15:09:46 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 2/2] 9pfs: fix init_in_iov_from_pdu truncating size
In-Reply-To: <54f3b9c9f05a77ccdd6103bd46c828fcb675cbac.1589132512.git.qemu_oss@crudebyte.com>
Message-ID: <alpine.DEB.2.21.2005111454160.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
 <54f3b9c9f05a77ccdd6103bd46c828fcb675cbac.1589132512.git.qemu_oss@crudebyte.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 18:09:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 10 May 2020, Christian Schoenebeck wrote:
> Commit SHA-1 16724a173049ac29c7b5ade741da93a0f46edff7 introduced
> truncating the response to the currently available transport buffer
> size, which was supposed to fix an 9pfs error on Xen boot where
> transport buffer might still be smaller than required for response.
> 
> Unfortunately this change broke small reads (with less than 12
> bytes).
> 
> To address both concerns, check the actual response type and only
> truncate reply for Rreaddir responses, 

I realize you mean "Rread" (not Rreaddir). Are we sure that truncation
can only happen with Rread? I checked the spec it looks like Directories
are pretty much like files from the spec point of view. So it seems to
me that truncation might be possible there too.


> and only if truncated reply would at least return one payload byte to
> client. Use Rreaddir's precise header size (11) for this instead of
> P9_IOHDRSZ.

Ah! That's the underlying error isn't it? That P9_IOHDRSZ is not really
the size of the reply header, it is bigger. Hence the check:

  if (buf_size < P9_IOHDRSZ) {

can be wrong for very small sizes.



> Fixes: 16724a173049ac29c7b5ade741da93a0f46edff7
> Fixes: https://bugs.launchpad.net/bugs/1877688
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/virtio-9p-device.c | 35 +++++++++++++++++++++++++++--------
>  hw/9pfs/xen-9p-backend.c   | 38 +++++++++++++++++++++++++++++---------
>  2 files changed, 56 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 536447a355..57e4d92ecb 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -154,15 +154,34 @@ static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
>      VirtQueueElement *elem = v->elems[pdu->idx];
>      size_t buf_size = iov_size(elem->in_sg, elem->in_num);
>  
> -    if (buf_size < P9_IOHDRSZ) {
> -        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> +    if (pdu->id + 1 == P9_RREAD) {
> +        /* size[4] Rread tag[2] count[4] data[count] */

4+2+4 = 10


> +        const size_t hdr_size = 11;

Are you adding 1 to account for "count"?


> +        /*
> +         * If current transport buffer size is smaller than actually required
> +         * for this Rreaddir response, then truncate the response to the
> +         * currently available transport buffer size, however only if it would
> +         * at least allow to return 1 payload byte to client.
> +         */
> +        if (buf_size < hdr_size + 1) {

If you have already added 1 before, why do we need to add 1 again here?


> +            VirtIODevice *vdev = VIRTIO_DEVICE(v);
>  
> -        virtio_error(vdev,
> -                     "VirtFS reply type %d needs %zu bytes, buffer has %zu, less than minimum",
> -                     pdu->id + 1, *size, buf_size);
> -    }
> -    if (buf_size < *size) {
> -        *size = buf_size;
> +            virtio_error(vdev,
> +                         "VirtFS reply type %d needs %zu bytes, buffer has "
> +                         "%zu, less than minimum (%zu)",
> +                         pdu->id + 1, *size, buf_size, hdr_size + 1);
> +        }

I think we want to return here


> +        if (buf_size < *size) {
> +            *size = buf_size;
> +        }
> +    } else {
> +        if (buf_size < *size) {
> +            VirtIODevice *vdev = VIRTIO_DEVICE(v);
> +
> +            virtio_error(vdev,
> +                         "VirtFS reply type %d needs %zu bytes, buffer has %zu",
> +                         pdu->id + 1, *size, buf_size);
> +        }
>      }
>  
>      *piov = elem->in_sg;
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index f04caabfe5..98f340d24b 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -201,15 +201,35 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
>      xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
>  
>      buf_size = iov_size(ring->sg, num);
> -    if (buf_size  < P9_IOHDRSZ) {
> -        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d needs "
> -                      "%zu bytes, buffer has %zu, less than minimum\n",
> -                      pdu->id + 1, *size, buf_size);
> -        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> -    }
> -    if (buf_size  < *size) {
> -        *size = buf_size;
> +    if (pdu->id + 1 == P9_RREAD) {
> +        /* size[4] Rread tag[2] count[4] data[count] */
> +        const size_t hdr_size = 11;
> +        /*
> +         * If current transport buffer size is smaller than actually required
> +         * for this Rreaddir response, then truncate the response to the
> +         * currently available transport buffer size, however only if it would
> +         * at least allow to return 1 payload byte to client.
> +         */
> +        if (buf_size < hdr_size + 1) {
> +            xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d "
> +                          "needs %zu bytes, buffer has %zu, less than "
> +                          "minimum (%zu)\n",
> +                          pdu->id + 1, *size, buf_size, hdr_size + 1);
> +            xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> +            xen_9pfs_disconnect(&xen_9pfs->xendev);

I htink we want to return here.


> +        }
> +        if (buf_size < *size) {
> +            *size = buf_size;
> +        }
> +    } else {
> +        if (buf_size < *size) {
> +            xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d "
> +                         "needs %zu bytes, buffer has %zu\n", pdu->id + 1,
> +                          *size, buf_size);
> +
> +            xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> +            xen_9pfs_disconnect(&xen_9pfs->xendev);
> +        }
>      }
>  
>      *piov = ring->sg;
> -- 
> 2.20.1
> 


Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAD1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485E0207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ZVEy17Ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485E0207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbMpj-0000f5-IP
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 07:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jbMox-0008I7-Bu
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:23:35 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:45723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jbMov-0002p6-JR
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=w3mR/Y2+zfSUunYyij3g2FvEzxKVRoLFDyQEDarPU6Q=; b=ZVEy17KyQHlgXkml2GUONsRH8z
 PpyGeAzyhouoZqatu2SU4omhdjq14I0tjNJ7TKRNfxmoJezhrF0uPpyAYF+itA9SkBQds9p56sBpF
 b2T5CqZwgWLxr7JFyl3tVnl9h8DEx7h/MMnsymQT3DidGg8MzR1HAoKN3sw4m4VlZXCQOwuzm/aL0
 ClE87e8LBpoiTv3+H3zmf5RkNDTd/1Ntdv4MmjasA0Z6NmKdk7UZUB7lycIlOCmZUqYVXexdW7h4T
 PdNrmLXMJTqCCyLgdVrYwcfHtZ2u1dZY+OoMNQLqbree6ro9K0dhjbNTYRwiHdpgWY3Rs6Juo5sCG
 nQvzv35kbkSq6Ec8uZAgXBwT1wnknA+fVM4b0v7JC3bPOzmEz31z23A341yCZDwfNokv7RSOwDYGm
 2pnqiRlxbb9hte7fXEVFn5N2dSWvqYfYTnJBX8xeYy4T6KEWbrosTHq3oLI1UHaEnHrDa+Wd5cDv2
 U2TdDsJHLQvS57YEag4Cb8x5D1EOFpyPXGK6rl5p+hQpuB8iQ3sKKdvjBBMQ7j4BIpy/DC/3hNimT
 O5wRkUFQ43EeykHZxixA+hoQOKUNDUHCIN2cvsajP+z5AKPxG1ogFsfGzDxqlpjIS3YwD36csO91H
 XfkisRONBeMevxxI6SXEAqfWe5BWbHviTcKlXa/bU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, groug@kaod.org,
 anthony.perard@citrix.com, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 paul@xen.org
Subject: Re: [PATCH 2/2] xen/9pfs: yield when there isn't enough room on the
 ring
Date: Wed, 20 May 2020 13:23:18 +0200
Message-ID: <14197604.KFEeGaIGOr@silver>
In-Reply-To: <20200520014712.24213-2-sstabellini@kernel.org>
References: <alpine.DEB.2.21.2005191651130.27502@sstabellini-ThinkPad-T480s>
 <20200520014712.24213-2-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 07:23:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 20. Mai 2020 03:47:12 CEST Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> Instead of truncating replies, which is problematic, wait until the
> client reads more data and frees bytes on the reply ring.
> 
> Do that by calling qemu_coroutine_yield(). The corresponding
> qemu_coroutine_enter_if_inactive() is called from xen_9pfs_bh upon
> receiving the next notification from the client.
> 
> We need to be careful to avoid races in case xen_9pfs_bh and the
> coroutine are both active at the same time. In xen_9pfs_bh, wait until
> either the critical section is over (ring->co == NULL) or until the
> coroutine becomes inactive (qemu_coroutine_yield() was called) before
> continuing. Then, simply wake up the coroutine if it is inactive.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> ---

In general this patch makes sense to me, and much better and cleaner solution 
than what we discussed before. Just one detail ...

>  hw/9pfs/xen-9p-backend.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index fc197f6c8a..3939539028 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -37,6 +37,7 @@ typedef struct Xen9pfsRing {
> 
>      struct iovec *sg;
>      QEMUBH *bh;
> +    Coroutine *co;
> 
>      /* local copies, so that we can read/write PDU data directly from
>       * the ring */
> @@ -198,16 +199,18 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU
> *pdu, g_free(ring->sg);
> 
>      ring->sg = g_new0(struct iovec, 2);
> -    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
> +    ring->co = qemu_coroutine_self();
> +    smp_wmb();
> 
> +again:
> +    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
>      buf_size = iov_size(ring->sg, num);
>      if (buf_size  < size) {
> -        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
> -                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
> -                buf_size);
> -        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> +        qemu_coroutine_yield();
> +        goto again;
>      }
> +    ring->co = NULL;
> +    smp_wmb();
> 
>      *piov = ring->sg;
>      *pniov = num;
> @@ -292,6 +295,19 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
>  static void xen_9pfs_bh(void *opaque)
>  {
>      Xen9pfsRing *ring = opaque;
> +    bool wait;
> +
> +again:
> +    wait = ring->co != NULL && qemu_coroutine_entered(ring->co);
> +    smp_rmb();
> +    if (wait) {
> +        cpu_relax();
> +        goto again;
> +    }
> +
> +    if (ring->co != NULL) {
> +        qemu_coroutine_enter_if_inactive(ring->co);

... correct me if I am wrong, but AFAIK qemu_coroutine_enter_if_inactive() 
will simply run the coroutine directly on caller's thread, it will not 
dispatch the coroutine onto the thread which yielded the coroutine before.

> +    }
>      xen_9pfs_receive(ring);
>  }

AFAICS you have not addressed the problem msize >> xen ringbuffer size, in 
which case I would expect the Xen driver to loop forever. Am I missing 
something or have you postponed addressing this?

Best regards,
Christian Schoenebeck




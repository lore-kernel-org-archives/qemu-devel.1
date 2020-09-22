Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58ECC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DBA2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="eOttp2pO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DBA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKehr-0000Mx-0T
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kKeg9-0007Ps-As; Tue, 22 Sep 2020 05:33:43 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kKeg4-00076M-69; Tue, 22 Sep 2020 05:33:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600767197; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=RB0G5oTDbhNWNUPTeSO3Vb7udHrsdmDtsTvOsInUUq4j/+xEwHAableXKS1IsH2RKdaKKD6PeZazCeCp2jnYrJu3LxRxw2EuUlpeH+M3+V9rO9EJHSuV0+YnJfx0mYWYHOPuB+uVJRShnYzAJEtddzmcY7A/S7WRiXt68ssQbMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1600767197;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=0pjPDA+mCxU9SBqvaKOL9JMw3NJGhITXCI6GpxmGSig=; 
 b=C93IJcMmMjcKq++8T28POH7rM3APVgbdXCyJH4vydogtbOku2eGyXkT2Y8eOTXvYl8AbRGP5F7jvpsbNasSM/jcoFOGr1ryIwvaYLvrQJYlFF5SpJFFJAGaOqI8mBAZrD5JaO0+fFN9ihSngKwep9wgKjwVCO7tdSItPVbpXYuU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1600767197; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Mime-Version:Content-Transfer-Encoding;
 bh=0pjPDA+mCxU9SBqvaKOL9JMw3NJGhITXCI6GpxmGSig=;
 b=eOttp2pOlgtU/eixsGVqYRXanjIlwsHUgIgMyjKpC9Dk2/cUlIUJ37H6xFYQ3n7+
 uhzdj8Dzt9msvGnU+I2m/l4Kh2NVRhCmODA7NphanMJpmSd23AiXfyAecOtd232K4TN
 +EkqxGIDlzwrq9rRm25ZUrFq2/+xwair+zJqagvE=
Received: from vpn-10-85-95-225.fra53.corp.amazon.com (54.239.6.177
 [54.239.6.177]) by mx.zoho.com.cn
 with SMTPS id 1600767196240862.1538975018872;
 Tue, 22 Sep 2020 17:33:16 +0800 (CST)
Message-ID: <ced372a0cb707de8f7db49524d3a0fd7f7f8f142.camel@euphon.net>
Subject: Re: [PATCH 2/6] block/nvme: Map doorbells pages write-only
From: Fam Zheng <fam@euphon.net>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Date: Tue, 22 Sep 2020 10:33:10 +0100
In-Reply-To: <22dab788-06f1-3686-51f3-24ee7ce77fda@redhat.com>
References: <20200921162949.553863-1-philmd@redhat.com>
 <20200921162949.553863-3-philmd@redhat.com>
 <6ea4b96862a0dac22205592b6c8d9e21ab57189a.camel@euphon.net>
 <22dab788-06f1-3686-51f3-24ee7ce77fda@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:19:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-09-22 at 10:41 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Fam,
>=20
> +Paolo?
>=20
> On 9/22/20 10:18 AM, Fam Zheng wrote:
> > On Mon, 2020-09-21 at 18:29 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> > > Per the datasheet sections 3.1.13/3.1.14:
> > >   "The host should not read the doorbell registers."
> > >=20
> > > As we don't need read access, map the doorbells with write-only
> > > permission. We keep a reference to this mapped address in the
> > > BDRVNVMeState structure.
> >=20
> > Besides looking more correct in access mode, is there any side
> > effect
> > of WO mapping?
>=20
> TBH I don't have enough knowledge to answer this question.
> I tested successfully on X86. I'm writing more tests.

The reason I'm asking is more because x86 pages are either RO or RW. So
I'd like to see if there's a practical reason behind this patch (I have
no idea about the effects on MTRR and/or IOMMU).

Fam

>=20
> >=20
> > Fam
> >=20
> > >=20
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > ---
> > >  block/nvme.c | 29 +++++++++++++++++++----------
> > >  1 file changed, 19 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/block/nvme.c b/block/nvme.c
> > > index 5a4dc6a722a..3c834da8fec 100644
> > > --- a/block/nvme.c
> > > +++ b/block/nvme.c
> > > @@ -31,7 +31,7 @@
> > >  #define NVME_SQ_ENTRY_BYTES 64
> > >  #define NVME_CQ_ENTRY_BYTES 16
> > >  #define NVME_QUEUE_SIZE 128
> > > -#define NVME_BAR_SIZE 8192
> > > +#define NVME_DOORBELL_SIZE 4096
> > > =20
> > >  /*
> > >   * We have to leave one slot empty as that is the full queue
> > > case
> > > where
> > > @@ -84,10 +84,6 @@ typedef struct {
> > >  /* Memory mapped registers */
> > >  typedef volatile struct {
> > >      NvmeBar ctrl;
> > > -    struct {
> > > -        uint32_t sq_tail;
> > > -        uint32_t cq_head;
> > > -    } doorbells[];
> > >  } NVMeRegs;
> > > =20
> > >  #define INDEX_ADMIN     0
> > > @@ -103,6 +99,11 @@ struct BDRVNVMeState {
> > >      AioContext *aio_context;
> > >      QEMUVFIOState *vfio;
> > >      NVMeRegs *regs;
> > > +    /* Memory mapped registers */
> > > +    volatile struct {
> > > +        uint32_t sq_tail;
> > > +        uint32_t cq_head;
> > > +    } *doorbells;
> > >      /* The submission/completion queue pairs.
> > >       * [0]: admin queue.
> > >       * [1..]: io queues.
> > > @@ -247,14 +248,14 @@ static NVMeQueuePair
> > > *nvme_create_queue_pair(BDRVNVMeState *s,
> > >          error_propagate(errp, local_err);
> > >          goto fail;
> > >      }
> > > -    q->sq.doorbell =3D &s->regs->doorbells[idx * s-
> > > > doorbell_scale].sq_tail;
> > >=20
> > > +    q->sq.doorbell =3D &s->doorbells[idx * s-
> > > >doorbell_scale].sq_tail;
> > > =20
> > >      nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES,
> > > &local_err);
> > >      if (local_err) {
> > >          error_propagate(errp, local_err);
> > >          goto fail;
> > >      }
> > > -    q->cq.doorbell =3D &s->regs->doorbells[idx * s-
> > > > doorbell_scale].cq_head;
> > >=20
> > > +    q->cq.doorbell =3D &s->doorbells[idx * s-
> > > >doorbell_scale].cq_head;
> > > =20
> > >      return q;
> > >  fail:
> > > @@ -712,13 +713,12 @@ static int nvme_init(BlockDriverState *bs,
> > > const char *device, int namespace,
> > >          goto out;
> > >      }
> > > =20
> > > -    s->regs =3D qemu_vfio_pci_map_bar(s->vfio, 0, 0,
> > > NVME_BAR_SIZE,
> > > +    s->regs =3D qemu_vfio_pci_map_bar(s->vfio, 0, 0,
> > > sizeof(NvmeBar),
> > >                                      PROT_READ | PROT_WRITE,
> > > errp);
> > >      if (!s->regs) {
> > >          ret =3D -EINVAL;
> > >          goto out;
> > >      }
> > > -
> > >      /* Perform initialize sequence as described in NVMe spec
> > > "7.6.1
> > >       * Initialization". */
> > > =20
> > > @@ -748,6 +748,13 @@ static int nvme_init(BlockDriverState *bs,
> > > const
> > > char *device, int namespace,
> > >          }
> > >      }
> > > =20
> > > +    s->doorbells =3D qemu_vfio_pci_map_bar(s->vfio, 0,
> > > sizeof(NvmeBar),
> > > +                                         NVME_DOORBELL_SIZE,
> > > PROT_WRITE, errp);
> > > +    if (!s->doorbells) {
> > > +        ret =3D -EINVAL;
> > > +        goto out;
> > > +    }
> > > +
> > >      /* Set up admin queue. */
> > >      s->queues =3D g_new(NVMeQueuePair *, 1);
> > >      s->queues[INDEX_ADMIN] =3D nvme_create_queue_pair(s,
> > > aio_context,
> > > 0,
> > > @@ -873,7 +880,9 @@ static void nvme_close(BlockDriverState *bs)
> > >                             &s-
> > > >irq_notifier[MSIX_SHARED_IRQ_IDX],
> > >                             false, NULL, NULL);
> > >      event_notifier_cleanup(&s-
> > > >irq_notifier[MSIX_SHARED_IRQ_IDX]);
> > > -    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0,
> > > NVME_BAR_SIZE);
> > > +    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->doorbells,
> > > +                            sizeof(NvmeBar),
> > > NVME_DOORBELL_SIZE);
> > > +    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0,
> > > sizeof(NvmeBar));
> > >      qemu_vfio_close(s->vfio);
> > > =20
> > >      g_free(s->device);
>=20
>=20



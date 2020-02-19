Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6439C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9445E20801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PerqAXUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9445E20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4TFT-0006D9-R9
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4TEj-0005lL-Lf
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4TEi-0005Qd-5b
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:34:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26751
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4TEi-0005Q5-1B
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582133651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xVBQC95Vtlqllm+O2m5fTeAcVqhFSKFjA4eN6gL2wMQ=;
 b=PerqAXUolwSTqiwja2nBoFeqLA0nIe50S2HnW0vc9Y5dMzAlurge2FuFA0JJUOLDHEErqT
 AvJPi7oQ5yZRbRdTi5k0K9BKdOm2R6WrCYaJNinh/Uwpf2qP10hywHc+xe4bEN7AtEyl6G
 XWv+PxsvmWGeU1XglrT1ocFDIINv3Pc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-JQ4kZf1mNmm0c_hdL8S04Q-1; Wed, 19 Feb 2020 12:34:09 -0500
Received: by mail-qk1-f199.google.com with SMTP id t17so745143qkg.16
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 09:34:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Gb9XZIg+nMVIrINUAFL4uCF6pFd6pCh0ClCNEL8xXnQ=;
 b=NqEYsgV0/TneEV3lpBUSDxlZ/Qc0/150ioZoBgm+qHWAWwAcRTkmRqkSwFssLMTBT0
 8gi1c9EGWLbybJEhcslH5h4KQDWHCgHONqhcN6Rs4vH58dJMNbA/yekelU7Iv8OuATD4
 jEg+dl7Qdu3MWqvb7rhHnFiQB4t45YUnsUeE3qotCHZzG407V2c27A5DdTdbKU4TO43W
 QZcaLmjtTf3GNK9JeAJXhmvg/U9EGm0kd/m9trTvQquMifHdffF89/kkuoXriEvlkRHa
 ELk/doabQsV1zRGn0jNXU3YUEHmammKp8sC1QI14TlCECPPW7jVMSzh0K9TEhTFqv10G
 0chw==
X-Gm-Message-State: APjAAAVg+8pwWQyKmR+jBiKQqxljDGj4KOpWIdaP8AsLffX7Xx2bppJ9
 em79/ch5/Lb7HBv0qyFZkvk/FGIWzyjCc5R9LBNjBvygHsElBNalym+RG7VXSdBjU4zjtxsgJAs
 x7LDXp8trAvwZN0s=
X-Received: by 2002:a0c:fe8e:: with SMTP id d14mr22117427qvs.106.1582133649162; 
 Wed, 19 Feb 2020 09:34:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxP3NZywaH2iy4b78nNrDeVcduVG9h7BuAnvagjNPOlOszifBzRlLglriB0yiCtQeqYHz3B6g==
X-Received: by 2002:a0c:fe8e:: with SMTP id d14mr22117404qvs.106.1582133648879; 
 Wed, 19 Feb 2020 09:34:08 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id c45sm343589qtd.43.2020.02.19.09.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 09:34:08 -0800 (PST)
Date: Wed, 19 Feb 2020 12:34:06 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 01/16] util: vfio-helpers: Factor out and fix
 processing of existing ram blocks
Message-ID: <20200219173406.GB34517@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-2-david@redhat.com>
 <20200218220001.GE7090@xz-x1>
 <88dcdda3-e9a9-ca46-3e53-ab5b8d2d0936@redhat.com>
MIME-Version: 1.0
In-Reply-To: <88dcdda3-e9a9-ca46-3e53-ab5b8d2d0936@redhat.com>
X-MC-Unique: JQ4kZf1mNmm0c_hdL8S04Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 09:43:02AM +0100, David Hildenbrand wrote:
> On 18.02.20 23:00, Peter Xu wrote:
> > On Wed, Feb 12, 2020 at 02:42:39PM +0100, David Hildenbrand wrote:
> >> Factor it out into common code when a new notifier is registered, just
> >> as done with the memory region notifier. This allows us to have the
> >> logic about how to process existing ram blocks at a central place (whi=
ch
> >> will be extended soon).
> >>
> >> Just like when adding a new ram block, we have to register the max_len=
gth
> >> for now. We don't have a way to get notified about resizes yet, and so=
me
> >> memory would not be mapped when growing the ram block.
> >>
> >> Note: Currently, ram blocks are only "fake resized". All memory
> >> (max_length) is accessible.
> >>
> >> We can get rid of a bunch of functions in stubs/ram-block.c . Print th=
e
> >> warning from inside qemu_vfio_ram_block_added().
>=20
> [...]
>=20
> >>  #include "exec/ramlist.h"
> >>  #include "exec/cpu-common.h"
> >> =20
> >> -void *qemu_ram_get_host_addr(RAMBlock *rb)
> >> -{
> >> -    return 0;
> >> -}
> >> -
> >> -ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
> >> -{
> >> -    return 0;
> >> -}
> >> -
> >> -ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
> >> -{
> >> -    return 0;
> >> -}
> >=20
> > Maybe put into another patch?
> >=20
> > Actually I'm thinking whether it would worth to do...  They're still
> > declared in include/exec/cpu-common.h, so logically who includes the
> > header but linked against stubs can still call this function.  So
> > keeping them there still make sense to me.
>=20
> Why keep dead code around? If you look closely, the stubs really only
> contain what's strictly necessary to make current code compile, not any
> available ramblock related function.

Seems correct.  Then it's fine.

>=20
> I don't see a good reason for a separate patch either (after all, we're
> removing the last users in this patch), but if more people agree, I can
> move it to a separate patch.
> [...]
>=20
> >> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> >> index 813f7ec564..71e02e7f35 100644
> >> --- a/util/vfio-helpers.c
> >> +++ b/util/vfio-helpers.c
> >> @@ -376,8 +376,13 @@ static void qemu_vfio_ram_block_added(RAMBlockNot=
ifier *n,
> >>                                        void *host, size_t size)
> >>  {
> >>      QEMUVFIOState *s =3D container_of(n, QEMUVFIOState, ram_notifier)=
;
> >> +    int ret;
> >> +
> >>      trace_qemu_vfio_ram_block_added(s, host, size);
> >> -    qemu_vfio_dma_map(s, host, size, false, NULL);
> >> +    ret =3D qemu_vfio_dma_map(s, host, size, false, NULL);
> >> +    if (ret) {
> >> +        error_report("qemu_vfio_dma_map(%p, %zu) failed: %d", host, s=
ize, ret);
> >> +    }
> >=20
> > Irrelevant change (another patch)?
>=20
> This is the error that was printed in qemu_vfio_init_ramblock(). Not
> moving it in this patch would mean we would stop printing the error.
> [...]
>=20
> >> -
> >>  static void qemu_vfio_open_common(QEMUVFIOState *s)
> >>  {
> >>      qemu_mutex_init(&s->lock);
> >>      s->ram_notifier.ram_block_added =3D qemu_vfio_ram_block_added;
> >>      s->ram_notifier.ram_block_removed =3D qemu_vfio_ram_block_removed=
;
> >> -    ram_block_notifier_add(&s->ram_notifier);
> >>      s->low_water_mark =3D QEMU_VFIO_IOVA_MIN;
> >>      s->high_water_mark =3D QEMU_VFIO_IOVA_MAX;
> >> -    qemu_ram_foreach_block(qemu_vfio_init_ramblock, s);
> >> +    ram_block_notifier_add(&s->ram_notifier);
> >=20
> > Pure question: this looks like a good improvement, however do you know
> > why HAX and SEV do not need to init ramblock?
>=20
> They register very early (e.g., at accel init time), before any ram
> blocks are added.

That's what I thought but I did feel like it's tricky (not anything
about this patch, though).  Say, I don't see how that's guaranteed
that accel init will always happen before creating any ramblocks.

Anyway, your patch looks good from that point of view. :)

Thanks,

--=20
Peter Xu



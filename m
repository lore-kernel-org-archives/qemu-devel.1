Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C25C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E496206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZC4fABfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E496206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8MAA-0007eA-Kg
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 07:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k8M9a-00076B-R7
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:21:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k8M9Z-0008OY-1L
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597836072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLW2s7OskYEo4vgBPJNrAIro4pqHgOpRlEVMorhjZTc=;
 b=ZC4fABfjkaBw2Z4OnRyCKKxEe5lLD2/lbLqB8edOsKixkXw7UMTzTWNGo+pddZQZbCDewn
 ZDd7xYAFUKx4nHg0KGhYrVyevOFdn76bmGt/lHZMlccrb8q8RauXJJ9ipevsiprmeigpiF
 zZG/iXtA5iHK19/9wyQJWPbL4NKiSOU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-8o3r2JdlPQGRTDI8WDG-8g-1; Wed, 19 Aug 2020 07:21:08 -0400
X-MC-Unique: 8o3r2JdlPQGRTDI8WDG-8g-1
Received: by mail-wr1-f71.google.com with SMTP id m7so9234591wrb.20
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 04:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KLW2s7OskYEo4vgBPJNrAIro4pqHgOpRlEVMorhjZTc=;
 b=I7fQTGxCsTKAKyOzo270PfIrIlmkV2p0eFSn7rNkFgzHTZyvlXR7BL+4nwOF4wmfOe
 eFYsX9Q8fiWGULtmJ+dAmI8LwcdU3SGJl0ZqgrrOzRqPnhYHzGO9ouURyrDHubSACIwp
 NcztRz0yq7b4tjiY/rg/4PrL2EGLO9oolJUZ/AKMOwUymYAUfftC/V9QM4BNjbxdFl6K
 sCfZSJ/LtAauW8gvUr8JF3n3bds0D0DJ9ZLvVoFFGlptEQ5fNnd1UBGHuSjfcB9SAn2w
 6f65yASyQu/6JuX6J32vNs7xdLqL/gNk7qO1hym3E0/TRZDtZr+tHl61gdOBZFCQuLLP
 mikg==
X-Gm-Message-State: AOAM5312P3eS15acuriP7bmcXRJ4RCZHQ3yUMmf/SPHs+uXaznQSsVzA
 R2f8W5T3Bsu1ES7CHrvzHSJz/joJro2k0zrngYVwlWg0eRg4Z3F6JD4TJL+VYo9Tv+jKDmNNS79
 yLVQCKVUvkjvwLWw=
X-Received: by 2002:a1c:5416:: with SMTP id i22mr4503038wmb.172.1597836067550; 
 Wed, 19 Aug 2020 04:21:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyazdWoWH3su5boBgOWjxrIgp1s9KoxTdlXFfwhgppla4hMd4FfSw2dDZwNjtwOLrhQNTQ3Kw==
X-Received: by 2002:a1c:5416:: with SMTP id i22mr4502999wmb.172.1597836067147; 
 Wed, 19 Aug 2020 04:21:07 -0700 (PDT)
Received: from steredhat.lan ([5.171.195.20])
 by smtp.gmail.com with ESMTPSA id o2sm37856522wrj.21.2020.08.19.04.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 04:21:06 -0700 (PDT)
Date: Wed, 19 Aug 2020 13:21:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/3] vhost-vsock: force virtio version 1
Message-ID: <20200819112102.rpuf6hib7poaoxui@steredhat.lan>
References: <20200819105156.54163-1-sgarzare@redhat.com>
 <0b33b4b9-f1d1-759e-649d-899400b286c1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0b33b4b9-f1d1-759e-649d-899400b286c1@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Qian Cai <caiqian@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 01:06:55PM +0200, David Hildenbrand wrote:
> On 19.08.20 12:51, Stefano Garzarella wrote:
> > Recenlty changes in QEMU 5.1 requires to set 'disable-legacy=3Don'
> > on vhost-vsock-pci and vhost-user-vsock-pci devices:
> > 
> >     $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=3D5
> >         qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=3D5:
> >         device is modern-only, use disable-legacy=3Don
> 
> Something seemed to messed up your encoding (= vs. =3D). The patches
> look fine, though. (did you copy and paste this from somewhere?)

mmm, I used git-publish and I copied it from the first commint of the
series.

Re-opening the cover letter with git-publish everything looks okay, so
maybe the issue happened when sending it...

> 
> > 
> > As discussed with Cornelia [1], this series force virtio version 1
> > to vhost-vsock-pci, vhost-user-vsock-pci, and vhost-vsock-ccw devices.
> > 
> > virtio-vsock was introduced after the release of VIRTIO 1.0 specifications,
> > so it should be 'modern-only'.
> > In addition Cornelia verified that forcing a legacy mode on vhost-vsock-pci
> > device using x86-64 host and s390x guest, so with different endianness,
> > produces strange behaviours.
> > 
> > About migration, QEMU 5.1 already requires that the source and destination
> > specify 'disable-legacy=3Don', otherwise the migration fails in this way:
> >     qemu-system-x86_64: get_pci_config_device: Bad config data: i=3D0x2 read:=
> >  12 device: 53 cmask: ff wmask: 0 w1cmask:0
> >     qemu-system-x86_64: Failed to load PCIDevice:config
> >     qemu-system-x86_64: Failed to load virtio-vhost_vsock:virtio
> >     qemu-system-x86_64: error while loading state for instance 0x0 of device =
> > '0000:00:03.0/virtio-vhost_vsock'
> >     qemu-system-x86_64: load of migration failed: Invalid argument
> > 
> > With this series applied there is the same requirements. Alternatively
> > we have to detach and re-attach the device manually.
> > 
> > Thanks,
> > Stefano
> > 
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg02515.html
> > 
> > Stefano Garzarella (3):
> >   vhost-vsock-pci: force virtio version 1
> >   vhost-user-vsock-pci: force virtio version 1
> >   vhost-vsock-ccw: force virtio version 1
> > 
> >  hw/s390x/vhost-vsock-ccw.c       | 2 ++
> >  hw/virtio/vhost-user-vsock-pci.c | 2 +-
> >  hw/virtio/vhost-vsock-pci.c      | 2 +-
> >  3 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > --=20
> 
> ^ also here

Everywhere :-(

I'll check my configuration.

Thanks for pointing that out,
Stefano



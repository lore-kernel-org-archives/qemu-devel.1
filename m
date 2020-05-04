Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB12C4725A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDC62075A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iS51Gx2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDC62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbpS-0006BW-SY
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVboq-0005cN-Bq
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:11:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVboo-0003fQ-Nj
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588601497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zvxj+OeQ2PvDVWzyPYpDwDpKKFPEoKOzjrfN1ugoWQ=;
 b=iS51Gx2LmZkQBCXYQX7O9a3Ju7wEhWDG0x5OOohXKT4Fr84Sub+eblU7TyFloa1FdpyKd9
 9bdR55NBiDnWsz05qkCxuHOvEZHzFjxAiBkFFhHFuTIYvdwmSliMZ+rd0iZexdDwST5u1y
 2KpNtU+ujQVuvPR/EggWqFSAGEWRzEY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-IVzWVp_UMIe7Dias6A8qFw-1; Mon, 04 May 2020 10:11:35 -0400
X-MC-Unique: IVzWVp_UMIe7Dias6A8qFw-1
Received: by mail-wm1-f72.google.com with SMTP id t62so4964259wma.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=onTjnUkuuvgBXPScDCZIBIzpwU/V7A+HO0uggSgGZj8=;
 b=dSbnnC0qTSROd7ShSghbsW8okn15GByujkv01l2qFEZuq5yIcs8OPJ1IJi3tAOzwFx
 rrxF4YPfLFyFuB0ZS+ZuHnGwODkjYY2LdbREedtOHhjR43u42kOTw4bXkZg4+jqCKRQw
 OOkH4LLetdyDfBP8sMaCfwaHKHjIhnmeeQlDzX4dDA5jv9u6r3S6tokIrMdwIrfubBEZ
 4DlICBE8Hm6PesoVN288CGS7D8gMIuRROeBrr1f/4l1f9MnM6k/crW2Z576fOWZrPAUN
 RBwVSMWu4gDw4I6Gahq7iygBH663bL57msc6VFWsns2hlMzSfMJNeU+NvGLc/FtpLEnH
 JuiQ==
X-Gm-Message-State: AGi0PuZTgyZ1B/MLZBPtIZppQgTPRvOvhySY17ppA1tF8VoE6APnYDHO
 Sv0TsB1buZZBFdrNrAVUYVOBgGDoLFoxHeAZ3RGM4fkIRmr5/JhHo4kPTNCmZB5ahCLBBJCMEwk
 Qx4u5mbKRK1swpPE=
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr14612434wma.26.1588601494478; 
 Mon, 04 May 2020 07:11:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypJaez7XWXEje3w0eoerziNBjYygjXU48ds5WGbGPf8Mu426JvdyRHOV1QQ7/EmcEnX4GXRHYg==
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr14612402wma.26.1588601494240; 
 Mon, 04 May 2020 07:11:34 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 e5sm18533175wru.92.2020.05.04.07.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:11:33 -0700 (PDT)
Date: Mon, 4 May 2020 10:11:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RESEND v3 0/4] virtio-pci: enable blk and scsi
 multi-queue by default
Message-ID: <20200504101053-mutt-send-email-mst@kernel.org>
References: <20200320103041.129527-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200320103041.129527-1-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, slp@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 10:30:37AM +0000, Stefan Hajnoczi wrote:
> v3:
>  * Add new performance results that demonstrate the scalability
>  * Mention that this is PCI-specific [Cornelia]
> v2:
>  * Let the virtio-DEVICE-pci device select num-queues because the optimal
>    multi-queue configuration may differ between virtio-pci, virtio-mmio, =
and
>    virtio-ccw [Cornelia]


So this needs to be rebased wrt compat properties. I also see some
comments from Cornelia, worth addressing.

> Enabling multi-queue on virtio-pci storage devices improves performance o=
n SMP
> guests because the completion interrupt is handled on the vCPU that submi=
tted
> the I/O request.  This avoids IPIs inside the guest.
>=20
> Note that performance is unchanged in these cases:
> 1. Uniprocessor guests.  They don't have IPIs.
> 2. Application threads might be scheduled on the sole vCPU that handles
>    completion interrupts purely by chance.  (This is one reason why bench=
mark
>    results can vary noticably between runs.)
> 3. Users may bind the application to the vCPU that handles completion
>    interrupts.
>=20
> Set the number of queues to the number of vCPUs by default on virtio-blk =
and
> virtio-scsi PCI devices.  Older machine types continue to default to 1 qu=
eue
> for live migration compatibility.
>=20
> Random read performance:
>       IOPS
> q=3D1    78k
> q=3D32  104k  +33%
>=20
> Boot time:
>       Duration
> q=3D1        51s
> q=3D32     1m41s  +98%
>=20
> Guest configuration: 32 vCPUs, 101 virtio-blk-pci disks
>=20
> Previously measured results on a 4 vCPU guest were also positive but show=
ed a
> smaller 1-4% performance improvement.  They are no longer valid because
> significant event loop optimizations have been merged.
>=20
> Stefan Hajnoczi (4):
>   virtio-scsi: introduce a constant for fixed virtqueues
>   virtio-scsi: default num_queues to -smp N
>   virtio-blk: default num_queues to -smp N
>   vhost-user-blk: default num_queues to -smp N
>=20
>  hw/block/vhost-user-blk.c          |  6 +++++-
>  hw/block/virtio-blk.c              |  6 +++++-
>  hw/core/machine.c                  |  5 +++++
>  hw/scsi/vhost-scsi.c               |  3 ++-
>  hw/scsi/vhost-user-scsi.c          |  5 +++--
>  hw/scsi/virtio-scsi.c              | 13 +++++++++----
>  hw/virtio/vhost-scsi-pci.c         | 10 ++++++++--
>  hw/virtio/vhost-user-blk-pci.c     |  6 ++++++
>  hw/virtio/vhost-user-scsi-pci.c    | 10 ++++++++--
>  hw/virtio/virtio-blk-pci.c         |  9 ++++++++-
>  hw/virtio/virtio-scsi-pci.c        | 10 ++++++++--
>  include/hw/virtio/vhost-user-blk.h |  2 ++
>  include/hw/virtio/virtio-blk.h     |  2 ++
>  include/hw/virtio/virtio-scsi.h    |  5 +++++
>  14 files changed, 76 insertions(+), 16 deletions(-)
>=20
> --=20
> 2.24.1
>=20



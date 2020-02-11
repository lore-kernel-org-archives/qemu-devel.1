Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0078BC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9667206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz6sUxsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9667206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Te2-000237-Ua
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 06:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1TcG-0000e2-PE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1TcF-0008Ce-KT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:22:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34774
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1TcF-0008BU-Ft
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581420126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OB3uQLDzV7BgDA+zxgZp33eaQ6qrglR0t6JlSC7m9QQ=;
 b=Nz6sUxsri296qu8ZMToJB4enKqxZWhaWW4ujIHS0zFqrGwCt1Qe9Znn0AQuFgfpQPgfNao
 mFyy0VdjVRlGYCNYgbjpwqWvuk6QRjzK4nlTCIHcspRHpQxeIBRQFqIjX8KeT6GErOw1AH
 txODnaZfyda2E2AQXUg2zxe20S0Dl5c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-ba3r4u_oPFi7Qanc5ll7cw-1; Tue, 11 Feb 2020 06:22:02 -0500
Received: by mail-qk1-f197.google.com with SMTP id y6so6837011qki.13
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 03:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uywzlgED9FQaejQMPT8+w69RgaNeWiLfzY9AcwWvmwg=;
 b=hrxk3x0W5WR/zstwu/otevv8zGgyfWTB1hc1gXZBf2YZBXyQWoCcY1QJ9gKMC0SeC8
 /a5zEIL3tHdEX647pLkeytu2EoSrdGSamYWPn6lDiRJeKXI7/bH5xWAjAGcBW3oTFbw/
 mVUeG2teAY+7o6GblB5M1u6lqkjzGkY/9gacmR38h3OqrjCA7kymNwDs2xPkCd8dhqOY
 uhdGYbTy3QUjx+w4NtXttrDno1e/LiNFVFFn8zGgndtj+dUKbbzOMtPUgE23weSQDPFI
 QxSUBbcAJoaAa+WR/wZUIteMHpHJh754XbIgHFJ3sIanbWdHgkzK2CS3u45jBjL0U4b9
 DLnA==
X-Gm-Message-State: APjAAAWzeoUG+VZaSU5b8DelzLsVj7nJ1lHh9p6Tq47RcxKLFDm6Fjgf
 fTKL5+h8iXjbCuFTxWGoY5YoEOw3KdLe9bIyLgbqIDyv26v//1FpeiG6yX+8ND9+opTjot1y/pj
 Ocdhf5XmopW3klMM=
X-Received: by 2002:a37:4a46:: with SMTP id x67mr5025567qka.160.1581420122033; 
 Tue, 11 Feb 2020 03:22:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqz25NYgqQ4RyqKjzgoUmmDztlCipwhKzeimR0ml6ZS/X3NzdSxMN8c8069qeqewBEMoFh327Q==
X-Received: by 2002:a37:4a46:: with SMTP id x67mr5025556qka.160.1581420121807; 
 Tue, 11 Feb 2020 03:22:01 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id t23sm1896118qto.88.2020.02.11.03.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 03:22:00 -0800 (PST)
Date: Tue, 11 Feb 2020 06:21:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200211061932-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
X-MC-Unique: ba3r4u_oPFi7Qanc5ll7cw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 slp@redhat.com, Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 11, 2020 at 11:35:43AM +0800, Liu, Jing2 wrote:
>=20
> On 2/11/2020 11:17 AM, Jason Wang wrote:
> >=20
> > On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
> > > From: Liu Jiang<gerry@linux.alibaba.com>
> > >=20
> > > Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of usi=
ng
> > > virtio over mmio devices as a lightweight machine model for modern
> > > cloud. The standard virtio over MMIO transport layer only supports on=
e
> > > legacy interrupt, which is much heavier than virtio over PCI transpor=
t
> > > layer using MSI. Legacy interrupt has long work path and causes speci=
fic
> > > VMExits in following cases, which would considerably slow down the
> > > performance:
> > >=20
> > > 1) read interrupt status register
> > > 2) update interrupt status register
> > > 3) write IOAPIC EOI register
> > >=20
> > > We proposed to add MSI support for virtio over MMIO via new feature
> > > bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
> > >=20
> > > With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
> > > uses msi_sharing[1] to indicate the event and vector mapping.
> > > Bit 1 is 0: device uses non-sharing and fixed vector per event mappin=
g.
> > > Bit 1 is 1: device uses sharing mode and dynamic mapping.
> >=20
> >=20
> > I believe dynamic mapping should cover the case of fixed vector?
> >=20
> Actually this bit *aims* for msi sharing or msi non-sharing.
>=20
> It means, when msi sharing bit is 1, device doesn't want vector per queue
>=20
> (it wants msi vector sharing as name) and doesn't want a high interrupt
> rate.
>=20
> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>=20
> So they are opposite not superset.
>=20
> Thanks!
>=20
> Jing

what's the point of all this flexibility? the cover letter
complains about the code size of pci, then you go back
and add a ton of options with no justification.



>=20
> > Thanks
> >=20
> >=20
> >=20
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >=20



Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F17C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E537B20857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="et+mQPr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E537B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWuU-00015E-S9
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jUWth-0000BO-Fz
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jUWtg-0007Ft-0D
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:44:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jUWtf-0007En-Ao
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588344249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NL4zyHznFsj3tkoH2FRG/PQbe2d5i1qZDJTTUd7bbyg=;
 b=et+mQPr2JKe7sygYMCB+apTuAiXguvQZwFHQSv+stRt/QzfvwivIM3yTqdfll1P7M9EVQW
 3rETv7ZxlpjEsK4E0G/IIU3nYcpVQk2gyTVNhESpeiUNUXL0ADBEMLKFXsOvSnbgGPoP3T
 x5vtkvsmCG15QrPBUbInIhA1+b8x+7w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-I5drAE7JMvSR9SqFydXI-g-1; Fri, 01 May 2020 10:44:07 -0400
X-MC-Unique: I5drAE7JMvSR9SqFydXI-g-1
Received: by mail-wr1-f71.google.com with SMTP id m5so5754387wru.15
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Y7pL+sFX0YB9q72AIOt6ZlYNtq1DFBrUvYwn9R5J190=;
 b=DYNfDGr+KGn/XdL2QmUjC7RhNNXG4AA7jxGA2J/vQbmqUl0182Jhq39XlkfYdgQL2A
 CCV+t1dFUFuHZuKMe37lnR2X/y3yHug1MH9NRivxNo//fwS6OXQJbjXbIDQCPxmI/eHr
 a8LbK1dK9zqg+BfE29A4CFBaueFt7EpE31xoYEG5AEGiTlezbYOdpYfbQV4K1p0Tbp2r
 1O8mkPhfFDIkDHw9zMxa7CF8vQ+AaWLGFBBIx0DgdbptJZjn3vwC6F5F/ujalDnWlL4v
 MsV6jguT/9NLanO44js3LtfUOANRiCFTN+znrw0Ptcxk8UqQDraheQH+mqDTLz928+Bu
 1spA==
X-Gm-Message-State: AGi0PuZIHFIeFaacO0JmCzCtjolBPtTCIol7ChD9Rry/qJlNYbvMNit1
 KQAigt0PpHMYDUFAYdUAZof3fptLZ9YWIEaKtS10zVYBrIDXpO8v5D2UfBRaDpjBwLKx70ORE7X
 r+IwgmnQllZAHzFs=
X-Received: by 2002:adf:a1d3:: with SMTP id v19mr4411824wrv.253.1588344246328; 
 Fri, 01 May 2020 07:44:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ2yxFSUe9iedH1cSEb16fIN5h5IEJjMzQLUhaXfz/puaT7U4gTBiPAn6umQLpjusavthErew==
X-Received: by 2002:adf:a1d3:: with SMTP id v19mr4411804wrv.253.1588344246103; 
 Fri, 01 May 2020 07:44:06 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 s14sm4471416wme.33.2020.05.01.07.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 07:44:05 -0700 (PDT)
Date: Fri, 1 May 2020 10:44:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v7 0/7] reference implementation of RSS and hash report
Message-ID: <20200501104325-mutt-send-email-mst@kernel.org>
References: <20200329150953.23812-1-yuri.benditovich@daynix.com>
 <20200331102004-mutt-send-email-mst@kernel.org>
 <CAOEp5OeOcTZM_b254LxX5=jRiiAkGSoLsbMeiMjPs2OoF1MxNA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OeOcTZM_b254LxX5=jRiiAkGSoLsbMeiMjPs2OoF1MxNA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 08:22:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are in freeze so nothing's applied right now.
v8 which has all the bits will be a good step so we
are ready for after freeze.

On Fri, May 01, 2020 at 07:01:58AM +0300, Yuri Benditovich wrote:
> Michael/Jason,
>=20
> As Linux headers was updated in qemu and now include RSC/RSS/Hash definit=
ions,
> please let me know what you prefer:
> 1. You apply this series as is, then I submit clean-up series that will r=
emove
> all the redundant defines from virtio-net.c
> 2. I post v8 of this series with cleanup of all the redundant defines and=
 also
> RSC ones
> 3. Something other
>=20
> Thanks,
> Yuri Benditovich
>=20
> On Tue, Mar 31, 2020 at 5:26 PM Michael S. Tsirkin <mst@redhat.com> wrote=
:
>=20
>     On Sun, Mar 29, 2020 at 06:09:46PM +0300, Yuri Benditovich wrote:
>     > Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
>     > features in QEMU for reference purpose.
>     > Implements Toeplitz hash calculation for incoming
>     > packets according to configuration provided by driver.
>     > Uses calculated hash for decision on receive virtqueue
>     > and/or reports the hash in the virtio header
>=20
>=20
>     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
>     Probably post 5.0 material.
>=20
>     > Changes from v6:
>     > Fixed a bug in patch 5 "reference implementation of hash report"
>     > that caused the ASAN test to fail
>     > was: n->rss_data.populate_hash =3D true;
>     > fixed: n->rss_data.populate_hash =3D !!hash_report;
>     >
>     > Yuri Benditovich (7):
>     >=A0 =A0virtio-net: introduce RSS and hash report features
>     >=A0 =A0virtio-net: implement RSS configuration command
>     >=A0 =A0virtio-net: implement RX RSS processing
>     >=A0 =A0tap: allow extended virtio header with hash info
>     >=A0 =A0virtio-net: reference implementation of hash report
>     >=A0 =A0vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
>     >=A0 =A0virtio-net: add migration support for RSS and hash report
>     >
>     >=A0 hw/net/trace-events=A0 =A0 =A0 =A0 =A0 =A0 |=A0 =A03 +
>     >=A0 hw/net/virtio-net.c=A0 =A0 =A0 =A0 =A0 =A0 | 448 +++++++++++++++=
++++++++++++++++--
>     >=A0 include/hw/virtio/virtio-net.h |=A0 16 ++
>     >=A0 include/migration/vmstate.h=A0 =A0 |=A0 10 +
>     >=A0 net/tap.c=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=A0 11 +-
>     >=A0 5 files changed, 460 insertions(+), 28 deletions(-)
>     >
>     > --
>     > 2.17.1
>=20
>=20



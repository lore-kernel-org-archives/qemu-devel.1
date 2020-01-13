Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CB4C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7272080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+4VdLCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7272080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir5pF-0003cm-UF
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 14:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ir5ml-00084K-69
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ir5mk-0008Eo-1P
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:54:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25143
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ir5mj-0008Ds-Pl
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578945241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1j+mPe4cJIBJCBm9ZPogUyr+mteKp3lGBIfY0ZzH+Uk=;
 b=i+4VdLCBHo2NoZ2aH6MVAtXETqA+zMlFacPs7+5zsDjEZ4Bg3U9AHxtPBC9NTs9V6ucWbH
 OShsZuDNnmSzWGWA5XzxFR7VEaa+tgKxGGKosoybZPX9l7Zy4k7zFJUA5Xm307+e8qTcsA
 OolFDW1rtsW0Unwa9DqsL6SL2KIY79k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-GSdYOkuwOUiGu1iKjDjgOQ-1; Mon, 13 Jan 2020 14:53:59 -0500
Received: by mail-qk1-f198.google.com with SMTP id s9so6614952qkg.21
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 11:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PoBP/FNDU8dSVutypfRBqxdZ4EzkLMcbKHU0J1nBkyM=;
 b=WW6DsIjKS6xJclYl7W0sU9qy+rAtTtnpThKR3rWpUev7AhShdTMoAKJ8CKKgH+bshr
 9/TZtDNG6uIY9nBAAXyK3Mv8115xrLPb6bHk48oXmkkunTpm/cgCYbv6oKVsI1QKx4af
 +cVQO6szg0A61dtKnV80r2T/se6fa5+KD384pxXbDbstog5owVuZhWwpI0KFf4CmGmIB
 mxP1U+8ghuVWfZlwblKqjL513Aqqnf60mkdjxuxob23xPycnlpND+00wLWmtmM4Sz6up
 f0u7kum9kc2BLkbdvp7ckho+oiV08cku/FI5yMKdQ/giXrAlZqgKLtLBCeh7NDrlpOXD
 8Tpw==
X-Gm-Message-State: APjAAAWIZhf6blKIlbzkD0saoY1mOAh4PEXEumx57CwOamKpm73WHbKR
 RK3XIUOF/5VaYQAcYnLkZdsxq64NOdyktaBO1Tj5/ATZvQKuAa3LAcQUpSfarXXSd1xYP9tKBpm
 0ncWGUmASyKpk1VI=
X-Received: by 2002:a05:620a:1183:: with SMTP id
 b3mr17344630qkk.316.1578945239316; 
 Mon, 13 Jan 2020 11:53:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxNrdF/m6fliDIzCtLud96QunaVXiRHtXkR9SO9uW1PoFAmc8xlCyQoVbdifCgPjZFLdD4Sqg==
X-Received: by 2002:a05:620a:1183:: with SMTP id
 b3mr17344610qkk.316.1578945239124; 
 Mon, 13 Jan 2020 11:53:59 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id d184sm5504762qkb.128.2020.01.13.11.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 11:53:58 -0800 (PST)
Date: Mon, 13 Jan 2020 14:53:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v12 02/13] virtio-iommu: Add skeleton
Message-ID: <20200113195357.GB201624@xz-x1>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-3-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200109144319.15912-3-eric.auger@redhat.com>
X-MC-Unique: GSdYOkuwOUiGu1iKjDjgOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 03:43:08PM +0100, Eric Auger wrote:
> This patchs adds the skeleton for the virtio-iommu device.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu



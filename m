Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F700C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 20:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE74C208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 20:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="e3ICOzeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE74C208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEIUY-00049i-N1
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 16:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kEITy-0003eZ-DU; Fri, 04 Sep 2020 16:38:50 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kEITv-000383-J2; Fri, 04 Sep 2020 16:38:50 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id D21E2BF7D3;
 Fri,  4 Sep 2020 20:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599251925;
 bh=5K4QwpjskbwwFXD4jMiECpz0iyOa/FWGbtq0ckPhQ98=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e3ICOzeW9stUDwnDbvKvOB4YAFIRsuzO18pSqAcob6ODlWvUqul3mV5pe0GiQRfuz
 QhzZGkW9xfbh54+M/n/6u9PfwxC48cN3gKPklsYqaVtQQcCO7yI6b0RwxNIgQz4pTe
 titzLN9Li0HoFlP8uVB8Is9qwGldULpZkT+ozM/vGIH1lXFrIsAwhtYb4D8/iD4Bsd
 tdq/0aD4Isz4HoOdEMpOoQqUSeCeGfJvS2bVE53y7v4lCdFFAH6CH6eOOc4FcBJFTs
 gxEdaP/y4QBmnOqB7p+Z43mr61KWmSzOAg67dkEDwJk05cJpI+SQsMSWWJJsM4rzEW
 /7GBMHSYE/sXA==
Date: Fri, 4 Sep 2020 22:38:39 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 08/17] hw/block/nvme: refactor aio submission
Message-ID: <20200904203839.GA610544@apples.localdomain>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-9-its@irrelevant.dk>
 <20200904194708.GA3318909@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200904194708.GA3318909@dhcp-10-100-145-180.wdl.wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 16:38:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sep  4 12:47, Keith Busch wrote:
> On Fri, Sep 04, 2020 at 04:19:47PM +0200, Klaus Jensen wrote:
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index bfac3385cb64..3e32f39c7c1d 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -110,6 +110,7 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX=
] =3D {
> >  };
> > =20
> >  static void nvme_process_sq(void *opaque);
> > +static void nvme_aio_cb(void *opaque, int ret);
>=20
> You don't need the forward declaration here. Just move the
> implementation above where it's used. It looks safe: nvme_aio_cb()
> doesn't have any circular dependencies.

You are right, of course. But it is getting a circular dependency in a
later patch. I left it there to reduce code movement later.


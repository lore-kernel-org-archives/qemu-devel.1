Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B81C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111CC20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbbDfpuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111CC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01WU-000886-AA
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k01Vq-0007fI-0r
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:41:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k01Vo-0001BJ-1y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595850103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uBIOvR6niCiITuLnMIPaIPt6rmQuhwCHBuZfoPesmd4=;
 b=EbbDfpuG1zqDfFnqYTI+ECGAXWsuOMR4UqlfXa/FVy/O6HIf1Qhq1AC/fH7Po5Hue6reD2
 3oqIipVTI8UXC7hDMx/025zbbngAO7vATCT47MpZ1TSJrvasG5u0Cfz+Scww4PuUJ+vIM5
 tOd0vR9gs0fmbIS30KPjxcfrvYWzrP8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-X6zM9muPOYydx4WfyTJkbw-1; Mon, 27 Jul 2020 07:41:41 -0400
X-MC-Unique: X6zM9muPOYydx4WfyTJkbw-1
Received: by mail-wr1-f71.google.com with SMTP id w7so3846644wrt.9
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 04:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uBIOvR6niCiITuLnMIPaIPt6rmQuhwCHBuZfoPesmd4=;
 b=ci3g5K/Gztd/fM8dKdly65jIvafp34aCFO5v8IdT3e+q1xiUeyqu9fFPJFtU2NH+gc
 YKJhihBSqxcYm+3LN0JJAaxF/btPAu0wg3tqfOhU+NQMXifggOyZqg13fh5BROgcD7or
 PiHsRf0xM7sHVl4ptkqq5JBSv2w8jSWrBXU7P99XuuZ0QY/yw+6nVrNa7zvmf6pSmgxd
 fl9OLTZA5M9JpPwspmFj50TCHxe9w+AlWpmoBwgzBWnw3NI2u1K5OHUe02ArbvrmJMf9
 zIVUK4Ip/WItl9H/H4euUzlnMO5zKs6n7zUqk1gvHeVDzBb8G1owKtYF2XFwh6+FYtMu
 QhXQ==
X-Gm-Message-State: AOAM530KcWgR2GAWZfkSM1TC2/uV8BTrvrVlF9/d7RaUI/Eye0tbeMHe
 VQRocn24jTOTZ+BxSsR9rpAI+yw3w6I4T89cZmmxK7CgtQUXLxxOhzIcnDNiCqY6LCbILCPV9uM
 yLJvV+6G9fC4Ax1s=
X-Received: by 2002:a1c:f616:: with SMTP id w22mr19230770wmc.44.1595850100230; 
 Mon, 27 Jul 2020 04:41:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS1IK7f7tZKKDePqmEJ4jD4pAqdyluATBjjDCFqUEvlWFHaNQtz+P7LP5aZFJYsRbtAksQtg==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr19230755wmc.44.1595850100013; 
 Mon, 27 Jul 2020 04:41:40 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id k10sm11962938wrm.74.2020.07.27.04.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 04:41:39 -0700 (PDT)
Date: Mon, 27 Jul 2020 07:41:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: check the existence of peer before accesing
 its config
Message-ID: <20200727073943-mutt-send-email-mst@kernel.org>
References: <20200727074328.2279-1-jasowang@redhat.com>
 <20200727053954-mutt-send-email-mst@kernel.org>
 <20200727115322.4e7fe1aa.cohuck@redhat.com>
 <20200727061112-mutt-send-email-mst@kernel.org>
 <0cad868a-7f64-47e0-f4bf-014a5fc1bcf6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0cad868a-7f64-47e0-f4bf-014a5fc1bcf6@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 06:26:37PM +0800, Jason Wang wrote:
> 
> On 2020/7/27 下午6:13, Michael S. Tsirkin wrote:
> > On Mon, Jul 27, 2020 at 11:53:22AM +0200, Cornelia Huck wrote:
> > > On Mon, 27 Jul 2020 05:41:17 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > > > On Mon, Jul 27, 2020 at 03:43:28PM +0800, Jason Wang wrote:
> > > > > We try to get config from peer unconditionally which may lead NULL
> > > > > pointer dereference. Add a check before trying to access the config.
> > > > > 
> > > > > Fixes: 108a64818e69b ("vhost-vdpa: introduce vhost-vdpa backend")
> > > > > Cc: Cindy Lu <lulu@redhat.com>
> > > > > Tested-by: Cornelia Huck <cohuck@redhat.com>
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > I am a bit lost here. Isn't this invoked
> > > > when guest attempts to read the config?
> > > > With no peer, what do we return to guest?
> > > Same as with a non-vdpa peer? It's the dereference that needs to be
> > > guarded.
> > So vdpa has a GET_CONFIG ioctl which to me hints that a peer needs to be
> > notified on get config calls.
> > If we return config from qemu memory here, then I guess we
> > need to call GET_CONFIG on connect and validate it -
> > does this make sense?
> > 
> > Cindy, Jason?
> 
> 
> For "connect" you meant connecting virtio-net to its peer (vDPA)? AFAIK, if
> we start with no peer, there's no way to set a peer afterwards.
> 
> Thanks


That would be a good sentence to add in a code comment:

/*
 * Is this VDPA? No peer means not VDPA: there's no way to
 * disconnect/reconnect a VDPA peer.
 */

> 
> > 
> > > > A code comment might be helpful here.
> > > > 
> > > > > ---
> > > > >   hw/net/virtio-net.c | 22 +++++++++++-----------
> > > > >   1 file changed, 11 insertions(+), 11 deletions(-)



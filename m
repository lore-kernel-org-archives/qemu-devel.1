Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DBBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C751120774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adfV/2Fh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C751120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigL2-0002gV-3G
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigKF-00028Y-AQ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:38:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigKE-0006xe-G7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591717085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yc0zmfqbJVYu05RqMXNYrnYS5/nQ9a9J5WCs1e7dfW0=;
 b=adfV/2Fh3bLSzjoLjKNWsqx3m9i1zKg9fVUzj9A228u1cVmsV/L3+rLN2YgH8yvC9fscQc
 jO6de7r1O7/YSFSCE8D4EYkdaFR0WNoujpYKJ+XkBw6/j6qOIPMJvYHreaZCRwge5c6GM8
 QWID7bCFDBXjI4RRqOCNS5NpX2T1wvM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-gFEePDXgO6u9XFTbNiqrYw-1; Tue, 09 Jun 2020 11:38:00 -0400
X-MC-Unique: gFEePDXgO6u9XFTbNiqrYw-1
Received: by mail-wm1-f71.google.com with SMTP id v24so836265wmh.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 08:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yc0zmfqbJVYu05RqMXNYrnYS5/nQ9a9J5WCs1e7dfW0=;
 b=LH9lZ7fjCbM8XEptlxoTbZCnqUK34Rs+KH70K+RkDzKjwQJWQTVJWS2XQLUNK8CpSJ
 1boTQ3NZZD1sxbtV9kR8cNAG4gI0hcVb+pXPzmqTZWengt+OvwLulwccTzxWt1lNYbZe
 brqVhiJ3GWuiv7qnpUMdsPeMHdl8I2pW5rfNG8B06WzXBx99Eiukj3CGT4BZtoQUTwQ1
 6oQ2oNKA1byevq4FoQQeeXE3T/DAqL0yCLu9JsrmaWMaAiG/7vYABXByLUcOWSzwzFf3
 kXp5G3UMxnOymA1Hog2Sa8ITWBhjTv9QJTYFDYhdJwEwyEgH6QOxZiTilCHMiQ52J9BI
 Bd1g==
X-Gm-Message-State: AOAM532c+PGm+EGATz4rWSpqrSeJaeUmbIpJHplyHQ6a2sDLmoK7mT1F
 CyaqFmEWIHFUDmpMRBqGdL47b2D5zCbk7+jIHJJCpfzuXY4m3OjZ/VwHPZVy55cCOdosLYtdMhC
 iC6INrIFb8xpxw4U=
X-Received: by 2002:a5d:484b:: with SMTP id n11mr5185662wrs.356.1591717079372; 
 Tue, 09 Jun 2020 08:37:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlRpzpvOUdJigrxHHwUhwOHU1iDjBmi0Ea4znC8pnzMZWAS/W8FjMwFzRseDjrGQMtPMz4Gw==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr5185643wrs.356.1591717079180; 
 Tue, 09 Jun 2020 08:37:59 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id q1sm3255091wmc.15.2020.06.09.08.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 08:37:58 -0700 (PDT)
Date: Tue, 9 Jun 2020 11:37:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 1/5] virtio-pci: add virtio_pci_optimal_num_queues()
 helper
Message-ID: <20200609113745-mutt-send-email-mst@kernel.org>
References: <20200527102925.128013-1-stefanha@redhat.com>
 <20200527102925.128013-2-stefanha@redhat.com>
 <20200528173555.5f079b70.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200528173555.5f079b70.cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 28, 2020 at 05:35:55PM +0200, Cornelia Huck wrote:
> On Wed, 27 May 2020 11:29:21 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> 
> > Multi-queue devices achieve the best performance when each vCPU has a
> > dedicated queue. This ensures that virtqueue used notifications are
> > handled on the same vCPU that submitted virtqueue buffers.  When another
> > vCPU handles the the notification an IPI will be necessary to wake the
> > submission vCPU and this incurs a performance overhead.
> > 
> > Provide a helper function that virtio-pci devices will use in later
> > patches to automatically select the optimal number of queues.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.h | 9 +++++++++
> >  hw/virtio/virtio-pci.c | 7 +++++++
> >  2 files changed, 16 insertions(+)
> 
> That looks like a good idea, since the policy can be easily tweaked in
> one place later.
> 
> For ccw, I don't see a good way to arrive at an optimal number of
> queues. Is there something we should do for mmio? If yes, should this
> be a callback in VirtioBusClass?

Stefan do you plan to address this?



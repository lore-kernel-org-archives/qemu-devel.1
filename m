Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA4EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA944207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvXAAPGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA944207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4BE-0006a0-4n
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jw4AT-0005aR-IQ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:43:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20983
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jw4AR-0006K0-6R
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594906997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ySTIa6cNC6EDm9bKUehXmbkXOL8bUZv0WDuVb4VfAE=;
 b=ZvXAAPGzhMziT//6NfZUbYe3ODRbpl0V1IPfpk+Kd9WQBIT7Ss4uYNyzVzUqZ2cKTWcGGJ
 p5FhF+f1kYOGuoeSi8D2dUTvC86wpjDo7s2oRQAc/P67XWJpO2gqaHNlmskSJe1jUlvqSH
 WtE4HkBymj3uYAITwHloLBA7U1FoBQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-nktLm9ViMiKD8LVvtMO1xg-1; Thu, 16 Jul 2020 09:43:15 -0400
X-MC-Unique: nktLm9ViMiKD8LVvtMO1xg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46A1B193F560;
 Thu, 16 Jul 2020 13:43:09 +0000 (UTC)
Received: from gondolin (ovpn-113-57.ams2.redhat.com [10.36.113.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EABA5710D7;
 Thu, 16 Jul 2020 13:43:07 +0000 (UTC)
Date: Thu, 16 Jul 2020 15:43:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/2] virtio: non-legacy device handling
Message-ID: <20200716154305.0fc2d2b4.cohuck@redhat.com>
In-Reply-To: <20200707105446.677966-1-cohuck@redhat.com>
References: <20200707105446.677966-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:55:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  7 Jul 2020 12:54:44 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> As discussed in "virtio-fs: force virtio 1.x usage", it seems like
> a good idea to make sure that any new virtio device (which does not
> support legacy virtio) is indeed a non-transitional device, just to
> catch accidental misconfigurations. We can easily compile a list
> of virtio devices with legacy support and have transports verify
> in their plugged callbacks that legacy support is off for any device
> not in that list.
> 
> Most new virtio devices force non-transitional already, so nothing
> changes for them. vhost-user-fs-pci even does not allow to configure
> a non-transitional device, so it is fine as well.
> 
> One problematic device, however, is virtio-iommu-pci. It currently
> offers both the transitional and the non-transitional variety of the
> device, and does not force anything. I'm unsure whether we should
> consider transitional virtio-iommu unsupported, or if we should add
> some compat handling. (The support for legacy or not generally may
> change based upon the bus, IIUC, so I'm unsure how to come up with
> something generic.)
> 
> Cornelia Huck (2):
>   virtio: list legacy-capable devices
>   virtio: verify that legacy support is not accidentally on
> 
>  hw/s390x/virtio-ccw.c      |  6 ++++++
>  hw/virtio/virtio-pci.c     |  4 ++++
>  hw/virtio/virtio.c         | 25 +++++++++++++++++++++++++
>  include/hw/virtio/virtio.h |  2 ++
>  4 files changed, 37 insertions(+)
> 

Friendly ping.



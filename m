Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B85CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C2D20578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS0lIVaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C2D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspoo-0006EN-9i
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jspoC-0005ZC-5A
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:47:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jspoA-0002cf-Ju
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594136817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCDC3qD++7O9USFb/BYEmQt+Q223g3dq0LjY3XMCYSU=;
 b=jS0lIVaFO7kQIinC8H4wougaQCQXhIfgTLCR++4Az4wWbZ6b6etuzLOE3NbGtFeGOw+FEs
 A8NjL07qUEbBCRvzvgqUU9WnqzFV+wqfL5m5IDCsKw+ca+/aQoBN49sylGc4g6Zu0ZFvm7
 C67YfNNaAkAGgqqe18WsYZkbWkSSMSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-i0SJjJ1xPK6m240Mzg9edg-1; Tue, 07 Jul 2020 11:46:53 -0400
X-MC-Unique: i0SJjJ1xPK6m240Mzg9edg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D6581052512;
 Tue,  7 Jul 2020 15:46:52 +0000 (UTC)
Received: from gondolin (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F84619D7B;
 Tue,  7 Jul 2020 15:46:49 +0000 (UTC)
Date: Tue, 7 Jul 2020 17:46:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5 1/5] virtio-pci: add virtio_pci_optimal_num_queues()
 helper
Message-ID: <20200707174647.5184a094.cohuck@redhat.com>
In-Reply-To: <20200706135650.438362-2-stefanha@redhat.com>
References: <20200706135650.438362-1-stefanha@redhat.com>
 <20200706135650.438362-2-stefanha@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  6 Jul 2020 14:56:46 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Multi-queue devices achieve the best performance when each vCPU has a
> dedicated queue. This ensures that virtqueue used notifications are
> handled on the same vCPU that submitted virtqueue buffers.  When another
> vCPU handles the the notification an IPI will be necessary to wake the
> submission vCPU and this incurs a performance overhead.
> 
> Provide a helper function that virtio-pci devices will use in later
> patches to automatically select the optimal number of queues.
> 
> The function handles guests with large numbers of CPUs by limiting the
> number of queues to fit within the following constraints:
> 1. The maximum number of MSI-X vectors.
> 2. The maximum number of virtqueues.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/virtio/virtio-pci.h |  9 +++++++++
>  hw/virtio/virtio-pci.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)

I guess this should honour all relevant limits now.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>



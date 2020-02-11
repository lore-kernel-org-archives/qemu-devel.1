Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21714C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 03:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DCB20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 03:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyEhYvO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DCB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1M4J-0003QW-4f
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 22:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j1M3d-00030n-AP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j1M3b-0000YZ-UG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:17:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j1M3b-0000XB-QP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581391070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Nf36Pd4q2AVY4oKU24K8vx0+ORsf2vbbJBRG1witbM=;
 b=YyEhYvO9zwru6WyQf/OLqB81xbVf8pzHtxQo6aygej9FBO+WL7pOfu1T0UeCg0e7KsMyzW
 i5a4EnKfWTq1/FligicgJ9AQMphlgCB2CzRv3Jl4YFnwUf76p/Q+eYbENmW9Yw+K2Fngtj
 lk6knKAQ5NSzivu0CuEUsNZeGY8ezM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-ryGiD3WYO_iQ5R0AcXlykw-1; Mon, 10 Feb 2020 22:17:48 -0500
X-MC-Unique: ryGiD3WYO_iQ5R0AcXlykw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72832184AEB0;
 Tue, 11 Feb 2020 03:17:47 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 859ED83861;
 Tue, 11 Feb 2020 03:17:39 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt feature support
To: Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
Date: Tue, 11 Feb 2020 11:17:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, mst@redhat.com,
 jing2.liu@linux.intel.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com,
 gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
> From: Liu Jiang<gerry@linux.alibaba.com>
>
> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
> virtio over mmio devices as a lightweight machine model for modern
> cloud. The standard virtio over MMIO transport layer only supports one
> legacy interrupt, which is much heavier than virtio over PCI transport
> layer using MSI. Legacy interrupt has long work path and causes specifi=
c
> VMExits in following cases, which would considerably slow down the
> performance:
>
> 1) read interrupt status register
> 2) update interrupt status register
> 3) write IOAPIC EOI register
>
> We proposed to add MSI support for virtio over MMIO via new feature
> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>
> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
> uses msi_sharing[1] to indicate the event and vector mapping.
> Bit 1 is 0: device uses non-sharing and fixed vector per event mapping.
> Bit 1 is 1: device uses sharing mode and dynamic mapping.


I believe dynamic mapping should cover the case of fixed vector?

Thanks




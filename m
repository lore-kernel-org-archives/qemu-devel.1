Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FFAC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BE320678
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQ7WbaHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BE320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBZq-00083L-Jr
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kcBS2-0007xC-AD
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:59:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kcBRz-0007IJ-Sf
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604944769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mc8ykPwYbsMSenXOrMSuvYfhJTig/4/IT0nAUvd6i2w=;
 b=SQ7WbaHzXpxmSvI0R7VLXiObRHG/+KmtTJYGTO9DJ10sdk9wHDFTlbj0+uEyW0vRlBm7B3
 X2x3ux9CCiMjFKoy4D5t7r5iOLcrg1RO9Jz85grCnH5EMdL2McSwuIEhodepW8EZvxZFjS
 F8WvetF6YRVHcVY+hELtK7IyIDBTy2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-Y_L6Jf13Pf-QB0W37N6Uow-1; Mon, 09 Nov 2020 12:59:27 -0500
X-MC-Unique: Y_L6Jf13Pf-QB0W37N6Uow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC4BF1005513;
 Mon,  9 Nov 2020 17:59:26 +0000 (UTC)
Received: from gondolin (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09FBA19C71;
 Mon,  9 Nov 2020 17:59:17 +0000 (UTC)
Date: Mon, 9 Nov 2020 18:59:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH for-5.2] vhost-user: fix VHOST_USER_ADD/REM_MEM_REG
 truncation
Message-ID: <20201109185900.509417bf.cohuck@redhat.com>
In-Reply-To: <20201109174355.1069147-1-stefanha@redhat.com>
References: <20201109174355.1069147-1-stefanha@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  9 Nov 2020 17:43:55 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> QEMU currently truncates the mmap_offset field when sending
> VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG messages. The struct
> layout looks like this:
> 
>   typedef struct VhostUserMemoryRegion {
>       uint64_t guest_phys_addr;
>       uint64_t memory_size;
>       uint64_t userspace_addr;
>       uint64_t mmap_offset;
>   } VhostUserMemoryRegion;
> 
>   typedef struct VhostUserMemRegMsg {
>       uint32_t padding;
>       /* WARNING: there is a 32-bit hole here! */
>       VhostUserMemoryRegion region;
>   } VhostUserMemRegMsg;
> 
> The payload size is calculated as follows when sending the message in
> hw/virtio/vhost-user.c:
> 
>   msg->hdr.size = sizeof(msg->payload.mem_reg.padding) +
>       sizeof(VhostUserMemoryRegion);
> 
> This calculation produces an incorrect result of only 36 bytes.
> sizeof(VhostUserMemRegMsg) is actually 40 bytes.
> 
> The consequence of this is that the final field, mmap_offset, is
> truncated. This breaks x86_64 TCG guests on s390 hosts. Other guest/host
> combinations may get lucky if either of the following holds:
> 1. The guest memory layout does not need mmap_offset != 0.
> 2. The host is little-endian and mmap_offset <= 0xffffffff so the
>    truncation has no effect.
> 
> Fix this by extending the existing 32-bit padding field to 64-bit. Now
> the padding reflects the actual compiler padding. This can be verified
> using pahole(1).
> 
> Also document the layout properly in the vhost-user specification.  The
> vhost-user spec did not document the exact layout. It would be
> impossible to implement the spec without looking at the QEMU source
> code.
> 
> Existing vhost-user frontends and device backends continue to work after
> this fix has been applied. The only change in the wire protocol is that
> QEMU now sets hdr.size to 40 instead of 36. If a vhost-user
> implementation has a hardcoded size check for 36 bytes, then it will
> fail with new QEMUs. Both QEMU and DPDK/SPDK don't check the exact
> payload size, so they continue to work.

Seems we are lucky, then.

> 
> Fixes: f1aeb14b0809e313c74244d838645ed25e85ea63 ("Transmit vhost-user memory regions individually")

I think the canonical format is

Fixes: f1aeb14b0809 ("Transmit vhost-user memory regions individually")

Maybe cc:stable as well?


> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/interop/vhost-user.rst           | 21 +++++++++++++++++++--
>  contrib/libvhost-user/libvhost-user.h |  2 +-
>  hw/virtio/vhost-user.c                |  5 ++---
>  3 files changed, 22 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>



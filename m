Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C363BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4F120663
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cONPX1F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4F120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo4rw-0001dN-R6
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 08:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jo4qn-0000CN-Ke
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:50:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41248
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jo4ql-0004PY-Uw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593002999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jDlM8Fso+2XIFRLHpqgyykwf6RsW1F6vY29jFDO97NM=;
 b=cONPX1F6HcnLnzwcJOuSRt/1STICMls112VN/Dwt43x1hBhdGsRBT37D8bM654ntkBa4E7
 DMDwNcAtdSOiX/fQ8G1Sg0nugpSnFvjrudUA7qFuK9iJbFlSkkr2zgB/y8EiwL9pZIIZmr
 FnToog/xDND9sJaCdEwaijOPQJsrCvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-HhEJ7rKLPuyCXIukeqpuRQ-1; Wed, 24 Jun 2020 08:49:55 -0400
X-MC-Unique: HhEJ7rKLPuyCXIukeqpuRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4914800D5C;
 Wed, 24 Jun 2020 12:49:53 +0000 (UTC)
Received: from gondolin (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1033100EBB8;
 Wed, 24 Jun 2020 12:49:44 +0000 (UTC)
Date: Wed, 24 Jun 2020 14:49:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v3 8/8] s390: guest support for diagnose 0x318
Message-ID: <20200624144942.4a562f0e.cohuck@redhat.com>
In-Reply-To: <20200618222258.23287-9-walling@linux.ibm.com>
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-9-walling@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 18:22:58 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> DIAGNOSE 0x318 (diag318) is an s390 instruction that allows the storage
> of diagnostic information that is collected by the firmware in the case
> of hardware/firmware service events.
> 
> QEMU handles the instruction by storing the info in the CPU state. A
> subsequent register sync will communicate the data to the hypervisor.
> 
> QEMU handles the migration via a VM State Description.
> 
> This feature depends on the Extended-Length SCCB (els) feature. If
> els is not present, then a warning will be printed and the SCLP bit
> that allows the Linux kernel to execute the instruction will not be
> set.
> 
> Availability of this instruction is determined by byte 134 (aka fac134)
> bit 0 of the SCLP Read Info block. This coincidentally expands into the
> space used for CPU entries, which means VMs running with the diag318
> capability may not be able to read information regarding all CPUs
> unless the guest kernel supports an extended-length SCCB.

We cannot do anything about that, I guess.

> 
> This feature is not supported in protected virtualization mode.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/sclp.c                     |  5 +++++
>  include/hw/s390x/sclp.h             |  3 +++
>  target/s390x/cpu.h                  |  3 ++-
>  target/s390x/cpu_features.h         |  1 +
>  target/s390x/cpu_features_def.inc.h |  3 +++
>  target/s390x/cpu_models.c           |  1 +
>  target/s390x/gen-features.c         |  1 +
>  target/s390x/kvm.c                  | 31 +++++++++++++++++++++++++++++
>  target/s390x/machine.c              | 17 ++++++++++++++++
>  9 files changed, 64 insertions(+), 1 deletion(-)

LGTM.



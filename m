Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3506CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCF3206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I74fEWiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCF3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzzg4-0004VW-1H
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 05:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzzet-0003by-Mw
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:42:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31159
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzzes-0005jM-5t
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595842977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbFS+/4j9/oIOf9g6q7zI2jvwT8P1W/IvDWzu6e9kas=;
 b=I74fEWiGy4AjyatmKxtGSYmAq0OJsbVbwzWRC+FOfy/+yEfsvqS0xYnmav9QCbbek+tWIX
 dj24xOjATXgKEQN9ERLSAOlz0wKruklPTAnagMz1NacMoQVx0P8+6Oab4cbIq8trpDD8ZV
 e283ZID1+A/Z6J2jPHYHQMKIiqIvkH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-EvDb7kUWOheUB6DGmfRmBA-1; Mon, 27 Jul 2020 05:42:53 -0400
X-MC-Unique: EvDb7kUWOheUB6DGmfRmBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB79458;
 Mon, 27 Jul 2020 09:42:51 +0000 (UTC)
Received: from gondolin (ovpn-112-210.ams2.redhat.com [10.36.112.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3919872EF;
 Mon, 27 Jul 2020 09:42:43 +0000 (UTC)
Date: Mon, 27 Jul 2020 11:42:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv3 4/9] s390x: prepare for more diag500 hypercalls
Message-ID: <20200727114240.4a90388c.cohuck@redhat.com>
In-Reply-To: <20200724143750.59836-5-david@redhat.com>
References: <20200724143750.59836-1-david@redhat.com>
 <20200724143750.59836-5-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 16:37:45 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's generalize, abstacting the virtio bits. diag500 is now a generic
> hypercall to handle QEMU/KVM specific things. Explicitly specify all
> already defined subcodes, including legacy ones (so we know what we can
> use for new hypercalls). While at it, move exception handling into the
> handler.

IIRC, diag 500 had been reserved as "KVM stuff" and not just "virtio
stuff", so that should be fine.

The kernel documentation explicitly talks about "KVM virtio functions",
though; you may want to tweak this (and also add a reference to any new
subcodes.)

[Do we have a good resting place for documenting non-virtio-specific
subcodes?]

> 
> We'll rename the files separately, so git properly detects the rename.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-hcall.c | 14 +++++++-------
>  hw/s390x/s390-virtio-hcall.h | 12 ++++++------
>  target/s390x/kvm.c           | 15 +++------------
>  target/s390x/misc_helper.c   |  3 ++-
>  4 files changed, 18 insertions(+), 26 deletions(-)
>

(...)

> diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
> index 67e11ea39a..2214216ce8 100644
> --- a/hw/s390x/s390-virtio-hcall.h
> +++ b/hw/s390x/s390-virtio-hcall.h
> @@ -1,5 +1,5 @@
>  /*
> - * Support for virtio hypercalls on s390x
> + * Support for QEMU/KVM-specific hypercalls on s390
>   *
>   * Copyright IBM Corp. 2012, 2017
>   * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> @@ -12,10 +12,10 @@
>  #ifndef HW_S390_VIRTIO_HCALL_H
>  #define HW_S390_VIRTIO_HCALL_H
>  
> -#include "standard-headers/asm-s390/virtio-ccw.h"
> +#define DIAG500_VIRTIO_NOTIFY          0 /* legacy, implemented as a NOP */
> +#define DIAG500_VIRTIO_RESET           1 /* legacy */
> +#define DIAG500_VIRTIO_SET_STATUS      2 /* legacy */
> +#define DIAG500_VIRTIO_CCW_NOTIFY      3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
>  
> -/* The only thing that we need from the old kvm_virtio.h file */
> -#define KVM_S390_VIRTIO_NOTIFY 0

It feels a bit odd to define it here; but this is host/guest api and
won't change anyway.

> -
> -int s390_virtio_hypercall(CPUS390XState *env);
> +void handle_diag_500(CPUS390XState *env, uintptr_t ra);
>  #endif /* HW_S390_VIRTIO_HCALL_H */

(...)



Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8865FC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5803A207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjGzyILu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5803A207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4ci-0000lp-I5
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1is4bu-0008Dm-QA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1is4bq-00061l-TV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:50:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37658
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1is4bq-00061L-PW
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579179049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8cHhkAlnHCmpRMbfimsb3m25Hqd+pmMxMB9VqbsIW4I=;
 b=UjGzyILucsneJ3t1p2z9x3jQx9KCbiewkFrLghzZGksRLiTGSLedY4HEMYst36eQ1NzYmY
 7joMaykd9zBlYIYZRU02DVb0xDnK9P4ecqRvukoN4baHLAZ9SaN0RpVMMRwz6xPFscxIYg
 GCp9g2EsqyGBCJmZTMvr668exIgBiSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-sl_PZpJtMRG2q8DYHXZTZw-1; Thu, 16 Jan 2020 07:50:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2957A183B526;
 Thu, 16 Jan 2020 12:50:45 +0000 (UTC)
Received: from gondolin (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66DA3842BA;
 Thu, 16 Jan 2020 12:50:41 +0000 (UTC)
Date: Thu, 16 Jan 2020 13:50:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] target/s390x/kvm: Enable adapter interruption
 suppression again
Message-ID: <20200116135038.2c8cf3c6.cohuck@redhat.com>
In-Reply-To: <20200116122026.5804-1-thuth@redhat.com>
References: <20200116122026.5804-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sl_PZpJtMRG2q8DYHXZTZw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 13:20:26 +0100
Thomas Huth <thuth@redhat.com> wrote:

> The AIS feature has been disabled late in the v2.10 development
> cycle since there were some issues with migration (see commit
> 3f2d07b3b01ea61126b - "s390x/ais: for 2.10 stable: disable ais
> facility"). We originally wanted to enable it again for newer
> machine types, but apparently we forgot to do this so far. Let's
> do it for the new s390-ccw-virtio-5.0 machine now.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         |  4 ++++
>  include/hw/s390x/s390-virtio-ccw.h |  4 ++++
>  target/s390x/kvm.c                 | 11 ++++++++---
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 

> @@ -365,10 +367,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      /*
>       * The migration interface for ais was introduced with kernel 4.13
>       * but the capability itself had been active since 4.12. As migration
> -     * support is considered necessary let's disable ais in the 2.10
> -     * machine.
> +     * support is considered necessary we only enable this for newer

s/necessary we only enable this/necessary, we only try to enable this/

> +     * machine types and if KVM_CAP_S390_AIS_MIGRATION is available.

maybe s/and if/if/

>       */
> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
> +    if (smc->kvm_ais_allowed &&
> +        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
> +        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> +    }
>  
>      kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
>      return 0;

Looks good.

Remind me again: ais only made a difference for pci devices, right? Is
it enough to give this a quick whirl with virtio-pci devices?



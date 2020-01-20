Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B2DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADE121835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNNbTucA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADE121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itaqv-00053I-KO
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1itaqI-0004Sa-BI
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:28:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1itaqF-0003si-UJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:28:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54438
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1itaqE-0003p2-4Y
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579541276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Is3QcVDl1DA4b+8bTrTei5F+oaTl+6G02a3SWUYxkYI=;
 b=NNNbTucA4SlGqTfbkR9uk7yP7yQ4W3hoDLpoCK2CMhIQEJurEaDUjMtdkVehWEXFyykZ2V
 uneC9C7+usR+RDkQ3686VdudSorD5Jj8YSD8SfsFEH8f2ugTeWZoZAwobGb+JDvY0QOTel
 K9jJX3sR7uLhUbozT4hn+T5MapoHUcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-v0rkg3R4PHCyLlh5DtyGQA-1; Mon, 20 Jan 2020 12:27:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CB21107ACC4;
 Mon, 20 Jan 2020 17:27:54 +0000 (UTC)
Received: from gondolin (ovpn-205-161.brq.redhat.com [10.40.205.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C79C860DA;
 Mon, 20 Jan 2020 17:27:49 +0000 (UTC)
Date: Mon, 20 Jan 2020 18:27:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3] target/s390x/kvm: Enable adapter interruption
 suppression again
Message-ID: <20200120182747.5135fea8.cohuck@redhat.com>
In-Reply-To: <20200120132441.11884-1-thuth@redhat.com>
References: <20200120132441.11884-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: v0rkg3R4PHCyLlh5DtyGQA-1
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
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jan 2020 14:24:41 +0100
Thomas Huth <thuth@redhat.com> wrote:

> The AIS feature has been disabled late in the v2.10 development cycle since
> there were some issues with migration (see commit 3f2d07b3b01ea61126b -
> "s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
> to enable it again for newer machine types, but apparently we forgot to do
> this so far. Let's do it for the new s390-ccw-virtio-5.0 machine now.
> 
> While at it, also add a more verbose comment why we need the *_allowed()
> wrappers in s390-virtio-ccw.c.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3: Moved "s390mc->kvm_ais_allowed = false" to the end of the function
> 
>  hw/s390x/s390-virtio-ccw.c         | 20 +++++++++++++++++---
>  include/hw/s390x/s390-virtio-ccw.h |  3 +++
>  target/s390x/kvm.c                 |  9 ++++++---
>  3 files changed, 26 insertions(+), 6 deletions(-)

> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 15260aeb9a..cf4fb4f2d9 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -365,10 +365,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      /*
>       * The migration interface for ais was introduced with kernel 4.13
>       * but the capability itself had been active since 4.12. As migration
> -     * support is considered necessary let's disable ais in the 2.10
> -     * machine.
> +     * support is considered necessary, we only try to enable this for
> +     * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
>       */
> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
> +    if (kvm_ais_allowed() &&
> +        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {

Hnm, we actually need a kernel irqchip with the kvm flic to get ais to
work; else we'll fail with

qemu-system-s390x: Failed to inject airq with AIS supported

in the kernel_irqchip=off case, as we won't have an I/O adapter
registered.

Adding 'kvm_kernel_irqchip_required() &&' seems to do the trick;
comments?

> +        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> +    }
>  
>      kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
>      return 0;



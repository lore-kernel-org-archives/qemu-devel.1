Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1427BC2D0EC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C9920719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyNi9gkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C9920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHVon-0002rk-1N
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 12:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jHVnb-0001WH-HK
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jHVnZ-0007x0-EA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:56:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35755)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jHVnZ-0007wc-6A
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585241764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3w3eIqtkuZZt0x6XwEPrAwkEHKKBwaKdajX6wsdJN0E=;
 b=iyNi9gkAsLGknJpHCBEBmmEJUSN6rTbq8zhzJz1YJRFfKV1FWTp12fq+KzOwv5wybVLudv
 b7xJ1kmW0yLsyNAgVBNTYBBtJ78Kg6kk1S73eEJS9QNMQ/4ac+TZ/LO05ADRBCrlgCp3XL
 ClI6BE80/5fU7vUo3UBTqZfLmI3eStE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-KCXWVck9NW2Ua8BKgtgGOw-1; Thu, 26 Mar 2020 12:56:02 -0400
X-MC-Unique: KCXWVck9NW2Ua8BKgtgGOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 837B88024EF;
 Thu, 26 Mar 2020 16:56:00 +0000 (UTC)
Received: from gondolin (ovpn-112-191.ams2.redhat.com [10.36.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D8A060C18;
 Thu, 26 Mar 2020 16:55:54 +0000 (UTC)
Date: Thu, 26 Mar 2020 17:55:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH] s390x: protvirt: Fix stray error_report_err in
 s390_machine_protect
Message-ID: <20200326175551.542153aa.cohuck@redhat.com>
In-Reply-To: <20200326140505.2432-1-frankja@linux.ibm.com>
References: <20200326140505.2432-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Mar 2020 10:05:05 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> In case the protection of the machine fails at s390_pv_vm_enable(),
> we'll currently report the local_error variable. Problem is that
> there's no migration blocker error that we can report at this point so
> the pointer is always NULL which leads to a SEGFAULT.
> 
> Let's remove the error report.

Yes, s390_pvm_vm_enable() will already moan on error.

> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Fixes: 520935eedf941da3 ("s390x: protvirt: Add migration blocker")

Note to self: update commit ID before I send a pull request (I will at
least need to rebase for a headers update...)

> ---
>  hw/s390x/s390-virtio-ccw.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3cf19c99f3468b7d..855ecf370d6e82fa 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -358,7 +358,6 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>      rc = s390_pv_vm_enable();
>      if (rc) {
>          qemu_balloon_inhibit(false);
> -        error_report_err(local_err);
>          migrate_del_blocker(pv_mig_blocker);
>          error_free_or_abort(&pv_mig_blocker);
>          return rc;

Thanks, applied.



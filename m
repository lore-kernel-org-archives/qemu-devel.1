Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A302C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C862076F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxTBl86+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C862076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEX6N-00045J-3K
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEX5d-0003Rm-UJ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEX5c-0004my-I3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:42:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47189)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEX5c-0004bB-88
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584531743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NoF2tXLL+2rmnbX9do3XUmMoNsslmXyv5OuhY+nKjBo=;
 b=OxTBl86+V7MMxAfbJ6trIwacein+jNqkpynYYV2C4V5yF8Vu7VGnCqRhjgS87Nfb1VlhSL
 NI4DFnbpd+qeNzEpyeThAeE/4OwPznvuR/8TlnS7QEm5qLCnCZuumCl2amBP1vmS+HXbmo
 8tOgx9GDYyKle6T2fdwNRSQQvOmX7+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-8x4xAT3OPIq6INNMAgqwVw-1; Wed, 18 Mar 2020 07:42:21 -0400
X-MC-Unique: 8x4xAT3OPIq6INNMAgqwVw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8952A107ACC7;
 Wed, 18 Mar 2020 11:42:20 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A7435D9C5;
 Wed, 18 Mar 2020 11:42:16 +0000 (UTC)
Date: Wed, 18 Mar 2020 12:42:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 04/15] s390x: protvirt: Inhibit balloon when
 switching to protected mode
Message-ID: <20200318124214.15778f76.cohuck@redhat.com>
In-Reply-To: <20200311132151.172389-5-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-5-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On Wed, 11 Mar 2020 09:21:40 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Ballooning in protected VMs can only be done when the guest shares the
> pages it gives to the host. If pages are not shared, the integrity
> checks will fail once those pages have been altered and are given back
> to the guest.
> 
> As we currently do not yet have a solution for this we will continue
> like this:
> 
> 1. We block ballooning now in QEMU (with this patch)

add trailing '.'

> 
> 2. Later we will provide a change to virtio that removes the blocker

s/Later/Later,/

> and adds VIRTIO_F_IOMMU_PLATFORM automatically by QEMU when doing the
> protvirt switch. This is ok as the guest balloon driver will reject to
> work with the IOMMU change

"This is OK, as the balloon driver in Linux (the only supported guest)
will refuse to work with the IOMMU_PLATFORM feature bit set."

?

> 
> 3. Later we can fix the guest balloon driver to accept the IOMMU

"Later, we can fix the Linux guest balloon driver..."

> feature bit and correctly exercise sharing and unsharing of balloon
> pages

again, missing trailing '.'

> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index deb31e060052d279..066e01f303c35671 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -41,6 +41,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/s390x/tod.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/balloon.h"
>  #include "hw/s390x/pv.h"
>  #include "migration/blocker.h"
>  
> @@ -326,6 +327,7 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
>      ms->pv = false;
>      migrate_del_blocker(pv_mig_blocker);
>      error_free_or_abort(&pv_mig_blocker);
> +    qemu_balloon_inhibit(false);
>  }
>  
>  static int s390_machine_protect(S390CcwMachineState *ms)
> @@ -333,10 +335,12 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>      Error *local_err = NULL;
>      int rc;
>

Maybe add a comment?

/*
 * Ballooning on protected VMs needs support in the guest for
 * sharing and unsharing balloon pages. Block ballooning for
 * now, until we have a solution to make at least Linux guests
 * either support it or fail gracefully.
 */
  
> +    qemu_balloon_inhibit(true);
>      error_setg(&pv_mig_blocker,
>                 "protected VMs are currently not migrateable.");
>      rc = migrate_add_blocker(pv_mig_blocker, &local_err);
>      if (local_err) {
> +        qemu_balloon_inhibit(false);
>          error_report_err(local_err);
>          error_free_or_abort(&pv_mig_blocker);
>          return rc;
> @@ -345,6 +349,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>      /* Create SE VM */
>      rc = s390_pv_vm_enable();
>      if (rc) {
> +        qemu_balloon_inhibit(false);
>          error_report_err(local_err);
>          migrate_del_blocker(pv_mig_blocker);
>          error_free_or_abort(&pv_mig_blocker);



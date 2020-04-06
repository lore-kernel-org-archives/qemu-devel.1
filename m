Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CAAC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C601B206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHZB7Pam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C601B206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLPHn-0008Is-Qc
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jLPGv-0007rD-3u
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jLPGt-0007Em-QP
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:46:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48353
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jLPGt-0007ES-II
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586169987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSFRJtBKc/pQRx7w+wlscFqgByX2T546jIvi1QRbDtI=;
 b=IHZB7PamEv1nbUjo8RlF6aQxJunAY+PipMeFjgTaomMODySOFlBkhwBfCcYzKYfBg+jxAl
 K9P5TlKTufNnveMIcpWHQfzMga554m0HrDR1NjNcevc72//lnNH0mdLm5o24hsB9GwzNkf
 AM+VlZaMfEJSb+2CntSd3JNB1jTPdJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-BH-4UwAoOdCFpwi2Uy6KdA-1; Mon, 06 Apr 2020 06:46:25 -0400
X-MC-Unique: BH-4UwAoOdCFpwi2Uy6KdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC856800D5C;
 Mon,  6 Apr 2020 10:46:22 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1C7E5DA81;
 Mon,  6 Apr 2020 10:46:16 +0000 (UTC)
Date: Mon, 6 Apr 2020 12:46:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 1/1] s390x/s390-virtio-ccw: Fix build on systems
 without KVM
Message-ID: <20200406124613.288806b6.cohuck@redhat.com>
In-Reply-To: <20200406100158.5940-2-borntraeger@de.ibm.com>
References: <20200406100158.5940-1-borntraeger@de.ibm.com>
 <20200406100158.5940-2-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Bruce Rogers <brogers@suse.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  6 Apr 2020 06:01:58 -0400
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> linux/kvm.h is not available on all platforms. Let us move
> s390_machine_inject_pv_error into pv.c as it uses KVM structures.
> Also rename the function to s390_pv_inject_reset_error.
> 
> While at it, ipl.h needs an include for "exec/address-spaces.h"
> as it uses address_space_memory.
> 
> Fixes: 49fc3220175e ("s390x: protvirt: Support unpack facility")
> Reported-by: Bruce Rogers <brogers@suse.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/ipl.h             |  1 +
>  hw/s390x/pv.c              | 11 +++++++++++
>  hw/s390x/s390-virtio-ccw.c | 12 +-----------
>  include/hw/s390x/pv.h      |  3 +++
>  4 files changed, 16 insertions(+), 11 deletions(-)

Thanks, applied.



Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7BBC433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E6620759
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhBssA3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E6620759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzzNT-0006Md-HQ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 05:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzzMs-0005tv-GM
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:24:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35049
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzzMp-0002uN-VR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595841858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eS1qMATIfEoFXjsaCWak/KvfNF7PFwW6pksAxA7QPi4=;
 b=GhBssA3zNwtsNXCvvCx+4DA077srEabYoceFxTXl9i4OEBi9NIcD7qw4Uj67JzNY82Mkxl
 axUJqkyFzVdHfLL2FaSa+O7zMGpkwCXoen338Qzv+Jk73lNJjWrgqThRbOujA9mzErm4BN
 dPqdxPcgpH/6qH8xG5ycbkfqsM21BlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-BC5vlXUuP16a_ch2Gy_pTg-1; Mon, 27 Jul 2020 05:24:16 -0400
X-MC-Unique: BC5vlXUuP16a_ch2Gy_pTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84D9F194092C;
 Mon, 27 Jul 2020 09:24:14 +0000 (UTC)
Received: from gondolin (ovpn-112-210.ams2.redhat.com [10.36.112.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23EDA76216;
 Mon, 27 Jul 2020 09:24:06 +0000 (UTC)
Date: Mon, 27 Jul 2020 11:24:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv3 3/9] s390x: remove hypercall registration mechanism
Message-ID: <20200727112403.78f0d78c.cohuck@redhat.com>
In-Reply-To: <20200724143750.59836-4-david@redhat.com>
References: <20200724143750.59836-1-david@redhat.com>
 <20200724143750.59836-4-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 16:37:44 +0200
David Hildenbrand <david@redhat.com> wrote:

> Nowadays, we only have a single machine type in QEMU, everything is based
> on virtio-ccw and the traditional virtio machine does no longer exist. No
> need to dynamically register diag500 handlers. Move the two existing

Hm, do we want to make certain subcodes available only if certain code
has been configured? If yes, it might make sense to keep the mechanism.

> handlers into diag500.c.

In any case, that file does not exist :)

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c   | 46 -----------------------------
>  hw/s390x/s390-virtio-hcall.c | 56 ++++++++++++++++++++++++------------
>  hw/s390x/s390-virtio-hcall.h |  2 --
>  3 files changed, 38 insertions(+), 66 deletions(-)
> 

(...)

> diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-virtio-hcall.c
> index ec7cf8beb3..5e14bd49b7 100644
> --- a/hw/s390x/s390-virtio-hcall.c
> +++ b/hw/s390x/s390-virtio-hcall.c
> @@ -12,30 +12,50 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "hw/s390x/s390-virtio-hcall.h"
> +#include "hw/s390x/ioinst.h"

(Maybe you could remove the ioinst.h include from s390-virtio-ccw.c
with this change?)

> +#include "hw/s390x/css.h"
> +#include "virtio-ccw.h"
>  
> -#define MAX_DIAG_SUBCODES 255
> -
> -static s390_virtio_fn s390_diag500_table[MAX_DIAG_SUBCODES];
> -
> -void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn)
> +static int handle_virtio_notify(uint64_t mem)
>  {
> -    assert(code < MAX_DIAG_SUBCODES);
> -    assert(!s390_diag500_table[code]);
> -
> -    s390_diag500_table[code] = fn;
> +    if (mem < ram_size) {
> +        /* Tolerate early printk. */

I'm wondering if we still need this. Probably doesn't hurt too much to
keep it around, though.

> +        return 0;
> +    }
> +    return -EINVAL;
>  }
>  

(...)



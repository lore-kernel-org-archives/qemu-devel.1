Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668EEC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FC124658
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeqbXloe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FC124658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46mS-0004uM-Ar
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j46ln-0004PO-HG
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j46lm-0003Y3-Hk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:34:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60726
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j46lm-0003Xh-Di
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582047290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kT2paYm92xFi3d5d5EyqaQmTy/DF99fVEVGy9maaAvk=;
 b=BeqbXloeM6Ban/0EYVr6Ob9mDInOxYeGWRblVTV4LLknR31aBE3Hv7/SbGD8lBR+Cc2QB1
 c1NGmmXVj5e+uWLgo72cBsX79uS3hNGQjiensu/B2QTEnFvP39WjbOIPg0DwmXljB/1+hc
 0nfnajdjqCXmQWv+z8ClTtGztyuFSgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-DFTLOTwqPGqMPYxwHmaYyg-1; Tue, 18 Feb 2020 12:34:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71FAA8026A6;
 Tue, 18 Feb 2020 17:34:46 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 118B7196AE;
 Tue, 18 Feb 2020 17:34:43 +0000 (UTC)
Date: Tue, 18 Feb 2020 18:34:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] Avoid address_space_rw() with a constant is_write
 argument
Message-ID: <20200218183441.0f5c9155.cohuck@redhat.com>
In-Reply-To: <20200218112457.22712-1-peter.maydell@linaro.org>
References: <20200218112457.22712-1-peter.maydell@linaro.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: DFTLOTwqPGqMPYxwHmaYyg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 11:24:57 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> The address_space_rw() function allows either reads or writes
> depending on the is_write argument passed to it; this is useful
> when the direction of the access is determined programmatically
> (as for instance when handling the KVM_EXIT_MMIO exit reason).
> Under the hood it just calls either address_space_write() or
> address_space_read_full().
> 
> We also use it a lot with a constant is_write argument, though,
> which has two issues:
>  * when reading "address_space_rw(..., 1)" this is less
>    immediately clear to the reader as being a write than
>    "address_space_write(...)"
>  * calling address_space_rw() bypasses the optimization
>    in address_space_read() that fast-paths reads of a
>    fixed length
> 
> This commit was produced with the included Coccinelle script
> scripts/coccinelle/as-rw-const.patch.
> 
> Two lines in hw/net/dp8393x.c that Coccinelle produced that
> were over 80 characters were re-wrapped by hand.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I could break this down into separate patches by submaintainer,
> but the patch is not that large and I would argue that it's
> better for the project if we can try to avoid introducing too
> much friction into the process of doing 'safe' tree-wide
> minor refactorings.
> 
> v1->v2: put the coccinelle script in scripts/coccinelle rather
> than just in the commit message.
> ---
>  accel/kvm/kvm-all.c                  |  6 +--
>  dma-helpers.c                        |  4 +-
>  exec.c                               |  4 +-
>  hw/dma/xlnx-zdma.c                   | 11 ++---
>  hw/net/dp8393x.c                     | 68 ++++++++++++++--------------
>  hw/net/i82596.c                      | 25 +++++-----
>  hw/net/lasi_i82596.c                 |  5 +-
>  hw/ppc/pnv_lpc.c                     |  8 ++--
>  hw/s390x/css.c                       | 12 ++---

s390 part:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

>  qtest.c                              | 52 ++++++++++-----------
>  target/i386/hvf/x86_mmu.c            | 12 ++---
>  scripts/coccinelle/as_rw_const.cocci | 30 ++++++++++++
>  12 files changed, 133 insertions(+), 104 deletions(-)
>  create mode 100644 scripts/coccinelle/as_rw_const.cocci



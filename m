Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B421C3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 09:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DE320989
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 09:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DE320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzeFW-00073y-Vb
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 05:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1hzeE7-0006MO-9d
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hzeE6-0000EL-6K
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:45:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hzeE6-0000Dh-0M; Mon, 19 Aug 2019 05:45:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 146B730084AE;
 Mon, 19 Aug 2019 09:45:21 +0000 (UTC)
Received: from gondolin (unknown [10.36.116.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD73D859BD;
 Mon, 19 Aug 2019 09:45:15 +0000 (UTC)
Date: Mon, 19 Aug 2019 11:45:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190819114513.2864c5e0.cohuck@redhat.com>
In-Reply-To: <20190816084708.602-4-david@redhat.com>
References: <20190816084708.602-1-david@redhat.com>
 <20190816084708.602-4-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 19 Aug 2019 09:45:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/6] s390x/tcg: Rework MMU selection for
 instruction fetches
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
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Aug 2019 10:47:05 +0200
David Hildenbrand <david@redhat.com> wrote:

> Instructions are always fetched from primary address space, except when
> in home address mode. Perform the selection directly in cpu_mmu_index().
> 
> get_mem_index() is only used to perform data access, instructions are
> fetched via cpu_lduw_code(), which translates to cpu_mmu_index(env, true).
> 
> We don't care about restricting the access permissions of the TLB
> entries anymore, as we no longer enter PRIMARY entries into the
> SECONDARY MMU. Cleanup related code a bit.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h        |  7 +++++++
>  target/s390x/mmu_helper.c | 38 +++++++++++++++-----------------------
>  2 files changed, 22 insertions(+), 23 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


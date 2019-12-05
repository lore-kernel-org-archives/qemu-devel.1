Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF1EC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4884120659
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UttF8Agw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4884120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrGX-0003Ws-ER
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icrFh-0002pU-5x
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icrFb-0000ud-9I
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:33:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icrFa-0000rA-9q
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575552773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwUj1w6e3dOU54HNGh94afT799qhTfQK84VzsE6eX1A=;
 b=UttF8Agw2F06HyPG6r2DSz3x5oc2zoikT9F2FkY1hIKi04YG5THGk/Pwx+wEbYUCPcc4fr
 DVswrFtPqactCjj+0DkJ8y+hanUp5h8PSnulVRyAxydRYUNK2kh4ScHkwOCLurozpD8XLv
 kQQ4PG6xGMIqyAh9Myy2aelcsr5LnAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-Vqi4A7YHP26_ngtoI2Tzlw-1; Thu, 05 Dec 2019 08:32:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1390718A8C82;
 Thu,  5 Dec 2019 13:32:49 +0000 (UTC)
Received: from gondolin (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBFF85D6A5;
 Thu,  5 Dec 2019 13:32:47 +0000 (UTC)
Date: Thu, 5 Dec 2019 14:32:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] s390x: Fix cpu normal reset ri clearing
Message-ID: <20191205143245.1758f574.cohuck@redhat.com>
In-Reply-To: <20191203132813.2734-4-frankja@linux.ibm.com>
References: <20191203132813.2734-1-frankja@linux.ibm.com>
 <20191203132813.2734-4-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Vqi4A7YHP26_ngtoI2Tzlw-1
X-Mimecast-Spam-Score: 0
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  3 Dec 2019 08:28:12 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> As it turns out we need to clear the ri controls and PSW enablement
> bit to be architecture compliant.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu.c | 7 ++++++-
>  target/s390x/cpu.h | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)

Thanks, applied.



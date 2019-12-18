Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82E3C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736B22176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh9ekUR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736B22176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZ7W-0008IR-CR
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ihYRZ-0007tR-AE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ihYRY-0001Qv-7T
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:28:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60323
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ihYRX-0001M2-Vx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576672123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abpb771Ls4PQvTTxdpAOrOXGfp0x2Azjpf5Xis36iwM=;
 b=Gh9ekUR+nbDFz6vdQ+Nn7pfkfXIHbAXsmw92ML+S069Pby1ytQYgx9O0znU20E3S5+IjSI
 xaqJqHvUL9VZ3BTtPdJ+8uw9MYOBpa+T8+yMWEtzaT7YrK8LvHjRXYu+6s/y/+IyOaz2OM
 uBAdSROj1mtQa0WfsvNOlC21nBOBubE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-QXB6fBuKMemAhMl-P6ZOSQ-1; Wed, 18 Dec 2019 07:28:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E864107B007;
 Wed, 18 Dec 2019 12:28:40 +0000 (UTC)
Received: from gondolin (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F044E5C1B0;
 Wed, 18 Dec 2019 12:28:38 +0000 (UTC)
Date: Wed, 18 Dec 2019 13:28:36 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 4/4] pc-bios/s390x: Fix reset psw mask
Message-ID: <20191218132836.6e0c334c.cohuck@redhat.com>
In-Reply-To: <20191203132813.2734-5-frankja@linux.ibm.com>
References: <20191203132813.2734-1-frankja@linux.ibm.com>
 <20191203132813.2734-5-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: QXB6fBuKMemAhMl-P6ZOSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Tue,  3 Dec 2019 08:28:13 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> We need to set the short psw indication bit in the reset psw, as it is
> a short psw.
> 
> fixes: 9629823290 ("pc-bios/s390-ccw: do a subsystem reset before running the guest")
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/jump2ipl.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

FWIW, I'll re-queue this patch (and the bios rebuild) in front of the
short psw fix that exposed the problem, in order to preserve
bisectability.



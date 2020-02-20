Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494DEC11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AC220722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3HlwWNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AC220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4pGh-0002p3-99
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j4pC1-00065J-Rc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j4pC0-0004qh-Fs
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:00:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40949
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j4pC0-0004qE-1f
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582218050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJcu7yzotCqXAIIF1n3chgEH6Bm5wyhOiS4p2lsHnkQ=;
 b=i3HlwWNW4J7T70SjaTBynFgSaJMbL6dCay2jLFoGSVz/uM64gHLbYWwCEv+L1xSB6dId+e
 S5Al9ZHd65LeocaU6QVtRNCA0sREhydXE3zdSgbbtAMefYjS4Hf/Wg2VWczkM9M9qc35No
 /DdGC9unQGmRF9tfzvMCMs2luqJmUJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-E7hkzVT9PMaNOo1k5GKEBw-1; Thu, 20 Feb 2020 12:00:48 -0500
X-MC-Unique: E7hkzVT9PMaNOo1k5GKEBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D8741088382;
 Thu, 20 Feb 2020 17:00:47 +0000 (UTC)
Received: from gondolin (ovpn-205-37.brq.redhat.com [10.40.205.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC52860BE1;
 Thu, 20 Feb 2020 17:00:42 +0000 (UTC)
Date: Thu, 20 Feb 2020 18:00:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] s390/sclp: improve special wait psw logic
Message-ID: <20200220180040.1f69bec8.cohuck@redhat.com>
In-Reply-To: <1582204582-22995-1-git-send-email-borntraeger@de.ibm.com>
References: <1582204582-22995-1-git-send-email-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 14:16:22 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> There is a special quiesce PSW that we check for "shutdown". Otherwise disabled
> wait is detected as "crashed". Architecturally we must only check PSW bits
> 116-127. Fix this.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied.



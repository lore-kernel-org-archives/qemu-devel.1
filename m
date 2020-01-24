Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394D4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F4E2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHmlxVpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F4E2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuzvO-0006Nx-8V
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 09:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iuzu7-0005OQ-BT
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iuzu6-0004ej-D4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:25:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45301
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iuzu6-0004e2-90
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579875945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWjkVvVFvxGYfVy+RfRjkwfRnja4EIbbDdyIuIu/FF0=;
 b=QHmlxVpDiFEUj/LQOUWpD9CUSiGrGT+Rri6ia1qTGBq/ETczCNxhpNfastk+0XvzCsvTHf
 wFaJq/eyBuCMynIJPhfdfzdqKq3V+0TihUpNnFcvf2AkKt3qyyg5sHthcgHPoS5bPVbLBd
 h9jryPjogOVFjuIgfJhbOpTTlk0nJ+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-SPDaBzSQNIGRPL5rMITlpg-1; Fri, 24 Jan 2020 09:25:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A81D710054E3;
 Fri, 24 Jan 2020 14:25:42 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E20BF1001B0B;
 Fri, 24 Jan 2020 14:25:41 +0000 (UTC)
Date: Fri, 24 Jan 2020 15:25:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] target/s390x: Do not leak stack address in
 translate_one
Message-ID: <20200124152540.36e5b69d.cohuck@redhat.com>
In-Reply-To: <20200123232248.1800-1-richard.henderson@linaro.org>
References: <20200123232248.1800-1-richard.henderson@linaro.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: SPDaBzSQNIGRPL5rMITlpg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-s390x@nongnu.org, thuth@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 13:22:43 -1000
Richard Henderson <richard.henderson@linaro.org> wrote:

> Thomas' patch avoids the leak, but I think we can do a bit more to
> cleaning in this area, and move the structure inline to DisasContext.
> 
> 
> r~
> 
> 
> Richard Henderson (5):
>   target/s390x: Move struct DisasFields definition earlier
>   target/s390x: Remove DisasFields argument from callbacks
>   target/s390x: Pass DisasContext to get_field and have_field
>   target/s390x: Move DisasFields into DisasContext
>   target/s390x: Remove DisasFields argument from extract_insn
> 
>  target/s390x/translate.c        | 982 ++++++++++++++++----------------
>  target/s390x/translate_vx.inc.c | 649 +++++++++++----------
>  2 files changed, 813 insertions(+), 818 deletions(-)
> 

Thanks, applied.



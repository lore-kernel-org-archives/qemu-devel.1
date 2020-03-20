Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F87CC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D8120722
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EP/ayn8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D8120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLPO-0004ac-GT
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jFLOm-00049i-GA
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jFLOl-0001FA-HA
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:25:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jFLOl-0001F2-EG
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584725131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/UulfTDATDKmuiYYGHDqEMixfJD+JrIQ5gT+09FhOPc=;
 b=EP/ayn8icKepm6ATuHLezKaYkJ8xm6YBdGX6//WZTFV372nHxiyQc2i5oI2E7B3y/IqL1P
 PtpclHDPBUvodRyobL4rDxyI60I++hTUso3I+jUBJ8wDKuPw9S5TK6L2VSwYu7/ESPNph9
 Z1AmAHk8SQC8l0ONUHOMDODC4+QJY6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-uqLU-QsUP9GsZr3pCcadiQ-1; Fri, 20 Mar 2020 13:25:27 -0400
X-MC-Unique: uqLU-QsUP9GsZr3pCcadiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FD6F107ACC4;
 Fri, 20 Mar 2020 17:25:26 +0000 (UTC)
Received: from gondolin (ovpn-113-89.ams2.redhat.com [10.36.113.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D017CBBBEE;
 Fri, 20 Mar 2020 17:25:21 +0000 (UTC)
Date: Fri, 20 Mar 2020 18:25:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/ipl: fix off-by-one in
 update_machine_ipl_properties()
Message-ID: <20200320182518.69bbb053.cohuck@redhat.com>
In-Reply-To: <20200320143101.41764-1-pasic@linux.ibm.com>
References: <20200320143101.41764-1-pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 15:31:01 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> In update_machine_ipl_properties() the array ascii_loadparm needs to
> hold the 8 char lodparm and a string terminating zero char.

s/lodparm/loadparm/

> Let's increase the size of ascii_loadparm accordingly.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 0a01e082a4 ("s390/ipl: sync back loadparm")

Fixes: Coverity CID 1421966

> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/s390x/ipl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index b81942e1e6..8c3e019571 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -546,7 +546,7 @@ static void update_machine_ipl_properties(IplParameterBlock *iplb)
>      /* Sync loadparm */
>      if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
>          uint8_t *ebcdic_loadparm = iplb->loadparm;
> -        char ascii_loadparm[8];
> +        char ascii_loadparm[9];
>          int i;
>  
>          for (i = 0; i < 8 && ebcdic_loadparm[i]; i++) {
> 
> base-commit: 226cd20706e20264c176f8edbaf17d7c9b7ade4a

Thanks, queued to s390-fixes.



Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE36C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888FA207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="didgtAM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888FA207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEau-0001Vh-Ij
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iZEYU-0008Vz-3C
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iZEYT-00078W-3X
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:37:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53759
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iZEYT-000786-0S
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574689048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7/W305eeFsJvnPRXC8LMg09/tn/wN8/+/3OX3cK9XA=;
 b=didgtAM3DyZjfHPpTsV7gm2rkDdeZiPEW6HZc2jOVb5m8GnAmi+Jm3cKrxoWIgJXebYOK4
 dU8scqG2F/JDR8Mz3kMBAG2Vk/H7z6vrvP9wb9WJGOm5nxUrq8vVPVqoj0l5cz5HUyR1qx
 O8TniJ5ing2BlxxkwyzPRBPTi9g9Bcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-K06j2G0-N3Cx1a1-rcaCVg-1; Mon, 25 Nov 2019 08:37:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5457F107BA98;
 Mon, 25 Nov 2019 13:37:23 +0000 (UTC)
Received: from gondolin (ovpn-116-165.ams2.redhat.com [10.36.116.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFAFD100EBA6;
 Mon, 25 Nov 2019 13:37:17 +0000 (UTC)
Date: Mon, 25 Nov 2019 14:37:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 4/5] s390x: Move clear reset
Message-ID: <20191125143714.1c7c5937.cohuck@redhat.com>
In-Reply-To: <20191125090348.27010-5-frankja@linux.ibm.com>
References: <20191125090348.27010-1-frankja@linux.ibm.com>
 <20191125090348.27010-5-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: K06j2G0-N3Cx1a1-rcaCVg-1
X-Mimecast-Spam-Score: 0
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 Nov 2019 04:03:47 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's also move the clear reset function into the reset handler.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/cpu-qom.h |  1 +
>  target/s390x/cpu.c     | 58 +++++++++++++-----------------------------
>  2 files changed, 18 insertions(+), 41 deletions(-)
> 

> @@ -453,6 +424,11 @@ static Property s390x_cpu_properties[] = {
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> +static void s390_cpu_reset_clear(CPUState *s)
> +{
> +    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
> +}
> +
>  static void s390_cpu_class_init(ObjectClass *oc, void *data)
>  {
>      S390CPUClass *scc = S390_CPU_CLASS(oc);
> @@ -469,7 +445,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>      scc->load_normal = s390_cpu_load_normal;
>  #endif
>      scc->reset = s390_cpu_reset;
> -    cc->reset = s390_cpu_full_reset;
> +    cc->reset = s390_cpu_reset_clear;
>      cc->class_by_name = s390_cpu_class_by_name,
>      cc->has_work = s390_cpu_has_work;
>  #ifdef CONFIG_TCG

One thing I liked about the previous naming is that it is more obvious
that the clear reset is actually the full reset of a cpu. Not sure if
keeping that is better than matching the function name to the name of
the reset being performed. Opinions?



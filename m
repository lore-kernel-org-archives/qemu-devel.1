Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10FEC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95FB206F6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDxosWrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95FB206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJyc8-0005jE-TO
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jJybY-0005JE-1y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jJybX-0002Y2-3o
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:05:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56980
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jJybX-0002Xl-0z
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585829150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RX1EbGT+3j5RwG+yQvfnFDndaPpuqo9yu+PLsw4+35s=;
 b=fDxosWrEDrEmndhAbj6iOwJ1bRFMGJg/VbqByeT4pNEtEOU8Pp24TWqw8UL4Og1xu+LAF8
 H8U+GfIKOoim7YRMR4ojLJGR98roU+6dC4WEcfvfEiw3cwjchvGSHCMIvqM4PI/cqWfibC
 hclgvY7bGXNhe35AyA3IP9p3vNLaDW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Ts3wV5rjPuicYRJjLGT4gg-1; Thu, 02 Apr 2020 08:05:47 -0400
X-MC-Unique: Ts3wV5rjPuicYRJjLGT4gg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF57B18A8C80;
 Thu,  2 Apr 2020 12:05:45 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD7F55D9CA;
 Thu,  2 Apr 2020 12:05:38 +0000 (UTC)
Date: Thu, 2 Apr 2020 14:05:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 1/1] vl/s390x: fixup ram sizes for compat machines
Message-ID: <20200402140536.1b9e7c41@redhat.com>
In-Reply-To: <e3dfecd4-2905-dc8b-92e7-2194a52ea9ea@de.ibm.com>
References: <20200401123754.109602-1-borntraeger@de.ibm.com>
 <20200401183456.09ba3540@redhat.com>
 <20200402112735.6961297d.cohuck@redhat.com>
 <20200402133958.72fabf45@redhat.com>
 <e3dfecd4-2905-dc8b-92e7-2194a52ea9ea@de.ibm.com>
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
Cc: =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 13:42:22 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02.04.20 13:39, Igor Mammedov wrote:
> [...]
> >>>     
> >>>> +                    "MB to match machine restrictions. Consider updating "
> >>>> +                    "the guest definition.i\n", sz / MiB, newsz / MiB);      
> >>>
> >>> also it might be better to use size_to_str() to format numbers    
> >>
> >> The text explicitly talks about 'MB'... not sure if it would be
> >> confusing if the user specified MB and ended up with GB or so in this
> >> message.  
> > 
> > MB can be dropped, since it still might not match what user specified with -m
> > it could be specified in b/kb/mb/gb over there
> > 
> > so I'd drop MB and print value size_to_str() returns
> > (it will add appropriate suffix if I'm not mistaken)
> >   
> 
> The return value of size_to_str must be freed. Arent we going overboard for such
> a message?

yep, one can use g_autofree for it.
on upside one doesn't have to bother with picking proper format string
which is far from trivial in case type mutates depending on host.

> 



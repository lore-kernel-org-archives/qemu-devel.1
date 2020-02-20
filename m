Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13637C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D117F208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqrB1h2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D117F208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ogj-0008A1-WD
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j4og6-0007Vb-Iv
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j4og5-0002Sv-Iv
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:27:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j4og5-0002SU-F4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582216072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMOfplasy9bWpmsu9ktdRgJq97DDxZOs1VLc3528ngQ=;
 b=GqrB1h2BVYWGV230t18dFK/1Da+PQIiKqf8mQGp9EEKlbXmRaGOACcW1fMjXJ6u8+p/NZO
 0fgvC5/5KD3YInoKk1IuiTsh7h1yhuRxzcbGtDe6PrOuvwJ48jWTH2lLuk+6gqsOAp0aaN
 oNuqGQq0VL/iYfQSwdcWe8jtvmy7ANg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-DPsGEQLrOwuPp9XT-tRxDg-1; Thu, 20 Feb 2020 11:27:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15A7B801E7A;
 Thu, 20 Feb 2020 16:27:49 +0000 (UTC)
Received: from gondolin (ovpn-205-37.brq.redhat.com [10.40.205.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CACE677935;
 Thu, 20 Feb 2020 16:27:44 +0000 (UTC)
Date: Thu, 20 Feb 2020 17:27:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] s390/sclp: improve special wait psw logic
Message-ID: <20200220172728.05992077.cohuck@redhat.com>
In-Reply-To: <a28b2eb0-8436-ff4e-c1f2-943ca6cd7443@de.ibm.com>
References: <1582204582-22995-1-git-send-email-borntraeger@de.ibm.com>
 <7b3478cc-7d74-49af-dfad-bd0349371517@redhat.com>
 <a28b2eb0-8436-ff4e-c1f2-943ca6cd7443@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: DPsGEQLrOwuPp9XT-tRxDg-1
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
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 14:35:01 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 20.02.20 14:26, David Hildenbrand wrote:
> > On 20.02.20 14:16, Christian Borntraeger wrote:  
> >> There is a special quiesce PSW that we check for "shutdown". Otherwise disabled
> >> wait is detected as "crashed". Architecturally we must only check PSW bits
> >> 116-127. Fix this.
> >>
> >> Cc: qemu-stable@nongnu.org  
> > 
> > Is this really stable material?  
> 
> Guests that end with lets say 0xaafffUL would be considered "crashed" instead of "shutdown".
> I will let Conny decide. 

It cannot really hurt; but would be interesting if you have seen that
in the wild.

> > 
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> >   
> 



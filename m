Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555CEC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C702206F8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4fEAZma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C702206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJcCQ-0008IK-5y
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 08:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJcBl-0007rE-5s
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJcBk-0007l6-2u
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:09:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21143
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJcBj-0007kn-Vp
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585742983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n66h5IWoyATia74PAZImhgGWGuOlF2dZQdhFJdyj7Pg=;
 b=B4fEAZma0InpLIT9g5GtJhaRC6ZoYyWPOeW5vvQknQDMRmGfoG6KYziOgbpfb1vdNrh/0d
 OiF92oRhtY21mZL+JMARAn1T2ZXNZqxokRRLH+rBL2iRro9noim95XaxgDSovjO7vCqCAY
 DBgp/NKXeQplPGSC5YdUYaaFGnxr9x0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-avxUT0iVMuu0mv-XpzrBXA-1; Wed, 01 Apr 2020 08:08:06 -0400
X-MC-Unique: avxUT0iVMuu0mv-XpzrBXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C95B2F61;
 Wed,  1 Apr 2020 12:08:05 +0000 (UTC)
Received: from gondolin (ovpn-112-252.ams2.redhat.com [10.36.112.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 897ECDA105;
 Wed,  1 Apr 2020 12:07:58 +0000 (UTC)
Date: Wed, 1 Apr 2020 14:07:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] vl/s390: fixup ram sizes for compat machines
Message-ID: <20200401140755.59d233ad.cohuck@redhat.com>
In-Reply-To: <ece23eb1-e977-55d8-ab7b-713f4af662ba@redhat.com>
References: <20200401085014.100125-1-borntraeger@de.ibm.com>
 <da218b9e-1551-08c5-86e4-9f9837901974@redhat.com>
 <5f3f603e-6e1e-d157-554c-219e63fb438c@de.ibm.com>
 <ece23eb1-e977-55d8-ab7b-713f4af662ba@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: =?UTF-8?B?THVr?= =?UTF-8?B?w6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Apr 2020 14:04:17 +0200
David Hildenbrand <david@redhat.com> wrote:

> > something like
> > 
> >     while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
> >         increment_size++;
> >     }
> >     newsz = sz >> increment_size << increment_size;
> >     
> >     if (sz != newsz) {
> >         qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64  
> 
> Maybe warn_report()

The _report() functions prescribe using just a single sentence without
trailing period, though. The only real difference is whether the
message goes to stderr or stdout in absence of a monitor.

> 
> >                     "MB to match machine restrictions. Consider updating "
> >                     "the guest definition.\n",
> >                     sz / MiB, newsz / MiB);  
> 
> might be able to squeeze that into the previous line.
> 
> >     }
> >     return newsz;
> > 
> > ?  
> 
> Much better.

Seconded :)



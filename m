Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73D9C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE31206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoHibI/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE31206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJbKI-0006BL-Lv
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 07:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJbJF-0005Gf-7G
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJbJD-00007x-M3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:13:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJbJD-00007G-CJ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585739602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ez95WzjdwCLqrjXyuHkHO3HL1ZExDT6b4tUuMMLb/3I=;
 b=PoHibI/Mj62qOyQDA3Ft0TnBbBK2nnB7yfwDp7OL0Xs/CXtywi+GlivAkA3Xp3W49QrFm6
 aS25AhqBxRtXPRlzs2VUibJkwoNFXig2w5/djVhTA4W9YIuf2v8dhqXH+IU7I05/FZEIJ+
 wRgtvqMOtJzBdXTsaGxoQd0Ut+wrgSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-_As59BF8O1i9Ne79cyNDBw-1; Wed, 01 Apr 2020 07:13:20 -0400
X-MC-Unique: _As59BF8O1i9Ne79cyNDBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3F99800D4E;
 Wed,  1 Apr 2020 11:13:19 +0000 (UTC)
Received: from gondolin (ovpn-112-252.ams2.redhat.com [10.36.112.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C8BC60BE2;
 Wed,  1 Apr 2020 11:13:14 +0000 (UTC)
Date: Wed, 1 Apr 2020 13:12:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] vl/s390: fixup ram sizes for compat machines
Message-ID: <20200401131243.14125f37.cohuck@redhat.com>
In-Reply-To: <9f64cfb4-df6d-f43e-034c-f4e18a372e06@de.ibm.com>
References: <20200401085014.100125-1-borntraeger@de.ibm.com>
 <20200401121324.379cfd0d.cohuck@redhat.com>
 <9f64cfb4-df6d-f43e-034c-f4e18a372e06@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: =?UTF-8?B?THVr?= =?UTF-8?B?w6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Apr 2020 13:01:43 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 01.04.20 12:13, Cornelia Huck wrote:
> > On Wed,  1 Apr 2020 04:50:14 -0400
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> Older QEMU versions did fixup the ram size to match what can be reported
> >> via sclp. We need to mimic this behaviour for machine types 4.2 and
> >> older to not fail on inbound migration for memory sizes that do not fit.
> >> Old machines with proper aligned memory sizes are not affected.
> >>
> >> Alignment table:
> >>  VM size (<=) | Alignment
> >> --------------------------
> >>       1020M   |     1M
> >>       2040M   |     2M
> >>       4080M   |     4M
> >>       8160M   |     8M
> >>      16320M   |    16M
> >>      32640M   |    32M
> >>      65280M   |    64M
> >>     130560M   |   128M
> >>     261120M   |   256M
> >>     522240M   |   512M
> >>    1044480M   |     1G
> >>    2088960M   |     2G
> >>    4177920M   |     4G
> >>    8355840M   |     8G
> >>
> >> Suggested action is to replace unaligned -m value with a suitable  
> > 
> > "to replace any unaligned -m value" ?
> >   
> >> aligned one or to use a machine version >= 5.0 as future versions might
> >> remove the compatibility handling.  
> > 
> > I'm confused by the second part of the sentence. Warning about possible
> > future removal of the compat stuff is fine, but I don't understand the
> > suggestion to use a machine type >= 5.0. If I create a new machine that
> > does not need be migrated to an old QEMU, using the latest machine type
> > always seems like the best idea, right? And for a migration target it's
> > not like we can choose the version freely anyway.  
> 
> 
> My point was that - when you redefine your guest, which is disruptive anyway
> you could also change the machine version to 5.0 and keep the strange memory
> size.

Ah, ok. That depends however on whether you still need compatibility,
so it might not be advisable. What about:

"...or to switch to a machine version >= 5.0 if migration to older
machine types is not needed; future versions might remove the
compatibility handling."

?



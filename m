Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC35AC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 18:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BE9206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 18:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQArnO7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BE9206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1vu-0001oN-PQ
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 14:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jW1oo-0000uM-V4
 for qemu-devel@nongnu.org; Tue, 05 May 2020 13:57:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jW1om-0003np-OO
 for qemu-devel@nongnu.org; Tue, 05 May 2020 13:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588701439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eNY8el9ncDJRCMXBdMRDoIob91TuSjzv4+0n3/W4wc=;
 b=QQArnO7ND7L+MA12alq+2jfDNnhOSj4OVQziCu2XCkx2f0CLcnnJ9kIgqMj59YNpYHr2H8
 Z42apJCfpj5DJYrZAu+FSIWxFum+pfGtPzHyAler/ADXW8Agne0TBky5GON1GF4wyDz4ut
 ZQ6Ku5AbhCi8c6fz3cmuFdtnQSmohRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-RJLhLElHOxK9gl0pG3h9Rw-1; Tue, 05 May 2020 13:57:17 -0400
X-MC-Unique: RJLhLElHOxK9gl0pG3h9Rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75F8C805C24;
 Tue,  5 May 2020 17:57:12 +0000 (UTC)
Received: from work-vm (ovpn-114-183.ams2.redhat.com [10.36.114.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0BE319C4F;
 Tue,  5 May 2020 17:57:11 +0000 (UTC)
Date: Tue, 5 May 2020 18:57:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Florian Schmidt <flosch@nutanix.com>
Subject: Re: Postcopy with different page sizes on source and destination
Message-ID: <20200505175709.GB2813@work-vm>
References: <3fd5a3b0-5b1c-e123-b3d7-e8f91e3871c1@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <3fd5a3b0-5b1c-e123-b3d7-e8f91e3871c1@nutanix.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Florian Schmidt (flosch@nutanix.com) wrote:
> Hi,

Hi Florian,

> with precopy live migration, change in page size on source and=20
> destination is possible: using hugetlbfs memory backing for the VM on=20
> the source and anonymous memory on the destination, and vice versa. For=
=20
> postcopy migration, this is not allowed, and in fact checked during the=
=20
> advise stage.
>=20
> Is there any fundamental limitation in the design that prevents this, or=
=20
> is it more that this is an additional complication that nobody has=20
> implemented so far because there was no strong need for it?
>=20
> It seems to me like this should be possible, and the comment in=20
> loadvm_postcopy_handle_advise() (migration/savevm.c:1681) also seems to=
=20
> suggest that; so I'll add a (very rough) first idea.

Yeh it was getting hairy enough at the time, so I kept that restriction.
Now let me just reload that from my brain from 3 years or so back....

> Please tell me if=20
> I'm missing something important. The "background" copy is similar to=20
> precopy, so the main difference is the userfaultfd page fault handling=20
> on the destination, and requesting the correct memory from the source.

Right.

> 1. If the source has hugepages and the destination doesn't, then a page=
=20
> fault would lead the destination to ask "I need these 4k of memory from=
=20
> you to fill my page and handle the page fault". The source could then=20
> answer "here you are, and here are these other 511 4k pages around it=20
> (which form my 2M page; similarly for 1G pages), please deal with them=20
> now". That way, even "release-ram" would still work on a (huge)page=20
> granularity.

Yeh I think that's about right; you might have to watch out for cases
where the RAMBlock sizes are different because they've got rounded.

> 2. If the destination has hugepages and the source doesn't, then the=20
> above works similarly: now the destination, on a page fault, asks for a=
=20
> larger memory area that corresponds to 512 (or more) pages on the=20
> source. The only issue I could see here is during the initial phase,=20
> when postcopy is switched on, to make sure that the source doesn't=20
> release RAM that it has copied and thinks is clean, but it part of a=20
> hugepage on the other side. That seems easy enough to solve though? And=
=20
> indeed is probably already implemented for precopy migration to work=20
> with different page sizes on source and destination and could be adapted=
=20
> here.

Precopy doesn't have to worry about it because it doesn't have to clear
out previously partially sent pages.

You'd have a situation where the source things page p+8k is dirty so
sends a discard for that; the destination can't do that - so what does
it do?  You need to get the source to discard on the largest granularity
of source and destination.

The other problem you have here is making sure that the source really
does send all the pages continuously starting from the right point so
that they all end up in one chunk on the destination and it can perform
a place;  for example imagine the source is doing a background
page transfer and is currently at x+1MB,  now it gets a request
from the destination for page y, so it switches to transmitting 'y'
which given the destinations request it will probably transfer
the whole of y - but x was partially transmitted which means
x won't have got placed on the destination.  I'd also worry about
whether the code on the source is OK if it gets a request for 'z'
while it's sending y, but it's probably ok because it has the
counter.

(I'm not sure if there are any changes needed in postcopy recovery -
that was more recent).

Note it's not just hugepages either; you get aarch and power systems
that can have configurable base page sizes, but it's rare to mix
them.

Dave

> Cheers,
> Florian
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



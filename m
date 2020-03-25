Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EABC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959E2206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccn5gYTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959E2206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHABm-00042q-PC
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jHA9R-0001ib-3a
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jHA9P-0004LJ-T6
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:49:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47479)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jHA9P-0004Ko-Pj
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585158550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlzp+LwBwOL5c66PqiJVr8LJWG9KFvUKUfDUUSPkvqY=;
 b=ccn5gYTsf5lGm7lvSeXz98Zi+e9pVDr4fOxQaAeXG3UoQUPJWskaC8lOeQ9j4RjS15br+x
 TrU5EDaB08n2qMBC7WIgwUjM6sc/o5tJb3CHvNNPjHcw5NXDdvEmcgAWLZCGICRRdlkgTI
 ON4cfKJKtmw/2+xyjO9aNntlLl80pes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-i_pnjWI7OL-bG5GlBe8plw-1; Wed, 25 Mar 2020 13:49:06 -0400
X-MC-Unique: i_pnjWI7OL-bG5GlBe8plw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A64D477;
 Wed, 25 Mar 2020 17:49:05 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-184.ams2.redhat.com [10.36.113.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 593AD6266E;
 Wed, 25 Mar 2020 17:49:04 +0000 (UTC)
Date: Wed, 25 Mar 2020 18:49:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: Re: [PATCH 0/2] mirror: Fix hang (operation waiting for
 itself/circular dependency)
Message-ID: <20200325174902.GC6756@linux.fritz.box>
References: <20200325172326.22347-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200325172326.22347-1-kwolf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.03.2020 um 18:23 hat Kevin Wolf geschrieben:
> The recent fix didn't actually fix the whole problem. Operations can't
> only wait for themselves, but we can also end up with circular
> dependencies like two operations waiting for each other to complete.
>=20
> This reverts the first fix and implements another approach.

Hm, somehow this seems to break iotests 151. I don't actually understand
the backtrace, because that's during job initialisation, so my changes
shouldn't have had any effect yet:

(gdb) bt
#0  0x00007fba6d85057f in raise () at /lib64/libc.so.6
#1  0x00007fba6d83a895 in abort () at /lib64/libc.so.6
#2  0x00005624d94d109a in bitmap_new (nbits=3D<optimized out>) at /home/kwo=
lf/source/qemu/include/qemu/bitmap.h:103
#3  0x00005624d94d109a in mirror_run (job=3D0x5624dc8d5560, errp=3D<optimiz=
ed out>) at block/mirror.c:922
#4  0x00005624d988053f in job_co_entry (opaque=3D0x5624dc8d5560) at job.c:8=
78
#5  0x00005624d998d3bb in coroutine_trampoline (i0=3D<optimized out>, i1=3D=
<optimized out>) at util/coroutine-ucontext.c:115
#6  0x00007fba6d866250 in __start_context () at /lib64/libc.so.6
#7  0x00007fffa2d48130 in  ()
#8  0x0000000000000000 in  ()

Something to check tomorrow.

Kevin



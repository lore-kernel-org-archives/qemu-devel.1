Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6803DC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231C621739
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqg/E/yE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231C621739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaOGq-0001Kk-9d
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 13:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iaNbi-0005nS-Nv
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iaNZV-0001LT-32
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:27:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42529
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iaNZT-0000zn-TV
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574962031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cgVnLUgiCFWWYevJL6RI6jgL8ZpkDIbo4upP8Mrwbxw=;
 b=eqg/E/yELrm3iDULC5s1pwm87S5E5Jk9OGUflcuqRHRVq6Q1W5JTDu4jUtRX0XzosVinBc
 NNytfdKa0r+60G++H4fQkhw+HaUEK01L1V4zOexxxCJ1aWXDdhuE4/xNY9VIZCvILC4Ma/
 5DP9n+Q/UaOrhKo0DhOtguh0y0tIBS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-azWAE_5DNWilyUsUG1hmcg-1; Thu, 28 Nov 2019 12:27:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C858180A3E0;
 Thu, 28 Nov 2019 17:27:07 +0000 (UTC)
Received: from gondolin (ovpn-116-200.ams2.redhat.com [10.36.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D42445D6D0;
 Thu, 28 Nov 2019 17:27:02 +0000 (UTC)
Date: Thu, 28 Nov 2019 18:27:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 2/6] s390x: Move reset normal to shared reset handler
Message-ID: <20191128182700.3bf9f90a.cohuck@redhat.com>
In-Reply-To: <66f79294-ab07-356c-ad69-addb591dbd82@redhat.com>
References: <20191127175046.4911-1-frankja@linux.ibm.com>
 <20191127175046.4911-3-frankja@linux.ibm.com>
 <66f79294-ab07-356c-ad69-addb591dbd82@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: azWAE_5DNWilyUsUG1hmcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Janosch Frank <frankja@linux.ibm.com>, pmorel@linux.ibm.com,
 david@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 07:32:53 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 27/11/2019 18.50, Janosch Frank wrote:
> > Let's start moving the cpu reset functions into a single function with
> > a switch/case, so we can use fallthroughs and share more code between
> > resets.  
> 
> Nit: I'd add a "later" in above sentence, since you don't use 
> fallthroughs yet.

If nobody objects, I can apply this with the sentence changed to "so we
can later use...".

> 
> > This patch introduces the reset function by renaming cpu_reset() and
> > cleaning up leftovers.  
> 
> Hmm, which leftovers? I can mainly see the renaming here...

That's probably a leftover from before splitting the original patch in
three... I can drop the leftover part when applying :)

> 
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > ---
> >   target/s390x/cpu-qom.h |  6 +++++-
> >   target/s390x/cpu.c     | 19 +++++++++++++------
> >   target/s390x/cpu.h     |  2 +-
> >   target/s390x/sigp.c    |  2 +-
> >   4 files changed, 20 insertions(+), 9 deletions(-)  
> 
> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>



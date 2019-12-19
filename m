Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AEFC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4121C24650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICDo17L2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4121C24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihyHe-0000eE-7c
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihyFT-0007BK-1t
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihyFO-00086s-7e
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:01:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihyFO-00084e-1x
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576771313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ph5lsHGMNbtJBIXk7q2Wb32H4M7F7M1kM4HM7jrTvdY=;
 b=ICDo17L2bQrw/onEONoAmCmJflP8jXv7LqvkQaTUNUO4XuzZjzRJgWtzloaMcNnVjb1OqC
 TyE9ym+OUELvyzKgSIqO+wMy4t7PXr6LdeLebVcUAXIGKlpoWJgY5UBtrrOjPcH01e8tqP
 YSZwQtWrQoj7+zAsqS/ZIUfIVKszsYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-_xWgWom-N7G5lEN4CzWVCw-1; Thu, 19 Dec 2019 11:01:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49F448D66CD;
 Thu, 19 Dec 2019 16:01:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 182021CB;
 Thu, 19 Dec 2019 16:01:46 +0000 (UTC)
Date: Thu, 19 Dec 2019 17:01:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH] iotests.py: Wait for postmigrate in wait_migration
Message-ID: <20191219160143.GO5230@linux.fritz.box>
References: <20191219155137.2431986-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219155137.2431986-1-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _xWgWom-N7G5lEN4CzWVCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.12.2019 um 16:51 hat Max Reitz geschrieben:
> Without this patch, I see intermittent failures in the new iotest 280
> under high system load.  I have not yet seen such failures with other
> iotests that use VM.wait_migration() and query-status afterwards, but
> maybe they just occur even more rarely.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to the block branch.

Kevin



Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00B6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAE1208D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3nCIOrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAE1208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX1Ax-00074y-Cz
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iX19R-0006db-MM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iX19Q-0004BG-Ak
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:54:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35751
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iX19Q-0004AW-73
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574160867;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAy8hXmx5UPyFrqlqj2H0vBEAx3bpA/x9mzRdJHumOw=;
 b=c3nCIOrmcnA2+Su9BlMkJWIqlTXMoSRJhrmIJVV4nly/pEoo6D6BImgaM95w3qdzMgswDa
 ZGrD5mi2qfqtjI+lnjLGHzVlL/KXjvxeoWvAZEYpHIeslxAzF1/zozMt1n0lvygX3TMKSE
 wLz+djghtJC04UPvyXfhgi11ykMrT70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-JqNMgN6fPD63xEXzEZ8v9g-1; Tue, 19 Nov 2019 05:54:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD08B801FA1;
 Tue, 19 Nov 2019 10:54:22 +0000 (UTC)
Received: from redhat.com (ovpn-116-161.ams2.redhat.com [10.36.116.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31BAE4D701;
 Tue, 19 Nov 2019 10:54:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 1/2] migration/multifd: clean pages after filling packet
In-Reply-To: <20191025232000.25857-2-richardw.yang@linux.intel.com> (Wei
 Yang's message of "Sat, 26 Oct 2019 07:19:59 +0800")
References: <20191025232000.25857-1-richardw.yang@linux.intel.com>
 <20191025232000.25857-2-richardw.yang@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 19 Nov 2019 11:54:19 +0100
Message-ID: <87h830gmqs.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: JqNMgN6fPD63xEXzEZ8v9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richardw.yang@linux.intel.com> wrote:
> This is a preparation for the next patch:
>
>     not use multifd during postcopy.
>
> Without enabling postcopy, everything looks good. While after enabling
> postcopy, migration may fail even not use multifd during postcopy. The
> reason is the pages is not properly cleared and *old* target page will
> continue to be transferred.
>
> After clean pages, migration succeeds.
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I don't like asserts, but I understand why you put them there.



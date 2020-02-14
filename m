Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2B8C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F5020675
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FX9H/yOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F5020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2aFC-0004rb-AA
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 07:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2aEN-0004K0-8E
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2aEM-0001Vu-Ap
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:38:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43482
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2aEM-0001Pj-6R
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581683881;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+W9txIdLoOWr6vncr5tz07ls1P8lsw8pGo5wlUeuoNA=;
 b=FX9H/yOPV9bj/utV5/TeQL5zClAJUbeRmEqXDRpPdD4xLcrbX/nbxuTHKhiHWxUg7vzerT
 DZR6X6eArUNnieDUDiYpb5XuSGtfb14f8c21uktAXbIVH1NNE/OzjIJRImmH1eCpY2KXJP
 WcjBNGAXm+5dmkXbCWt9TwdpY9pvKmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-fx-gXt9PNJ6KGX-SnriOww-1; Fri, 14 Feb 2020 07:37:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E72D38010E9;
 Fri, 14 Feb 2020 12:37:57 +0000 (UTC)
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C4D6863D2;
 Fri, 14 Feb 2020 12:37:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH] migration/throttle: Make throttle slower at tail stage
In-Reply-To: <20200214032700.25011-1-zhukeqian1@huawei.com> (Keqian Zhu's
 message of "Fri, 14 Feb 2020 11:27:00 +0800")
References: <20200214032700.25011-1-zhukeqian1@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 14 Feb 2020 13:37:53 +0100
Message-ID: <87o8u1gx9a.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: fx-gXt9PNJ6KGX-SnriOww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, wanghaibin.wang@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keqian Zhu <zhukeqian1@huawei.com> wrote:
> At the tail stage of throttle, VM is very sensitive to
> CPU percentage. We just throttle 30% of remaining CPU
> when throttle is more than 80 percentage.

Why?

If we really think that this is better that current approarch, just do
this _always_.  And throothre 30% of remaining CPU.  So we go:

30%
30% + 0.3(70%)
...

Or anything else.

My experience is:
- you really need to go to very high throothle to make migration happens
  (more than 70% or so usually).
- The way that we throotle is not completely exact.

> This doesn't conflict with cpu_throttle_increment.
>
> This may make migration time longer, and is disabled
> by default.


What do you think?
I think that it is better to change method and improve documentation
that yet adding another parameter.

Later, Juan.



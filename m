Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58927C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 10:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D53824125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 10:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gr3sxQXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D53824125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuZhB-0001EL-4K
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 05:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iuZgU-0000mK-RW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iuZgS-0003jJ-Ly
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:25:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iuZgS-0003ix-IH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579775156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0DDGT/l2iXOeQW71dBnd4eP+HdKmgJP5yhUXbMBTG0=;
 b=gr3sxQXbvSTTcj7jNrG7v36wgo1sEbjlPcJ05xoDR3lSd/d4HWZkCXi8dsdr6Q+l0ybRap
 PYXF4KNhsJiHDhNmFc3Yvo+X4uqjw3aTvPRNop2mQWpM40HEUL06MhuZyRgABjxu9bsyog
 kVgMXIxMgZ4tTpfPJbBP3Rjz6VnN0WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-CsOQRTpRNQi34c3eSTA5oA-1; Thu, 23 Jan 2020 05:25:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EB7A800D41;
 Thu, 23 Jan 2020 10:25:51 +0000 (UTC)
Received: from gondolin (ovpn-116-120.ams2.redhat.com [10.36.116.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6832C5DA70;
 Thu, 23 Jan 2020 10:25:44 +0000 (UTC)
Date: Thu, 23 Jan 2020 11:25:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] target/s390x/translate: Do not leak stack address in
 translate_one()
Message-ID: <20200123112542.4a0c38e2.cohuck@redhat.com>
In-Reply-To: <20200123070533.19699-1-thuth@redhat.com>
References: <20200123070533.19699-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: CsOQRTpRNQi34c3eSTA5oA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 08:05:33 +0100
Thomas Huth <thuth@redhat.com> wrote:

> The code in translate_one() leaks a stack address via "s->field" parameter:
> 
>  static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
>  {
>      DisasJumpType ret = DISAS_NEXT;
>      DisasFields f;
>      [...]
>      s->fields = &f;
>      [...]
>      return ret;
>  }
> 
> It's currently harmless since the caller does not seem to use "fields"
> anymore, but let's better play safe (and please static code analyzers)
> by setting the fields back to NULL before returning.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1661815
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/translate.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks, applied.



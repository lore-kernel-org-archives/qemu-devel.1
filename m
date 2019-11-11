Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F479C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA5C2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpQ7FpBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA5C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU6BL-0007FU-CZ
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 04:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iU68b-000619-Lj
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iU68Z-0008Ds-Sa
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:37:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29897
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iU68Z-0008Dj-LG
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573465051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9QCWrGYnauJqy83dzNoDPcvEHdZJP5YZhB7uOKX7Nnc=;
 b=fpQ7FpBP8NV1OS/dTR3tiXd+zL+fDJ0O87V31O29rSGtx9JNgfsShs6G8Gxm+p93eeKXRk
 Zw2bYNYM/cs0RtPZ57iVn/FyNkna0VHAtVd/QfBpVEFqFWANOqZsbvAX9V8Eoh7j4CBarN
 4//oSLP2mTW6bl00vKyuBKCGAbGQGrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-PoqGm2bYPSu0f8I3GUT52A-1; Mon, 11 Nov 2019 04:36:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01EBE107ACC5;
 Mon, 11 Nov 2019 09:36:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF42B600C6;
 Mon, 11 Nov 2019 09:36:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 372661138648; Mon, 11 Nov 2019 10:36:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 13/18] qapi: Create module 'monitor'
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-14-kwolf@redhat.com>
Date: Mon, 11 Nov 2019 10:36:20 +0100
In-Reply-To: <20191017130204.16131-14-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 17 Oct 2019 15:01:59 +0200")
Message-ID: <87v9rqu54b.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: PoqGm2bYPSu0f8I3GUT52A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> misc.json contains definitions that are related to the system emulator,
> so it can't be used for the storage daemon. This patch moves basic
> functionality that is related to the monitor itself into a new
> monitor.json, which could be used in tools as well.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

I'm afraid this commit message is hard to understand unless the reader
already knows you're working towards having
storage-daemon/qapi/qapi-schema.json and qapi/qapi-schema.json share
modules.  Becomes clear only in PATCH 18.

Would qmp.json be more fitting than monitor.json?



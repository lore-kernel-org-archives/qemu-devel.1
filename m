Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1BBC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF8E205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwIgl8XZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF8E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iejbx-0004HV-0d
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 12:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iejb5-0003hs-6e
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iejb4-0003tN-7K
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:46:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40007
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iejb4-0003t5-3a
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576000013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MS000ukHE/2kUXiFGEFx8u0mi9hvakVasMFeFWduJXs=;
 b=NwIgl8XZL7gtr9qOz1rbDxfYvV8PwU2yb4TYQpsKQIGvmlSuG2ye6leIf5aJDq5kdGO2MU
 Gf1uziT5Ib9SycbxjIGQUANwo49wj5uEZylKmM3jXfeBIhIAYOuXlx0BFneg7X64zv6nAP
 BJh+Xsu7OVnhNkxFfq7vFsH9HaqSxCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-kcl-31U9MFGVFLiKESgQLw-1; Tue, 10 Dec 2019 12:46:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 444C710054E3;
 Tue, 10 Dec 2019 17:46:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-11.ams2.redhat.com [10.36.117.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A11ED605B4;
 Tue, 10 Dec 2019 17:46:45 +0000 (UTC)
Date: Tue, 10 Dec 2019 18:46:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: Re: [PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short
 overlays
Message-ID: <20191210174644.GC7103@linux.fritz.box>
References: <20191122160511.8377-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122160511.8377-1-kwolf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kcl-31U9MFGVFLiKESgQLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.11.2019 um 17:05 hat Kevin Wolf geschrieben:
> See patch 4 for the description of the bug fixed.

I'm applying patches 3 and 5-7 to the block branch because they make
sense on their own.

The real fix will need another approach because the error handling is
broken in this one: If zeroing out fails (either because of NO_FALLBACK
or because of some other I/O error), bdrv_co_truncate() will return
failure, but the image size has already been increased, with potentially
incorrect data in the new area.

To fix this, we need to make sure that zeros will be read before we
commit the new image size to the image file (e.g. qcow2 header) and to
bs->total_sectors. In other words, it must become the responsibility of
the block driver.

To this effect, I'm planning to introduce a PREALLOC_MODE_ZERO_INIT flag
that can be or'ed to the preallocation mode. This will fail by default
because it looks like just another unimplemented preallocation mode to
block drivers. It will be requested explicitly by commit jobs and
automatically added by bdrv_co_truncate() if the backing file would
become visible (like in this series, but now for all preallocation
modes). I'm planning to implement it for qcow2 and file-posix for now,
which should cover most interesting cases.

Does this make sense to you?

Kevin



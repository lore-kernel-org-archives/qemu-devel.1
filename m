Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C21C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1782054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjklLx10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1782054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iex7d-0007Oi-ES
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 03:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iex72-0006vr-Ik
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iex71-00012R-Hw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:12:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29040
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iex71-00011H-DE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576051967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=505XZ8KhR5kN273cjgDyxrQkUgcXu5hvNmK84dCQUX4=;
 b=JjklLx10a8nIDYKgAxSsu7qKFMEJart+ghV5XtCDueU7VFfmAfHiMUSO5TBT0Jax6DDtbb
 WbOm5wlzRbKgOgeBdnDHSJ41rGhh6MYN1Zj6Klso7oI8AOnM5KqOMKg3UBUYyrWl/e0Dfa
 dmQ5lh8sf+5/3+/btmWTTm8Nze5ZNB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-lxQ_9wm8MbSjy5gk-I2htA-1; Wed, 11 Dec 2019 03:12:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D93E218AAFA1;
 Wed, 11 Dec 2019 08:12:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8F2E10013A1;
 Wed, 11 Dec 2019 08:12:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3DC4211386A7; Wed, 11 Dec 2019 09:12:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Insufficiently documented deprecated command arguments
Date: Wed, 11 Dec 2019 09:12:41 +0100
Message-ID: <87tv67wa9y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: lxQ_9wm8MbSjy5gk-I2htA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I went through the QAPI schema looking for deprecated stuff not
mentioned in qemu-deprecated.texi.  Here's what I found:

    Commit b33945cfff "block: Accept device model name for
    blockdev-open/close-tray" (v2.8.0) deprecated blockdev-open-tray,
    blockdev-close-tray argument @device.

    Commit 70e2cb3bd7 "block: Accept device model name for
    blockdev-change-medium" (v2.8.0) deprecated blockdev-change-medium
    argument @device.

    Commit 7a9877a026 "block: Accept device model name for
    block_set_io_throttle" (v2.8.0) deprecated block_set_io_throttle
    argument @device.

    Commit c01c214b69 "block: remove all encryption handling APIs"
    (v2.10.0) deprecated query-named-block-nodes result field
    encryption_key_missing and query-block result field
    inserted.encryption_key_missing.

    Commit c42e8742f5 "block: Use JSON null instead of "" to disable
    backing file" (v2.10.0) deprecated blockdev-add empty string
    argument @backing.

    These were missed in commit eb22aeca65 "docs: document deprecation
    policy & deprecated features in appendix" (v2.10.0).

    Commit 3c605f4074 "commit: Add top-node/base-node options" (v3.1.0)
    deprecated block-commit arguments @base and @top.

I can update qemu-deprecated.texi for these.

Now my question: I wonder whether we want to remove any of them right
away.



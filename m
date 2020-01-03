Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA95EC00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 07:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7461821734
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 07:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jtual1IO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7461821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inHaO-00011U-Aq
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 02:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1inHZG-0008Q9-5A
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:40:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1inHZE-0007Pj-20
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:40:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26133
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1inHZD-0007Mh-Qw
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578037218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i+IOjbQD1eOjruWzCdFUsImjUi6yJQ4gDjWnwN4aHWg=;
 b=Jtual1IOBefKeLFsgLaoR0rA/BUiVHrNIgee8MO4ny3vv30DiDrwfHfnw+mvW3mLtEheKe
 cydtWa6wMypxT76x/hB/pF89942Ztvi9zAyANTzN5fTV128l5ejIN5bCI6tHTZIUM74Nv0
 Ke+yg0xtuSGfjomVdSG3Pye2Up0CVug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-IzJ32CTFMuqU6QFyl5PqZA-1; Fri, 03 Jan 2020 02:40:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF054800D4C;
 Fri,  3 Jan 2020 07:40:15 +0000 (UTC)
Received: from localhost (ovpn-112-30.ams2.redhat.com [10.36.112.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AEB2272CB;
 Fri,  3 Jan 2020 07:40:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] tpm: fix PPI RAM migration
Date: Fri,  3 Jan 2020 11:39:57 +0400
Message-Id: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: IzJ32CTFMuqU6QFyl5PqZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The following series fixes a migration issue with the TPM PPI code due
to unaligned host RAM pointer.

v2:
- use QEMU_IS_ALIGNED macros
- remove RFC status from "savevm: check RAM is pagesize aligned"

Marc-Andr=C3=A9 Lureau (3):
  misc: use QEMU_IS_ALIGNED
  tpm-ppi: page-align PPI RAM
  savevm: check RAM is pagesize aligned

 exec.c             | 4 ++--
 hw/tpm/tpm_ppi.c   | 3 ++-
 migration/savevm.c | 5 +++++
 roms/SLOF          | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

--=20
2.24.0.308.g228f53135a



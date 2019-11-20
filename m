Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754FEC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECB62067D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA+7/NUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECB62067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTBo-0000pF-Ab
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iXTAO-0007LQ-QU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iXTAN-0003xA-Ue
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:49:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33340
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iXTAN-0003wO-RZ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574268559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EWi4qxS6QwKQxtCH3P86jam0fFKpXMYymDTJzTrCP8I=;
 b=cA+7/NUu/bPDAdrL/yCfu0ubzohtc+hemh1ieaMBu//KE1wl/TsabA4xAYQ/g1p9busdnY
 RjKc+ZgrgDg82PDBUt/+HD8OzMk6df+LWv0yUIuT+l7gLIjuzMbvDbT3k6hHK6sJrsCYbY
 b0hMsYSThTehuIwPIhkQYA/m3HOddcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-nugFmrVlPvCPZNAetRZaYA-1; Wed, 20 Nov 2019 11:49:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DA07593CE;
 Wed, 20 Nov 2019 16:49:14 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F15B86BF98;
 Wed, 20 Nov 2019 16:49:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-4.2 0/2] i386: Add new versions of
 Skylake/Cascadelake/Icelake without TSX
Date: Wed, 20 Nov 2019 13:49:10 -0300
Message-Id: <20191120164912.32384-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nugFmrVlPvCPZNAetRZaYA-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Systems with TSX disabled due to TAA now make existing CPU models
not usable.  Add new versions with TSX disabled so people can
still use them.  See individual patch commit messages for
additional details.

I'm not 100% sure about the new -noTSX aliases, so I'm adding
them in a separate patch.

Eduardo Habkost (2):
  i386: Add new versions of Skylake/Cascadelake/Icelake without TSX
  i386: Add -noTSX aliases for hle=3Doff,rtm=3Doff CPU models

 target/i386/cpu.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

--=20
2.21.0



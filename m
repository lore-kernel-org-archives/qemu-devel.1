Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C02C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D87E206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5SEht04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D87E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCmv-0001yN-AC
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixCks-00089P-QH
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixCkp-0007g5-5B
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:33:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50526
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixCko-0007dY-9W
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580401995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Psv1XrYMRp6/bio5BGEkLgfD58ErvuUMr6pDtw2Fzdk=;
 b=G5SEht04vyACEgCdJnWoJNYNAPs6i2MOU6KbpcXmGpsywEOrW7BhsAUJ2WNx2EJCQK00+P
 4KdSvqo0+ovcpYAZHwStsrjiAmrS7UufCCLhUV9hMhTGoeIKYEnrgGUaPZFbCrp7XEQuln
 nKMVJ/e3+3PujkE5PKchKCbfr+5J9YE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-ndvTu8k8M1myO9PxOaoeMQ-1; Thu, 30 Jan 2020 11:33:00 -0500
X-MC-Unique: ndvTu8k8M1myO9PxOaoeMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E899DB63;
 Thu, 30 Jan 2020 16:32:58 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6C345DA75;
 Thu, 30 Jan 2020 16:32:47 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/12] scripts/checkpatch.pl: Only allow Python 3
 interpreter
Date: Thu, 30 Jan 2020 17:32:21 +0100
Message-Id: <20200130163232.10446-2-philmd@redhat.com>
In-Reply-To: <20200130163232.10446-1-philmd@redhat.com>
References: <20200130163232.10446-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, kvm@vger.kernel.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit ddf9069963 QEMU requires Python >=3D 3.5.

PEP 0394 [*] states that 'python3' should be available and
that 'python' is optional.

To avoid problem with unsupported versions, enforce the
shebang interpreter to Python 3.

[*] https://www.python.org/dev/peps/pep-0394/

Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3aef6e3dfe..ce43a306f8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1460,6 +1460,12 @@ sub process {
 			}
 		}
=20
+# Only allow Python 3 interpreter
+		if ($realline =3D=3D 1 &&
+			$line =3D~ /^\+#!\ *\/usr\/bin\/(?:env )?python$/) {
+			ERROR("please use python3 interpreter\n" . $herecurr);
+		}
+
 # Accept git diff extended headers as valid patches
 		if ($line =3D~ /^(?:rename|copy) (?:from|to) [\w\/\.\-]+\s*$/) {
 			$is_patch =3D 1;
--=20
2.21.1



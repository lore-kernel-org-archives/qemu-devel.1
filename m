Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C800CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AACF20663
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYlwsZzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AACF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRe9T-0001Lp-5g
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 10:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iRe3K-0002ma-7E
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iRe3J-0002ik-36
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:13:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27315
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iRe3I-0002iH-Vt
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572880436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0xLuW7dxW0/vpxUgGUMzkeq0r++XbA8BvBA+hcvGFM=;
 b=DYlwsZzPHJ4+/DB0gg5/hT52GAlk6f6E80iQJbyz1nAu1XsB23irOZy4cKKZ3KGNaIHqsa
 QEw5o8qzz7RWNCD+MotKnWGTGCugSHzUTaTPvCNXIrhIuAyUmWUvBrNLMJO5cX2K5xUciV
 tGffse8BjhBVPAPbV2WVCSp80wcWL5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-anljG6vVMFGhNcd2sWOuRQ-1; Mon, 04 Nov 2019 10:13:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7136107ACC2;
 Mon,  4 Nov 2019 15:13:51 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCAC05D6C5;
 Mon,  4 Nov 2019 15:13:44 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 5/8] Acceptance tests: keep a stable reference to the QEMU
 build dir
Date: Mon,  4 Nov 2019 10:13:20 -0500
Message-Id: <20191104151323.9883-6-crosa@redhat.com>
In-Reply-To: <20191104151323.9883-1-crosa@redhat.com>
References: <20191104151323.9883-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: anljG6vVMFGhNcd2sWOuRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Beraldo Leal <bleal@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is related to the the differences in in-tree and out-of-tree
builds in QEMU.  For simplification, <BLD> means my build directory.

Currently, by running a `make check-acceptance` one gets (in
tests/acceptance/avocado_qemu/__init__.py):

   SRC_ROOT_DIR: <BLD>/tests/acceptance/avocado_qemu/../../..

This in itself is problematic, because after the parent directories
are applied, one may be left not with a pointer to the build directory
as intended, but with the location of the source tree (assuming they
differ). Built binaries, such as qemu-img, are of course not there and
can't be found.

Given that a Python '__file__' will contain the absolute path to the
file backing the module, say:

   __file__: <BLD>/tests/acceptance/avocado_qemu/__init__.py

                  |  4  |     3    |      2     |     1     |

A solution is to not "evaluate" the third parent dir (marked as 4
here) because that ends up following the "tests" directory symlink to
the source tree.  In fact, there's no need to keep or evaluate any of
the parent directories, we can just drop the rightmost 4 components,
and we'll keep a stable reference to the build directory (with no
symlink being followed).  This works for either a dedicated build
directory or also a combined source and build tree.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index 6618ea67c1..17ce583c87 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -16,7 +16,7 @@ import tempfile
=20
 import avocado
=20
-SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), '..', '..', '..')
+SRC_ROOT_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(os.path.d=
irname(__file__))))
 sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
=20
 from qemu.machine import QEMUMachine
--=20
2.21.0



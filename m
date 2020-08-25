Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4BBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AFC20782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXtdsLYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AFC20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdEe-0001SV-A3
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 13:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAdDU-0007qh-Pq
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:58:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22524
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAdDT-0003Pk-3Y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598378317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pGA7CtbcYoa2/XSwaK+R7D2Qi2jgkCd5D1ty1JS4dtg=;
 b=SXtdsLYdIJEFQRfT2wHN1BPl75XH/QX+kTdHGyBvgPFAOEPY2mjgSTfGzxDUpUox7L+X+N
 TxhfJWLtMOAdEOtNcd5xA2mzj7NuNrh1a0AaIkKCn7aoq01jiB8M++DDMBObm0bq0YgJps
 CRL51vwiMY/v30m1gNYLItTIsOJs9sc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-z3glGWmZPyOAu8XWPqp71w-1; Tue, 25 Aug 2020 13:58:35 -0400
X-MC-Unique: z3glGWmZPyOAu8XWPqp71w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D85B801AAD;
 Tue, 25 Aug 2020 17:58:34 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 921FB50B3F;
 Tue, 25 Aug 2020 17:58:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] meson: mingw installation fixes & nsis conversion
Date: Tue, 25 Aug 2020 21:58:22 +0400
Message-Id: <20200825175827.355940-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: sw@weilnetz.de, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D

Hi,=0D
=0D
The following patches fix installation path when cross-compiling Windows=0D
version, and move the NSIS build rule to meson.=0D
=0D
v2:=0D
 - replaced the shell script by a python version=0D
 - add copyright/license for the new python script=0D
=0D
Marc-Andr=C3=A9 Lureau (5):=0D
  meson: pass confsuffix option=0D
  meson: use meson datadir instead of qemu_datadir=0D
  meson: add docdir option and pass pre-prefix qemu_docdir=0D
  meson: use meson mandir instead of qemu_mandir=0D
  meson: add NSIS building=0D
=0D
 Makefile                           | 56 ---------------------=0D
 configure                          |  2 +=0D
 contrib/vhost-user-gpu/meson.build |  2 +-=0D
 docs/meson.build                   |  4 +-=0D
 meson.build                        | 33 +++++++++++--=0D
 meson_options.txt                  |  2 +=0D
 pc-bios/descriptors/meson.build    |  2 +-=0D
 pc-bios/keymaps/meson.build        |  6 +--=0D
 pc-bios/meson.build                |  2 +-=0D
 scripts/nsis.py                    | 78 ++++++++++++++++++++++++++++++=0D
 tools/virtiofsd/meson.build        |  2 +-=0D
 trace/meson.build                  |  2 +-=0D
 12 files changed, 122 insertions(+), 69 deletions(-)=0D
 create mode 100644 scripts/nsis.py=0D
=0D
--=20=0D
2.26.2=0D
=0D



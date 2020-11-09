Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3985C5517A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60206206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSdKROL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60206206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEhL-0005T3-AO
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEfv-0003rl-HT
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEfq-0005aD-IN
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604957160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C5qkeUQJ0JQGnZdwzf4B4w0YcTXrOy3S9QRUXGclc7o=;
 b=MSdKROL1NHo2y/S4MOlph53YlKV0a3NfUhWwo9xXoJm3d/GBGTOGqqTiQT1PveuuUpQ0pQ
 Xrs7qF7sshxM0ZY1Ilo79GsEhroJosr50npNJewvuzT4G4YEQgAaMd5pch88dhf/xIBRz1
 hFLLUVI+Tp2dzTVZbY7e2X0u9l5TOn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-drvVxd4AOGqrUHd30Ss3lw-1; Mon, 09 Nov 2020 16:25:58 -0500
X-MC-Unique: drvVxd4AOGqrUHd30Ss3lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1688640B2
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 21:25:57 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 953982C31E;
 Mon,  9 Nov 2020 21:25:57 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] qom: Use qlit to represent property defaults
Date: Mon,  9 Nov 2020 16:25:48 -0500
Message-Id: <20201109212556.3934583-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: 20201104160021.2342108-1-ehabkost@redhat.com=0D
Git branch: https://gitlab.com/ehabkost/qemu/-/commits/work/qdev-qlit-defau=
lts=0D
=0D
This extend qlit.h to support all QNum types (signed int,=0D
unsigned int, and double), and use QLitObject to represent field=0D
property defaults.=0D
=0D
It allows us to get rid of most type-specific .set_default_value=0D
functions for QOM property types.=0D
=0D
Eduardo Habkost (8):=0D
  qobject: Include API docs in docs/devel/qobject.html=0D
  qnum: Make qnum_get_double() get const pointer=0D
  qnum: QNumValue type for QNum value literals=0D
  qnum: qnum_value_is_equal() function=0D
  qlit: Support all types of QNums=0D
  qlit: qlit_type() function=0D
  qom: Make object_property_set_default() public=0D
  qom: Use qlit to represent property defaults=0D
=0D
 docs/devel/index.rst                  |   1 +=0D
 docs/devel/qobject.rst                |  11 +++=0D
 include/hw/qdev-properties-system.h   |   2 +-=0D
 include/qapi/qmp/qlit.h               |  16 +++-=0D
 include/qapi/qmp/qnum.h               |  47 ++++++++++-=0D
 include/qapi/qmp/qobject.h            |  48 +++++++----=0D
 include/qom/field-property-internal.h |   4 -=0D
 include/qom/field-property.h          |  26 +++---=0D
 include/qom/object.h                  |  11 +++=0D
 include/qom/property-types.h          |  21 ++---=0D
 hw/core/qdev-properties-system.c      |   8 --=0D
 qobject/qlit.c                        |   4 +-=0D
 qobject/qnum.c                        | 116 +++++++++++++++-----------=0D
 qom/field-property.c                  |  27 ++++--=0D
 qom/object.c                          |   2 +-=0D
 qom/property-types.c                  |  36 ++------=0D
 tests/check-qjson.c                   |  72 ++++++++++++++--=0D
 17 files changed, 295 insertions(+), 157 deletions(-)=0D
 create mode 100644 docs/devel/qobject.rst=0D
=0D
--=20=0D
2.28.0=0D
=0D



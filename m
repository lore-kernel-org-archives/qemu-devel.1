Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8968AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3CB21BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEaa0bTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3CB21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4zn-0001tX-St
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kL4yS-0000FV-NM
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kL4yQ-0005zO-6g
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600868297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tQRoNuKsM85S6dOrahwCoBi3agJZYsO6Om4aDsnQEVA=;
 b=UEaa0bTgUogQWr0RU5yHzShlCuNq7GAh45Wfx4RbxFPynoFskZZ5nwzZaJMR1bvoOaBeaA
 vGz/wz7k6zc11yIxkwy/u7AAGCQYUZbL/NwsDGzpFFHuIwvv9RVgFVgYl/H1Vn/50Prt30
 wR3U1Iws0NwF4EBEbdj5XeXjq1zWiTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-d5kWxqnFMcGDcp6zjhQaaw-1; Wed, 23 Sep 2020 09:38:13 -0400
X-MC-Unique: d5kWxqnFMcGDcp6zjhQaaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 107EB801ABD;
 Wed, 23 Sep 2020 13:38:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-73.ams2.redhat.com
 [10.36.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18F6F60BEC;
 Wed, 23 Sep 2020 13:38:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] Add support for loading SMBIOS OEM strings from a file
Date: Wed, 23 Sep 2020 14:38:01 +0100
Message-Id: <20200923133804.2089190-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I previously added support for SMBIOS OEM strings tables but only=0D
allowed for data to be passed inline. Potential users indicated they=0D
wanted to pass some quite large data blobs which is inconvenient todo=0D
inline. Thus I'm adding support for passing the data from a file.=0D
=0D
In testing this I discovered the hard way that on x86 we're limited to=0D
using the SMBIOS 2.1 entry point currently. This has a maximum size of=0D
0xffff, and if you exceed this all sorts of wierd behaviour happens.=0D
=0D
QEMU forces SMBIOS 2.1 on x86 because the default SeaBIOS firmware does=0D
not support SMBIOS 3.0. The EDK2 firmware supports SMBIOS 3.0 and QEMU=0D
defaults to this on the ARM virt machine type.=0D
=0D
This series adds support for checking the SMBIOS 2.1 limits to protect=0D
users from impossible to diagnose problems.=0D
=0D
There is also a fix needed to SeaBIOS which fails to check for=0D
integer overflow when it appends the type 0 table.=0D
=0D
  https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/thread/3EMI=
OY=3D=0D
6YS6MG5UQN3JJJS2A3DJZOVFR6/=0D
=0D
IIUC, SMBIOS 3.0 should only be limited by what you can fit into RAM,=0D
but in testing, EDK2 appears to hang shortly after the SMBIOS 3.0 data=0D
size exceeds 128 KB. I've not spotted an obvious flaw in EDK2 or QEMU,=0D
nor do I attempt to enforce a limit in QEMU for SMBIOS 3.0.=0D
=0D
Changed in v3:=0D
=0D
 - Adjust for qemu_open method signature change=0D
=0D
Changed in v2:=0D
=0D
 - Drop the patches that allowed choice of SMBIOS 2.1 / 3.0 entry=0D
   point. There's no compelling reason to need 3.0 on x86 while=0D
   aarch64 is 3.0 only.=0D
=0D
Daniel P. Berrang=3DC3=3DA9 (3):=0D
  hw/smbios: support loading OEM strings values from a file=0D
  hw/smbios: report error if table size is too large=0D
  qemu-options: document SMBIOS type 11 settings=0D
=0D
 hw/smbios/smbios.c | 85 +++++++++++++++++++++++++++++++++++++++-------=0D
 qemu-options.hx    | 41 ++++++++++++++++++++++=0D
 2 files changed, 113 insertions(+), 13 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D



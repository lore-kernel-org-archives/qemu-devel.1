Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434CBC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 22:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D961120732
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 22:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD/u/yml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D961120732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIg2y-0001U6-Rn
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 18:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIfzA-0006po-MG
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 18:33:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24092
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIfz8-0000OK-UI
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 18:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600295585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L9/LF5Xrwk2JE+99zquvSY7UhKjq7FWKpJXQ/uxD/gA=;
 b=LD/u/ymlPiXno+AbMa1YfZB0Ch86RT2JAzeMYEfE0ZiUaJcbT2SF/Nx3w5hEN4kQhGziph
 Sfw0nCtexK++zeRK/3v1u3DaOpV9TIJA390iyBjNvK0zyUP2qZXUEFHZiR7gt+AzATB4Fi
 qbXaPoCGYAZS8DgnJ7r4XlXwSA9ldiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-9OKYtl3WP_-uc3cyK1Bxqg-1; Wed, 16 Sep 2020 18:33:02 -0400
X-MC-Unique: 9OKYtl3WP_-uc3cyK1Bxqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFB0F1868427;
 Wed, 16 Sep 2020 22:32:59 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B466F1EA;
 Wed, 16 Sep 2020 22:32:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] qom: DECLARE_INTERFACE_CHECKER macro
Date: Wed, 16 Sep 2020 18:32:56 -0400
Message-Id: <20200916223258.599367-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 18:33:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an alternative to the series:=0D
  Subject: [PATCH 0/3] qom: Replace INTERFACE_CHECK with OBJECT_CHECK=0D
  https://lore.kernel.org/qemu-devel/20200916193101.511600-1-ehabkost@redha=
t.com/=0D
=0D
Instead of removing INTERFACE_CHECK completely, keep it but use a=0D
DECLARE_INTERFACE_CHECKER macro to define the type checking functions for=
=0D
interface types.=0D
=0D
Eduardo Habkost (2):=0D
  qom: DECLARE_INTERFACE_CHECKER macro=0D
  qom: Use DECLARE_INTERFACE_CHECKER macro=0D
=0D
 include/hw/acpi/acpi_dev_interface.h |  5 ++---=0D
 include/hw/arm/linux-boot-if.h       |  4 ++--=0D
 include/hw/fw-path-provider.h        |  4 ++--=0D
 include/hw/hotplug.h                 |  4 ++--=0D
 include/hw/intc/intc.h               |  5 ++---=0D
 include/hw/ipmi/ipmi.h               |  4 ++--=0D
 include/hw/isa/isa.h                 |  4 ++--=0D
 include/hw/mem/memory-device.h       |  4 ++--=0D
 include/hw/nmi.h                     |  4 ++--=0D
 include/hw/ppc/pnv_xscom.h           |  4 ++--=0D
 include/hw/ppc/spapr_irq.h           |  4 ++--=0D
 include/hw/ppc/xics.h                |  4 ++--=0D
 include/hw/ppc/xive.h                | 12 ++++++------=0D
 include/hw/rdma/rdma.h               |  5 ++---=0D
 include/hw/rtc/m48t59.h              |  4 ++--=0D
 include/hw/stream.h                  |  4 ++--=0D
 include/hw/vmstate-if.h              |  4 ++--=0D
 include/qom/object.h                 | 14 ++++++++++++++=0D
 include/qom/object_interfaces.h      |  5 ++---=0D
 include/sysemu/tpm.h                 |  4 ++--=0D
 target/arm/idau.h                    |  4 ++--=0D
 tests/check-qom-interface.c          |  4 ++--=0D
 22 files changed, 60 insertions(+), 50 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D



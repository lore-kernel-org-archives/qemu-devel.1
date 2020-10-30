Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EC7C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8608420739
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isbsM3+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8608420739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYave-0001uw-Ej
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 16:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYau3-0000AU-MB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYau1-0007gz-Sp
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604089297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rmUpSIFLP4bcBRGklgXcM+VcVM29u1CqdRtS3UAu3H8=;
 b=isbsM3+jnjyA40Jmi9Yy0UPPHPAbUzbZ98IVBMA7kTLK94bnapgrwpL+BVR1NFWOTResjp
 urYWxy682R4EGAmhLl9bgvj8viVzbQKb1iQ8q/63E4rFBUxVtwHm6AGxCJaW1l5G55ntG/
 KItWBl+lvjlgOaaioZdlfhxjQUvfCwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-G1cpfHq3OpO-9BTnsANPMA-1; Fri, 30 Oct 2020 16:21:33 -0400
X-MC-Unique: G1cpfHq3OpO-9BTnsANPMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01F56805EF4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 20:21:33 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDB0260DA0;
 Fri, 30 Oct 2020 20:21:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/20] qdev/qom: Remove explicit type names from error_setg()
 calls
Date: Fri, 30 Oct 2020 16:21:11 -0400
Message-Id: <20201030202131.796967-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 16:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: 20201029220246.472693-1-ehabkost@redhat.com=0D
Git branch: https://gitlab.com/ehabkost/qemu/-/commits/work/prop-error-repo=
rting=0D
=0D
One of the obstacles when refactoring the QOM property parsing=0D
code are the references to the object itself in the error code,=0D
to generate "Property '<TYPE>.<PROP>' can't take value ..." error=0D
messages.  This makes it hard to isolate the string parsing code=0D
into functions that are independent from QOM.=0D
=0D
The simple solution for that would be to just remove the prefix=0D
and have less descriptive error messages.=0D
=0D
A slightly better solution is to make the code that parses=0D
-device and -object add a=0D
  "Property '<TYPE>.<PROP>' can't take value '<VALUE>': "=0D
prefix automatically when encountering an error=0D
when setting a property.  This is the approach implemented in=0D
this series.=0D
=0D
Eduardo Habkost (20):=0D
  qom: Add prefix to error message inside object_property_parse()=0D
  qdev: Stop using error_set_from_qdev_prop_error() for netdev property=0D
  qdev: Stop using error_set_from_qdev_prop_error() for audiodev=0D
    property=0D
  qdev: Stop using error_set_from_qdev_prop_error() for mac property=0D
  qdev: Stop using error_set_from_qdev_prop_error() for devfn property=0D
  qdev: Stop using error_set_from_qdev_prop_error() for PCI host device=0D
    property=0D
  qdev: Stop using error_set_from_qdev_prop_error() for css devno=0D
    property=0D
  qdev: Delete unused error_set_from_qdev_prop_error() function=0D
  cryptodev: Remove unnecessary prefix from error message=0D
  memfd: Remove unnecessary prefix from error message=0D
  tpm_util: Remove unnecessary prefix from error message=0D
  qdev: drive: Remove unnecessary prefix from error message=0D
  qdev: chardev: Remove unnecessary prefix from error message=0D
  i386: Remove unnecessary prefix from error message=0D
  qerror: Delete unused QERR_PROPERTY_VALUE_BAD macro=0D
  nvdimm: Remove unnecessary prefix from error message=0D
  colo-compare: Remove unnecessary prefix from error message=0D
  filter-dump: Remove unnecessary prefix from error message=0D
  filter-buffer: Remove unnecessary prefix from error message=0D
  qom: Remove error prefix check at object_property_parse()=0D
=0D
 include/hw/qdev-properties.h     |  2 --=0D
 include/qapi/qmp/qerror.h        |  3 ---=0D
 backends/cryptodev.c             |  3 +--=0D
 backends/hostmem-memfd.c         |  3 +--=0D
 backends/tpm/tpm_util.c          |  3 +--=0D
 hw/core/qdev-properties-system.c | 28 +++++++++++-----------------=0D
 hw/core/qdev-properties.c        | 22 ----------------------=0D
 hw/mem/nvdimm.c                  |  6 ++----=0D
 hw/s390x/css.c                   |  2 +-=0D
 net/colo-compare.c               |  9 +++------=0D
 net/dump.c                       |  3 +--=0D
 net/filter-buffer.c              |  3 +--=0D
 qom/object.c                     |  5 +++++=0D
 target/i386/cpu.c                |  2 +-=0D
 14 files changed, 28 insertions(+), 66 deletions(-)=0D
=0D
--=20=0D
2.28.0=0D
=0D



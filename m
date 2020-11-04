Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3EAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04682067C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiyvYwID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04682067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMYU-0002Mh-OU
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXB-0000y0-8p
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMX8-000871-OM
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604510717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O9S2DboR2olJsV4h7vplZf4xNYm6N4n5l5+vOvwgg5I=;
 b=IiyvYwIDN+3erpRUkzxICuZguYyZrzqwspn1+J4JldpDSDDhvDrgaLrJA0PhFGoAQ0cieg
 wsf46rqEznRVpDsd+5jhU3cYfx2iV0KlM4E3JyzbwGpGR3wRqsWZFSUOz8FZoXjkrn7UzX
 haGvoBAqdPIlJYOXCFdRuU6oskCu1Ng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-J1fdU10ROnmCUfi9-1VVTQ-1; Wed, 04 Nov 2020 12:25:15 -0500
X-MC-Unique: J1fdU10ROnmCUfi9-1VVTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7278F64155
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 17:25:14 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1FC5C629;
 Wed,  4 Nov 2020 17:25:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] qom: Field properties type safety
Date: Wed,  4 Nov 2020 12:25:05 -0500
Message-Id: <20201104172512.2381656-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: 20201104160021.2342108-1-ehabkost@redhat.com=0D
Git branch: https://gitlab.com/ehabkost/qemu/-/commits/work/qdev-size-valid=
ation=0D
=0D
This adds additional validation to field properties, to ensure=0D
the field property usage and implementation agree about the=0D
struct field size.=0D
=0D
The first patch in the series fixes one bug found using the new=0D
safety mechanism.  I hope it's the only one.=0D
=0D
Eduardo Habkost (7):=0D
  sparc: Fix property/field size mismatch for iu-version=0D
  qom: Save size of struct field in Property struct=0D
  qdev: Don't register unreadable legacy properties=0D
  qom: Replace void* parameter with Property* on field getters/setters=0D
  qom: Replace void* parameter with Property* on PropertyInfo.release=0D
  qom: Add FIELD_PTR, a type-safe wrapper for object_field_prop_ptr()=0D
  sparc: Use FIELD_PTR at nwindows getter/setter=0D
=0D
 include/qom/field-property-internal.h |   8 +-=0D
 include/qom/field-property.h          |  61 ++++++++--=0D
 include/qom/property-types.h          |   1 +=0D
 target/sparc/cpu.h                    |   2 +-=0D
 backends/tpm/tpm_util.c               |  18 ++-=0D
 hw/block/xen-block.c                  |  10 +-=0D
 hw/core/qdev-properties-system.c      | 140 +++++++++-------------=0D
 hw/core/qdev-properties.c             |   4 +-=0D
 hw/s390x/css.c                        |  10 +-=0D
 hw/s390x/s390-pci-bus.c               |  10 +-=0D
 hw/vfio/pci-quirks.c                  |  14 +--=0D
 qom/field-property.c                  |  16 ++-=0D
 qom/property-types.c                  | 166 +++++++++++---------------=0D
 target/sparc/cpu.c                    |  17 ++-=0D
 14 files changed, 231 insertions(+), 246 deletions(-)=0D
=0D
--=20=0D
2.28.0=0D
=0D



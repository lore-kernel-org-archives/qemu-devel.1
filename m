Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47508C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C4D21D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gh7MngYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C4D21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSTOn-0000EI-Nc
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 19:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSTM5-0006Dv-VU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSTM3-0003T8-Ep
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602630314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ji38uyqyWisDFO4IfCcIcwK8uRW+sV+VPP3zMuIrrWM=;
 b=gh7MngYvbprDR9CaA0z34WSr64iOGLGe5hLxI5VNd57fNncv9FAKQmHnYCa8NDSSNugex9
 ydEJRvq0WKHSGeVzbGwiLLokoJWOsq6B1xKwtkf7RaW5gYxDeAwed/m1i3yie3vdjbqdB2
 Jeazegs/7n0qsyMtN1hFcS3BL7ubsA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-16oC7qqIM0G0he5kVHYLWg-1; Tue, 13 Oct 2020 19:05:11 -0400
X-MC-Unique: 16oC7qqIM0G0he5kVHYLWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4853656BE8;
 Tue, 13 Oct 2020 23:05:08 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD3D26EF53;
 Tue, 13 Oct 2020 23:04:58 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] i386: Add `machine` parameter to query-cpu-definitions
Date: Tue, 13 Oct 2020 19:04:50 -0400
Message-Id: <20201013230457.150630-1-ehabkost@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes v1 -> v2:=0D
* Rewrite documentation, with suggestions from Markus=0D
* Try to reduce churn and keep the existing default_cpu_version=0D
  static variable=0D
* Replace x86_cpu_class_get_alias_of() with x86_cpu_model_resolve_alias()=
=0D
=0D
Link to v1:=0D
https://lore.kernel.org/qemu-devel/20191025022553.25298-1-ehabkost@redhat.c=
om=0D
=0D
We had introduced versioned CPU models in QEMU 4.1, including a=0D
method for querying for CPU model versions using=0D
query-cpu-definitions.  This solution had one problem: fetching=0D
CPU alias information for multiple machine types required=0D
restarting QEMU for each machine being queried.=0D
=0D
This series adds a new `machine` parameter to=0D
query-cpu-definitions, that can be used to query CPU model alias=0D
information for multiple machines without restarting QEMU.=0D
=0D
About CPU model versioning vs query-cpu-model-expansion=0D
-------------------------------------------------------=0D
=0D
There had been some discussion[1] about using a mechanism for=0D
this similar to what's done in s390x, based on=0D
query-cpu-model-expansion.  I had considered that approach in the=0D
beginning, but this would require=0D
  query-cpu-model-expansion type=3Dstatic=0D
to resolve to a useful base CPU model that is static.=0D
=0D
Unfortunately, we have no useful static CPU model in x86 yet,=0D
except for "base", because of the complex accelerator-dependent=0D
rules that affect expansion of CPU models.  Maybe in the future=0D
we'll be able to define static versions of each CPU model, and=0D
unify the CPU model versioning approaches in all architectures.=0D
=0D
While we don't have this, we need to work with what we have.=0D
What we have today in x86 are CPU models that are not static and=0D
not accelerator-independent.=0D
=0D
[1] https://lore.kernel.org/qemu-devel/dbf9e4c1-0acf-9469-84f9-f80c41e2cae0=
@redhat.com/=0D
=0D
Eduardo Habkost (7):=0D
  machine: machine_find_class() function=0D
  i386: Add X86CPUModel.alias_of field=0D
  i386: Replace x86_cpu_class_get_alias_of() with=0D
    x86_cpu_model_resolve_alias()=0D
  i386: Add default_version parameter to CPU version functions=0D
  i386: Wrap QMP code in !CONFIG_USER_ONLY=0D
  i386: Don't use default_cpu_version inside x86_cpu_definition_entry()=0D
  cpu: Add `machine` parameter to query-cpu-definitions=0D
=0D
 qapi/machine-target.json                   |  14 ++-=0D
 include/hw/boards.h                        |   2 +=0D
 hw/core/machine.c                          |  16 ++++=0D
 softmmu/vl.c                               |  17 +---=0D
 target/arm/helper.c                        |   4 +-=0D
 target/i386/cpu.c                          | 105 +++++++++++++++------=0D
 target/mips/helper.c                       |   4 +-=0D
 target/s390x/cpu_models.c                  |   4 +-=0D
 target/ppc/translate_init.c.inc            |   4 +-=0D
 tests/acceptance/x86_cpu_model_versions.py |  48 ++++++++++=0D
 10 files changed, 167 insertions(+), 51 deletions(-)=0D
=0D
--=20=0D
2.28.0=0D
=0D



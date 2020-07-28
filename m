Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DE2C433EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4DA21D95
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mg2Nqdu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4DA21D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0KIc-0004eO-7D
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0KHa-00035B-UE
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:44:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46567
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0KHY-0003vl-Cj
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595922254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7esL7FV/9oUv0L/2lC7bvyKnI+H5f38/iJJXBMyAPS4=;
 b=Mg2Nqdu9MILoQ8fv8rG487MlXr9/NwAhTEcrT70yYktm2xRiJKd88gxGcRPjX0ZsUrUtZ1
 NsB6lbaWNF+VyjJsvvvDqlEApVhQbC8ThznwaL+nGr10iDVWkHKXGB8N4JHuZZgoui47rF
 1bGpte2IDid6QmvxEp8CoqICSdbiMt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-l6OnmMI0N5OlU6QzYhJBhw-1; Tue, 28 Jul 2020 03:44:10 -0400
X-MC-Unique: l6OnmMI0N5OlU6QzYhJBhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 974CF1DE2;
 Tue, 28 Jul 2020 07:44:09 +0000 (UTC)
Received: from thuth.com (ovpn-112-161.ams2.redhat.com [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC37F5F1EA;
 Tue, 28 Jul 2020 07:44:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 0/4] Improve FreeBSD and macOS jobs in the Cirrus-CI
Date: Tue, 28 Jul 2020 09:44:01 +0200
Message-Id: <20200728074405.13118-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our configure script does not enable -Werror on macOS and FreeBSD
by default yet. That's bad in the CI, since we might miss compiler
warnings and thus bugs this way. So after fixing a problem in the
configure script in the first patch, we now turn on -Werror here
in the second and third patch. The fourth patch is just a cosmetical
one, since Cirrus-CI seems to upgrade all jobs automatically to
Cataline these days.

v2:
 - Split the -Werror enablement patch into two, one for FreeBSD and
   one for macOS
 - Use -Wno-error=deprecated-declarations instead of --disable-sasl
   on macOS to work-around the deprecation messages from Apple.

Thomas Huth (4):
  configure: Fix atomic64 test for --enable-werror on macOS
  cirrus.yml: Compile FreeBSD with -Werror
  cirrus.yml: Compile macOS with -Werror
  cirrus.yml: Update the macOS jobs to Catalina

 .cirrus.yml | 13 ++++++++-----
 configure   | 10 +++++-----
 2 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.18.1



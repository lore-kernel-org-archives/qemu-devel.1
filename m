Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED7CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC3F2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyWFGqoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC3F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw8US-0002hc-1v
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 14:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8TS-00018w-7k
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:19:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57057
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8TP-0004mG-KQ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594923550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bcaUp7K1qGuSxSBLKg7snT0x3RS30X9CYTyFB+6dlUg=;
 b=dyWFGqoFT1h55L1pp5PPOICHuYbX5AHa/Vk0RpcrfNa7EkaOIc0lFikBvtnOqyB9h4HHMn
 /nvSGzBVVEYvy0hvfENCqh1VSMqT5OT7zkAg7JJvZwf9LeKPO42Cy6mDwn6A05PVOsW7V4
 Tx9SzcHghRd0FujRqIViIwGys9soaV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-uaOsYLi3NXiD46Cn1A9jxw-1; Thu, 16 Jul 2020 14:19:06 -0400
X-MC-Unique: uaOsYLi3NXiD46Cn1A9jxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF8C380048E;
 Thu, 16 Jul 2020 18:19:04 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7719478A50;
 Thu, 16 Jul 2020 18:19:04 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 0/6] x86 fixes for -rc1
Date: Thu, 16 Jul 2020 14:18:57 -0400
Message-Id: <20200716181903.1895314-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 Roman Bolshakov <r.bolshakov@yadro.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit ee5128bb00f90dd301991d80d1db5224ce924c84=
:=0D
=0D
  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' int=
o staging (2020-07-16 13:12:05 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request=0D
=0D
for you to fetch changes up to 818b9f111d64b40661d08f5e23236ac1ca5df505:=0D
=0D
  i386: hvf: Explicitly set CR4 guest/host mask (2020-07-16 14:15:13 -0400)=
=0D
=0D
----------------------------------------------------------------=0D
x86 fixes for -rc1=0D
=0D
Fixes for x86 that missed hard freeze:=0D
* Don't trigger warnings for features set by=0D
  CPU model versions (Xiaoyao Li)=0D
* Missing features in Icelake-Server, Skylake-Server,=0D
  Cascadelake-Server CPU models (Chenyi Qiang)=0D
* Fix hvf x86_64 guest boot crash (Roman Bolshakov)=0D
=0D
----------------------------------------------------------------=0D
=0D
Chenyi Qiang (3):=0D
  target/i386: add fast short REP MOV support=0D
  target/i386: fix model number and add missing features for=0D
    Icelake-Server CPU model=0D
  target/i386: add the missing vmx features for Skylake-Server and=0D
    Cascadelake-Server CPU models=0D
=0D
Roman Bolshakov (1):=0D
  i386: hvf: Explicitly set CR4 guest/host mask=0D
=0D
Xiaoyao Li (2):=0D
  i368/cpu: Clear env->user_features after loading versioned CPU model=0D
  i386/cpu: Don't add unavailable_features to env->user_features=0D
=0D
 target/i386/cpu.h     |  2 ++=0D
 target/i386/hvf/vmx.h |  1 +=0D
 target/i386/cpu.c     | 38 ++++++++++++++++++++++++++++++++++++--=0D
 3 files changed, 39 insertions(+), 2 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D



Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BFEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC142206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcMV33NV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC142206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jygfY-0007Un-4o
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 15:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jyget-00072p-5z
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:13:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32217
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jyger-0007AM-2l
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595531611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fi0Xx+HOA47rxc4kzKwModkWwvN2vWwQYn4U8B9m63w=;
 b=DcMV33NV7/bqAZuvNouSUAPdCJLWY+35yZaFi2GLy4uVylYuzCCUe26UlPvt1lrAcNlAfC
 GCB3uqxrWSanwQk80S+6lrcI75MtcWyBnJzY2C5Al4sRgM7fD81ggbJQLgeYPWA5L51Mls
 e9ZphdRgO7pCTAVQLHRe+tHKM8TaOX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-Vb2nPeyUP6efpeMJpcxhkA-1; Thu, 23 Jul 2020 15:13:29 -0400
X-MC-Unique: Vb2nPeyUP6efpeMJpcxhkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC1E818C63C0;
 Thu, 23 Jul 2020 19:13:28 +0000 (UTC)
Received: from localhost (unknown [10.10.67.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DF7D60CC0;
 Thu, 23 Jul 2020 19:13:28 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] x86 bug fix for -rc2
Date: Thu, 23 Jul 2020 15:13:26 -0400
Message-Id: <20200723191327.3003969-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8ffa52c20d5693d454f65f2024a1494edfea65d4=
:=0D
=0D
  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging=
 (2020-07-23 13:38:21 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/x86-next-for-5.1-pull-request=0D
=0D
for you to fetch changes up to 0baa4b445e28f37243e5dc72e7efe32f0c9d7801:=0D
=0D
  KVM: fix CPU reset wrt HF2_GIF_MASK (2020-07-23 15:03:54 -0400)=0D
=0D
----------------------------------------------------------------=0D
x86 bug fix for -rc2=0D
=0D
A fix from Vitaly Kuznetsov for a CPU reset bug=0D
reported by Jan Kiszka.=0D
=0D
----------------------------------------------------------------=0D
=0D
Vitaly Kuznetsov (1):=0D
  KVM: fix CPU reset wrt HF2_GIF_MASK=0D
=0D
 target/i386/kvm.c | 16 +++++++++++-----=0D
 1 file changed, 11 insertions(+), 5 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D



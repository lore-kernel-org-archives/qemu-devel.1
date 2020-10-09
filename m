Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D98C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0992022261
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6uQzgD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0992022261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuy0-0004eL-4x
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQupn-0003dR-9K
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQupl-00016d-En
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/SYhszIXA0xCmoEZQMOxUX9tfGF1A44jM698h/Hu00Y=;
 b=a6uQzgD5VwfTBAZW01Awr9s/aMf6aIGhVYMwa4n3RlG5mGnneZu225A/2FKcRNtAHPMhQ3
 bvdO7zi+Pbb68xkeYyLAO1o1A9FufdIDafU/rVmGklENGdIxM1W4+2b4Z40bi+Nb0bd1gP
 95K0SGGk4l2n8jmHi61+1NIonlpn/ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-_9IxrQuyPEu2mGgAIHhdbA-1; Fri, 09 Oct 2020 12:01:26 -0400
X-MC-Unique: _9IxrQuyPEu2mGgAIHhdbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7188802B6A
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 16:01:25 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF15D6EF6C;
 Fri,  9 Oct 2020 16:01:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/12] qom: Make all -object types use only class properties
Date: Fri,  9 Oct 2020 12:01:10 -0400
Message-Id: <20201009160122.1662082-1-ehabkost@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To make introspection possible, make all TYPE_USER_CREATABLE=0D
classes use only class properties, and add a mechanism to lock=0D
QOM properties so writable instance properties won't be allowed=0D
anymore.=0D
=0D
Eduardo Habkost (12):=0D
  qom: Helpers for pointer properties=0D
  qom: Introduce PointerProperty struct=0D
  qom: Make object_class_property_add_uint*_ptr() get offset=0D
  sev: Use class properties=0D
  rng: Use class properties=0D
  can_host: Use class properties=0D
  colo: Use class properties=0D
  netfilter: Reorder functions=0D
  netfilter: Use class properties=0D
  input: Use class properties=0D
  [RFC] qom: Property lock mechanism=0D
  [RFC] qom: Lock properties of all TYPE_USER_CREATABLE types=0D
=0D
 include/qom/object.h           |  25 +++-=0D
 backends/rng-egd.c             |  10 +-=0D
 backends/rng-random.c          |   8 +-=0D
 backends/rng.c                 |   6 +-=0D
 net/can/can_host.c             |  16 +--=0D
 net/colo-compare.c             |  57 ++++----=0D
 net/dump.c                     |  10 +-=0D
 net/filter-buffer.c            |  26 ++--=0D
 net/filter-mirror.c            |  64 ++++-----=0D
 net/filter-rewriter.c          |   7 +-=0D
 net/filter.c                   |  24 ++--=0D
 qom/object.c                   | 256 ++++++++++++++++++---------------=0D
 qom/object_interfaces.c        |  11 ++=0D
 target/i386/sev.c              |  22 +--=0D
 tests/check-qom-proplist.c     |  10 +-=0D
 tests/test-qdev-global-props.c |  70 +++++++++=0D
 ui/input-barrier.c             |  44 +++---=0D
 ui/input-linux.c               |  27 ++--=0D
 18 files changed, 407 insertions(+), 286 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D



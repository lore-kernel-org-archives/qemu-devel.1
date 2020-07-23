Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1D5C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1F5206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdtAQ47L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1F5206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfJV-0005a2-W3
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyfIh-00050L-TL
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:46:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyfIf-00047q-VN
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595526393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mqPjPxI/e2dwAxJUrCftiGEZiFbyQIwzwnp49pUraKI=;
 b=FdtAQ47LZAhJtnMnHeZYlELglYypZaNvnkWUIjK74ydZAK2CunxDFxLD3eLSM2+T4RwSX9
 C8v6NDP1dI3RZxuE7bQAte0pCjnKWuKU/aVEuZxSOlLNNH3BSn98xMP3pvTQPp2raTr2Fa
 xSJ7h9zX30WD4q0Ca5roZXsYC3JOcnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-Vxv5Nz_SM8uSTIvT4kj84g-1; Thu, 23 Jul 2020 13:46:30 -0400
X-MC-Unique: Vxv5Nz_SM8uSTIvT4kj84g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66A90106B242;
 Thu, 23 Jul 2020 17:46:29 +0000 (UTC)
Received: from turbo.com (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D5A45C6D9;
 Thu, 23 Jul 2020 17:46:16 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com
Subject: [PATCH 0/7] Make SPICE a load module
Date: Thu, 23 Jul 2020 19:46:08 +0200
Message-Id: <20200723174615.2370096-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series builds the qemu SPICE code into a load module in order to=0D
remove the number of shared libraries that the main qemu binary=0D
depends on.=0D
=0D
It is intended to be built on the work that Gerd shared recently=0D
regarding modular devices and chardev initialization. I left the=0D
patch I used in the series since Gerd may still be working on it.=0D
=0D
With these changes, the following shared libraries are no longer=0D
needed in the main binary:=0D
=0D
        libspice-server.so.1=0D
        libopus.so.0=0D
        liblz4.so.1=0D
        libgstapp-1.0.so.0=0D
        libgstvideo-1.0.so.0=0D
        libgstbase-1.0.so.0=0D
        libgstreamer-1.0.so.0=0D
        libssl.so.1.1=0D
        liborc-0.4.so.0=0D
=0D
There are still some not-so-nice changes in the makefiles,=0D
e.g. references to ../directory/foo.o. I don't want to invest too much=0D
time in fixing it the right way if Meson changes the way these things=0D
are built.=0D
=0D
Christophe de Dinechin (5):=0D
  minikconf: Pass variables for modules=0D
  spice: Make spice a module configuration=0D
  spice: Move all the spice-related code in spice-app.so=0D
  build: Add SPICE_CFLAGS and SPICE_LIBS to relevant files=0D
  spice: Call qemu spice functions indirectly=0D
=0D
Gerd Hoffmann (2):=0D
  spice: simplify chardev setup=0D
  build: fix device module builds=0D
=0D
 audio/Makefile.objs      |  2 +-=0D
 chardev/Makefile.objs    |  2 +-=0D
 chardev/spice.c          | 29 ++++------------=0D
 configure                |  6 ++--=0D
 dtc                      |  2 +-=0D
 hw/display/Makefile.objs |  1 +=0D
 hw/i386/pc.c             |  1 -=0D
 include/chardev/spice.h  |  1 -=0D
 include/ui/qemu-spice.h  | 75 ++++++++++++++++++----------------------=0D
 monitor/Makefile.objs    |  3 ++=0D
 monitor/hmp-cmds.c       | 13 +++++++=0D
 monitor/misc.c           |  2 +-=0D
 monitor/qmp-cmds.c       |  6 ++--=0D
 roms/SLOF                |  2 +-=0D
 roms/openbios            |  2 +-=0D
 roms/opensbi             |  2 +-=0D
 roms/seabios             |  2 +-=0D
 scripts/minikconf.py     |  4 +--=0D
 slirp                    |  2 +-=0D
 softmmu/Makefile.objs    |  2 +-=0D
 softmmu/vl.c             | 35 ++++++++++++++++---=0D
 ui/Makefile.objs         | 12 +++----=0D
 ui/spice-app.c           | 17 ++++-----=0D
 ui/spice-core.c          | 35 ++++++++++++++++---=0D
 24 files changed, 150 insertions(+), 108 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D



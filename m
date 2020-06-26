Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A50FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27852206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxvNVb08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27852206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorcP-0001HB-CO
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorRp-0005gD-Mj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:43:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59037
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorRm-0006vC-Vt
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593189805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JjxT6rM8zGr6Kdd4CzcuTN7PCxNsll0KV4HDcYs8fyw=;
 b=PxvNVb08Gg3w85c2bTkZhOVXr9tuzasIWVzgMqF0Da+HqOID9SQ9eSE/zvMqzmHiuPUy5Q
 V2qKgjcFTJfj2XFLOKbYJ1rgfm86KflUwXQZvK+idOLSjPaRHe3VyIwgCbrF1uDu6xTkiw
 UFNNR8M0cLglAlyW7A1+I6meAI/EyUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-JkzD1UYTMD-DJIm4l4ouMA-1; Fri, 26 Jun 2020 12:43:20 -0400
X-MC-Unique: JkzD1UYTMD-DJIm4l4ouMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A7B480058A;
 Fri, 26 Jun 2020 16:43:19 +0000 (UTC)
Received: from turbo.com (ovpn-112-91.ams2.redhat.com [10.36.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83F485C1BB;
 Fri, 26 Jun 2020 16:43:08 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] RFC: Move SPICE to a load module
Date: Fri, 26 Jun 2020 18:42:57 +0200
Message-Id: <20200626164307.3327380-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There has been a bit of discussion regarding the possibility to move=0D
SPICE code to a module in order to reduce the attack surface and=0D
memory usage when SPICE is not used.=0D
=0D
This WIP series proposes one way to do it that is relatively cheap in=0D
terms of code changes, relative to other ideas I tested, and seems to=0D
be working on simple test cases, unlike a couple of more=0D
"sophisiticated" ideas I tried where I ran into rather nasty SPICE=0D
initialization order issues.=0D
=0D
Furthermore, the approach presented here requires relatively few code=0D
changes in order to apply to other components as well. It relies on a=0D
couple of macros added to the module.h file, MODIFACE and MODIMPLE.=0D
=0D
MODIFACE declare the interface for a module function. A module=0D
function is transformed into a pointer when you build with modules,=0D
and that pointer is used instead of the original function.=0D
=0D
MODIMPL implements a MODIFACE, and patches the pointer at load time to=0D
call the function in the shared library.=0D
=0D
Thanks to some suggestions from Gerd, I also moved QXL to a module,=0D
although at the moment it does not load correctly.=0D
=0D
There are a few known hacks in the present state, including:=0D
=0D
- Adding various non-UI files into spice-app.so, which required a=0D
  couple of ../pwd/foo.o references in the makefile. Not very nice,=0D
  but I did not want to spend too much time fixing the makefiles.=0D
=0D
- qmp_query_spice had to be dealt with "manually" because its=0D
  interface is generated.=0D
=0D
With these changes, the following shared libraries are no longer=0D
needed in the main binary:=0D
=0D
 =09libspice-server.so.1 =3D> /lib64/libspice-server.so.1 (HEX)=0D
 =09libopus.so.0 =3D> /lib64/libopus.so.0 (HEX)=0D
 =09liblz4.so.1 =3D> /lib64/liblz4.so.1 (HEX)=0D
 =09libgstapp-1.0.so.0 =3D> /lib64/libgstapp-1.0.so.0 (HEX)=0D
 =09libgstvideo-1.0.so.0 =3D> /lib64/libgstvideo-1.0.so.0 (HEX)=0D
 =09libgstbase-1.0.so.0 =3D> /lib64/libgstbase-1.0.so.0 (HEX)=0D
 =09libgstreamer-1.0.so.0 =3D> /lib64/libgstreamer-1.0.so.0 (HEX)=0D
 =09libssl.so.1.1 =3D> /lib64/libssl.so.1.1 (HEX)=0D
 =09liborc-0.4.so.0 =3D> /lib64/liborc-0.4.so.0 (HEX)=0D
=0D
I will keep pushing updates on branch "modular-spice"=0D
on https://github.com/c3d/qemu.git=0D
=0D
Christophe de Dinechin (10):=0D
  modules: Provide macros making it easier to identify module exports=0D
  minikconf: Pass variables for modules=0D
  spice: Make spice a module configuration=0D
  spice: Move all the spice-related code in spice-app.so=0D
  build: Avoid build failure when building drivers as modules=0D
  trivial: Remove extra trailing whitespace=0D
  qxl - FIXME: Build as module=0D
  build: Add SPICE_CFLAGS and SPICE_LIBS to relevant files=0D
  spice: Put spice functions in a separate load module=0D
  REMOVE: Instrumentation to show the module functions being replaced=0D
=0D
 Makefile                 |  1 +=0D
 Makefile.objs            |  2 ++=0D
 Makefile.target          |  7 +++++++=0D
 audio/Makefile.objs      |  2 +-=0D
 chardev/Makefile.objs    |  2 +-=0D
 configure                |  6 +++---=0D
 hw/Makefile.objs         |  1 +=0D
 hw/display/Makefile.objs |  4 +++-=0D
 hw/display/qxl.c         |  2 +-=0D
 hw/i386/Makefile.objs    |  1 +=0D
 include/qemu/module.h    | 28 ++++++++++++++++++++++++++++=0D
 include/ui/qemu-spice.h  | 24 +++++++++++++++---------=0D
 monitor/Makefile.objs    |  3 +++=0D
 monitor/hmp-cmds.c       |  6 ++++++=0D
 scripts/minikconf.py     |  4 ++--=0D
 softmmu/Makefile.objs    |  2 +-=0D
 softmmu/vl.c             |  1 +=0D
 stubs/Makefile.objs      |  2 +-=0D
 ui/Makefile.objs         | 12 ++++++------=0D
 ui/spice-core.c          | 31 +++++++++++++++++++++----------=0D
 ui/spice-display.c       |  2 +-=0D
 util/module.c            | 13 +++++++++++--=0D
 22 files changed, 117 insertions(+), 39 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D



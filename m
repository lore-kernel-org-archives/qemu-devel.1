Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17076C3B186
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D8D2467E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJoNi/L2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D8D2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ycn-0006vd-IS
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 15:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1ybY-0005ap-Au
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1ybW-0001VE-B9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1ybW-0001U7-3G
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581539242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uo6OUUUL9wc6T1GR+QhzDs9SttkwujTnvg+DFcT6Cpk=;
 b=GJoNi/L2ACUhQGy1eNg4N0gMh2Y7zoh2FSlqtHzuCfVAzy4AzuKJAL6Q2OJtcV1EvMOT1j
 mKCx1HUypzsEWbsQ6xQx6mEvwkB4bPXy7761Nwy7H73ndxbfIACtLXYBdDRz+y1VCqwD2/
 eBtLDarJ1Og/EHhJ9NWHHl5KIfAA4Ds=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-yFT7DmI9PCCV32vmf9NjQg-1; Wed, 12 Feb 2020 15:27:16 -0500
Received: by mail-wr1-f70.google.com with SMTP id z15so1319600wrw.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/8ShEv16ibh68iR2Xn39ntksyBo+vXY8veHScioM07c=;
 b=Q5bC2ZdsLqAjnI4pT79fXe3MCE/gBq5pQznGIbCHJ6Bvz1aZZ5FK6OLcHsOGI20jEJ
 nE9G2NLDalT3E3R415Pd/SwsXs4abDsUn8FzGubbHajIjDMrjwqOS8NpKsp27YnHEEUi
 Czpoz+ga8V/FyJKMSWX4g9nBK/sZUX1QfR2bFilW1Mustcd/qMawX5Xc5Sb3NNKWX1h3
 iM/8LVuJy8yMNzMCavZzZcV7SIwdihEq5bCUWLB2pRwyQ93C44KwFfbxZkLLu8OTZ2BH
 dSv87UE4CGa1qyq9uJZWBvQsx6F4a7E2H8P+VEUxAdF/Z7f8nWbIKM9/SIW4ICNIKunF
 4RWA==
X-Gm-Message-State: APjAAAUKqKB29SizpwYU70wk1m/3zfizUG+ff5gwfTHJeChEbdsP0yQS
 MxblcBfVb24HkSTUSieoMy/b75JbYxitN332LSl29yYmnq4sQZC9ms7nCsxJHtEEj+Wth0tB1Nl
 e9P88n/z7fU4UtkM=
X-Received: by 2002:a05:600c:2290:: with SMTP id
 16mr845235wmf.93.1581539234675; 
 Wed, 12 Feb 2020 12:27:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMqu3xw9dVvpGmGKaK5fJLmnCMeSbofoiQXEYnIOupLANivVcJu+SJYaMHR3V/Kmi4pubvFQ==
X-Received: by 2002:a05:600c:2290:: with SMTP id
 16mr845214wmf.93.1581539234399; 
 Wed, 12 Feb 2020 12:27:14 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x14sm1957035wmj.42.2020.02.12.12.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 12:27:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] tests/docker: Update VirGL to v0.8.0
Date: Wed, 12 Feb 2020 21:27:09 +0100
Message-Id: <20200212202709.12665-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212202709.12665-1-philmd@redhat.com>
References: <20200212202709.12665-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: yFT7DmI9PCCV32vmf9NjQg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dave Airlie <airlied@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Building the qemu:debian-amd64 fails when building VirGL:

  make[2]: Entering directory '/usr/src/virglrenderer/src/gallium/auxiliary=
'
    CC       cso_cache/cso_cache.lo
    CC       cso_cache/cso_hash.lo
    CC       os/os_misc.lo
    CC       util/u_debug.lo
    CC       util/u_debug_describe.lo
    CC       util/u_format.lo
    GEN      util/u_format_table.c
  Traceback (most recent call last):
    File "./util/u_format_table.py", line 168, in <module>
      main()
    File "./util/u_format_table.py", line 164, in main
      write_format_table(formats)
    File "./util/u_format_table.py", line 132, in write_format_table
      print("   %s,\t/* is_array */" % (bool_map(format.is_array()),))
    File "/usr/src/virglrenderer/src/gallium/auxiliary/util/u_format_parse.=
py", line 164, in is_array
      return self.array_element() !=3D None
    File "/usr/src/virglrenderer/src/gallium/auxiliary/util/u_format_parse.=
py", line 73, in __eq__
      return self.type =3D=3D other.type and self.norm =3D=3D other.norm an=
d self.pure =3D=3D other.pure and self.size =3D=3D other.size
  AttributeError: 'NoneType' object has no attribute 'type'
  make[2]: Leaving directory '/usr/src/virglrenderer/src/gallium/auxiliary'
  make[2]: *** [Makefile:906: util/u_format_table.c] Error 1
  make[1]: *** [Makefile:631: install-recursive] Error 1

VirGL commits a8962eda1..a613dcc82 fix this problem.
Update to VirGL 0.8.0 which contains them.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/do=
ckerfiles/debian-amd64.docker
index a1d40a56fa..c70c916343 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -28,7 +28,7 @@ RUN apt update && \
         libepoxy-dev \
         libgbm-dev
 RUN git clone https://gitlab.freedesktop.org/virgl/virglrenderer.git /usr/=
src/virglrenderer && \
-    cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
+    cd /usr/src/virglrenderer && git checkout virglrenderer-0.8.0
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --disable-tes=
ts && make install
=20
 # netmap
--=20
2.21.1



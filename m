Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8438DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6AC206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sbzku++W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6AC206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCmK-0006rC-IO
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jyClb-0006SG-Oo
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:18:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48496
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jyCla-0007GG-7y
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595416709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rF0EHGZP2dv3kPOpJMAuWEsermLuCTZkEKShM//f3fI=;
 b=Sbzku++WZ0+bt/Mm63IPjuIq+v7GZ8ZdxqqW8QAlSCRjh80Ic8/dN/LzatWKPrQjBr7PJm
 aBguiH3JpnFStMbWrzFr3bREcMQcBytsO6kGeW7MsMDUQDL+hfC0MUOLjXTHciKmJgbYs8
 hOsVA5uVXiHkyNLzCK7e130OyemiJpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-CAByNdPSPJ-a1AG70cPRKw-1; Wed, 22 Jul 2020 07:18:27 -0400
X-MC-Unique: CAByNdPSPJ-a1AG70cPRKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74BFD800469
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 11:18:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CC915D9D7;
 Wed, 22 Jul 2020 11:18:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 67CDA9D9F; Wed, 22 Jul 2020 13:18:22 +0200 (CEST)
Date: Wed, 22 Jul 2020 13:18:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH] spice: simplify chardev setup
Message-ID: <20200722111822.skfkwlmr5ikhkaqh@sirius.home.kraxel.org>
References: <20200722084935.9601-1-kraxel@redhat.com>
 <lytuxzhpnk.fsf@redhat.com> <lyr1t3hmww.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <lyr1t3hmww.fsf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 12:19:43PM +0200, Christophe de Dinechin wrote:
> 
> On 2020-07-22 at 11:20 CEST, Christophe de Dinechin wrote...
> > On 2020-07-22 at 10:49 CEST, Gerd Hoffmann wrote...
> >> Initialize spice before chardevs.  That allows to register the spice
> >> chardevs directly in the init function and removes the need to maintain
> >> a linked list of chardevs just for registration.
> >>
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > Looks good to me, but I still need to test how this integrates with my work
> > on putting SPICE in a module.
> 
> That part does not seem to work so well. It looks like with this move, the
> init happens before the module is loaded:
> 
>    qemu-system-x86_64 -display spice-app
>    Unexpected error in qemu_chr_open_spice_port() at ui/../chardev/spice.c:307:
>    qemu-system-x86_64: spice not enabled
> 
> I'll try to find the correct fix. Any idea how to address this?

move chardev init from early to normal:

commit 77297a71e6be60997caf2c55c09ce01a8c492bc2
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Wed Jul 22 13:17:28 2020 +0200

    [fixup] spice app

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 40fb2ef57399..03d971b15f0c 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -117,7 +117,6 @@ static void spice_app_atexit(void)
 static void spice_app_display_early_init(DisplayOptions *opts)
 {
     QemuOpts *qopts;
-    ChardevBackend *be = chr_spice_backend_new();
     GError *err = NULL;
 
     if (opts->has_full_screen) {
@@ -162,6 +161,15 @@ static void spice_app_display_early_init(DisplayOptions *opts)
     qemu_opt_set(qopts, "gl", opts->has_gl ? "on" : "off", &error_abort);
     display_opengl = opts->has_gl;
 #endif
+}
+
+static void spice_app_display_init(DisplayState *ds, DisplayOptions *opts)
+{
+    ChardevBackend *be = chr_spice_backend_new();
+    QemuOpts *qopts;
+    GError *err = NULL;
+    gchar *uri;
+
     be->u.spiceport.data->fqdn = g_strdup("org.qemu.monitor.qmp.0");
     qemu_chardev_new("org.qemu.monitor.qmp", TYPE_CHARDEV_SPICEPORT,
                      be, NULL, &error_abort);
@@ -171,13 +179,6 @@ static void spice_app_display_early_init(DisplayOptions *opts)
     qemu_opt_set(qopts, "mode", "control", &error_abort);
 
     qapi_free_ChardevBackend(be);
-}
-
-static void spice_app_display_init(DisplayState *ds, DisplayOptions *opts)
-{
-    GError *err = NULL;
-    gchar *uri;
-
     uri = g_strjoin("", "spice+unix://", app_dir, "/", "spice.sock", NULL);
     info_report("Launching display with URI: %s", uri);
     g_app_info_launch_default_for_uri(uri, NULL, &err);



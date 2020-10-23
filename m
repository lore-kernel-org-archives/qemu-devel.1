Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5EDC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBE420829
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWD81EOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBE420829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwEq-0004Uz-EQ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVwBB-0002Nm-7P
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVwB7-0002L2-QT
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603456093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEFD1ki1mn2HlWZvRDdWLbvnUZcy4Zvea1gOSAcm/aM=;
 b=jWD81EOKO8rL69J4xtamL6e9iRWudZ0icR4FQ+xT/0cOGDeujVgrOufp5jfHuN0sXT/1pN
 DvVEZaI2lobOZJswU2pisMXNkZB5gz3j2smArHVbIF/mAURK/gy+FNv0oG49UchZqTyH7u
 TzPz9U4zUQV/q4xjEITHqY9BlghRYyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-3qT-dl5iPZmcrc0YSMeDtw-1; Fri, 23 Oct 2020 08:28:10 -0400
X-MC-Unique: 3qT-dl5iPZmcrc0YSMeDtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B70F5804B6A;
 Fri, 23 Oct 2020 12:28:09 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B1B96EF42;
 Fri, 23 Oct 2020 12:28:08 +0000 (UTC)
Date: Fri, 23 Oct 2020 14:28:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 3/6] qapi: Remove wrapper struct for simple unions
Message-ID: <20201023122807.GC4793@merkur.fritz.box>
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023101222.250147-4-kwolf@redhat.com>
 <CAJ+F1CJAzbRwab5E7XQUEpTXX1e+DE_QkknoEgvYqmHAeqY2MQ@mail.gmail.com>
 <CAJ+F1CKd24SSYyTje=rVFJa9+Oew2y4OXabP2ZqnqhtW33AoZg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKd24SSYyTje=rVFJa9+Oew2y4OXabP2ZqnqhtW33AoZg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.10.2020 um 13:06 hat Marc-André Lureau geschrieben:
> On Fri, Oct 23, 2020 at 2:40 PM Marc-André Lureau <marcandre.lureau@gmail.com> wrote:
> > On Fri, Oct 23, 2020 at 2:14 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> >> Variants of simple unions are always contained in a wrapper object
> >> called 'data' that serves no real use. When mapping a QAPI object to the
> >> command line, this becomes very visible to users because they have to
> >> add one or more useless 'data.' to many option names.
> >>
> >> As a first step towards avoiding this painful CLI experience, this gets
> >> rid of the 'data' indirection internally: The QAPI parser doesn't use a
> >> wrapper object as the variant type any more, so the indirection is
> >> removed from the generated C types. As a result, the C type looks the
> >> same for flat and simple unions now. A large part of this patch is
> >> mechanical conversion of C code to remove the 'data' indirection.
> >>
> >> Conceptually, the important change is that variants can now have flat
> >> and wrapped representations. For a transitioning period, we'll allow
> >> variants to support both representations in a later patch. Eventually,
> >> the plan is to deprecate and remove wrapped representations entirely,
> >> unifying simple and flat unions.
> >>
> >> The externally visible interfaces stay unchanged: Visitors still expect
> >> the 'data' wrappers, and introspection still shows it.
> >>
> >> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >
> > breaks the build for me:

Oops, apparently I'm not compiling spice code. I've installed the
libraries now and will fix this for v2 (it's just the same mechanical
conversion as elsewhere).

See below for the changes I'm squashing in.

> Other than that, I like the change, and it looks quite
> straightforward. I hope it's acceptable and we are not missing the
> reasons that extra data indirection was necessary.
> 
> Having to support both flat and wrapped versions in the externally visible
> interfaces might be tricky though.

It's actually pretty simple, I have some quickly hacked up draft patches
because Markus wanted to see what the path is for eventually getting rid
of the wrapped versions (and with that, the difference between simple
and flat unions).

Essentially what I'm doing is calling visit_optional("data") and if it's
there I do the visit_start/end_struct thing for wrapped representation,
and if not, it's flat.

This would be problematic if we had a simple union with a variant that
contains an option "data" (because then it would be ambiguous), but in
this case we're lucky for a change.

After that, it's setting the "deprecated" feature on the "data" member,
waiting for two releases and eventually removing the support for wrapped
representation.

I'm expecting the first part to happen in the 6.0 release cycle, and the
removal could be done in 6.2 then.

Kevin


diff --git a/chardev/spice.c b/chardev/spice.c
index 1104426e3a..8d8502dca7 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -258,7 +258,7 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
                                     bool *be_opened,
                                     Error **errp)
 {
-    ChardevSpiceChannel *spicevmc = backend->u.spicevmc.data;
+    ChardevSpiceChannel *spicevmc = &backend->u.spicevmc;
     const char *type = spicevmc->type;
     const char **psubtype = spice_server_char_device_recognized_subtypes();

@@ -294,7 +294,7 @@ static void qemu_chr_open_spice_port(Chardev *chr,
                                      bool *be_opened,
                                      Error **errp)
 {
-    ChardevSpicePort *spiceport = backend->u.spiceport.data;
+    ChardevSpicePort *spiceport = &backend->u.spiceport;
     const char *name = spiceport->fqdn;
     SpiceChardev *s;

@@ -321,14 +321,13 @@ static void qemu_chr_parse_spice_vmc(QemuOpts *opts, ChardevBackend *backend,
                                      Error **errp)
 {
     const char *name = qemu_opt_get(opts, "name");
-    ChardevSpiceChannel *spicevmc;
+    ChardevSpiceChannel *spicevmc = &backend->u.spicevmc;

     if (name == NULL) {
         error_setg(errp, "chardev: spice channel: no name given");
         return;
     }
     backend->type = CHARDEV_BACKEND_KIND_SPICEVMC;
-    spicevmc = backend->u.spicevmc.data = g_new0(ChardevSpiceChannel, 1);
     qemu_chr_parse_common(opts, qapi_ChardevSpiceChannel_base(spicevmc));
     spicevmc->type = g_strdup(name);
 }
@@ -337,14 +336,13 @@ static void qemu_chr_parse_spice_port(QemuOpts *opts, ChardevBackend *backend,
                                       Error **errp)
 {
     const char *name = qemu_opt_get(opts, "name");
-    ChardevSpicePort *spiceport;
+    ChardevSpicePort *spiceport = &backend->u.spiceport;
 
     if (name == NULL) {
         error_setg(errp, "chardev: spice port: no name given");
         return;
     }
     backend->type = CHARDEV_BACKEND_KIND_SPICEPORT;
-    spiceport = backend->u.spiceport.data = g_new0(ChardevSpicePort, 1);
     qemu_chr_parse_common(opts, qapi_ChardevSpicePort_base(spiceport));
     spiceport->fqdn = g_strdup(name);
 }
diff --git a/ui/spice-app.c b/ui/spice-app.c
index 026124ef56..b542e927e5 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -60,7 +60,6 @@ chr_spice_backend_new(void)
     ChardevBackend *be = g_new0(ChardevBackend, 1);
 
     be->type = CHARDEV_BACKEND_KIND_SPICEPORT;
-    be->u.spiceport.data = g_new0(ChardevSpicePort, 1);
 
     return be;
 }
@@ -83,7 +82,7 @@ static void vc_chr_open(Chardev *chr,
     }
 
     be = chr_spice_backend_new();
-    be->u.spiceport.data->fqdn = fqdn ?
+    be->u.spiceport.fqdn = fqdn ?
         g_strdup(fqdn) : g_strdup_printf("org.qemu.console.%s", chr->label);
     vc->parent_open(chr, be, be_opened, errp);
     qapi_free_ChardevBackend(be);
@@ -182,7 +181,7 @@ static void spice_app_display_init(DisplayState *ds, DisplayOptions *opts)
     GError *err = NULL;
     gchar *uri;
 
-    be->u.spiceport.data->fqdn = g_strdup("org.qemu.monitor.qmp.0");
+    be->u.spiceport.fqdn = g_strdup("org.qemu.monitor.qmp.0");
     qemu_chardev_new("org.qemu.monitor.qmp", TYPE_CHARDEV_SPICEPORT,
                      be, NULL, &error_abort);
     qopts = qemu_opts_create(qemu_find_opts("mon"),



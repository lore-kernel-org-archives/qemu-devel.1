Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7945C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266D7215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gy4dZQcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266D7215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQylK-000485-8k
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 16:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQyiG-0002I3-AQ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 16:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQyiE-0007dz-8Z
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 16:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602274197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6J+J+IDrbdIWwyN0vlZZD1/3FzlWpmAl7kXRQGITUA=;
 b=gy4dZQcTgA+ll+IFJai74TzATYmWHumwGlpIR+i/d+7ser65j6O7mLP4SlF0AOoJK/hsSv
 MHtZ3v/hc/4ouCKgXOtgfjYuOpwUWFZ5x4uc9EQzfV66F8rDMH7U0k+9sbVQuw4pEgAczQ
 O1AL/Tg0NNz3b+bfdsbSyWbhcQ7KH9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-zQunGiqFNJiGukoXiv8Kgg-1; Fri, 09 Oct 2020 16:09:55 -0400
X-MC-Unique: zQunGiqFNJiGukoXiv8Kgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43589803F69;
 Fri,  9 Oct 2020 20:09:54 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 555431002382;
 Fri,  9 Oct 2020 20:09:48 +0000 (UTC)
Date: Fri, 9 Oct 2020 16:09:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: fixup! qom: Simplify and merge pointer property getters/setters
Message-ID: <20201009200947.GG7303@habkost.net>
References: <20201009191520.1799419-1-ehabkost@redhat.com>
 <20201009191520.1799419-4-ehabkost@redhat.com>
 <3f01d20b-b172-5fb0-6659-8aafad2ed4be@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3f01d20b-b172-5fb0-6659-8aafad2ed4be@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 09, 2020 at 03:02:58PM -0500, Eric Blake wrote:
> On 10/9/20 2:15 PM, Eduardo Habkost wrote:
> > Both the property getter and setter for pointer properties can
> > simply call the visitor functions directly, instead of making
> > extra copies and requiring additional logic.
> > 
> > Remove the extra copying logic, and merge the getter and setter
> > functions in object_visit_uint*_ptr() accessors.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  qom/object.c | 114 ++++++++++-----------------------------------------
> >  1 file changed, 22 insertions(+), 92 deletions(-)
> > 
> > diff --git a/qom/object.c b/qom/object.c
> > index 6b4dfc279a..3b343fd118 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -2496,119 +2496,57 @@ static void *pointer_property_get_ptr(Object *obj, PointerProperty *prop)
> >      }
> >  }
> >  
> > -static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
> > +static void property_visit_uint8_ptr(Object *obj, Visitor *v, const char *name,
> >                                     void *opaque, Error **errp)
> 
> Indentation is now off.  Several instances.

Oops.  Fixup applied locally.  Thanks!

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
diff --git a/qom/object.c b/qom/object.c
index 3b343fd118..9d3710dec5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2497,7 +2497,7 @@ static void *pointer_property_get_ptr(Object *obj, PointerProperty *prop)
 }
 
 static void property_visit_uint8_ptr(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
+                                     void *opaque, Error **errp)
 {
     PointerProperty *prop = opaque;
     uint8_t *field = pointer_property_get_ptr(obj, prop);
@@ -2505,7 +2505,7 @@ static void property_visit_uint8_ptr(Object *obj, Visitor *v, const char *name,
 }
 
 static void property_visit_uint16_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
+                                      void *opaque, Error **errp)
 {
     PointerProperty *prop = opaque;
     uint16_t *field = pointer_property_get_ptr(obj, prop);
@@ -2513,7 +2513,7 @@ static void property_visit_uint16_ptr(Object *obj, Visitor *v, const char *name,
 }
 
 static void property_visit_uint32_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
+                                      void *opaque, Error **errp)
 {
     PointerProperty *prop = opaque;
     uint32_t *field = pointer_property_get_ptr(obj, prop);
@@ -2521,7 +2521,7 @@ static void property_visit_uint32_ptr(Object *obj, Visitor *v, const char *name,
 }
 
 static void property_visit_uint64_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
+                                      void *opaque, Error **errp)
 {
     PointerProperty *prop = opaque;
     uint64_t *field = pointer_property_get_ptr(obj, prop);


-- 
Eduardo



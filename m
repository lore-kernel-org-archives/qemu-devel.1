Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AACC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659F7206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5QXtTIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659F7206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOFzQ-0003NG-Eo
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOFyT-0002o9-Vu
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOFyQ-0006ue-0E
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601625565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNjuvHpBffh3WOPLbipfiJn3OpFgq5GdgfzDPnc0B+k=;
 b=C5QXtTIfnCIloWlEeNAz/Ad5jYbIX+YuUGEQSH9sXnO4oNWDfwT3DV8iE/shVKkZC9Wx1G
 JrlxLLboddN27drNg9RZ72zB/MCw5SYadf7n5/Q1L0e4KREjsLBRnkdlRDn7n1GBYJj5Ji
 wNNl90jOGfgrmpFUrLMX7m794VgTXoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-s5dQarfRPu-Ih9KwUfLzaQ-1; Fri, 02 Oct 2020 03:59:21 -0400
X-MC-Unique: s5dQarfRPu-Ih9KwUfLzaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65E7B190A3E0;
 Fri,  2 Oct 2020 07:59:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCCB41972A;
 Fri,  2 Oct 2020 07:59:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E46741132784; Fri,  2 Oct 2020 09:59:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 08/13] qapi: Add a 'coroutine' flag for commands
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-9-kwolf@redhat.com>
Date: Fri, 02 Oct 2020 09:59:15 +0200
In-Reply-To: <20200909151149.490589-9-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 9 Sep 2020 17:11:44 +0200")
Message-ID: <87d021oy7g.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hit send too fast.

Kevin Wolf <kwolf@redhat.com> writes:

> This patch adds a new 'coroutine' flag to QMP command definitions that
> tells the QMP dispatcher that the command handler is safe to be run in a
> coroutine.
>
> The documentation of the new flag pretends that this flag is already
> used as intended, which it isn't yet after this patch. We'll implement
> this in another patch in this series.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
[...]
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 78309a00f0..c44d391c3f 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -128,7 +128,7 @@ class QAPISchemaVisitor:
> =20
>      def visit_command(self, name, info, ifcond, features,
>                        arg_type, ret_type, gen, success_response, boxed,
> -                      allow_oob, allow_preconfig):
> +                      allow_oob, allow_preconfig, coroutine):
>          pass
> =20
>      def visit_event(self, name, info, ifcond, features, arg_type, boxed)=
:
> @@ -713,7 +713,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
> =20
>      def __init__(self, name, info, doc, ifcond, features,
>                   arg_type, ret_type,
> -                 gen, success_response, boxed, allow_oob, allow_preconfi=
g):
> +                 gen, success_response, boxed, allow_oob, allow_preconfi=
g,
> +                 coroutine):
>          super().__init__(name, info, doc, ifcond, features)
>          assert not arg_type or isinstance(arg_type, str)
>          assert not ret_type or isinstance(ret_type, str)
> @@ -726,6 +727,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
>          self.boxed =3D boxed
>          self.allow_oob =3D allow_oob
>          self.allow_preconfig =3D allow_preconfig
> +        self.coroutine =3D coroutine
> =20
>      def check(self, schema):
>          super().check(schema)
> @@ -768,7 +770,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
>          visitor.visit_command(
>              self.name, self.info, self.ifcond, self.features,
>              self.arg_type, self.ret_type, self.gen, self.success_respons=
e,
> -            self.boxed, self.allow_oob, self.allow_preconfig)
> +            self.boxed, self.allow_oob, self.allow_preconfig, self.corou=
tine)

Recommend to break the line after preconfig, like you do elsewhere.

> =20
> =20
>  class QAPISchemaEvent(QAPISchemaEntity):
> @@ -1074,6 +1076,7 @@ class QAPISchema:
>          boxed =3D expr.get('boxed', False)
>          allow_oob =3D expr.get('allow-oob', False)
>          allow_preconfig =3D expr.get('allow-preconfig', False)
> +        coroutine =3D expr.get('coroutine', False)
>          ifcond =3D expr.get('if')
>          features =3D self._make_features(expr.get('features'), info)
>          if isinstance(data, OrderedDict):
> @@ -1086,7 +1089,8 @@ class QAPISchema:
>          self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, feat=
ures,
>                                             data, rets,
>                                             gen, success_response,
> -                                           boxed, allow_oob, allow_preco=
nfig))
> +                                           boxed, allow_oob, allow_preco=
nfig,
> +                                           coroutine))

Preexisting: the arguments are kind of squeezed onto the right margin.
Hanging indent would avoid that.  Feel free to ignore.

> =20
>      def _def_event(self, expr, info, doc):
>          name =3D expr['event']
[...]



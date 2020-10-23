Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B129C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA4A208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsFeVs/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA4A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVxin-0000bg-2P
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 10:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVxiB-00006S-AN
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 10:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVxi6-00078A-01
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 10:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603461984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAjyGpPRr6XDWJeTtkJdnD8O3s33SZKFSurjKA9uQY8=;
 b=NsFeVs/z/3AKlDQuaTOq1BiBczr7f/dEue/udRJOwcSg9R5IQD/LDedy7jgXQzWWVj9xnD
 DuNnelOMeoAI259LbxT/0VNvZDzBZaeJ7YESGU+fa4qQXwYUBQKHPt0ifeh2HxQdXPWzJ7
 gL7s9QCbQlD6rco1rfrjG6DGjQJjkk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-oDI8RHIgPYe_E1eU7OHisw-1; Fri, 23 Oct 2020 10:06:21 -0400
X-MC-Unique: oDI8RHIgPYe_E1eU7OHisw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3879C804B76;
 Fri, 23 Oct 2020 14:06:20 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE8FB5D9CC;
 Fri, 23 Oct 2020 14:06:18 +0000 (UTC)
Date: Fri, 23 Oct 2020 16:06:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 3/6] qapi: Remove wrapper struct for simple unions
Message-ID: <20201023140617.GD4793@merkur.fritz.box>
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023101222.250147-4-kwolf@redhat.com>
 <CAJ+F1CJAzbRwab5E7XQUEpTXX1e+DE_QkknoEgvYqmHAeqY2MQ@mail.gmail.com>
 <87h7qlp0nz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87h7qlp0nz.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.10.2020 um 14:49 hat Markus Armbruster geschrieben:
> In addition to that, I get
> 
>     /usr/bin/sphinx-build-3 -Dversion=5.1.50 -Drelease= -Ddepfile=docs/interop.d -Ddepfile_stamp=docs/interop.stamp -b html -d /work/armbru/qemu/bld-x86/docs/interop.p /work/armbru/qemu/docs/interop /work/armbru/qemu/bld-x86/docs/interop
>     Running Sphinx v2.2.2
>     building [mo]: targets for 0 po files that are out of date
>     building [html]: targets for 12 source files that are out of date
>     updating environment: [new config] 12 added, 0 changed, 0 removed
>     reading sources... [  8%] bitmaps
>     reading sources... [ 16%] dbus
>     reading sources... [ 25%] dbus-vmstate
>     reading sources... [ 33%] index
>     reading sources... [ 41%] live-block-operations
>     reading sources... [ 50%] pr-helper
>     reading sources... [ 58%] qemu-ga
>     reading sources... [ 66%] qemu-ga-ref
>     reading sources... [ 75%] qemu-qmp-ref
> 
>     Exception occurred:
>       File "/work/armbru/qemu/docs/sphinx/qapidoc.py", line 187, in _nodes_for_members
>         assert not v.type.base and not v.type.variants
>     AttributeError: 'QAPISchemaBuiltinType' object has no attribute 'base'

FWIW, when I install sphinx on F33 (sphinx-build 3.2.1), master doesn't
even build for me, so I uninstalled it again for now...

But the fix is the following, I'll include it in v2.

Kevin

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index e03abcbb95..75f6721e29 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -183,12 +183,14 @@ class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):
 
         if variants:
             for v in variants.variants:
-                if v.type.is_implicit():
-                    assert not v.type.base and not v.type.variants
-                    for m in v.type.local_members:
-                        term = self._nodes_for_one_member(m)
-                        term.extend(self._nodes_for_variant_when(variants, v))
-                        dlnode += self._make_dlitem(term, None)
+                if v.wrapped:
+                    term = [nodes.literal('', 'data'),
+                            nodes.Text(': '),
+                            nodes.literal('', v.type.doc_type())]
+                    term.extend(self._nodes_for_variant_when(variants, v))
+                    dlnode += self._make_dlitem(term, None)
+                elif v.type.is_implicit():
+                    assert v.type.name == 'q_empty'
                 else:
                     term = [nodes.Text('The members of '),
                             nodes.literal('', v.type.doc_type())]



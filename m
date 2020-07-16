Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA90C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB57020578
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jom5K0O4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB57020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvx05-0005zL-6b
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvwvL-0001sX-4G
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 01:59:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55144
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvwvI-0000gF-Kn
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 01:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594879151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E950rwzW/0jMvyXkAODfH0a7u89O6d6OTvsnWBnIyns=;
 b=Jom5K0O4IzsOnSLoQzgkCWFXzaVHImJrh9xtDwTbUx7lZabcE/FYJ5XV5rKcCFoMhzH1kH
 l2cycxjj8oEimCBOjY6iBm6oixVBe9hSBwB+UtPf4D4DuLpKvmeRQh78fI1HDedc9xIM3N
 vkaxPL4pI4BQ8UtYqNcFNB8Edbc2R4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-fEHs33a5OvecDxLx45MSIA-1; Thu, 16 Jul 2020 01:59:10 -0400
X-MC-Unique: fEHs33a5OvecDxLx45MSIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07C8F106B244;
 Thu, 16 Jul 2020 05:59:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F088017DFE;
 Thu, 16 Jul 2020 05:59:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F3EC11385E0; Thu, 16 Jul 2020 07:59:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Li Qiang <liq3ea@163.com>
Subject: Re: [PATCH v2] tests: qmp-cmd-test: fix memory leak
References: <20200715154117.15456-1-liq3ea@163.com>
Date: Thu, 16 Jul 2020 07:59:04 +0200
In-Reply-To: <20200715154117.15456-1-liq3ea@163.com> (Li Qiang's message of
 "Wed, 15 Jul 2020 08:41:17 -0700")
Message-ID: <874kq8roev.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:59:11
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
Cc: lvivier@redhat.com, thuth@redhat.com, liq3ea@gmail.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Li Qiang <liq3ea@163.com> writes:

> Properly free each test response to avoid memory leak and separate
> qtest_qmp() calls with spare lines, in a consistent manner.
>
> Fixes: 5b88849e7b9("tests/qmp-cmd-test: Add
> qmp/object-add-failure-modes"

The patch also fixes leaks introduced in 442b09b83d and 9fc719b869,
actually.  At least it should, but the patch appears to be incomplete.

>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> Change sincve v1: add detailed commit message
>  
> tests/qtest/qmp-cmd-test.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index c68f99f659..f7b1aa7fdc 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -230,6 +230,8 @@ static void test_object_add_failure_modes(void)
   static void test_object_add_failure_modes(void)
   {
       QTestState *qts;
       QDict *resp;

       /* attempt to create an object without props */
       qts = qtest_init(common_args);
       resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
                        " {'qom-type': 'memory-backend-ram', 'id': 'ram1' } }");
       g_assert_nonnull(resp);
       qmp_assert_error_class(resp, "GenericError");

Doesn't @resp leak here, too?

       /* attempt to create an object without qom-type */
       resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
                        " {'id': 'ram1' } }");
       g_assert_nonnull(resp);
       qmp_assert_error_class(resp, "GenericError");

Likewise.

       /* attempt to delete an object that does not exist */
       resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
                        " {'id': 'ram1' } }");
       g_assert_nonnull(resp);
       qmp_assert_error_class(resp, "GenericError");

Likewise.

       /* attempt to create 2 objects with duplicate id */
       resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
                        " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
>                       " 'props': {'size': 1048576 } } }");
>      g_assert_nonnull(resp);
>      g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +
>      resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>                       " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
>                       " 'props': {'size': 1048576 } } }");
       g_assert_nonnull(resp);
       qmp_assert_error_class(resp, "GenericError");

Likewise.

       /* delete ram1 object */
       resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
> @@ -241,6 +243,7 @@ static void test_object_add_failure_modes(void)
>                       " {'id': 'ram1' } }");
>      g_assert_nonnull(resp);
>      g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
>  
>      /* attempt to create an object with a property of a wrong type */
>      resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
                        " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
                        " 'props': {'size': '1048576' } } }");
> @@ -249,17 +252,20 @@ static void test_object_add_failure_modes(void)
>      g_assert_nonnull(resp);
>      /* now do it right */
>      qmp_assert_error_class(resp, "GenericError");

Likewise.

> +
>      resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>                       " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
>                       " 'props': {'size': 1048576 } } }");
>      g_assert_nonnull(resp);
>      g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
>  
>      /* delete ram1 object */
>      resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
>                       " {'id': 'ram1' } }");
>      g_assert_nonnull(resp);
>      g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
>  
>      /* attempt to create an object without the id */
>      resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
                        " {'qom-type': 'memory-backend-ram',"
> @@ -267,18 +273,21 @@ static void test_object_add_failure_modes(void)
>                       " 'props': {'size': 1048576 } } }");
>      g_assert_nonnull(resp);
>      qmp_assert_error_class(resp, "GenericError");

Likewise.

> +
>      /* now do it right */
>      resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>                       " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
>                       " 'props': {'size': 1048576 } } }");
>      g_assert_nonnull(resp);
>      g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
>  
>      /* delete ram1 object */
>      resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
>                       " {'id': 'ram1' } }");
>      g_assert_nonnull(resp);
>      g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
>  
>      /* attempt to set a non existing property */
>      resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
                        " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
> @@ -286,23 +295,27 @@ static void test_object_add_failure_modes(void)
>                       " 'props': {'sized': 1048576 } } }");
>      g_assert_nonnull(resp);
>      qmp_assert_error_class(resp, "GenericError");

Likewise.

> +
>      /* now do it right */
>      resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>                       " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
>                       " 'props': {'size': 1048576 } } }");
>      g_assert_nonnull(resp);
>      g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
>  
>      /* delete ram1 object without id */
>      resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
>                       " {'ida': 'ram1' } }");
>      g_assert_nonnull(resp);
> +    qobject_unref(resp);
>  
>      /* delete ram1 object */
>      resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
>                       " {'id': 'ram1' } }");
>      g_assert_nonnull(resp);
>      g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
>  
>      /* delete ram1 object that does not exist anymore*/
>      resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
                        " {'id': 'ram1' } }");
       g_assert_nonnull(resp);
       qmp_assert_error_class(resp, "GenericError");

Likewise.

       qtest_quit(qts);
   }



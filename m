Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C34C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C890620657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUjDwhXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C890620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvdLv-0001Vj-RG
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 05:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jvdLI-000160-WE
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:04:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24571
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jvdLG-0001BT-Np
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594803880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHUT2BBaLlNilmq63Y3IQ5dfoo3nKxZ/vHadKMr0CIY=;
 b=QUjDwhXwuRpjQ4EOwqjHCP4gUerVQJuA/5gV5Kf4au06XB7ODNFZT+3eEz6ZrQkFU16LeN
 0t+WCxMlm96nBP2vi5HotQgQXrz+0EF0FIDTUc1Ix6zOXynx2uPKDG0e5Oar73WKuF8PoY
 tvZOdZOEZqJj6dOo4WABA060PXZNpB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-jJc1AsZhNJGFrNbxvAOUVQ-1; Wed, 15 Jul 2020 05:04:39 -0400
X-MC-Unique: jJc1AsZhNJGFrNbxvAOUVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D9B7800597;
 Wed, 15 Jul 2020 09:04:38 +0000 (UTC)
Received: from [10.36.112.108] (ovpn-112-108.ams2.redhat.com [10.36.112.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6574919C58;
 Wed, 15 Jul 2020 09:04:36 +0000 (UTC)
Subject: Re: [PATCH] tests: qmp-cmd-test: fix memory leak
To: Li Qiang <liq3ea@163.com>, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20200714171531.83723-1-liq3ea@163.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8560a4dc-8e44-5465-b121-c0046c1fde54@redhat.com>
Date: Wed, 15 Jul 2020 11:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714171531.83723-1-liq3ea@163.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Li,

On 7/14/20 7:15 PM, Li Qiang wrote:


> Fixes: 5b88849e7b9("tests/qmp-cmd-test: Add
> qmp/object-add-failure-modes"
Thank you for fixing this.

Adding a commit message generally is welcome such as for example:
properly free each test response and separate qtest_qmp() calls with
spare lines, in a consistent manner.


> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/qtest/qmp-cmd-test.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index c68f99f659..f7b1aa7fdc 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -230,6 +230,8 @@ static void test_object_add_failure_modes(void)
>                       " 'props': {'size': 1048576 } } }");
>      g_assert_nonnull(resp);
>      g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +
>      resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
>                       " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
>                       " 'props': {'size': 1048576 } } }");
> @@ -241,6 +243,7 @@ static void test_object_add_failure_modes(void)
>                       " {'id': 'ram1' } }");
>      g_assert_nonnull(resp);
>      g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
>  
>      /* attempt to create an object with a property of a wrong type */
>      resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
> @@ -249,17 +252,20 @@ static void test_object_add_failure_modes(void)
>      g_assert_nonnull(resp);
>      /* now do it right */
>      qmp_assert_error_class(resp, "GenericError");
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
> @@ -267,18 +273,21 @@ static void test_object_add_failure_modes(void)
>                       " 'props': {'size': 1048576 } } }");
>      g_assert_nonnull(resp);
>      qmp_assert_error_class(resp, "GenericError");
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
> @@ -286,23 +295,27 @@ static void test_object_add_failure_modes(void)
>                       " 'props': {'sized': 1048576 } } }");
>      g_assert_nonnull(resp);
>      qmp_assert_error_class(resp, "GenericError");
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
> 
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric



Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997DDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E492076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W51BygUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E492076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPbM-00082E-NX
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joPao-0007bd-Ik
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:58:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35524
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joPan-0005I8-1w
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593082732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t3WBbI/JIJb46I6oxMTQzlwQgOXH6BnFe2ilOyxd0HM=;
 b=W51BygUEQpn/vbsn82G6cawUIkErM7nCOLEpEDXHzKacgxhsGJJbnWvuiuP/jidR5ptEV7
 NvutG6BTKxfUC3hDHDex1tfHdcuhHhqESHMz06YrpvWcKIQ9vIXcXdN8y8uGerOrqbFTXo
 7b1QKhl8mfW3WRISEbY1VWs9ZRtPnOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-zGJCtCv9PgqzvDNB0cRqNg-1; Thu, 25 Jun 2020 06:58:50 -0400
X-MC-Unique: zGJCtCv9PgqzvDNB0cRqNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FE8D107ACCA;
 Thu, 25 Jun 2020 10:58:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 530065D9C5;
 Thu, 25 Jun 2020 10:58:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CEEBA11384D4; Thu, 25 Jun 2020 12:58:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 2/2] tests/qmp-cmd-test: Add qmp/object-add-duplicate-id
References: <20200624194809.26600-1-eric.auger@redhat.com>
 <20200624194809.26600-3-eric.auger@redhat.com>
Date: Thu, 25 Jun 2020 12:58:44 +0200
In-Reply-To: <20200624194809.26600-3-eric.auger@redhat.com> (Eric Auger's
 message of "Wed, 24 Jun 2020 21:48:09 +0200")
Message-ID: <87sgej4djv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Auger <eric.auger@redhat.com> writes:

> This new test checks that attempting to create an object
> with an existing ID gracefully fails.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/qmp-cmd-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index 9f5228cd99..ceb3296691 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -213,6 +213,23 @@ static void test_object_add_without_props(void)
>      qtest_quit(qts);
>  }
>  
> +static void test_object_add_with_duplicate_id(void)
> +{
> +    QTestState *qts;
> +    QDict *resp;
> +
> +    qts = qtest_init(common_args);
> +    resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
> +                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1', 'props': {'size': 4294967296 } } }");
> +    g_assert_nonnull(resp);
> +    g_assert(qdict_haskey(resp, "return"));
> +    resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
> +                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1', 'props': {'size': 4294967296 } } }");
> +    g_assert_nonnull(resp);
> +    qmp_assert_error_class(resp, "GenericError");
> +    qtest_quit(qts);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      QmpSchema schema;
> @@ -225,6 +242,8 @@ int main(int argc, char *argv[])
>  
>      qtest_add_func("qmp/object-add-without-props",
>                     test_object_add_without_props);
> +    qtest_add_func("qmp/object-add-duplicate-id",
> +                   test_object_add_with_duplicate_id);
>      /* TODO: add coverage of generic object-add failure modes */
>  
>      ret = g_test_run();

One test case per error gets tedious real quick.  I'd add a test case
for generic failures (resolving the TODO), test duplicate ID there, and
add a TODO for the remaining generic failures.

No reason to withhold my
Reviewed-by: Markus Armbruster <armbru@redhat.com>



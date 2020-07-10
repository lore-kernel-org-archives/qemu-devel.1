Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE09C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 06:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9FF2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 06:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNHGYgvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9FF2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtmzv-0000ON-Cm
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 02:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jtmz9-0008OK-Ny
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 02:58:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25066
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jtmz7-0002FE-RN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 02:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594364293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zuv9l5TXcDcGP3LvbEIvPpY2i8fVWDd4WetHendCh0s=;
 b=jNHGYgvp3PeOXwLpitz9C+2+J4PqGL++9imDiz3ToQetVHPE0/kC73INgnr6cFijuYWfac
 0A3uPPkMuIkTMp16Kz+06iZy9X0RApmpoK5o837fAUOf7qEvklVmQDRXL+cBJ+iwIKDacI
 +xBpRtzbvkDGwSfXYECgxN5l5ZtNmyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-UswA3Ya0MESTiAFOGGKNMg-1; Fri, 10 Jul 2020 02:58:11 -0400
X-MC-Unique: UswA3Ya0MESTiAFOGGKNMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E984F100D098
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 06:58:09 +0000 (UTC)
Received: from [10.36.112.252] (ovpn-112-252.ams2.redhat.com [10.36.112.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDC707EF80;
 Fri, 10 Jul 2020 06:58:08 +0000 (UTC)
Subject: Re: [PATCH v2] tests: improve performance of device-introspect-test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200710060719.22386-1-thuth@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
 D+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <5a123efd-7c06-4192-28fb-4518dd105f4e@redhat.com>
Date: Fri, 10 Jul 2020 08:58:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710060719.22386-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/2020 08:07, Thomas Huth wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> Total execution time with "-m slow" and x86_64 QEMU, drops from 3
> minutes 15 seconds, down to 54 seconds.
> 
> Individual tests drop from 17-20 seconds, down to 3-4 seconds.
> 
> The cost of this change is that any QOM bugs resulting in the test
> failure will not be directly associated with the device that caused
> the failure. The test case is not frequently identifying such bugs
> though, and the cause is likely easily visible in the patch series
> that causes the failure. So overall the shorter running time is
> considered the more important factor.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> [thuth: Add the tree check to test_device_intro_none() and
>  test_device_intro_abstract(), too, just to be sure...]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Add the tree check to test_device_intro_none() and
>      test_device_intro_abstract(), too
> 
>  When I run the following command, the test time drops from more
>  than 20 minutes to 50 seconds now (wow!):
>  
>  QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 \
>   time tests/qtest/device-introspect-test -m slow > /dev/null
> 
>  tests/qtest/device-introspect-test.c | 60 ++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
> index 9abb5ec889..d68b7856a7 100644
> --- a/tests/qtest/device-introspect-test.c
> +++ b/tests/qtest/device-introspect-test.c
> @@ -105,14 +105,9 @@ static void test_one_device(QTestState *qts, const char *type)
>  {
>      QDict *resp;
>      char *help;
> -    char *qom_tree_start, *qom_tree_end;
> -    char *qtree_start, *qtree_end;
>  
>      g_test_message("Testing device '%s'", type);
>  
> -    qom_tree_start = qtest_hmp(qts, "info qom-tree");
> -    qtree_start = qtest_hmp(qts, "info qtree");
> -
>      resp = qtest_qmp(qts, "{'execute': 'device-list-properties',"
>                            " 'arguments': {'typename': %s}}",
>                 type);
> @@ -120,21 +115,6 @@ static void test_one_device(QTestState *qts, const char *type)
>  
>      help = qtest_hmp(qts, "device_add \"%s,help\"", type);
>      g_free(help);
> -
> -    /*
> -     * Some devices leave dangling pointers in QOM behind.
> -     * "info qom-tree" or "info qtree" have a good chance at crashing then.
> -     * Also make sure that the tree did not change.
> -     */
> -    qom_tree_end = qtest_hmp(qts, "info qom-tree");
> -    g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
> -    g_free(qom_tree_start);
> -    g_free(qom_tree_end);
> -
> -    qtree_end = qtest_hmp(qts, "info qtree");
> -    g_assert_cmpstr(qtree_start, ==, qtree_end);
> -    g_free(qtree_start);
> -    g_free(qtree_end);
>  }
>  
>  static void test_device_intro_list(void)
> @@ -213,16 +193,38 @@ static void test_qom_list_fields(void)
>  static void test_device_intro_none(void)
>  {
>      QTestState *qts = qtest_init(common_args);
> +    g_autofree char *qom_tree_start = qtest_hmp(qts, "info qom-tree");
> +    g_autofree char *qom_tree_end = NULL;
> +    g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
> +    g_autofree char *qtree_end = NULL;
>  
>      test_one_device(qts, "nonexistent");
> +
> +    /* Make sure that really nothing changed in the trees */
> +    qom_tree_end = qtest_hmp(qts, "info qom-tree");
> +    g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
> +    qtree_end = qtest_hmp(qts, "info qtree");
> +    g_assert_cmpstr(qtree_start, ==, qtree_end);
> +
>      qtest_quit(qts);
>  }
>  
>  static void test_device_intro_abstract(void)
>  {
>      QTestState *qts = qtest_init(common_args);
> +    g_autofree char *qom_tree_start = qtest_hmp(qts, "info qom-tree");
> +    g_autofree char *qom_tree_end = NULL;
> +    g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
> +    g_autofree char *qtree_end = NULL;
>  
>      test_one_device(qts, "device");
> +
> +    /* Make sure that really nothing changed in the trees */
> +    qom_tree_end = qtest_hmp(qts, "info qom-tree");
> +    g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
> +    qtree_end = qtest_hmp(qts, "info qtree");
> +    g_assert_cmpstr(qtree_start, ==, qtree_end);
> +
>      qtest_quit(qts);
>  }
>  
> @@ -231,9 +233,12 @@ static void test_device_intro_concrete(const void *args)
>      QList *types;
>      QListEntry *entry;
>      const char *type;
> -    QTestState *qts;
> +    QTestState *qts = qtest_init(args);
> +    g_autofree char *qom_tree_start = qtest_hmp(qts, "info qom-tree");
> +    g_autofree char *qom_tree_end = NULL;
> +    g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
> +    g_autofree char *qtree_end = NULL;
>  
> -    qts = qtest_init(args);
>      types = device_type_list(qts, false);
>  
>      QLIST_FOREACH_ENTRY(types, entry) {
> @@ -243,6 +248,17 @@ static void test_device_intro_concrete(const void *args)
>          test_one_device(qts, type);
>      }
>  
> +    /*
> +     * Some devices leave dangling pointers in QOM behind.
> +     * "info qom-tree" or "info qtree" have a good chance at crashing then.
> +     * Also make sure that the tree did not change.
> +     */
> +    qom_tree_end = qtest_hmp(qts, "info qom-tree");
> +    g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
> +
> +    qtree_end = qtest_hmp(qts, "info qtree");
> +    g_assert_cmpstr(qtree_start, ==, qtree_end);
> +
>      qobject_unref(types);
>      qtest_quit(qts);
>      g_free((void *)args);
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>



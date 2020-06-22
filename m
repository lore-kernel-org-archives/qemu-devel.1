Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41ACC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 20:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4D32075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 20:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC+4koDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4D32075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnSnW-0007cb-0F
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 16:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jnSmt-000764-19
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 16:11:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25394
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jnSmq-00071d-HX
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 16:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592856682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mTc3nTuv3+E95YWblrZ4womgAmwm01Da22NV/Nv8VAA=;
 b=DC+4koDzFcJe0nNOLUQ1Q5FPi0tsMeX0a/azwFR4bJV8STGtRi0h3Z6pU+UbGSIAYEe/n4
 tq2VB4N8OFsdZ+7Yre/iUESvTdphcjXIE9WPHju4dVm2L7a8AT3JC5VwXghTXZ63MpyX65
 69s62s450kjYsJHZybiJ6wsD77aDxVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-plwrIt9uN_G2waASGBkpag-1; Mon, 22 Jun 2020 16:11:20 -0400
X-MC-Unique: plwrIt9uN_G2waASGBkpag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF0D0804004;
 Mon, 22 Jun 2020 20:11:18 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA1E619D61;
 Mon, 22 Jun 2020 20:11:16 +0000 (UTC)
Date: Mon, 22 Jun 2020 22:11:13 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] target/arm: Check supported KVM features globally
 (not per vCPU)
Message-ID: <20200622201113.o7uqsgiuyyvfgmgm@kamzik.brq.redhat.com>
References: <20200619095542.2095-1-philmd@redhat.com>
 <20200619114123.7nhuehm76iwhsw5i@kamzik.brq.redhat.com>
 <CAFEAcA-3keThbaWccv+Rzh4dmnLquSwXMyEOmbMMHgQHM=c-8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-3keThbaWccv+Rzh4dmnLquSwXMyEOmbMMHgQHM=c-8Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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
Cc: kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Haibo Xu <haibo.xu@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 08:57:51PM +0100, Peter Maydell wrote:
> On Fri, 19 Jun 2020 at 12:41, Andrew Jones <drjones@redhat.com> wrote:
> > Can you also post the attached patch with this one (a two patch series)?
> 
> This would be easier to review if you'd just posted it as
> a patch with a Based-on: and a note that it needed to be

OK, will do.

> applied after the bugfix patch. Anyway:
> 
> +    /* Enabling and disabling kvm-no-adjvtime should always work. */
>      assert_has_feature_disabled(qts, "host", "kvm-no-adjvtime");
> +    assert_set_feature(qts, "host", "kvm-no-adjvtime", true);
> +    assert_set_feature(qts, "host", "kvm-no-adjvtime", false);
> 
>      if (g_str_equal(qtest_get_arch(), "aarch64")) {
>          bool kvm_supports_sve;
> @@ -475,7 +497,11 @@ static void
> test_query_cpu_model_expansion_kvm(const void *data)
>          char *error;
> 
>          assert_has_feature_enabled(qts, "host", "aarch64");
> +
> +        /* Enabling and disabling pmu should always work. */
>          assert_has_feature_enabled(qts, "host", "pmu");
> +        assert_set_feature(qts, "host", "pmu", true);
> +        assert_set_feature(qts, "host", "pmu", false);
> 
> It seems a bit odd that we do the same "set true, then
> set false" sequence whether the feature is enabled or not.
> Shouldn't the second one be "set false, then set true" ?

That would be better. Will do.

Thanks,
drew



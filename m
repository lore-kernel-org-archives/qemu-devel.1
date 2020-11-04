Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF45EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065C72225B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLiByez0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065C72225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDVc-00065d-Pd
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaDTW-00056b-1z
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:44:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaDTU-0006JK-Di
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604475895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhV4mDp7Zq+KHCt5ip+rKqCIvhtS9QiERps5GJnAKgg=;
 b=VLiByez0XwsCPJuK0aEmCrCiam0gK3ao9JqqAJUgiSBehiC5fd+F7oKqyPVJXkTjyhbpdQ
 qenwbbveRTrxi63U5qsuqLPaIn9WFUgiJhakZiqFetfQoNEmlg+o7pCJoXBp29jlaR6sTR
 P2Fwcxe4kzLaLWWXWmVv2vgibKfYHno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-pI-wYTjbPUuX-ym33wgSHA-1; Wed, 04 Nov 2020 02:44:54 -0500
X-MC-Unique: pI-wYTjbPUuX-ym33wgSHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32BDE1009E26
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 07:44:53 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AFA76EF7E;
 Wed,  4 Nov 2020 07:44:52 +0000 (UTC)
Subject: Re: [PATCH for-5.2 3/4] qtest: escape device name in
 device-introspect-test
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-4-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9fc66c84-56c4-ce09-524f-2cf8ffc210a4@redhat.com>
Date: Wed, 4 Nov 2020 08:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201103151452.416784-4-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/2020 16.14, Paolo Bonzini wrote:
> device-introspect-test uses HMP, so it should escape the device name
> properly.  Because of this, a few devices that had commas in their
> names were escaping testing.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qtest/device-introspect-test.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
> index 9f22340ee5..f471b0e0dd 100644
> --- a/tests/qtest/device-introspect-test.c
> +++ b/tests/qtest/device-introspect-test.c
> @@ -104,7 +104,9 @@ static QList *device_type_list(QTestState *qts, bool abstract)
>  static void test_one_device(QTestState *qts, const char *type)
>  {
>      QDict *resp;
> -    char *help;
> +    g_autofree char *help;
> +    g_autofree GRegex *comma;
> +    g_autofree char *escaped;
>  
>      g_test_message("Testing device '%s'", type);
>  
> @@ -113,8 +115,9 @@ static void test_one_device(QTestState *qts, const char *type)
>                 type);
>      qobject_unref(resp);
>  
> -    help = qtest_hmp(qts, "device_add \"%s,help\"", type);
> -    g_free(help);
> +    comma = g_regex_new(",", 0, 0, NULL);
> +    escaped = g_regex_replace_literal(comma, type, -1, 0, ",,", 0, NULL);
> +    help = qtest_hmp(qts, "device_add \"%s,help\"", escaped);
>  }

Having "help =" as final statement now, this looks somewhat weird at a first
glance (until you look at the g_autofree at the beginning of the function).
Maybe it's better to drop the help variable completely and just do:
g_free(gtest_hmp(...)) ?

 Thomas



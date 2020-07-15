Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA9AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5C920657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q640Z+xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5C920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhwP-0003G1-Bz
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvhvh-0002Ox-Ka
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:58:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40587
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvhvf-00068x-0Q
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594821514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=M+4XC1SlqIGAn0kUFK1R6xgWcnRLOtW1v2+ZJft6AKE=;
 b=Q640Z+xXk9mDhxuJa4NFYrh4YyOMzlQVEbMfq7Zoo3jLOoEySnBlv8jeYcPtPatPivnfHv
 jByXJO3JkvIDrlID2UDwsP4k7XYoWCLUAHO3Go6ANaKQdDasxMpO5tUPzd2nP4qBLXvjIG
 O0lBybG4eUltNx7Or51jHhB+CYkl2VE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-JTxxyMO3OaelNsAy6I2VQw-1; Wed, 15 Jul 2020 09:58:30 -0400
X-MC-Unique: JTxxyMO3OaelNsAy6I2VQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36991800C64;
 Wed, 15 Jul 2020 13:58:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-26.ams2.redhat.com [10.36.112.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02AC079CE4;
 Wed, 15 Jul 2020 13:58:20 +0000 (UTC)
Subject: Re: [PATCH] fuzz: Expect the cmdline in a freeable GString
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200714174616.20709-1-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7d253e0f-a6ce-b0da-b83b-8afefaf000c1@redhat.com>
Date: Wed, 15 Jul 2020 15:58:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200714174616.20709-1-alxndr@bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, f4bug@amsat.org,
 darren.kenny@oracle.com, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/07/2020 19.46, Alexander Bulekov wrote:
> In the initial FuzzTarget, get_init_cmdline returned a char *. With this
> API, we had no guarantee about where the string came from. For example,
> i440fx-qtest-reboot-fuzz simply returned a pointer to a string literal,
> while the QOS-based targets build the arguments out in a GString an
> return the gchar *str pointer. Since we did not try to free the cmdline,
> we have a leak for any targets that do not simply return string
> literals. Clean up this mess by forcing fuzz-targets to return
> a GString, that we can free.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/fuzz.c        | 13 ++++++-------
>  tests/qtest/fuzz/fuzz.h        |  6 +++---
>  tests/qtest/fuzz/i440fx_fuzz.c |  4 ++--
>  tests/qtest/fuzz/qos_fuzz.c    |  6 +++---
>  4 files changed, 14 insertions(+), 15 deletions(-)
      /* Prepend the arguments that we need */
>      g_string_prepend(cmd_line,
>              TARGET_NAME " -display none -machine accel=qtest -m 64 ");
> -    return cmd_line->str;
> +    return cmd_line;
>  }
>  
>  /*
> @@ -189,7 +189,7 @@ static void walk_path(QOSGraphNode *orig_path, int len)
>      g_free(path_str);
>  }
>  
> -static const char *qos_get_cmdline(FuzzTarget *t)
> +static GString *qos_get_cmdline(FuzzTarget *t)
>  {
>      /*
>       * Set a global variable that we use to identify the qos_path for our
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

... and queued to my "qtest-next" branch.

 Thanks,
  Thomas



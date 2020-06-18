Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C1BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89065206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIF/XF8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89065206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlp5M-0006vz-Pg
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 03:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlp4k-0006RS-RT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:35:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlp4j-00084z-C6
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592465704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=6eOlkwcqhGRkrWydzBEBlp5kyXsOcCaPVA6oXJn46ug=;
 b=FIF/XF8exbnqgRMemHKnLkUJ1k4BvkjRVjTE1+lrflYmVJbZv+XWnXhkr0fUBbBm9CYI8o
 0uN5a8mvCeE2U38nedyffFUCs4lyxVh93/lYz6PONXkZjbx1FkTzgUc+Acs19EeYVVjj2b
 wZrVqPpGtaZ4TtEsoYhhG7yDoB06K6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-cVFCwAYdNVaeL_f_oH4opA-1; Thu, 18 Jun 2020 03:35:02 -0400
X-MC-Unique: cVFCwAYdNVaeL_f_oH4opA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 762E0107B273;
 Thu, 18 Jun 2020 07:35:01 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-95.ams2.redhat.com [10.36.114.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF79B10246E2;
 Thu, 18 Jun 2020 07:34:53 +0000 (UTC)
Subject: Re: [PATCH v8 13/21] main: keep rcu_atfork callback enabled for qtest
To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-14-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <199e36b2-a509-00ed-94a7-0624753eb53f@redhat.com>
Date: Thu, 18 Jun 2020 09:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200129053357.27454-14-alxndr@bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/2020 06.34, Bulekov, Alexander wrote:
> The qtest-based fuzzer makes use of forking to reset-state between
> tests. Keep the callback enabled, so the call_rcu thread gets created
> within the child process.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  vl.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index bb77935f04..cf8e2d3ebb 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3794,7 +3794,14 @@ void qemu_init(int argc, char **argv, char **envp)
>      set_memory_options(&ram_slots, &maxram_size, machine_class);
>  
>      os_daemonize();
> -    rcu_disable_atfork();
> +
> +    /*
> +     * If QTest is enabled, keep the rcu_atfork enabled, since system processes
> +     * may be forked testing purposes (e.g. fork-server based fuzzing)
> +     */
> +    if (!qtest_enabled()) {
> +        rcu_disable_atfork();
> +    }
>  
>      if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
>          error_reportf_err(err, "cannot create PID file: ");

 Hi Alexander,

I think this patch might maybe not work as expected: The qtest_enabled()
has been added before configure_accelerators() is called in main(). So
qtest_enabled() should always return "false" and thus
rcu_disabled_fork() is still called in any case... could you please
double-check whether it works for you and I just made a mistake, or
whether this is a bug indeed?

 Thanks,
  Thomas



Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221F4C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8049922245
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQLbSZMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8049922245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeaS-0005oL-9Q
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZeUU-0005qR-10
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:23:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZeUL-0007GF-OK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604341405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Em5DBBElZI6ZGMkybu9adwpdfl8sVR8eOTjN/ebMxsI=;
 b=IQLbSZMYshRpSVzmDIxS4s5Py9iw+aR9VQ7uwwUIc8nQavPBDVKb0K4ceIlNtPw0GEvBIU
 jghiPF9+iUgPICrlgS0zSVJWjWG5hAthARHUUYgURhaE/1DKp1+9a0NfvE/STU6vY9RNnt
 UFQn2UbP2vlk2y+eP8aqwlMQ993TL0U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-5l1iAe1ZPlSu2DzCE-mk3A-1; Mon, 02 Nov 2020 13:23:13 -0500
X-MC-Unique: 5l1iAe1ZPlSu2DzCE-mk3A-1
Received: by mail-wm1-f72.google.com with SMTP id s85so2153284wme.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Em5DBBElZI6ZGMkybu9adwpdfl8sVR8eOTjN/ebMxsI=;
 b=qlQ/XTUGewRHo9jVKBxXuIAyiDGcZoqJLLk/fHgbA4AxaXSeZ6QjZM58vm9ew6fTB2
 jxfl2cxJ3Y4bERqu5mU7G7D/tE4Byf0/X/kZXmCZnFr/jrY7VCu0s7RKd5a7uMuHkQxQ
 v8YgGglVoUAP97yaNU7DqY0J2ISVIbfKO9PhvONZIAi/vIohTDBQGgVqGGyW+DY+fQoC
 kEOaX0c7yQGcoI7xLbojc8iXn0tOb4mvbkhWB3/LhXqcQnVoeX1MfErDmZ4ex4//ZD+Q
 X3mZrkf+VC/DhNVYzLwSkxEiURywqfNcx6pTPA0UmKYe1MtGQ1LhBYD7mHigRr68swkE
 WjIQ==
X-Gm-Message-State: AOAM533iMIUlTZ8HTphuE/Dgmsx6wDtsqOzi4LTIVP1t11ym7AmB9fc6
 abjw4PN3KgIHQSYkF+sBLCKZr4mRY7LPWhP5k3qyTv5wBvG/Hw1gDa+Ha3z4ZqADjLqc8P+2QQq
 ECtmSTyK4gMmDKTE=
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr21541129wro.24.1604341392374; 
 Mon, 02 Nov 2020 10:23:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVcswGanye+CoutzEz7smoTlbFnjBehY7zMqxK3S16UTvGW6hqczjP/jImQanYs0/liZOliw==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr21541114wro.24.1604341392183; 
 Mon, 02 Nov 2020 10:23:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id f13sm23838733wrp.12.2020.11.02.10.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 10:23:11 -0800 (PST)
Subject: Re: [PATCH] qtest: add a reproducer for LP#1878642
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201102163336.115444-1-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7825a2e7-dd79-c4ea-c3f7-673743619d89@redhat.com>
Date: Mon, 2 Nov 2020 19:23:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102163336.115444-1-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/11/20 17:33, Alexander Bulekov wrote:
> https://bugs.launchpad.net/qemu/+bug/1878642
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
> 
> Based-on: <20200717151705.18611-1-f4bug@amsat.org>
> 
> The added testcase will fail, unless this ^^^ patch is applied.
> 
>  tests/qtest/fuzz-test.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c
> index 2f38bb1ec2..9cb4c42bde 100644
> --- a/tests/qtest/fuzz-test.c
> +++ b/tests/qtest/fuzz-test.c
> @@ -34,6 +34,19 @@ static void test_lp1878263_megasas_zero_iov_cnt(void)
>      qtest_quit(s);
>  }
>  
> +static void test_lp1878642_pci_bus_get_irq_level_assert(void)
> +{
> +    QTestState *s;
> +
> +    s = qtest_init("-M pc-q35-5.0 "
> +                   "-nographic -monitor none -serial none "
> +                   "-d guest_errors -trace pci*");
> +
> +    qtest_outl(s, 0xcf8, 0x8400f841);
> +    qtest_outl(s, 0xcfc, 0xebed205d);
> +    qtest_outl(s, 0x5d02, 0xebed205d);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      const char *arch = qtest_get_arch();
> @@ -43,6 +56,8 @@ int main(int argc, char **argv)
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          qtest_add_func("fuzz/test_lp1878263_megasas_zero_iov_cnt",
>                         test_lp1878263_megasas_zero_iov_cnt);
> +        qtest_add_func("fuzz/test_lp1878642_pci_bus_get_irq_level_assert",
> +                       test_lp1878642_pci_bus_get_irq_level_assert);
>      }
>  
>      return g_test_run();
> 

Queued, thanks.

Paolo



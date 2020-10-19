Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C4BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BC82223C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdtrbIUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BC82223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXqa-0006Dw-Pk
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUXmN-0002em-6o
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUXmL-0002m0-3n
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603123973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQpcYyIs6dBhaxIqbwXb8JwMFZPuxTa4HBaDcfLZq28=;
 b=DdtrbIUcKG7FSWb/wepdCDM4pjbUzXHaDzfwoHWKdhGCIAAzQtEylidBFQY5rjew2w5gIe
 WQjSpghjq71BNLDUR5C27BzxVLh2sFZ+db9+bWuJWC7x5mencljT7C5GgJFXpYcynyeFdj
 xmWrF4XSvR9w6I9IHs2VjY28KBZjzms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-mQ2tddmwMSmNtTsZTugByw-1; Mon, 19 Oct 2020 12:12:49 -0400
X-MC-Unique: mQ2tddmwMSmNtTsZTugByw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 452331800D41;
 Mon, 19 Oct 2020 16:12:46 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE9CB6EF5B;
 Mon, 19 Oct 2020 16:12:44 +0000 (UTC)
Subject: Re: [PATCH] hw/arm/nseries: Fix loading kernel image on n8x0 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201019095148.1602119-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <918b0dbd-668c-a3ab-0819-cb77be5f32b9@redhat.com>
Date: Mon, 19 Oct 2020 18:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201019095148.1602119-1-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/2020 11.51, Philippe Mathieu-Daudé wrote:
> Commit 7998beb9c2e removed the ram_size initialization in the
> arm_boot_info structure, however it is used by arm_load_kernel().
> 
> Initialize the field to fix:
> 
>   $ qemu-system-arm -M n800 -append 'console=ttyS1' \
>     -kernel meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0
>   qemu-system-arm: kernel 'meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0' is too large to fit in RAM (kernel size 1964608, RAM size 0)
> 
> Noticed while running the test introduced in commit 050a82f0c5b
> ("tests/acceptance: Add a test for the N800 and N810 arm machines").
> 
> Fixes: 7998beb9c2e ("arm/nseries: use memdev for RAM")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/nseries.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index e48092ca047..76fd7fe9854 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -1318,6 +1318,7 @@ static void n8x0_init(MachineState *machine,
>          g_free(sz);
>          exit(EXIT_FAILURE);
>      }
> +    binfo->ram_size = machine->ram_size;
>  
>      memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE,
>                                  machine->ram);
> 

Fixes the test in "make check-acceptance" for me:

Tested-by: Thomas Huth <thuth@redhat.com>



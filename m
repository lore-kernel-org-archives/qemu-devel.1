Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEC9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383782256C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIxv86lS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383782256C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvO83-0002v6-DB
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvO5a-0007p1-Gp
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:47:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvO5Y-0007Q4-7P
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594745247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3Hj1HpnqMGL+qUM7RK75TW1YmMeTVHkj2eXTxgvllRU=;
 b=SIxv86lSSgSM3jPHULWolBSaO3GBw8pi6q3KOTgZ708ATIaFUk8nD4MFfiyhNvNMqXtytF
 skl0PE9BMxy/M6WEW/7gi4Zm/Sf2e2+HyJmI+vA1O8RxeWUqPQGIHWyAupSDJTM9mIZMa7
 UhCYStjMupLSVM9sTQxfbpKV0JvSR9w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442--wRCBCVvOyanZUnsnnWN9Q-1; Tue, 14 Jul 2020 12:47:06 -0400
X-MC-Unique: -wRCBCVvOyanZUnsnnWN9Q-1
Received: by mail-wr1-f69.google.com with SMTP id b8so22479705wro.19
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3Hj1HpnqMGL+qUM7RK75TW1YmMeTVHkj2eXTxgvllRU=;
 b=LJw415C96eizuePw6Io8mspr8oUbh0S/nTqd/mg9e4mBxIs7xRHicOJFbQQ00h+A6b
 suRw1Gw4npQdPb3M+40e4bJABfLhA6HdLMGejDTttyC+81yrml2V9BTIBTkE4ETxpATn
 FFD2PB+4VwVDjnfwflA8ORqSUCGMXcg0Oa/urZi8rCO4UFM3HS9bhI1U2gTxJcxvVNmL
 1FCq/sv9b+PGhNmPc1TbrPBOnTSPUAAp69K7tqpodPh7FgBdEKLepVfZTp1a82ceAYn+
 PRxUs9oGYk4Ttjisq6KtqavDAiLeBRPuRsFVdFPYKso5aGY10uWKxeh+7ZfYT+Qtsdwf
 Ao8A==
X-Gm-Message-State: AOAM532S7Xl25vw1p+/vRnZFX0MfXOTP3Bm7Kd4NIj5z47bX8+AEJxzb
 ErQxJzcCUSR6KCz3Wh0QZtvxZwdo4jDPkOXo2ESh0G7uqf6QJmTq/qaAJB3N1RaVWHK6kzK63On
 A3cfDf9GUHF9OQ9Q=
X-Received: by 2002:a1c:6788:: with SMTP id b130mr4932008wmc.100.1594745225081; 
 Tue, 14 Jul 2020 09:47:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy66jSz05zkMvtF4HIYs7J8xiA0CKBDoyiBTHZxDSHVw5qdXD6mjtryxQpDIM/PDr6U6XcLUQ==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr4931988wmc.100.1594745224867; 
 Tue, 14 Jul 2020 09:47:04 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y189sm6057602wmd.27.2020.07.14.09.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 09:47:04 -0700 (PDT)
Subject: Re: [PATCH] hmp: fix memory leak in qom_composition_compare()
To: Li Qiang <liq3ea@163.com>, pbonzini@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, armbru@redhat.com
References: <20200714151152.54760-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <39e02324-eaa1-1aea-96d2-fba48483b6c0@redhat.com>
Date: Tue, 14 Jul 2020 18:47:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714151152.54760-1-liq3ea@163.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
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

On 7/14/20 5:11 PM, Li Qiang wrote:
> While 'make chekc', I got following error:
> 
> root@ubuntu:~/qemu# ./tests/qtest/device-introspect-test
> /x86_64/device/introspect/list: OK
> /x86_64/device/introspect/list-fields: OK
> /x86_64/device/introspect/none:
> =================================================================
> ==53741==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 212 byte(s) in 20 object(s) allocated from:
>     #0 0x7f3b6319cb40 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xdeb40)
>     #1 0x7f3b62805ab8 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x51ab8)
> 
> SUMMARY: AddressSanitizer: 212 byte(s) leaked in 20 allocation(s).
> tests/qtest/libqtest.c:166: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
> Aborted (core dumped)
> 
> This is because the 'info qom-tree' path has a memory leak and qemu
> exit 1. The leak is in 'qom_composition_compare'. This patch fixes this.
> 
> Fixes: e8c9e65816f("qom: Make "info qom-tree" show children sorted")
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  qom/qom-hmp-cmds.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index 9ed8bb1c9f..3547d5ba4e 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -96,8 +96,10 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent);
>  
>  static int qom_composition_compare(const void *a, const void *b, void *ignore)
>  {
> -    return g_strcmp0(a ? object_get_canonical_path_component(a) : NULL,
> -                     b ? object_get_canonical_path_component(b) : NULL);
> +    g_autofree char *t1 = a ? object_get_canonical_path_component(a) : NULL;
> +    g_autofree char *t2 = b ? object_get_canonical_path_component(b) : NULL;
> +
> +    return g_strcmp0(t1, t2);
>  }
>  
>  static int insert_qom_composition_child(Object *obj, void *opaque)
> 

Ah you won the race with Markus:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04740.html

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>



Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C4C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68082065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXf1FRjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68082065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvj2C-0005PI-5b
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 11:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jviwA-00067D-FM
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:03:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30273
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jviw8-0004uE-Fp
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594825387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I1h24an3vYlBDWkMm/4BfzBWNqu0PvO5FvEnUc3o0cE=;
 b=gXf1FRjS1c1PzdzTvwhWotXXTPAjokDSTdgwHvEEDnD2uSsp1hHFTPT31Wt7aZV72ERZj9
 AL47m0GmtQo91Pb4q+damzHfvk19H1NWXu4dAbzhVLtAbl+RJXq6CmboNXUAUxD7n5zQqU
 qohRE5X0dBYDIAiVqA+0142SIxysCRk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-gxASuQJAOb-0t_7bTe_XiA-1; Wed, 15 Jul 2020 11:02:45 -0400
X-MC-Unique: gxASuQJAOb-0t_7bTe_XiA-1
Received: by mail-wm1-f71.google.com with SMTP id f68so4104734wmf.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 08:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=I1h24an3vYlBDWkMm/4BfzBWNqu0PvO5FvEnUc3o0cE=;
 b=qVSPfBZ6IvY9edTB0UCRvmLExHWIiU6l0G3VwnwiwAxoQ5lsavI6yhGyNY4Q5wBg8L
 ipM9MnFT3qXVtw5jO42WL+3EYBEZmsPXNm/7hse5/ewzAu89gsxPKnXtVKcMNY0OaVKm
 4o5WOmq0BnqMYWP1H1/jh1embdPcg2Ad+BKprI6HDZJp6XJM+0utZxAMgX9JpSVONClb
 NSjhejxC5/gn5W/hM16onShFJrGb9RK9ARG4PcjClMuRWRuVQ+HtxO0/EOAEgOC1Tlrr
 X4Kp8XfqOqXJFteYeYy2p1SMVb0u4eicJDiioqkLSDCIMzkrr4s85nBsBprVn+c477bA
 P7ng==
X-Gm-Message-State: AOAM5301WZREaszl442k1ypJpGnsPRDkqGKh+yP5fJ5RaLOqYErH5JDM
 Xph2Ek7gRBk0vbplh36QZpLYaeSGbsCzdF8sAUElHYRidNoo46fdguPR4864i3Bkv5ggulr6EUC
 q5Nt5s3IFbeW8fFY=
X-Received: by 2002:a5d:684f:: with SMTP id o15mr11983144wrw.148.1594825363910; 
 Wed, 15 Jul 2020 08:02:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeyKTrQY4aIA7j6MdaHLBOqb2uIk/2irIWLdimvFz/0fRiwPfrT1EaUUI+P2GFHk4h/RKH8A==
X-Received: by 2002:a5d:684f:: with SMTP id o15mr11983122wrw.148.1594825363714; 
 Wed, 15 Jul 2020 08:02:43 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s15sm3677838wmj.41.2020.07.15.08.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 08:02:42 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] net/colo: Remove unused trace event
To: qemu-devel@nongnu.org
References: <159482499077.11884.3340115804865619987@07a7f0d89f7d>
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
Message-ID: <8cff3dbe-9d98-f587-b9aa-bc7f41f23e57@redhat.com>
Date: Wed, 15 Jul 2020 17:02:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159482499077.11884.3340115804865619987@07a7f0d89f7d>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com,
 jasowang@redhat.com, chen.zhang@intel.com, r.bolshakov@yadro.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/20 4:56 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200715143130.11164-1-philmd@redhat.com/
> 
> In file included from /tmp/qemu-test/build/net/trace.h:6:0,
>                  from /tmp/qemu-test/src/net/colo-compare.c:18:
> /tmp/qemu-test/src/net/colo-compare.c: In function 'colo_compare_packet_payload':
> /tmp/qemu-test/src/net/colo-compare.c:330:40: error: 'TRACE_COLO_COMPARE_MISCOMPARE_ENABLED' undeclared (first use in this function)
>      if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
>                                         ^
> /tmp/qemu-test/src/trace/control.h:120:7: note: in definition of macro 'trace_event_get_state_backends'
> ---
> /tmp/qemu-test/src/trace/control.h:120:7: note: in definition of macro 'trace_event_get_state_backends'
>      ((id ##_ENABLED) && id ##_BACKEND_DSTATE())
>        ^
> /tmp/qemu-test/src/net/colo-compare.c:330:5: error: implicit declaration of function 'TRACE_COLO_COMPARE_MISCOMPARE_BACKEND_DSTATE' [-Werror=implicit-function-declaration]
>      if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {

Ah, interesting :)



Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08CFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AD5206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3BWAgm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AD5206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTnm-00028h-Nq
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtTn5-0001G6-0A
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:28:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22290
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtTn3-000874-8T
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594290508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K9ctq1FDF0rB6Mx0Cnye0CpnGBH4W0D7Kox0avHd/D0=;
 b=O3BWAgm30pUudfPG+p4y72S3DM0A1GJi95zXgRm0KhyUARZufDU9MJthDHJ0rAjmihfOWw
 L0KypTPaw8Y1viLc6lrsAiQMOZCyXQJAlzxGDv/XtQhN/qg3SrKCNaHRPg4QYfDzBni/t9
 kP4d1ZNYEnoR9OqpRhUmKcjyMQiq3Qk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-W6aXms_GO4KCCgajsd4S5w-1; Thu, 09 Jul 2020 06:28:27 -0400
X-MC-Unique: W6aXms_GO4KCCgajsd4S5w-1
Received: by mail-wm1-f71.google.com with SMTP id g187so1839899wme.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 03:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=K9ctq1FDF0rB6Mx0Cnye0CpnGBH4W0D7Kox0avHd/D0=;
 b=t78lHzbGwAT4XhZW6+0aJOKK1//ejCPZV6PBnp7Q0VUdMk8gV93R4BRpE9p4mLihJf
 caSiKukeeoUPTHtzUxdXRfIiQvO+9Xr2B8vIcIR710CXG62Ysn8xOvScnTbtjv+bQvAe
 EYtktvi7VheehDRFMlfGie+xRBxpX7s5OQJVJcREg4a5QeuWn+RfVjQweAJUyx7XprNL
 AztFUTL9OvGCWSuxN9Oq9KcrUun/hOAXpHU2/tDZzPQH9F4zQc0TQHqaB+o5AgcMoS4+
 9VOd8ioMExaS7qDoKz+Lojp48s7v61GC29HN4nQtKP6dGYlJ96y9hreRwwT95m6itSFJ
 0EWg==
X-Gm-Message-State: AOAM530qzv0SULEg9z4eGos1VVM+Ogz8yZwKLH7/qr3pKUhhVLTBuh2l
 YNR8uUqjyNhQtEvaGwJEe4+Z/thjPPYVbyLmKABZ3JbwV+5Muz4CuB2s+uOvTRq2ibtpBCTIpVk
 DfyIcln98DqAi468=
X-Received: by 2002:a05:6000:86:: with SMTP id
 m6mr29862166wrx.173.1594290505825; 
 Thu, 09 Jul 2020 03:28:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyp8IEokrYsA6tMx4HPbQda5ax+PfqvaedpR5P/lMdk2TbTnc94rvLRwNJUMDyObOr8+fm4aw==
X-Received: by 2002:a05:6000:86:: with SMTP id
 m6mr29862154wrx.173.1594290505661; 
 Thu, 09 Jul 2020 03:28:25 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a22sm4015534wmj.9.2020.07.09.03.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 03:28:25 -0700 (PDT)
Subject: Re: [PATCH] tests/qtest/fuzz: Add missing spaces in description
To: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-devel@nongnu.org
References: <20200709083719.22221-1-thuth@redhat.com>
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
Message-ID: <1b4acaae-f80b-68cd-8798-5fc5e0ce1021@redhat.com>
Date: Thu, 9 Jul 2020 12:28:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709083719.22221-1-thuth@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 10:37 AM, Thomas Huth wrote:
> There should be a space between "forking" and "for".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/fuzz/virtio_scsi_fuzz.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> index 51dce491ab..3a9ea13736 100644
> --- a/tests/qtest/fuzz/virtio_scsi_fuzz.c
> +++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> @@ -191,7 +191,7 @@ static void register_virtio_scsi_fuzz_targets(void)
>  {
>      fuzz_add_qos_target(&(FuzzTarget){
>                  .name = "virtio-scsi-fuzz",
> -                .description = "Fuzz the virtio-scsi virtual queues, forking"
> +                .description = "Fuzz the virtio-scsi virtual queues, forking "
>                                  "for each fuzz run",
>                  .pre_vm_init = &counter_shm_init,
>                  .pre_fuzz = &virtio_scsi_pre_fuzz,
> @@ -202,7 +202,7 @@ static void register_virtio_scsi_fuzz_targets(void)
>  
>      fuzz_add_qos_target(&(FuzzTarget){
>                  .name = "virtio-scsi-flags-fuzz",
> -                .description = "Fuzz the virtio-scsi virtual queues, forking"
> +                .description = "Fuzz the virtio-scsi virtual queues, forking "
>                  "for each fuzz run (also fuzzes the virtio flags)",
>                  .pre_vm_init = &counter_shm_init,
>                  .pre_fuzz = &virtio_scsi_pre_fuzz,
> 

Uh I thought we had fixed these already :/

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>



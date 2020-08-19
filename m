Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7ADC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 03:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB4F2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 03:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+TcEzuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB4F2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ES8-0001LY-5V
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 23:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8ERS-0000HF-8d
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 23:07:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34836
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8ERQ-0003P3-AF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 23:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597806427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=979V5Vd6/uGHDNqVqRyxWv43guOgWI6Yur8ZiVkaDL8=;
 b=i+TcEzuEFzkEHA98MQXDZ5HOGiFyjjuCOzaIriTLIEbDX9Xhr+LHzxiJwBihBlPP69qvUr
 qs41vrWCVup110R5chxTz6ZYOeD5bAeMnUpgWhyxEOttDNKJopKvz96goIbJX0z3R9KzZP
 xUlqlN07Aruvz+4mCPVq3tsayF2sqZg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-F13gMjDbPfWbyRhYuclldw-1; Tue, 18 Aug 2020 23:07:04 -0400
X-MC-Unique: F13gMjDbPfWbyRhYuclldw-1
Received: by mail-wm1-f70.google.com with SMTP id k204so441475wmb.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 20:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=979V5Vd6/uGHDNqVqRyxWv43guOgWI6Yur8ZiVkaDL8=;
 b=dGDX9nT0Ye6ILPFz6lhUezytQz4DBnCb1SMFol4mMWiGV0VqzR7puLRCSHCyQS7hrA
 PuZVHPznKlADtW3aMtPn8NNect0LJHZ+EElt4oYTGhaJKrBfmaRkAdd0SWjb5R4VsiE+
 nvBq4QRFuPH0NjL+8I71RQIEMrs6j11RAyRGM8Bq8dAyiZaYlbgIa5URxE8yYZlOVxEH
 K/u0CQ+ILcAXPbClB+BSevkEHH7R8EeyfITJx3Windy/Vtz5KIqUNV9gJeuEsXSw0K8d
 cXPEuWQziDXkGbfva4py3RCeloEaUOPM3iZpx4nQWjh4ZJEz2+PwDjiB4x3Fl6FlSfeo
 DAqQ==
X-Gm-Message-State: AOAM533vCxQ84kpeCHKVQ9T3F8s8pBe3oAJ74dXqktiR9ef5iOmqpkut
 i6+3snJw/wW847A85+lJDWix6aMdCTInv7of5SfzojVuWTGg/qJQujblIF7zAVqikg2czacv4LX
 9BhZq0X5igeWmxMM=
X-Received: by 2002:a5d:4984:: with SMTP id r4mr22536814wrq.401.1597806422938; 
 Tue, 18 Aug 2020 20:07:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqaJEH7POKiKMn+svOtbtaT4/JoTfBuXmvf0rFdSkg7jSufO9fIi1Ls0+2JacS6ulirhZAQA==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr22536786wrq.401.1597806422692; 
 Tue, 18 Aug 2020 20:07:02 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o7sm37683851wrv.50.2020.08.18.20.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 20:07:02 -0700 (PDT)
Subject: Re: [PATCH v5 6/8] sparc/sun4m: Remove main_cpu_reset()
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20200819024220.587612-1-bauerman@linux.ibm.com>
 <20200819024220.587612-7-bauerman@linux.ibm.com>
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
Message-ID: <a5bf6f7f-e2a7-4e4d-6ddf-c697cea18b4e@redhat.com>
Date: Wed, 19 Aug 2020 05:07:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819024220.587612-7-bauerman@linux.ibm.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:06:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 4:42 AM, Thiago Jung Bauermann wrote:
> We rely on cpu_common_reset() to set cs->halted to 0, so main_cpu_reset()
> is pointless.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/sparc/sun4m.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index cf7dfa4af5..22c51dac8a 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -218,15 +218,6 @@ static void dummy_cpu_set_irq(void *opaque, int irq, int level)
>  {
>  }
>  
> -static void main_cpu_reset(void *opaque)
> -{
> -    SPARCCPU *cpu = opaque;
> -    CPUState *cs = CPU(cpu);
> -
> -    cpu_reset(cs);
> -    cs->halted = 0;
> -}
> -
>  static void secondary_cpu_reset(void *opaque)
>  {
>      SPARCCPU *cpu = opaque;
> @@ -827,9 +818,7 @@ static void cpu_devinit(const char *cpu_type, unsigned int id,
>      env = &cpu->env;
>  
>      cpu_sparc_set_id(env, id);
> -    if (id == 0) {
> -        qemu_register_reset(main_cpu_reset, cpu);
> -    } else {
> +    if (id != 0) {
>          qemu_register_reset(secondary_cpu_reset, cpu);
>          cs = CPU(cpu);
>          cs->halted = 1;
> 



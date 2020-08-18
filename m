Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B769CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73614207DE
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g46E7Esa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73614207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k81I5-0008Fq-Ly
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 09:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k81HJ-0007Gc-NM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:03:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25101
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k81HH-00075Z-WB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597755827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MFwELZAUGhpkdXfHISM+0/NgEXub0Zg2vTlYw/nFjkc=;
 b=g46E7EsaU+LcmGV80rQIveMTLZJy/FP4SvrBIPwJg1TeZhbwGVDM1YVN/kfC8w5PnRtd5O
 OKJ6y2xJ8SeZYNhs4wQ+r6xD5Zm2JgXdR/1/WBIm9ElBe8Adla4EA9reY4m2afrxbXuVJH
 sjI7L/xOc46uqNPdgaa96YlrgWPE9Q8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-cahBEwrqPHywZxXDdL8WOw-1; Tue, 18 Aug 2020 09:03:43 -0400
X-MC-Unique: cahBEwrqPHywZxXDdL8WOw-1
Received: by mail-wr1-f70.google.com with SMTP id l14so8236195wrp.9
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 06:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MFwELZAUGhpkdXfHISM+0/NgEXub0Zg2vTlYw/nFjkc=;
 b=lSsxQUmVPSDKFH5uKKHYFIV+rUE66zBSJ4MEzWKu+bqrCSlm/96Myf6C5XVYQUcTHL
 2Q52sGoFM1iT8TmBatAePqFE8GmPNQ49R8IbbIU5Ulnc6fXU5YOuGSHcdgITifpzvl5m
 4Zy2RQCrq4bxLDcnysYEjWs4/g7NoFJyyK9lzxQTZCIlcj+8fg6pNfxGdC6jz9kXw5Kr
 TPmFrdhqWxCLUXOF+1fj2QkmCNYNFTSPv2DSY/iv9Yk/y3xlQVs37Jn+JE+dooq8YBDi
 ifg5Uhphttagma6eGUBqr1+rqZjc88Ow4hSsFHXVTmTWlpNjhjR+P3CvQ+2JFliXJzde
 xvzw==
X-Gm-Message-State: AOAM5310i/0FFW3vk7ASXNPgWduxBVNyqxo4CvsoxJQSld1yFfi/rKxn
 ZhrCtzm4RIICsng153k8K8PbV27BXwZzXPGb1elcL1qeLl4FC6udKWmPtaCPkg26I0avw77Ow8/
 z25h1m1AL2MCKNL0=
X-Received: by 2002:adf:fc06:: with SMTP id i6mr19986151wrr.79.1597755821894; 
 Tue, 18 Aug 2020 06:03:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEHrpV2YwQPvh5YrHab+3TNYPQrPengkoHfhpejqmBh+3zgXbdGIdDc/e2cUqWfq9WQRWKNw==
X-Received: by 2002:adf:fc06:: with SMTP id i6mr19986133wrr.79.1597755821689; 
 Tue, 18 Aug 2020 06:03:41 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id i9sm33344917wmb.11.2020.08.18.06.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 06:03:41 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] acpi: add aml_land() and aml_break() primitives
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200818122208.1243901-1-imammedo@redhat.com>
 <20200818122208.1243901-5-imammedo@redhat.com>
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
Message-ID: <15ff4284-b5de-dff2-c6ef-ad94820f6f81@redhat.com>
Date: Tue, 18 Aug 2020 15:03:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818122208.1243901-5-imammedo@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 2:22 PM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/acpi/aml-build.h |  2 ++
>  hw/acpi/aml-build.c         | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index d27da03d64..e213fc554c 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -291,6 +291,7 @@ Aml *aml_store(Aml *val, Aml *target);
>  Aml *aml_and(Aml *arg1, Aml *arg2, Aml *dst);
>  Aml *aml_or(Aml *arg1, Aml *arg2, Aml *dst);
>  Aml *aml_lor(Aml *arg1, Aml *arg2);
> +Aml *aml_land(Aml *arg1, Aml *arg2);
>  Aml *aml_shiftleft(Aml *arg1, Aml *count);
>  Aml *aml_shiftright(Aml *arg1, Aml *count, Aml *dst);
>  Aml *aml_lless(Aml *arg1, Aml *arg2);
> @@ -300,6 +301,7 @@ Aml *aml_increment(Aml *arg);
>  Aml *aml_decrement(Aml *arg);
>  Aml *aml_index(Aml *arg1, Aml *idx);
>  Aml *aml_notify(Aml *arg1, Aml *arg2);
> +Aml *aml_break(void);
>  Aml *aml_call0(const char *method);
>  Aml *aml_call1(const char *method, Aml *arg1);
>  Aml *aml_call2(const char *method, Aml *arg1, Aml *arg2);
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index f6fbc9b95d..14b41b56f0 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -556,6 +556,15 @@ Aml *aml_or(Aml *arg1, Aml *arg2, Aml *dst)
>      return build_opcode_2arg_dst(0x7D /* OrOp */, arg1, arg2, dst);
>  }
>  
> +/* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLAnd */
> +Aml *aml_land(Aml *arg1, Aml *arg2)
> +{
> +    Aml *var = aml_opcode(0x90 /* LandOp */);
> +    aml_append(var, arg1);
> +    aml_append(var, arg2);
> +    return var;
> +}
> +
>  /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLOr */
>  Aml *aml_lor(Aml *arg1, Aml *arg2)
>  {
> @@ -629,6 +638,13 @@ Aml *aml_notify(Aml *arg1, Aml *arg2)
>      return var;
>  }
>  
> +/* ACPI 1.0b: 16.2.5.3 Type 1 Opcodes Encoding: DefBreak */
> +Aml *aml_break(void)
> +{
> +    Aml *var = aml_opcode(0xa5 /* BreakOp */);
> +    return var;
> +}
> +
>  /* helper to call method without argument */
>  Aml *aml_call0(const char *method)
>  {
> 



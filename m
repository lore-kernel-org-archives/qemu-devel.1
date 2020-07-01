Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2181BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE03A20722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwVhgOnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE03A20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqXGh-0008MG-6x
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 03:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqXG6-0007wV-5E
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 03:34:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqXG3-0003F0-Lz
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 03:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593588853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8PfpnmywlDK4Z5XEffEf8v5U5WsOTQh+i41kBzDDiIM=;
 b=RwVhgOnEYcODUXE78adm2PK1cP8mxxL2NxfknjILmR5NdeH3c0Z1r/bkMaJ8bk6Z5+Y7iD
 Nhaex7tex8+h2l+9A0/TkL2xcuiBNqb5ji0zMTQD8hD2gZjuYlggaaDw4f7NHNOrxUKu0i
 Ft38Cm1MlhkYT9jYbBx2DDxDB8jMjNY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-LcXFKNJHNSSwoCgRkVY1og-1; Wed, 01 Jul 2020 03:34:11 -0400
X-MC-Unique: LcXFKNJHNSSwoCgRkVY1og-1
Received: by mail-wr1-f72.google.com with SMTP id y16so19782800wrr.20
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 00:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8PfpnmywlDK4Z5XEffEf8v5U5WsOTQh+i41kBzDDiIM=;
 b=PudTcD3HzZiEINf766zjB9TjgRj3pUzbz8dpdbIJAV24OIhNEthMS4xhHz47eVFB0W
 ecsGUlbqoqyIfYlU89+WlnL3KyMAgv3mWkfinWnGifcNsVHm8ncB/hZIv1njZ+q4uFgX
 zv0SyklinuOJ/11NS4TO6Ej80IJe8WBS1wXXU9GQD5yBIO6GytOVFxHgMAUvljnFMCRu
 sZ8ykrJaeldat26dkGDGyrHxdfzmgZ5/EIg6QQPihnDf6OxX1r5PG1mFODfbsJ1RPKXo
 bI5hHIOzn0z0WauKhuKq0hK2u26GCMNXFjCReu/tRXAO00kIeDQRlsZ0jfMgMpr/2sHq
 ScfA==
X-Gm-Message-State: AOAM5321eiQ0B7dO4OoQ4I28+oEwnchF7z0SmIrTd88PIorazA/CMZ6X
 9f4Wd4vMf9EIIvgrwvHmm6Ha544D8/HR5opfnSf87bVbOZnoZ0oCeCloQTxUF663wr/0yEQ5Ns7
 nEmOqSj6OlxPldZg=
X-Received: by 2002:a5d:4b84:: with SMTP id b4mr26702136wrt.334.1593588850408; 
 Wed, 01 Jul 2020 00:34:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkxsFxTrPYld4xchhUsQLD+xQDa4XiLTvYAQX70GelBaVJnAfFp+6vuEm8LzBRG95mlPxMRw==
X-Received: by 2002:a5d:4b84:: with SMTP id b4mr26702109wrt.334.1593588850098; 
 Wed, 01 Jul 2020 00:34:10 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r1sm6071567wrw.24.2020.07.01.00.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 00:34:09 -0700 (PDT)
Subject: Re: [PATCH] pc: fix leak in pc_system_flash_cleanup_unused
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200701015859.29820-1-alxndr@bu.edu>
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
Message-ID: <738a6ab5-ccea-0943-66f1-c8b345a5aba2@redhat.com>
Date: Wed, 1 Jul 2020 09:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701015859.29820-1-alxndr@bu.edu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 3:58 AM, Alexander Bulekov wrote:
> fix a leak detected when building with --enable-sanitizers:
> ./i386-softmmu/qemu-system-i386
> Upon exit:
> ==13576==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 1216 byte(s) in 1 object(s) allocated from:
>     #0 0x7f9d2ed5c628 in malloc (/usr/lib/x86_64-linux-gnu/libasan.so.5)
>     #1 0x7f9d2e963500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.)
>     #2 0x55fa646d25cc in object_new_with_type /tmp/qemu/qom/object.c:686
>     #3 0x55fa63dbaa88 in qdev_new /tmp/qemu/hw/core/qdev.c:140
>     #4 0x55fa638a533f in pc_pflash_create /tmp/qemu/hw/i386/pc_sysfw.c:88
>     #5 0x55fa638a54c4 in pc_system_flash_create /tmp/qemu/hw/i386/pc_sysfw.c:106
>     #6 0x55fa646caa1d in object_init_with_type /tmp/qemu/qom/object.c:369
>     #7 0x55fa646d20b5 in object_initialize_with_type /tmp/qemu/qom/object.c:511
>     #8 0x55fa646d2606 in object_new_with_type /tmp/qemu/qom/object.c:687
>     #9 0x55fa639431e9 in qemu_init /tmp/qemu/softmmu/vl.c:3878
>     #10 0x55fa6335c1b8 in main /tmp/qemu/softmmu/main.c:48
>     #11 0x7f9d2cf06e0a in __libc_start_main ../csu/libc-start.c:308
>     #12 0x55fa6335f8e9 in _start (/tmp/qemu/build/i386-softmmu/qemu-system-i386)
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
> 
> I am not very familiar with the QOM, so maybe this isn't the right way
> of going about this. With the call to object_property_add_child in
> pc_sysfw.c:pc_pflash_create, object_ref is called on the pflash device.
> In the pc_system_flash_cleanup_unused function, there are calls to
> object_propery_del and object_unparent, but it seems neither of these
> calls object_unref. So do we need to manually decrement the refcount?

Hint in such case, look at who wrote the commit, and Cc the author
to get an explanation:

$ git blame hw/i386/pc_sysfw.c
ebc29e1beab hw/i386/pc_sysfw.c  (Markus Armbruster      2019-03-11
18:39:26 +0100 119)     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
ebc29e1beab hw/i386/pc_sysfw.c  (Markus Armbruster      2019-03-11
18:39:26 +0100 120)         dev_obj = OBJECT(pcms->flash[i]);
ebc29e1beab hw/i386/pc_sysfw.c  (Markus Armbruster      2019-03-11
18:39:26 +0100 121)         if (!object_property_get_bool(dev_obj,
"realized", &error_abort)) {
ebc29e1beab hw/i386/pc_sysfw.c  (Markus Armbruster      2019-03-11
18:39:26 +0100 122)             prop_name = g_strdup_printf("pflash%d", i);
df4fe0b291b hw/i386/pc_sysfw.c  (Markus Armbruster      2020-05-05
17:29:26 +0200 123)             object_property_del(OBJECT(pcms),
prop_name);
ebc29e1beab hw/i386/pc_sysfw.c  (Markus Armbruster      2019-03-11
18:39:26 +0100 124)             g_free(prop_name);
ebc29e1beab hw/i386/pc_sysfw.c  (Markus Armbruster      2019-03-11
18:39:26 +0100 125)             object_unparent(dev_obj);
ebc29e1beab hw/i386/pc_sysfw.c  (Markus Armbruster      2019-03-11
18:39:26 +0100 126)             pcms->flash[i] = NULL;
ebc29e1beab hw/i386/pc_sysfw.c  (Markus Armbruster      2019-03-11
18:39:26 +0100 127)         }
ebc29e1beab hw/i386/pc_sysfw.c  (Markus Armbruster      2019-03-11
18:39:26 +0100 128)     }

> 
>  hw/i386/pc_sysfw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index ec2a3b3e7e..f69a93671a 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -123,6 +123,7 @@ static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>              object_property_del(OBJECT(pcms), prop_name);
>              g_free(prop_name);
>              object_unparent(dev_obj);
> +            object_unref(dev_obj);
>              pcms->flash[i] = NULL;
>          }
>      }
> 



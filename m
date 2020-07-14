Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50539C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAC52082F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIY03kAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAC52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNcP-0005A0-Bs
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvNbY-0004N5-Nx
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:16:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvNbW-0001Yt-3r
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594743384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FqdDn8VMLbT2SpVJHj8q8O9JV0eQgZW7xoNpHstZUto=;
 b=CIY03kANlk2XhkIobcAUgSBWFY5yCY6zYOHmLHDNLDPFouHxTc9OFIIsrpL67g/9G4kikY
 wKQi+5WW8SeA/X349Msa5BJXOONOrABb46Va4PiGMMrlyYsm41aKEBU2+AwVu3geVFoE5T
 mzR89lCiRCmUELkQkejWvbdv/NWf76o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-ZUYE7uK2MTqx1srzsaXjdg-1; Tue, 14 Jul 2020 12:16:22 -0400
X-MC-Unique: ZUYE7uK2MTqx1srzsaXjdg-1
Received: by mail-wr1-f70.google.com with SMTP id c6so22351329wru.7
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=FqdDn8VMLbT2SpVJHj8q8O9JV0eQgZW7xoNpHstZUto=;
 b=KkfevdjtwUgoUWyI/frvlPE/sMF2VKR+gRp+Ed3JjBO4ZVMq/WGaxDliUZuHwVf/9L
 vCuuN9Sc5clPkF3X2kb4N3fnr1SgJJ9tInYT6D2e4eRfnOXc9kLPe7offVa4qU5vasCI
 Ny3t/pn9nnq90z7TmpDBcVYqkQ06h/SLv2h2R+wyCH+NTweyCjhHBzTF4fLY8HoNDVVG
 BOuNlj0BGYo7KlLACK5RWCxWhJDdA93OQ6c4BW+OMuoFAgTCnVyaZMTLiZ4YRBZWMQo6
 zXRbaEI8fPoJ27iLCNEbSGIpcEK6RlGRQL/j9Ou8GwlY3ZQCp2LIHlWDxMz3Oer3Lg9N
 H48A==
X-Gm-Message-State: AOAM5332tNR9qazxOZGsf26AGGXPbXttYd8G4OoWQ5Vl6swKK9JTgRRE
 zhXIUJRpzUt5XEPnDcoKaDPMZPwuACvXeEX6XGvCymALOg6pLEbULeqc8uI7e+NNj320KxtYkgy
 FawsbJ67y41RAK6c=
X-Received: by 2002:a05:6000:100c:: with SMTP id
 a12mr7215710wrx.81.1594743381378; 
 Tue, 14 Jul 2020 09:16:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAv5rDS4avFJhQfn2zHNy4y+pZIL09qOysQykAqVszF5B+0hh2z26bLjWNt4aZZ++EUjyL5w==
X-Received: by 2002:a05:6000:100c:: with SMTP id
 a12mr7215671wrx.81.1594743381100; 
 Tue, 14 Jul 2020 09:16:21 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q5sm29966288wrp.60.2020.07.14.09.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 09:16:20 -0700 (PDT)
Subject: Re: [PATCH for-5.1 2/5] qom: Plug memory leak in "info qom-tree"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200714160202.3121879-1-armbru@redhat.com>
 <20200714160202.3121879-3-armbru@redhat.com>
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
Message-ID: <067bb7f2-2ac4-9ed2-493c-5705fe59affa@redhat.com>
Date: Tue, 14 Jul 2020 18:16:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714160202.3121879-3-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, thuth@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 6:01 PM, Markus Armbruster wrote:
> Commit e8c9e65816 "qom: Make "info qom-tree" show children sorted"
> created a memory leak, because I didn't realize
> object_get_canonical_path_component()'s value needs to be freed.
> 
> Reproducer:
> 
>     $ qemu-system-x86_64 -nodefaults -display none -S -monitor stdio
>     QEMU 5.0.50 monitor - type 'help' for more information
>     (qemu) info qom-tree
> 
> This leaks some 4500 path components, 12-13 characters on average,
> i.e. roughly 100kBytes depending on the allocator.  A couple of
> hundred "info qom-tree" here, a couple of hundred there, and soon
> enough we're talking about real memory.
> 
> Plug the leak.
> 
> Fixes: e8c9e65816f5dbfe18ad3b2be938d0d8192d459a
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qom/qom-hmp-cmds.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index 9ed8bb1c9f..aaacadacca 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -96,8 +96,10 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent);
>  
>  static int qom_composition_compare(const void *a, const void *b, void *ignore)
>  {
> -    return g_strcmp0(a ? object_get_canonical_path_component(a) : NULL,
> -                     b ? object_get_canonical_path_component(b) : NULL);
> +    g_autofree char *ac = object_get_canonical_path_component(a);
> +    g_autofree char *bc = object_get_canonical_path_component(b);
> +
> +    return g_strcmp0(ac, bc);
>  }
>  
>  static int insert_qom_composition_child(Object *obj, void *opaque)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>



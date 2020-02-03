Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4968AC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CAB20661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRsdP20y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CAB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXZi-0006xC-67
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 03:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iyXZ1-00068O-Q1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iyXZ0-0006SR-85
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:58:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iyXZ0-0006QB-3L
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580720316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQdArCN394JchJ00fEclWewzKnTc8XKQR1cL9Qi4rnI=;
 b=FRsdP20yFm1k892b9SjfP+YKjfh6TDw6oqxdUPr7uOAxzWlIzsOV5XZNBIfJn7NVD1jjeH
 1q9YDNaypotDPTZfGKr0DZ1pHY6Eyfh2VBfG731l0tRPjT5kgRy4G+NehW/QNJ8swjz55o
 WYLSJTzKZwOy1JtOBJmUxjl8gW8/ZN0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-59PaKzYoPWygQ_MUCrKfVA-1; Mon, 03 Feb 2020 03:58:34 -0500
Received: by mail-wr1-f72.google.com with SMTP id t6so4793513wru.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 00:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XQdArCN394JchJ00fEclWewzKnTc8XKQR1cL9Qi4rnI=;
 b=i4TMjvzi4otl01haLLD+3DGIVPC5EeKVMWKwgohujSHutv09lYTFalLoAOsn6Bvb3q
 7m//lDHucZyS3Y9POvW2OZguZ7bG2Wc1w27439k3UPU9JLedflhoK5GHCNjmnd85BuNu
 VRV1aR2Vquwb+aILpPJ6WpPTitXIhyekX4Grd0mWjKrk/HF5ed0eZtRh++2hiN46GDrP
 W0R2KwNmYcwf0oRUFUV2xmHLD9cpQA/lfdpXn5nug9d8CDJgtn0FTQzcllxQOSJ7m5SG
 8fIYCI+QlM/3sLyhnHOsFRgb3DmSh3bhkqCxE3h8b/JgqTe5PyBCQ5zo2CQYtoltYdDc
 5sTw==
X-Gm-Message-State: APjAAAW07xq0z5M86bkTjiaiW9Pc5eX9wbH7ohpx4BXNblbcC9At5QAz
 Tbh/sEsHvMegqVznu+dRiXgNBeWYnBn5qB0Ltmh97QMlrpxEOn2cppBVj027H1PFfLvGUjCsJ+K
 h3aBeDALnjw1WLL0=
X-Received: by 2002:a5d:42c6:: with SMTP id t6mr14020061wrr.151.1580720313569; 
 Mon, 03 Feb 2020 00:58:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbtd9C4TJPTyl1ozuRr84GlOnWYu+Xx89MJPFTUzkJtVdD8eGQQwIE+htiPHA+6suq72uydw==
X-Received: by 2002:a5d:42c6:: with SMTP id t6mr14020014wrr.151.1580720313244; 
 Mon, 03 Feb 2020 00:58:33 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b11sm8978565wrx.89.2020.02.03.00.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 00:58:32 -0800 (PST)
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
To: Markus Armbruster <armbru@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
References: <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org> <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org> <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
 <CAFEAcA-545QS9mnM6hwa6TxUpw_pDQ3Pa8tkf4qtzWS1Zi_fxQ@mail.gmail.com>
 <CABgObfaB=wHXyJbQR163bZdFHhWdCc4D8sWRHzte019_hSTuhA@mail.gmail.com>
 <20200131152243.GA24572@paraplu> <87sgjvbkvj.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b2a329bf-4795-14f0-473c-2a7cdfa4d262@redhat.com>
Date: Mon, 3 Feb 2020 09:56:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87sgjvbkvj.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: 59PaKzYoPWygQ_MUCrKfVA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/01/20 18:23, Markus Armbruster wrote:
> Kashyap Chamarthy <kchamart@redhat.com> writes:
> docs/devel/qapi-code-gen.txt has the same problem: it's mostly internal
> stuff, but there's also introspection, which is an external interface.

We should move introspection to docs/interop.  Any takers?

>>     Rigorous support for introspection both of runtime objects and type
>>     capabilities
> 
> For a value of "rigorous".
> 
> Let me propose QAPI's query-qmp-schema as the tin standard[*] of
> introspection:
> 
> * It's documented
> 
> * It comes with something that can pass as a type system
> 
> * It actually tells you the full truth.

Well, not all statements age equally well.  But compared to netdev_add 
and device_add, it was still an improvement. :)

It's certainly worse than QAPI *now*, but it's not nonexistent:

> * Documentation
> 
>   QAPI: docs/devel/qapi-code-gen.txt section "Client JSON Protocol
>   introspection"
> 
>   QOM: Nada

Well, there is qom.json.  So slightly more than nothing, though I have 
already found an off-by-one error and it could definitely be improved:

 @type: the type of the property.  This will typically come in one of four
        forms:

        1) A primitive type such as 'u8', 'u16', 'bool', 'str', or 'double'.
           These types are mapped to the appropriate JSON type.

        2) A child type in the form 'child<subtype>' where subtype is a qdev
           device type name.  Child properties create the composition tree.

        3) A link type in the form 'link<subtype>' where subtype is a qdev
           device type name.  Link properties form the device model graph.


> * Type system
> 
>   QAPI: A few built-in types specified in the documentation, type
>   constructors for complex types.
> 
>   QOM: Types are strings, and you just need to know what they mean.
>   Some string patterns are special: link<STR>, child<STR>, STR[INT], and
>   you just need to know what that means, too.

str[int] is not a type as far as I understood it, it's a property name.  
Types are documented as above; however types other than link<> and 
child<>, which are QAPI types, can be user-defined types (structs, 
enums) and this is not included in (1).

> * Full truth
> 
>   QAPI: If you can access it at the interface, you can also see it in
>   introspection.
> 
>   QOM: Type introspection can show you only the properties of a freshly
>   created object.  Properties that get created only later are invisible.
>   Properties that depend on global state are unreliable.  Object
>   introspection is reliable, but only for that object in its current
>   state.

Right, that's array properties and at least theoretically child 
properties (I don't know if there are examples).

Paolo



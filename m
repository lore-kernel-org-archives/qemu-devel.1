Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F37AC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E19220809
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjMQRTNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E19220809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0KsB-0001tj-Hj
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0KrV-0001SF-Si
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:21:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56731
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0KrT-0000Co-Tp
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595924482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vDQ8fRXh/UcmLIHxOprOQrUfvcIyRzAnVgLKYlcAP4=;
 b=UjMQRTNCitdIre+Bo20RqofbnJB6biTvaqz6732a0Gbg2UchWLSni8Oq4Uigx8nusDhLxZ
 kScvNFcsLHpHr0i7bk9Wx+z7nPyjzb9jz5rPQaEHLj59l2M1Q4pPKIXxWFL7qqdvAf1P/Q
 4yfywGDvhT+nCBdLI4bc1HlSbfIxJls=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-M4vP_qLOPcC_argNtugnwg-1; Tue, 28 Jul 2020 04:21:20 -0400
X-MC-Unique: M4vP_qLOPcC_argNtugnwg-1
Received: by mail-wm1-f69.google.com with SMTP id a207so534804wme.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 01:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6vDQ8fRXh/UcmLIHxOprOQrUfvcIyRzAnVgLKYlcAP4=;
 b=aJcics2JAXBzDBTWYN1EsUjuS+iQNgVaLvaTGwsuVzzbjM/Oe1cxwK0olzu9QS8OrU
 oLUZaDzcv5iYGZYX/f6Gqu7I/Fh2OabpKeZzEmg/xDW3DNCKx2eDiOF/TWjDOE+BUahX
 3nnSFtMzVAnf04ZYQ/Sr2EzniK49X9c9ZnHhR8NCLAXTzB2lEKvo4bYXfu+yqy37/bID
 fw+ApdlAZMKTTITN7f+JhqVYf+P9KHPPC3+BLDtFDI6PDPHwYpo11RHrF11urXpSmO8k
 nnNdhyEcnwk0ugfi9PZa1/DkWwXFklYZr8uzOVvuTS+CdtWaJkcEvUWMgRPxMoHrEpRv
 p70A==
X-Gm-Message-State: AOAM530DEuHu5YPJR3oKN/eMBIUKWdWWYKM+hg0onFX69bNjO//41cty
 pRcUZShsyIfkIElYdseboKGiGZveyYTYWaNd5BoaFP6YRWiEHLx4QnWqUoP9WOKvHq6XeixCtfV
 5kBGueCzTrHvcWJc=
X-Received: by 2002:a5d:4610:: with SMTP id t16mr25048014wrq.101.1595924479707; 
 Tue, 28 Jul 2020 01:21:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsYNsAaUKf8blauKNiaYGW8nbOkEnwui4INVVrHRTlWW/5K90UazaTPJUgHrCWplaTQhn8aA==
X-Received: by 2002:a5d:4610:: with SMTP id t16mr25047994wrq.101.1595924479485; 
 Tue, 28 Jul 2020 01:21:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4502:3ee3:2bae:c612?
 ([2001:b07:6468:f312:4502:3ee3:2bae:c612])
 by smtp.gmail.com with ESMTPSA id j6sm16313499wro.25.2020.07.28.01.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 01:21:19 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 v4] hw/core/qdev: Increase qdev_realize() kindness
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200727175112.6820-1-f4bug@amsat.org>
 <87d04gf5i4.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b5cd0d50-c0a6-afee-5b63-80bb83e7e001@redhat.com>
Date: Tue, 28 Jul 2020 10:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87d04gf5i4.fsf@dusky.pond.sub.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/07/20 09:44, Markus Armbruster wrote:
>> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
>> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
>> +        error_setg(errp, "Unexpected bus '%s' for bus-less device '%s'",
>> +                   DEVICE_GET_CLASS(dev)->bus_type,
>> +                   object_get_typename(OBJECT(dev)));
>> +        return false;
>>      }
>>  
>>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
> Objection.  This turns an abort into something else unless the caller
> passes &error_abort.  The caller in your commit message's example does,
> others don't.
> 
> Keep the unconditional abort, please.  Feel free to print something kind
> right before.  I doubt it's all that useful, as I believe whoever gets
> to fix the bug will have to figure out the code anyway, but I could be
> wrong.
> 

This was my request, actually.  We have an Error**, we should use it in
case this code is reached via device_add.

Paolo



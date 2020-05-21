Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A9EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AB420748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ypa2Ivkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AB420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblqK-00076R-Tr
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jblpE-0005CS-Dj
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:05:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37416
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jblpC-0003Mb-Ul
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590069929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuW4LhQZmtRPxOdsGv0UfenYyJdURtJzEmFBQoF1B8A=;
 b=Ypa2IvkmNFWqlHEvhzj4kNY9EI9p00KGUA4rJE7sLf1Vw4f4jl8jA05HpV5odVP+3SgYqP
 bNk+sFFnIUQxzal08rSf8zRsKfeODvbNl+JvmlBaZmBZ1nX8c1cRSS0SEDuQBjQMNSGdul
 m7jE9AnxuW3TBrl8KMVKz89PKQ5Zytk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-jNt-f-hfMoah5a1Gwy29pQ-1; Thu, 21 May 2020 10:05:22 -0400
X-MC-Unique: jNt-f-hfMoah5a1Gwy29pQ-1
Received: by mail-wr1-f69.google.com with SMTP id g10so2966291wrr.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WuW4LhQZmtRPxOdsGv0UfenYyJdURtJzEmFBQoF1B8A=;
 b=SFYl1/tdwTohsHIjKwSkv+qcJ/xmKVWaGMBjKTJSW55AP1opqNOYMsRUj30RbU+mVQ
 EYyCWdgffx1KYSIHNz0XsYhEGKC4LKKa0sKajoGmvPrJBWkJ99gZG76fFMWj35eBy+tf
 p2M+hKADtluTaCe6x5KHZ49myDjc2sRJMAaaxjRimHstjM0amBHO7gTBeH8duQMTZUkO
 rDIZG6TGg3dCVne71ROdgGVhePGri4rRrTA2Y7H3VGw0RbHXLg/lqcrb+KWmsxEgkGOV
 B31J1XpkwHPTskuo8TXOp27Z0v0b8SBZbBL+iZkPMBbZ3J3XuGOA7VgTHnlyFoMTIB3H
 wUcA==
X-Gm-Message-State: AOAM532Rgk8E+31ucwBF9TIE951tpGm+8T/5pp7npCd+zBd9KbrA7ihs
 BqJCSzsTSsasZ7k5nsIM7w3DhILcbDZM/bkKlHuRVDhERijezbDbWvzQVYoLc8NlqHjXAQybBOE
 BW2t14jnObfPv7hM=
X-Received: by 2002:a7b:c205:: with SMTP id x5mr9562697wmi.135.1590069920837; 
 Thu, 21 May 2020 07:05:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+9vDo+k5k5h2/AhbhlgqJeb0CrNG8dWFa5E8+nrQcjn7Lroo1lNJb24UV5jL3E+o+6JSXCg==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr9562654wmi.135.1590069920578; 
 Thu, 21 May 2020 07:05:20 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id c140sm6952309wmd.18.2020.05.21.07.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:05:19 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] various: Remove unnecessary casts
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
References: <20200512070020.22782-1-f4bug@amsat.org>
 <871rnlsps6.fsf@dusky.pond.sub.org>
 <8791b385-8493-f81d-5ee3-cca5b8559c27@redhat.com>
 <87imgt9ycp.fsf@dusky.pond.sub.org>
 <2f4607cf-90a9-ca9a-4ef6-a8358631cdf0@kaod.org>
 <87k1187dbo.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ffae374d-9429-5bdc-d415-053aaa1b033c@redhat.com>
Date: Thu, 21 May 2020 16:05:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87k1187dbo.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/05/20 06:34, Markus Armbruster wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> On 5/18/20 3:17 PM, Markus Armbruster wrote:
>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>
>>>> On 15/05/20 07:58, Markus Armbruster wrote:
>>>>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>>>>
>>>>>> Remove unnecessary casts using coccinelle scripts.
>>>>>>
>>>>>> The CPU()/OBJECT() patches don't introduce logical change,
>>>>>> The DEVICE() one removes various OBJECT_CHECK() calls.
>>>>> Queued, thanks!
>>>>>
>>>>> Managing expecations: I'm not a QOM maintainer, I don't want to become
>>>>> one, and I don't normally queue QOM patches :)
>>>>>
>>>>
>>>> I want to be again a QOM maintainer, but it's not the best time for me
>>>> to be one.  So thanks for picking up my slack.
>>>
>>> You're welcome :)
>>
>> Could you help me getting this patch merged ? :)
>>
>> http://patchwork.ozlabs.org/project/qemu-devel/patch/20200404153340.164861-1-clg@kaod.org/
> 
> I have more QOM patches in the pipe, and I may well post another QOM
> pull request while Paolo is busy with other stuff.  I'll consider
> including other QOM patches then.  Non-trivial ones need an R-by from
> Paolo, Daniel or Eduardo.

I queued Cedric's.

Paolo



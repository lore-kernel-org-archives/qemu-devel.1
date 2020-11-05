Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3102C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B533E20715
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZqxhYcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B533E20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaiEP-0001mQ-Hd
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 11:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaiDT-0001D4-JE
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaiDR-0006hM-Qh
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604594064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vh/TXgiE8fmcF8isdTd+PiNUDsUWBqZxyrOU+UmhEwg=;
 b=IZqxhYcDdl2OfnRw8eyS1CZf0YI4o/n9RKvQ2BNhuc5XObnTnhUQBYUIAPOIy76vwrV9ld
 lnTX7zm0RrmCGliwwlpyvCtyxPFV02wVzXcTFz4mYQG4O0PMUllKL65AKSfM32md4LZxDE
 M2UaiMOxY0H9P9IkVbfGShUOQd+hIYE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Mdv76oXbO76BB2Cer7lR6Q-1; Thu, 05 Nov 2020 11:34:22 -0500
X-MC-Unique: Mdv76oXbO76BB2Cer7lR6Q-1
Received: by mail-ej1-f72.google.com with SMTP id nt22so791518ejb.17
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 08:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vh/TXgiE8fmcF8isdTd+PiNUDsUWBqZxyrOU+UmhEwg=;
 b=srKwB8/jaE0vtqnR2T4WMYyohnm+hKkD/A6bF9XTjyaqN2K6i1EtB/2Z10ZlNbX/1G
 xQfeJxqWKThZW5PIgu+3YvmMLk+/FpahEUqv3kt8ltU5MqZ5srf87i4UdNc6fsumlacV
 SgK/mtglaAXxG+r5ZGL9kDjzh+mWyYo0TACjyBSMjLUeHSPlTaZMoIHx5S6TeOryZYiI
 4ZnSkzWr+YDNH1JECyoGVZ4yZMSvAbFZJn4rDemr9DZqVIQGs/nBxjAGuKlZeyhul97m
 kXsqdpE8shj7LBP4wbv9lIw9pug0jWoCnuMtWezmslrptx32enDkOpXptc0dpvIxWj2E
 VzXw==
X-Gm-Message-State: AOAM530VaEXdiNrhDGgWzbmtyUJVf2UjmqkwIxvrwq0IhCOyd7rf6GMs
 qEtOnpe2vQpk52oq8n5nO+o6JcW4RLNSUA1tVcuF/tJEQfJs/CsCMQPew0of7KDetsqq5iCnvCn
 eYe21cSc9Xqv6N7c=
X-Received: by 2002:a50:b5e1:: with SMTP id a88mr3499417ede.5.1604594061054;
 Thu, 05 Nov 2020 08:34:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMcP/0ogfOxHTXAol/lnyzGHcSb6pRD5KknqklgrayYqPQkJEdHPXedaySYAZZFkubrwjh+w==
X-Received: by 2002:a50:b5e1:: with SMTP id a88mr3499402ede.5.1604594060854;
 Thu, 05 Nov 2020 08:34:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id 11sm1235234ejy.19.2020.11.05.08.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 08:34:19 -0800 (PST)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>
References: <CAJ+F1CJ7KpB8C6-_+Gdh6twqjjRMweERUapw4tfjKyMqa6AM0w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Documents not in sphinx toctree
Message-ID: <8965346b-928f-d4f6-f0fb-3795e9df91bf@redhat.com>
Date: Thu, 5 Nov 2020 17:34:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ7KpB8C6-_+Gdh6twqjjRMweERUapw4tfjKyMqa6AM0w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Pankaj Gupta <pagupta@redhat.com>, Jens Freimann <jfreimann@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/11/20 17:12, Marc-André Lureau wrote:
> Hi,
> 
> By running sphinx over the docs/ directory (like readthedocs.org 
> <http://readthedocs.org> presumably does), it finds a couple of rst 
> documents that are not referenced:
> - cpu-hotplug.rst
> - microvm.rst
> - pr-manager.rst
> - virtio-net-failover.rst
> - virtio-pmem.rst
> 
> Shouldn't they be?
> 
> If not (I wonder why), there should be a way to explicitly exclude 
> those, and avoid extra warnings.

They were written or converted after we had decided to switch to Sphinx, 
but before we had a proper manual structure.

The problem is finding them a place...

Paolo



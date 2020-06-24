Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCC0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4032072E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvtJrw4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4032072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6HF-0003D1-Sf
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo6GG-0001i2-Vu
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:20:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35031
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo6GF-0000O9-8c
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593008422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWfpE4izy5B8C2VW8Atkz9nxPS5S/vhIhg0sPC/K/KY=;
 b=YvtJrw4wjXhLTUlqvJuIubxjmtv8QGJxAm0uXqnWxifnL1oxxh+voIbRZL3DY5ENcP+b2K
 gdqVZxP65/Y8ziCNStBEJZXAPhCgwSQVTcQs4/R1ppJJsHpiR6zJRd/iYknF2Z5Nv/+uZc
 MwHwjHF3EiQ4Hb/UL5zHMjpeozPiGy4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-tljO2aOONRWfCQgS0O7yyw-1; Wed, 24 Jun 2020 10:20:19 -0400
X-MC-Unique: tljO2aOONRWfCQgS0O7yyw-1
Received: by mail-wm1-f69.google.com with SMTP id g124so2843075wmg.6
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zWfpE4izy5B8C2VW8Atkz9nxPS5S/vhIhg0sPC/K/KY=;
 b=hCtX+eGIHLIg9yALokpcFMm1IIGnoeKL8tkJSfsnKs/x+QewsZZXD2Imc7G0CsqSjQ
 TVRa7RpagZRmVGvjhQp3gSYkEc+U2Si2zVpexSlBlmxVy+5qTQGzuxu8RQtI3P2ql7Gx
 hALnPRxfnAac5D710vycJMPZEbT9HDygAeJYykZcjSrsVLMIgbPWnLnMCSMnGRdJZw0K
 skJqjrVr+QXfAMH+wQx4oeGVKGBCGBq34UIu/MvN+m7pGSvHfM1gJeSWFj0mO4uQXZ+5
 YHIi7wpwc6XRfSBaEoGsIv7Ev/qFJ67Z72n2efTBghzE6TCF78e/dWmn9mjifZv+AB54
 OxhA==
X-Gm-Message-State: AOAM532M2ZGqRIwFSoiogUaN+ytz/Jle3iPbSO7AGmkNwdaiAcU6HVgJ
 FP+liyPPsUah4q+f7tJvJvDiKm5Lew/tGcra7IUacjKwT7lIswgnU03d38bhhj4x0YApqBSo0WV
 khID3SCSVpTNml+s=
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr31461281wmh.78.1593008418719; 
 Wed, 24 Jun 2020 07:20:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvZPzZl4jph78KBczwViytDJTwMkjpAMj074Vlvz0C5TZQ+sgaz/KmNj52tGWIhoLYdk/5SA==
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr31461263wmh.78.1593008418493; 
 Wed, 24 Jun 2020 07:20:18 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.253.55])
 by smtp.gmail.com with ESMTPSA id l10sm8140981wme.1.2020.06.24.07.20.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 07:20:17 -0700 (PDT)
Subject: Re: [PATCH v2 20/25] x86: Fix x86_cpu_new() error API violations
To: Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200624083737.3086768-1-armbru@redhat.com>
 <20200624083737.3086768-21-armbru@redhat.com>
 <20200624161703.153c7905@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d6e83fa-04c2-2d3e-3695-bf85f6647bfc@redhat.com>
Date: Wed, 24 Jun 2020 16:20:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200624161703.153c7905@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
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
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/20 16:17, Igor Mammedov wrote:
>> -    cpu = object_new(MACHINE(x86ms)->cpu_type);
>> -
>> -    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
>> -    qdev_realize(DEVICE(cpu), NULL, &local_err);
>> -
>> -    object_unref(cpu);
>> -    error_propagate(errp, local_err);
>> +    object_property_set_uint(cpu, apic_id, "apic-id", &error_abort);
> it may fail here if user specified wrong cpu flags, but there is nothing we can do to fix it.
> perhaps error_fatal would suit this case better?

No, we need to add the error_propagate dance instead.

Paolo



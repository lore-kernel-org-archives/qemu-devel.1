Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE093C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA04B2080D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nrq2KYB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA04B2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kabie-0006l8-TZ
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 04:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kabhT-0006Je-Nh
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:36:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kabhS-0001yN-5z
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604569017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tMpID9NlQAo6H+Ab7mddCtCWU/O9Qgnk25qUJ7KKXU=;
 b=Nrq2KYB2t/y9G3BwmbsfajwZ05Yp5wQE3CIUkLm634QrQOm+zukq65wAyvvlOJw9KEEJwE
 kgzUUFzltwR4Pd2mD2mQzhv/w23ntd1U9TgbmUgYry9Yvqaf08CcjQIweBGNsAlS6VrPR5
 Py0/pXB4JT0RtwV/dYIjnVzBU099534=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-K-naWvYYPZW_0OKTk1VH2Q-1; Thu, 05 Nov 2020 04:36:55 -0500
X-MC-Unique: K-naWvYYPZW_0OKTk1VH2Q-1
Received: by mail-wr1-f71.google.com with SMTP id j13so482729wrn.4
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 01:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1tMpID9NlQAo6H+Ab7mddCtCWU/O9Qgnk25qUJ7KKXU=;
 b=B5EHHtD0hep8a6qEW60p0gUFsdFrUDvn1uNG+efhPhZ3EDNAij6DCVZ2kZyd5BQ7PC
 Hy7az7VnsCR0IMJbIHdW9CDv+Jsc2+L0c73o8byuZVPtcUZzZX1o3Qc1sx6M3DXRdvel
 DQkB2FRtzFNCvGEGCKZNeLBNxrXzUMN/u5Rj+WOf2A0Rs8vL4F/7Qxqm0zg0WZcfnvkO
 1PeO2ZGipYlsg/IE3qLD9OMwwbB+jXmtFs3Vif9ef88kSbMNNvEwAhLzdFNQBeqYo5EQ
 2GzL/jW9E7OtejncmJ6FeFM9C52/0c7BxZqp+XTPQD+N7FQf+1Fa1qO+3zGrGEaMZvva
 +5XA==
X-Gm-Message-State: AOAM531xbfuxn/XinIH4qaTdOM0mV7BTd3c4jCfX+F9/GyLdXGotZWn7
 RjhSwTV+dIlbrwUy4I/GVy4T1JuX3+mW3OeyKbNBMx4NQDO1zraZy9eHTyvRlNq8NgN4E/soyBN
 8CkC3HBM0/JOtMOs=
X-Received: by 2002:adf:a51d:: with SMTP id i29mr1814348wrb.409.1604569014526; 
 Thu, 05 Nov 2020 01:36:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzY/nnr3pgpJCATRy5NEpSCYUAT+qy9Q3fVdaJ6M/czw480lt5X4CsMEiHQt8tDxbmMeW3cGA==
X-Received: by 2002:adf:a51d:: with SMTP id i29mr1814323wrb.409.1604569014308; 
 Thu, 05 Nov 2020 01:36:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id r10sm1725837wmg.16.2020.11.05.01.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 01:36:53 -0800 (PST)
Subject: Re: [PATCH v2 41/44] qdev: Move base property types to
 qom/property-types.c
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
 <20201104160021.2342108-42-ehabkost@redhat.com>
 <cf1eade5-3e3e-ffce-ac0f-b680f6462c47@redhat.com>
 <20201104205049.GV5733@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cdba50f8-1ad0-73f7-788e-1685d09d3c14@redhat.com>
Date: Thu, 5 Nov 2020 10:36:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104205049.GV5733@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/11/20 21:50, Eduardo Habkost wrote:
>> I would merge property-types.h and field-property.h in a single file.
> I like keeping them separate, to force us to define the API used
> to create new property types clearly.
> 
> What if I create a qom/qom.h header that includes object.h +
> field-properties.h + property-types.h to make this easier to use?
> 

Works for me!

Paolo



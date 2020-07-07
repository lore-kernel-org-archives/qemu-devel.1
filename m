Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEF7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9554A206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeOCRk7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9554A206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskCv-0004lk-U4
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 05:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jskCK-000429-0Z
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:47:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47489
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jskCI-0005g7-F4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594115249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+AsKJOEdfB3rBiu2z4qehMPhhRKa/dN/Tt1aMqHqjc=;
 b=UeOCRk7i7bS2a/xP71U0MCzmptQb90m93OCVli77j1qyfH97KBKLBP8EJcbaxQ5QqExkHa
 NLuZL5drtyKeKDMj91vl5jTi252VYHxDM1gxyXnFxxMhw0rzqLXvhxa5H5JRxvw9MNUvh5
 lFy5L9LDpS6z1xLE8MFxztqatGzbpEA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-_3ARV7BmPmOtUCltkofzRg-1; Tue, 07 Jul 2020 05:47:27 -0400
X-MC-Unique: _3ARV7BmPmOtUCltkofzRg-1
Received: by mail-wr1-f71.google.com with SMTP id y18so28494151wrq.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 02:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/+AsKJOEdfB3rBiu2z4qehMPhhRKa/dN/Tt1aMqHqjc=;
 b=EXe5z8ZDVR/zBKygT6EKNdHYmGa08AEsWXj7P8rCBx9L0WwthJYG2oJ1oniAmi/KPC
 /Yacf16IukwMLq5OlZd2/LumQQES46KfzAtw0IoDN3NQfQaCwMZ6KmFNLQuF9PH8MD9V
 JX70uwlGvKJyQIuvwpYlLShC3Uwoudarccpk4eUn27X9noC4yQL4IQTaKTLKPo29ZaYs
 G621ocRbI2CPUd3WdZtpkOnJffuRegCalxYN0dIVtbphesTJQwd1Arhptxd+6gfPxPHi
 E19xGVEUMu4TFDMKWRFa5ijMTGB34B4FRCOv1X0FDtxHQVjHkqtLI3KLVSt8ck1awhQY
 9AXw==
X-Gm-Message-State: AOAM533IJbl8TJSYNoTFwrmOKER+gO8IBtd4oztAotP3OpEW6yduBXIC
 cgeC7yktxTpa7x/8XVQJghpAktTBZ0quhUfuYzWKGPGvbad6NPl/tXlQauKa35Tdc5mdGi2MThr
 xh0esCDHc57K6ARc=
X-Received: by 2002:a1c:5646:: with SMTP id k67mr3426981wmb.61.1594115246596; 
 Tue, 07 Jul 2020 02:47:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysBAKjZirpjf+dye/HJf+ns4EYxPNzE6suJ7E6/Rz6a6jXKZ6q0gn6cXL7SM/6gRJxcA1gEg==
X-Received: by 2002:a1c:5646:: with SMTP id k67mr3426960wmb.61.1594115246378; 
 Tue, 07 Jul 2020 02:47:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46?
 ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
 by smtp.gmail.com with ESMTPSA id y16sm229609wro.71.2020.07.07.02.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 02:47:25 -0700 (PDT)
Subject: Re: [PATCH v3] hw/core/qdev: Increase qdev_realize() kindness
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200707033326.19178-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e472f6a-e6b3-910b-97fe-0526d1f560a1@redhat.com>
Date: Tue, 7 Jul 2020 11:47:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707033326.19178-1-f4bug@amsat.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/20 05:33, Philippe Mathieu-Daudé wrote:
> Since commit 510ef98dca5, qdev_realize() aborts if bus-less device
> is realized on a bus. While commits 514db7710b..007d1dbf72 took
> care of converting all mainstream uses, QEMU forks weren't. These
> forks are usually maintained by hobbyist with interest in following
> mainstream development, but with limited time, so usually rebase
> from time to time. To avoid them to spend time on debugging and
> reading git-log history, display a kind hint about what is wrong.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Since v2:
> - scratch __func__ (armbru)
> - reword to justify this is not an impossible case (armbru)
> ---
>  hw/core/qdev.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 2131c7f951..a16f1270f1 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -392,8 +392,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>  
>      if (bus) {
>          qdev_set_parent_bus(dev, bus);
> -    } else {
> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
> +        error_setg(errp, "Unexpected bus '%s' for bus-less device '%s'",
> +                   DEVICE_GET_CLASS(dev)->bus_type,
> +                   object_get_typename(OBJECT(dev)));
> +        return false;
>      }
>  
>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
> 

Queued, thanks.

Paolo



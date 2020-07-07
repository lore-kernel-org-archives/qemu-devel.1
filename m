Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0343C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC016206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpeG1vmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC016206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskEk-0006wW-UI
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 05:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jskE3-0005y3-0N
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:49:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55040
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jskE1-00062u-Hb
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594115356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jf0+4QYDpBfJLRMz8CMXs0iYqwm98IvWVmeyxml4qNM=;
 b=EpeG1vmvBvev9BOxMliM11I5Cv/EAFtkUHibZB3igkrC1ZvbYV+dUU1yCCNiR0kDLQdVMk
 d9BZXut7+KKCTbNe3aWR5r7b4HD96pWWaEmKcng86eLRrRzGLyo+KRhuHKSDNDo87QPFUp
 m4vHX8OGxggV/qROBgYU/pcB0anF/oo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-6ApO1zRfNYKj754mvSMB0w-1; Tue, 07 Jul 2020 05:49:15 -0400
X-MC-Unique: 6ApO1zRfNYKj754mvSMB0w-1
Received: by mail-wr1-f71.google.com with SMTP id y13so48076653wrp.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 02:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jf0+4QYDpBfJLRMz8CMXs0iYqwm98IvWVmeyxml4qNM=;
 b=GOlNTHO1G7xMgVORsJ2juoo6amYeyfav2rVHlPah3jrbRpXAxbuI1jtNrvTOP01T4Y
 2YVGA7drk7owBSVIH4qRY8qFhWOfaTlwoe9e48afD1QTvFMpspfjMNpB9TKeXX0Mu0sR
 yGj6LZHP1vpF6SNkDUuJRWdV4P+hofwkOfuiqFU3uQ2CFYSf22s9vKEDmiNKPLAHcOjp
 QIV5ykBnxRtIIBAsXPEJHY44ZfZ7Mw0YBZAkyK1UIAIErbwS1YJHTXQlj6/CEQlYzX/d
 NOnRQaHlp1FndT1Uy2azNrJccPs6BvvdD6YyHLIDcztjj6dJExl+eNPWEX5slM1hSDl2
 oVSQ==
X-Gm-Message-State: AOAM530747TkrqkyLyiT4A7Lr8n1SLL04NNpjvfjjCqw2I5JgCwGIcSX
 VslH0lsFGgMeoXAmCS2mBH/Ldm9+6Qdd4li6M3QrXv8Ws5VwA3Cmo8ssCwmWnWbH4nlc9HPmoWu
 1MOxGKErIg2YCYBc=
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr3205537wmi.19.1594115353832; 
 Tue, 07 Jul 2020 02:49:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhjO300padGf2IU9iGh5lHNKLXoZPyq8xQxiuZIEUPlTbnpXN3qkUAgPE+zveiTJ5kLy35fA==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr3205509wmi.19.1594115353577; 
 Tue, 07 Jul 2020 02:49:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46?
 ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
 by smtp.gmail.com with ESMTPSA id 1sm352370wmf.21.2020.07.07.02.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 02:49:13 -0700 (PDT)
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
 <20200707094006.GE2649462@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9f1c1b9-0148-8d9d-c67b-bd871f057089@redhat.com>
Date: Tue, 7 Jul 2020 11:49:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707094006.GE2649462@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
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
Cc: Laurent Vivier <lvivier@redhat.com>, ehabkost@redhat.com,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 mark.cave-ayland@ilande.co.uk, Greg Kurz <groug@kaod.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <dgibson@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/20 11:40, Daniel P. Berrangé wrote:
> 
> The info qom-tree calls could be pushed outside the loop
> 
>    info qom-tree
>    for each device type
>       device_addr type,help
>    info qom-tree
> 
> Taking /x86_64/device/introspect/concrete/defaults/pc-q35-5.1 as a
> example, this change is the difference between 20 seconds running and
> 3 seconds running.

Or even, saving half the runtime:

    info qom-tree
    for each device type
       device_addr type,help
       info qom-tree

Paolo

> Reverting Markus' change actually didn't make much difference, only
> reducing the 20 seconds to 17 seconds.
> 
> The downside is that if there is a stray object/crash, it would not
> immediately associate with the device type. I'm not sure that's a
> real problem though. Especially if we are running this as pre-merge
> CI we'll only need to look at the patch series to find the broken
> device. If this is quick enough that we can run it as standard,
> instead of only with -m slow, then its a net win I think.



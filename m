Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89720C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EB722249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtWHfByJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EB722249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVDV9-0005cI-Eo
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 08:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVDUB-000573-Bi
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVDU9-0006dg-Pu
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603284296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Il08k/FCl+ku1iFiG+fSrcgUS3s9ecpQz+nrDNgQzls=;
 b=TtWHfByJb32ejuRWrVdEl6KcPf+8XKJZwtaAJfoyc+9XzxeHyDQZZxWdgFIRpjajm8Mbm1
 OB54pVpOrVQEJxVmTb5g32VbxCmxkGe5Z1BQlR7YsM4g01ZYDiz7UEn5Pv7jpfNmNXofXf
 GbWllkQ1z7EQjSE4yx7C+6V5m0dO+YY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-HbRku61HP7-k4stXi6Cc4A-1; Wed, 21 Oct 2020 08:44:54 -0400
X-MC-Unique: HbRku61HP7-k4stXi6Cc4A-1
Received: by mail-wm1-f72.google.com with SMTP id o15so1473947wmh.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 05:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Il08k/FCl+ku1iFiG+fSrcgUS3s9ecpQz+nrDNgQzls=;
 b=XGHeZKucikM4Wde+YzdFOXiy2QCKSW00mYpLTAEGcj4qU5vdmqoV1hkID62AUXUITH
 FBtNKO91snZK9yleI/RshkXU+upoDOpjJWV4Qa14HLGMOy59owDNGSJJMvO932RpYaWa
 JKu8MES8rneFKFpiszKI5ZKBgUYvCHpmyuw/5zSADHJD+dER7vQLx+DAoy9WwwIWQJ8p
 4tioL6ROOfrkGp/VdkNqjoi27gdQ+G/QBypgEFwnsvjV4SoQ0wzFcOhADSQbfeYD6eIK
 i8NPBhWKwXSicsX9PRd2YWmhEgMvzcjC3ZATr3gnJqD1NeXtiX88dnBE8nP9rgC5DKAX
 atZw==
X-Gm-Message-State: AOAM530XCXklfLXVRoegZdD3jL5yFJp33LEv+FNnv7vSGW7EkxdLpeHX
 eJPvJUcPcAvnKJsJj16mkcNnsaWWvJmJNfvzCU0MnRQ7hqsr93Fw1P2N8EhCV/7WnvQ5nYORp8u
 eGrC6+9WUxobQxQU=
X-Received: by 2002:adf:fc0d:: with SMTP id i13mr4721920wrr.156.1603284293244; 
 Wed, 21 Oct 2020 05:44:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqI2XK0EjuG388HLQ9RgY5qP2Z14gEZnDrHXr++Jwqm6WWMuft+mhk9uPjx/OTisSlCq5E7g==
X-Received: by 2002:adf:fc0d:: with SMTP id i13mr4721895wrr.156.1603284292957; 
 Wed, 21 Oct 2020 05:44:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id t199sm3244214wmt.46.2020.10.21.05.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 05:44:52 -0700 (PDT)
Subject: Re: [PATCH v5 02/16] fuzz: Add general virtual-device fuzzer
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201021010752.973230-1-alxndr@bu.edu>
 <20201021010752.973230-3-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <675e45e4-3de1-bf0a-b7d3-117710b7fba2@redhat.com>
Date: Wed, 21 Oct 2020 14:44:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021010752.973230-3-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/20 03:07, Alexander Bulekov wrote:
> +static GString *generic_fuzz_cmdline(FuzzTarget *t)
                   ^^^^^^^

> +{
> +    GString *cmd_line = g_string_new(TARGET_NAME);
> +    if (!getenv("QEMU_FUZZ_ARGS")) {
> +        usage();
> +    }
> +    g_string_append_printf(cmd_line, " -display none \
> +                                      -machine accel=qtest, \
> +                                      -m 512M %s ", getenv("QEMU_FUZZ_ARGS"));
> +    return cmd_line;
> +}
> +
> +static void register_generic_fuzz_targets(void)
> +{
> +    fuzz_add_target(&(FuzzTarget){
> +            .name = "generic-fuzz",
> +            .description = "Fuzz based on any qemu command-line args. ",
> +            .get_init_cmdline = general_fuzz_cmdline,
                                   ^^^^^^^

Does this actually compile?

Paolo

> +            .pre_fuzz = general_pre_fuzz,
> +            .fuzz = general_fuzz});



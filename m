Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF20C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F421206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPuBMkgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F421206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUI2-00007W-4b
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXU1s-0003GL-6F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXU1q-0006fC-7t
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603824544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=isf6733Qk0Rl/B/21TvcSsL9gaZ2dMHhY9xDzcDNmMk=;
 b=HPuBMkgxvGnUoTgqrFb8wQuhPPNRgy+R8i1YWeroh1zKv9hzWcwLaJvqM36+rVoOjukTZl
 KGEJamSTDPczTPx+VUxbyQcOmdUQFu/55C7ivmfV4ou6QVCGYLlDgl8kKz+KN33i9xNb8k
 x2Sp06Yul+YC97FBTcVMLPHkgt4vvmI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-2RnkVlbJNRS_8kgmXqfT7Q-1; Tue, 27 Oct 2020 14:49:01 -0400
X-MC-Unique: 2RnkVlbJNRS_8kgmXqfT7Q-1
Received: by mail-wr1-f70.google.com with SMTP id j13so756642wrn.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 11:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=isf6733Qk0Rl/B/21TvcSsL9gaZ2dMHhY9xDzcDNmMk=;
 b=UP9X9K1jW3UYLDjKZomINW1ECU9+dtu5MGOABjCLiCBdclI2UGcC8s6MV4Yxq2B7Mj
 1xoiAw9wYC/FQV7T8JwLFJ3thWcltzvvYtxPsGUOJUs+22wvn+cKBflWGrMNv26owdQH
 Y+ZOZZnr7tuxlFgQNzOfnajbJH4Z1Ciui3tZrg6zAkdrl9ZxXxHz5AkT080izBmqUfsi
 VcnXOz/fIm0C5xKREczJ8CMMn9nO7WixxJiCP+1ZohyReheI7501QjMcM86osiocN6Mq
 5lgMlbVy3+/b3Ec/3y0YzLetwfrjys8ZaFxTsxVtQjA5YjSPqpTx3NauC/m69vP3a4/F
 fnvw==
X-Gm-Message-State: AOAM533M+QGMxG1VsY1sGMx29dDswRr8Ma9Jxo+n1WQTqWZbAEY9ahmw
 ub7LeYOizydOYLtos6o1LllQByKzLcgpHcbOVxD2SSShDHGfFQaw6lVK+F38OKgM0zUOzy83GSH
 MAUbk/QvkWW42X/w=
X-Received: by 2002:a1c:3142:: with SMTP id x63mr4161327wmx.168.1603824539984; 
 Tue, 27 Oct 2020 11:48:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybtnYMJFLOMOYX/38ofxKnjGPvJoNRjWh1MyojQm7QS9CELAZwhAXerQsiP2b4PPtckgixKg==
X-Received: by 2002:a1c:3142:: with SMTP id x63mr4161306wmx.168.1603824539806; 
 Tue, 27 Oct 2020 11:48:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id j9sm3202915wrp.59.2020.10.27.11.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 11:48:59 -0700 (PDT)
Subject: Re: [RFC] Using gitlab for upstream qemu repo?
To: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
 <CAFEAcA8OjeQ-utD56inorMk8dM6RNRzr-6Dv-YEW4n=qBi_MBQ@mail.gmail.com>
 <20201027131452.6q4tqvp6a75zj7kk@vm0>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <626eb3e1-cb34-d667-b937-5cfdd8bd9e52@redhat.com>
Date: Tue, 27 Oct 2020 19:48:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027131452.6q4tqvp6a75zj7kk@vm0>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/10/20 14:14, Michael Roth wrote:
> My only concern would be what the lag time might be between updates to
> qemu-web.git and the actual website update if the mirroring doesn't
> right away. Probably not a huge deal but might be good to know what the
> upper bound is if we want to verify the update process went okay.

If gitlab became the primary repo for qemu-web.git, deployment would be
done differently; either by rsyncing directly to qemu.org, or by making
www.qemu.org a proxy for qemu-project.gitlab.io/qemu.

Thanks,

Paolo



Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2F7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C78E207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUu5T7Sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C78E207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8UVV-0007Ij-N1
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 16:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8UUx-0006p3-Vw
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:15:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33894
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8UUw-0006ys-8b
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597868149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hz9s+FPm0MSetPZMORZKYzPu644qFZqT1E+aD2/Ba9Q=;
 b=jUu5T7SzbPPLfWK+90a/UqMwE3qlR2VWNHK4K9mElylVagrmojuIWCK+K+pHI/VPF83tBC
 WINbuNiVIpubtTAzYRcDcr9hX2mEb/ej+6qC6JzxEr39ayDMF2J91FPGF+jD+BGG5LX31L
 BtrcjaGd1QXfsyqxkQTkunUA6dXukZU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-ZjuCDTthO62nDzkUHboNZw-1; Wed, 19 Aug 2020 16:15:47 -0400
X-MC-Unique: ZjuCDTthO62nDzkUHboNZw-1
Received: by mail-wr1-f71.google.com with SMTP id b8so9740914wrr.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 13:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hz9s+FPm0MSetPZMORZKYzPu644qFZqT1E+aD2/Ba9Q=;
 b=gH4Y5T/IyAx0u7P0abrxMgtW3tdnKPn9pXqXtIe4CKhkBzTJezpewK5uqkQlXoSDYa
 5Ss7G4yKPq61vkewtrsA2gRGPAB0Fzwze8WQWVUu3tYCyZ86GHi9jC3AYwn5qOMKUtz1
 GwKv1YIREgp0hxr8avbEHpLs18bQ6pneCFofxxlLqirLxvUmyTDMyU9mQ1M0xCFbtqOy
 CQaXYFP6bm4fMPm8VpbJNu70jh4vZZOwqBietW1898SgRt4lELESz9+OPyegi8NR8CN+
 3k+RLGcuLzxm6NDPbNiex1+c4kAjQCzXDA/ZfUIDdb1r+OAHUPF6EqKd+JQVhHpMfgal
 yS2w==
X-Gm-Message-State: AOAM531lpSPFvOg9H/w3TAgRbQSlsqPe7UiUPju8mf06cslW8fKPn0/B
 V05D/9OZdtZxn509Z1k2Jwb1asaml4DbrAV+qNiIgfwfR2M/6dFY30aqKHU1CiOEd+JkCZdCPK2
 mkvf5s/jL0KODZTk=
X-Received: by 2002:a1c:c906:: with SMTP id f6mr7802wmb.5.1597868146258;
 Wed, 19 Aug 2020 13:15:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPMzSKh0a2AgLND/gTI/6+dv1YKqW4RChT8L/qusWRY3rswCq7F3oqq4M6gfRK977TOXBC3g==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr7786wmb.5.1597868146002;
 Wed, 19 Aug 2020 13:15:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id r11sm40565005wrw.78.2020.08.19.13.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 13:15:45 -0700 (PDT)
Subject: Re: [PULL v6 000/150] Meson-based build system
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200819143525.2175-1-pbonzini@redhat.com>
 <CAFEAcA_8VJecDyK8FR0ty=pknmo+Hc5s0OFj+-Y1Ah-OJ01FDQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f0c7cd7-c48f-04e0-a05c-c464fcdeb61c@redhat.com>
Date: Wed, 19 Aug 2020 22:15:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_8VJecDyK8FR0ty=pknmo+Hc5s0OFj+-Y1Ah-OJ01FDQ@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/20 20:12, Peter Maydell wrote:
> make: *** No rule to make target 'check-block', needed by 'check'. Stop.
> make: *** Waiting for unfinished jobs....
> [various other output from other parallel jobs snipped]

That's because no tests are available with --disable-system, but I can
certainly add a no-op target for the sake of backwards compatibility.

Paolo



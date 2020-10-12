Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEDDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6ED82074A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWbWlIio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6ED82074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4uS-000264-Ql
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4gI-0001Rx-Fk
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4gF-0003ro-VR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602535467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9tIHxyU70EYbxGtxRDLnF8x7FtTeIYvmQERCK+W95k=;
 b=VWbWlIio9lwI7WuxO0ombAK4wb39/C/KxCwWRYfd4iEfIwUGpQKbJs0ty84420E0xGC/Dp
 GWISNikRZxYtuyWHF63dvm6UjmWdII58bk/cRjhjvZSzqYTMaQgkSg7Te2k46zSLIfgMU4
 mnj1ztBRgTHOol2cgYZoLx7ZknmB3U0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-bRmufwegO5SKl6IOjbHV0w-1; Mon, 12 Oct 2020 16:44:25 -0400
X-MC-Unique: bRmufwegO5SKl6IOjbHV0w-1
Received: by mail-wm1-f70.google.com with SMTP id u5so5445508wme.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 13:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P9tIHxyU70EYbxGtxRDLnF8x7FtTeIYvmQERCK+W95k=;
 b=qqL9s8DiViSQj9NfiA5mv4oBgAub+kis3gm9TT9oVISzle3+fkFRepCPKHJAmbi7zO
 X/9Rdle1rtjRPZpYfY3b27KEhVZWJm+MTeZf+dR+OwLBdivEe65j/mptVxSmUJjOZcil
 yP5ephQH5MRGtgK+Km4VYiZ6gVRflO8pz51rOJDeCoohQb4IUteF5UsyI89VetTgmnJn
 Mp//YDtqtqZEB0XcIvg+H3MzJPamOApL+dQUPh6aRiHDfRyW/QL5XFpasADNFrwTRKMH
 xrHKR6UTjOwCmYSim4r9iJV38m7KRFe2Pv/dljsjTdmCOjBIwAPI9iKPv9rL0CjeAV/5
 aB5Q==
X-Gm-Message-State: AOAM531UWfCX3tV3DHAFUr3Cr4YCw0vXs5yr5lWz5bPzNu9WEKa2hYr6
 0uqCApSeaYS9KoAPjPPEFFqkBGU35+l7hJvN/4Lt11r2nDKlPzLGgtVstLEf7dPJxZwiteuUBxf
 HQ3dbghUqm0wBAcQ=
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr33085171wra.187.1602535464447; 
 Mon, 12 Oct 2020 13:44:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwycSwsnBLTILZmTeT/LSdg3ijO/jkC9Qt08vlM1p28f1lsLIhqYaL5ffYRvNXb/X7OZqjtHg==
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr33085160wra.187.1602535464272; 
 Mon, 12 Oct 2020 13:44:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5a47:91d0:18ce:e295?
 ([2001:b07:6468:f312:5a47:91d0:18ce:e295])
 by smtp.gmail.com with ESMTPSA id d4sm26176007wrp.47.2020.10.12.13.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 13:44:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] accel: move qtest CpusAccel functions to a common
 location
To: Jason Andryuk <jandryuk@gmail.com>, Claudio Fontana <cfontana@suse.de>
References: <20201012200725.64137-1-jandryuk@gmail.com>
 <20201012200725.64137-2-jandryuk@gmail.com>
 <f29b58c7-62c5-ad10-91c8-47598759c876@suse.de>
 <CAKf6xpuyr818af9ucB-vpL9JXtmsATJaP--UWRgTjRku_G82mQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <863b5bba-7001-beed-4bc3-238ce8743ff9@redhat.com>
Date: Mon, 12 Oct 2020 22:44:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAKf6xpuyr818af9ucB-vpL9JXtmsATJaP--UWRgTjRku_G82mQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
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
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/20 22:40, Jason Andryuk wrote:
>>> +specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: dummy_ss)
> ...  I don't really know meson, but this file is guarded by
> CONFIG_POSIX?  If that's true, then this ifdef can just go away.

Yes, it's redundant since cpus.c was split.

Paolo



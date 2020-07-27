Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10883C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF31320663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCWrev4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF31320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01Ib-0001bP-3H
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k01Hm-0000MZ-WD
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:27:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42296
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k01Hl-0007qA-C3
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595849232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uNxQVY+chDbijYdYSzn9OG8iOG6G5YlWPO/TNQduyHk=;
 b=NCWrev4jOyy/lfW1vNUOw49Afaor2IIseGtivwPeJsF+txRafzQ7JUflQKKUlVNBYHbFq9
 kitQNQ+Wu5BHgtXAs7fl5pqTPMpLTNuG47AEk+ve5DmHDzZvuAZQ5m0IKumMEVz7am2SjY
 ktR9jhNsHPJpf3j76X2dKelgCXzsjZw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-QIYVxPoZMaeJMSDYMtXpzQ-1; Mon, 27 Jul 2020 07:27:10 -0400
X-MC-Unique: QIYVxPoZMaeJMSDYMtXpzQ-1
Received: by mail-wr1-f72.google.com with SMTP id t12so3848974wrp.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 04:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uNxQVY+chDbijYdYSzn9OG8iOG6G5YlWPO/TNQduyHk=;
 b=gGo7nY9H6Ie6oT8w83l0I2w6DnXMk+p0il6o7znDR7UsK+XrLcU93luzF0A/UTqaT/
 ViuHx6V9OYRWme5PvdRZ4Y1APQud5sn+zE4QgBAUEMD4oI4gPSlL4Yy8nyXJnl3WBq5p
 VfaoZhCrcKMojwbT6YkOL3YZWdKA1VSDDI/v6oE0uIG9W+ro0w807knj3NVUJ7M8JhTL
 x6YH7+QOfmvHQ+mWn4igJPLVVQ2Ph+DNIn6P4zskENniPdPc0P6fcBidTbi54jZ84/rv
 KGNqSjLU7Da0mZtoVaTlOWxX4uDOYtthZ6M6OlzEGgWoLKpMXEORf69zx0Qg6JPoFxwM
 Rnjg==
X-Gm-Message-State: AOAM5335xR4Wtqy3zoeiOSaQpZJCs9oiaDdDhgZe8JvIUKoVkJn6WiAu
 XK5LGzkn74/giXvaVkX34709cDzSg5z6F7vJFMZ+8WjgLknL3oSxLvUWvgOZpJHWOley2TUlSPD
 uFfsXi+4VEm5Mrxc=
X-Received: by 2002:a1c:7402:: with SMTP id p2mr20434012wmc.117.1595849229011; 
 Mon, 27 Jul 2020 04:27:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9t+EC4ki5Zua/wybeI7pJi0PC53fnBcG59CbzO0eRKE23LkKmE2Jav8TLzYgz3xnvZIwdTQ==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr20433997wmc.117.1595849228760; 
 Mon, 27 Jul 2020 04:27:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:80b0:f446:bb61:1dbb?
 ([2001:b07:6468:f312:80b0:f446:bb61:1dbb])
 by smtp.gmail.com with ESMTPSA id w2sm13167540wre.5.2020.07.27.04.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 04:27:08 -0700 (PDT)
Subject: Re: [PATCH] softmmu/vl: Be less verbose about missing KVM when
 running the qtests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200710085020.28222-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <caf963db-26fb-e50a-3f82-e1b6a400813c@redhat.com>
Date: Mon, 27 Jul 2020 13:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710085020.28222-1-thuth@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/20 10:50, Thomas Huth wrote:
> Some of the qtests use "-accel kvm -accel tcg" to run real guest code.
> This causes some error messages when kvm is not available. We do not
> really care about these messages since the fallback to tcg is expected
> here. So let's silence them to avoid that they spoil the output of
> the tests.
> 
> Unfortunately, we can not use the qtest_enabled() wrapper in this case,
> since the qtest accelerator itself is not initialized. Thus we have to
> test for the qtest_chrdev variable instead.

I wonder if "-accel kvm -accel tcg" should warn at all.  I can
understand warning if we're running some /usr/bin/qemu-kvm binary, but
in this case the user has explicitly asked for a fallback.

Paolo



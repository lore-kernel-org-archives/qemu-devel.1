Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD19C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5873124654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zvg7ftKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5873124654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4NgF-0000vm-Iu
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 06:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4NfE-0008S8-9T
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4NfD-0007dX-8R
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:37:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48971
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4NfD-0007cj-1B
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582112230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8N9LrRkOPv2CV1LsD3E7E0MVOuDRwOA8YIo/oABPlQ=;
 b=Zvg7ftKqHCDKvLvdSrrnFezuFMAJ9F/GA38a6semf0iu27XKmmR+QTM23FFDXvBrrkKY+x
 2kRXZ51LpND34W3d2HClxu29Y6Gw5vMdm+V4Uf+zvWwxbu4MaVDEre0xil7rLlq0VgbQf4
 vA2W8TU/2bWgrpocq9eZpCBWTRHsO9M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-Toi7FtZBNS2G870y48U6nA-1; Wed, 19 Feb 2020 06:37:09 -0500
Received: by mail-wr1-f70.google.com with SMTP id m15so12348218wrs.22
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 03:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y8N9LrRkOPv2CV1LsD3E7E0MVOuDRwOA8YIo/oABPlQ=;
 b=sazhKYmTyaMwq4qZfsgD4CSuVitHdD7zaa6Vp+ER/Joe5kXA8iMQVpUvJ13NOfU8qX
 /rtyuL1vj7XrDY1YXR9mW2TMYbmt1We86eNTaZ+fYfCP3iqYxbs45stLkl56SydSkrd/
 sksoa3cOJM27HhdK3c/LHF/T7teQ5bhGL4Q+QmZtVt82g/ibXu55MUWVFFDiNOy504Pn
 yrtPk09pMaXIjgFzBqcJpNtH2fprbm0MNPrbfaN2D06RGBsgzbMSKZ63TC00Rbo3fKTh
 UcQKINB5htGXySQFUT0KyzKmK2+IpWIGPjf1RvRLQikuVuayt28N2AaYRLswZgUMdnCB
 IKQQ==
X-Gm-Message-State: APjAAAWOxK36sXUI0K9BQ1OHGMIhLLza6UE9hnzO19mYDw7GFazy593w
 Kv3982FTX8G43Ur1U7CTYBs4B8zrbCdz4+x2J8PtxmIJkVuNggJO++rbHJemj71+HXcZ5y6omBB
 8P2A4TaFrmNuem1s=
X-Received: by 2002:a05:600c:21da:: with SMTP id
 x26mr7762573wmj.114.1582112227952; 
 Wed, 19 Feb 2020 03:37:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmACpZyPsRgr89mMRwn8avijJ8sF4rPbUkW3VMsHoovXFyv61WAdbvvOKN6Ou4Uc5nzPcomg==
X-Received: by 2002:a05:600c:21da:: with SMTP id
 x26mr7762551wmj.114.1582112227697; 
 Wed, 19 Feb 2020 03:37:07 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51?
 ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
 by smtp.gmail.com with ESMTPSA id p15sm2557354wma.40.2020.02.19.03.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 03:37:07 -0800 (PST)
Subject: Re: [PATCH] memory: batch allocate ioeventfds[] in
 address_space_update_ioeventfds()
To: Stefan Hajnoczi <stefanha@gmail.com>, Peter Xu <peterx@redhat.com>
References: <20200218182226.913977-1-stefanha@redhat.com>
 <20200218214932.GD7090@xz-x1>
 <CAJSP0QV2+w0SNq+FtuYUfpAp_xcqg1rP8zdsYhfNxW49M3ANQg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cc41b046-9f03-50fe-de90-cbb2fbf88000@redhat.com>
Date: Wed, 19 Feb 2020 12:37:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJSP0QV2+w0SNq+FtuYUfpAp_xcqg1rP8zdsYhfNxW49M3ANQg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: Toi7FtZBNS2G870y48U6nA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/02/20 10:18, Stefan Hajnoczi wrote:
>> ... do exponential increase here (max*=2) instead so still easy to
>> converge?
> I'm happy to tweak the policy.  Let's see what Paolo thinks.

I included Peter's suggestion in my own tweak.  Thanks to both of you!

Paolo



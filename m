Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F48C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4EDD2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UF/yFAfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EDD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnp2Q-0007XA-6G
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnozI-0001bn-9o
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:53:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59607
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnozG-0006Qy-C6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592942021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijBJ39bc+vSoTtVS8ZuRaEc6t5ZyCnt60sn8O7R1ja8=;
 b=UF/yFAfRIxW4XlOCjQOoUklBFEUASY25dqyFwj7h56GUJhxXh2rWgEP/qEOfLBQLz3byYP
 eJLq/+k+9XLcg+viQQZntdYRGtZ5SEyDW5jg/b2fTe0Q/UuGk53UitWHx8gXLNrgApaM4R
 GSYcY3Nhb8eMFBfUtQUeDnslWSqVeKY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Yx23ilhtM4SSQcwKpNbkyw-1; Tue, 23 Jun 2020 15:53:33 -0400
X-MC-Unique: Yx23ilhtM4SSQcwKpNbkyw-1
Received: by mail-wm1-f70.google.com with SMTP id s134so5581571wme.6
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ijBJ39bc+vSoTtVS8ZuRaEc6t5ZyCnt60sn8O7R1ja8=;
 b=nejr90to1rRx7RWpa5S1VQXhDJN7W7v29xuIVFMQFTf7FP5gc93IN+PvpJO4M7fxLA
 lQllFYJ6qH2G2TWLGdMwq9tmh5tdz8FpCOsdDS7hweAYI2VEx11aYLTY0w8RosaKnH0s
 0FHtclgPqfDmNbne/F/sg8AVWiQe8ChCcAlYAYZpkDhyr7+NF2KD5lchT9xLsdsqFDe/
 +cunCcY1CaJSbiOcX3S103mRYicUVWUQnQ3Bj3WgoMHXUwBCEuTqMGS4zqxa1ey1ys6E
 BNXUrYxa9Ln0zCsvoYM2pdovFqe/YXeC6EBUoFTc7/U1J2ty9Cxs2FtjiBIA86doZBdo
 dwvg==
X-Gm-Message-State: AOAM531mHYmCcmsyC/6fwtv8I22/36kpRQm1xb4CFVzXRW4sIamslkUv
 +qjzSeWVsvgFT57q+F2maad8CgwYCGaCK+sBvFg5zGfjZ++hrg2fFJKEv/tXNW8S57BhQgCeUcL
 M4ZmKvgYmEXyn7VY=
X-Received: by 2002:a1c:dcc2:: with SMTP id t185mr27134383wmg.91.1592942012568; 
 Tue, 23 Jun 2020 12:53:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSNc92feIJX8/1g4eSEQdZLJq+H5ggGcTXEne+ytbzy373yNC0ouo6MqVA54ObdQrOwoqWAw==
X-Received: by 2002:a1c:dcc2:: with SMTP id t185mr27134367wmg.91.1592942012283; 
 Tue, 23 Jun 2020 12:53:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879?
 ([2001:b07:6468:f312:24f5:23b:4085:b879])
 by smtp.gmail.com with ESMTPSA id w17sm25115229wra.42.2020.06.23.12.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 12:53:31 -0700 (PDT)
Subject: Re: [PATCH] configure: disable -Wxor-used-as-pow
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200623173726.20909-1-pbonzini@redhat.com>
 <cc8efdbc-0d09-37ca-199a-2b82700aea00@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5cefdc7-b470-50a7-8c02-8f712d8f2c0c@redhat.com>
Date: Tue, 23 Jun 2020 21:53:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cc8efdbc-0d09-37ca-199a-2b82700aea00@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 23/06/20 20:41, Eric Blake wrote:
> On 6/23/20 12:37 PM, Paolo Bonzini wrote:
>> Clang being clang and adding more pointless warnings.  In a hardware
>> emulator there are going to be plenty of bitwise operations, and the
>> chance of someone writing ^ for pow and not being caught is basically
>> zero.
> 
> Did this warning actually fire?
> 
> My understanding (from a quick glance of
> https://reviews.llvm.org/D63423) is that it is supposed to catch
> instances of '2 ^ 16' where someone meant '1 << 16' instead of 18.  I
> don't know if it is supposed to flag 'a ^ 16' (if it does, then it is
> indeed useless), or only when both lhs and rhs are constants and where
> lhs is 2 or 10, so my initial reaction is that without seeing an actual
> false positive, we are premature in disabling it.

There is an instance of 2 ^ 20.

But it's actually a bug.  Objection (and faith in humanity) retracted.

Paolo



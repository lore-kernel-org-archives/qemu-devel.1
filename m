Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77BEC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0A324672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFCiMZEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0A324672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJiC-0008Va-Kl
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1irJgD-0006Cx-NJ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1irJg9-0006DI-0e
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:44:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1irJg8-0006Cw-FJ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578998647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NVuSMQBbvDwoEdjBHMq1QbXFvfXBXf2D63KHDijPaw=;
 b=iFCiMZElKtSy1RqaiwH4LvQVLgOt/g8olIW3qrYnd0BzXn07WPfoX70b1Hr0Pckdp2P9WO
 mYlN0o10sKNKWJtX/XxXpE8RIVfCKDRQLwpwwLh5dY7kztCrLM5tzNO9p6l2Gy/R7dAu6n
 LM1IO6SGolgPwdRAmkoP0THoXOYH6IY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-oF3dn6w2PuGRY24GUIcEiA-1; Tue, 14 Jan 2020 05:44:05 -0500
Received: by mail-wr1-f69.google.com with SMTP id w6so6272850wrm.16
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 02:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5NVuSMQBbvDwoEdjBHMq1QbXFvfXBXf2D63KHDijPaw=;
 b=b0Mkwe6UisvufiIcWPtulIXFxX5fh4XyZbN0t3pdxysvKqd7jNeJ6/QrADQmjaHxeM
 zCZSjNysTa1E/o9YIqxilBBJGJ6Xfr3X+HAhpJF2AtxqFleSeYHWTvXTR7G9EGikDVx2
 HVtv0l+dbnKxNC6dkS0UNSMt7nj57Fb3NqVsfejs9NLLS4MI1Is1561yGVfUPXqcWv6k
 h7J911n4j2hFaMNqxsIBFReu84zOH1kgw+VNZYn11dP9AbOhi8R+CaRhL9LgkJ7hlP7n
 /39RBXbtYeDh4QoFB3sWS1lLusN6G3TkPdoeSnkV5rPByLxpTUOXmwgr38rv7juZgK77
 P6tw==
X-Gm-Message-State: APjAAAWVsi57Hb8N0FbXqnUdDlXFqmJcER+XADfbMJxFrROf+54utWpO
 lynwJaNEJxFX2Jtw6EbQVw8gt+gGqYar2NYGqp5ji9PS50YcX8JCnRHBW7JwLVXPPEcD/u47paZ
 dBjjMzBqTfVFV32o=
X-Received: by 2002:a5d:5708:: with SMTP id a8mr25343449wrv.79.1578998642969; 
 Tue, 14 Jan 2020 02:44:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgIRwO+QtaJBtosJsLDbnmBQYJ9+lc+iPwyA0TZTfWl/4zcbT9VO+rMjfctPM3IwmWZnoBKA==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr25343429wrv.79.1578998642741; 
 Tue, 14 Jan 2020 02:44:02 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id z83sm18644437wmg.2.2020.01.14.02.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 02:44:02 -0800 (PST)
Subject: Re: Priority of -accel
To: Markus Armbruster <armbru@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
 <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
 <87d0bnwct1.fsf@dusky.pond.sub.org>
 <ff78d961-9432-c84d-4bba-6df14b1a5a79@redhat.com>
 <87lfqajtwh.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ba331fa5-b45b-72fe-7096-8b4e0cb5f38a@redhat.com>
Date: Tue, 14 Jan 2020 11:44:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87lfqajtwh.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: oF3dn6w2PuGRY24GUIcEiA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/01/20 09:59, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 13/01/20 17:17, Markus Armbruster wrote:
>>> Perfect opportunity to change the default to something more useful.
>>
>> I am not sure acutally if it's that more useful, now that we have
>> sanctioned qemu-kvm as the fast alternative.
> 
> If there is a fast alternative, why ship the slow one?

I find it more consistent that qemu-system-* is doing emulation (and can
usually be ignored) and qemu-kvm is doing virtualization.  It's more
intuitive to launch qemu-system-x86_64 than "qemu-kvm --no-kvm".

What we could do is automatically install a qemu-kvm binary for the
"most suitable" target that has KVM enabled (i.e. for
qemu-system-x86_64, not qemu-system-i386) instead of leaving it to distros.

Paolo

> No matter what we do, somebody is going to be confused.  How to resolve
> such a conundrum?  Utilitarian philosophy teaches us to pursue the
> greatest confusion of the greatest numbers.  I think not using x86
> hardware virtualization by default has been admirably successful there.



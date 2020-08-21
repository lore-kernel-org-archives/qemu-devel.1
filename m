Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C0C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5080207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4WMuhTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5080207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96nK-0000bc-UI
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k96mN-00082b-Hx
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k96mI-0005Z4-0A
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598015296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4EFxaV8jwI5++iHqTSXs+aUcaIYGWMRRd7Y4fvhYvE=;
 b=B4WMuhTWF7OWxb+HiMwSUAQfXhxY5sypzmTzgRI0V02V5END+Q0QKWrG18ZfcowrT0OOKk
 ceCK0jqqU6j7tBCWavB0rA7RDi9igm8H/4oQwmm/vxW8H6F28eaKcSujRgVOYyg9nNbDdg
 MP0Z1bRsFfrvexziWtg5Y8oB6dOtdE4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-MmILvLXzNgeDrfkudHNyMw-1; Fri, 21 Aug 2020 09:08:12 -0400
X-MC-Unique: MmILvLXzNgeDrfkudHNyMw-1
Received: by mail-wr1-f72.google.com with SMTP id r14so540978wrq.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f4EFxaV8jwI5++iHqTSXs+aUcaIYGWMRRd7Y4fvhYvE=;
 b=TXlLHjSOF+epmpVSpNWoMHdnxDYuHm0r0rhn/AsJM7ZLVmSaPDR1EmNLoQ+beHv60g
 ztkCn5juE5K9UDZhgsPhQV/xzX0wijo66/AfiqSHbpak7wBs7EdNNlQpS/hI5IvRM8Cj
 2b0KWOzKE5veuASD+1rIIKT3RRgUyLtiFSNcXEVTeOWf1bdSJqZ2Ak+Ocjg4UjaNidU5
 PUUdnMFR2v+t7/W6+ZVTPAqWxyTt6g8b3+zyH89IE135xH1XKbT/EbH25dRaFLm+h13L
 zhcN12FbnkO6AU714BYyfLnVPnEzrBUJ8rGTZ5Yiq0Y8B9ZcwRxUGqpepdkS/RdMWlB4
 AU5w==
X-Gm-Message-State: AOAM532NfNj/GDiCZb6/PN3G8HS3Av2DM/HnwG5swCkdzRuKX/Uad6ts
 ih+eT+jDzSLxAlN7GL2Q0rArZEg9WAEkK3alEjY9FXyUO7Etgn3iSemJfH0v/Iqof+PLOrbs6jl
 hwsTxP8CJsbiQAYI=
X-Received: by 2002:a5d:518e:: with SMTP id k14mr40710wrv.265.1598015291086;
 Fri, 21 Aug 2020 06:08:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB7tLPn/oI9TIi+GvWAzg8FxQd85yUzqapy3z0X2+La0y5/3SMtmPU5rXwEA+8uBoZ1hAVBA==
X-Received: by 2002:a5d:518e:: with SMTP id k14mr40692wrv.265.1598015290860;
 Fri, 21 Aug 2020 06:08:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id u6sm3951367wrn.95.2020.08.21.06.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 06:08:10 -0700 (PDT)
Subject: Re: recursive locks (in general)
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <20200819062940.52774-1-geoff@hostfission.com>
 <3140676.b1PlGooJ8z@silver> <c84d95de-c71d-3272-6b41-95753634482a@redhat.com>
 <4046931.6zmTeCK0lb@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <87c93055-c4ef-cba7-43b4-da2e7f65f2e4@redhat.com>
Date: Fri, 21 Aug 2020 15:08:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4046931.6zmTeCK0lb@silver>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Geoffrey McRae <geoff@hostfission.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/20 13:12, Christian Schoenebeck wrote:
> There is a golden rule with recursive locks: You always have to preserve a 
> clear hierarchy. Say you have the following recursive mutexes:
> 
> RecursiveMutex mutex0;
> RecursiveMutex mutex1;
> RecursiveMutex mutex2;
> ...
> RecursiveMutex mutexN;
> 
> where the suffix shall identify the hierarchy, i.e. h(mutex0) = 0,
> h(mutex1) = 1, ... h(mutexN) = N. Then the golden rule is that in any call 
> stack the nested locks must always preserve the same transitive hierarchy, 
> e.g.:

That's also what you do with regular locks.

But the difference is that with regular locks you can always do

void bar(std::unique_lock<std::mutex> &mutex3_guard)
{
	...
	mutex3_guard.unlock();
	synchronized(mutex2) {
	}
	mutex3_guard.lock();
	...
}

while with recursive locks you cannot, because you never know if
mutex3_guard.unlock() is really going to unlock mutex3.  So a simple
reasoning on the invariants guaranteed by mutex3 has turned into
interprocedural reasoning on all the callers of bar(), including callers
of callers and so on.

> For me, a non-recursive mutex makes sense for one use case: if the intention 
> is to lock the mutex on one thread while allowing to unlock it on another 
> thread.

Then you want a semaphore, not a non-recursive mutex.  Doing what you
suggest with pthread_mutex or C++ std::mutex is undefined behavior.

Paolo

> For all other use cases I would (personally) prefer a recursive type, 
> as it guards a clear ownership relation and hence allows to guard and prevent 
> many mistakes.
> 
> Best regards,
> Christian Schoenebeck
> 
> 



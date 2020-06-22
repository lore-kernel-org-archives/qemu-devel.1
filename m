Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B12C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315B1206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMRVD19C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315B1206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnN2z-00061u-Ek
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnMz6-0001na-87
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:59:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41220
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnMz3-0008FI-Vy
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592834377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9BiD6ihmh7HVq7Tiy25cLlHRw95ssQel+yhdTLsTGnc=;
 b=NMRVD19CWcOwG2/4r/+2VToXZZ9GvETcjle8sdjjajM1NiufqTSIcGOHea3TbgV9hB/LzK
 pgARvipX13UKct9gE9Z18eQuKe8JckO2Ii33GR/JMv/uV0S95WKN0Glx8+p8H+U337u7Da
 scL95B/4qEVEXsGH9ngrNn4BYYghiqA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-qv71DGKqPGKx8V077tKQyA-1; Mon, 22 Jun 2020 09:59:35 -0400
X-MC-Unique: qv71DGKqPGKx8V077tKQyA-1
Received: by mail-wm1-f70.google.com with SMTP id p24so6842442wma.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 06:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9BiD6ihmh7HVq7Tiy25cLlHRw95ssQel+yhdTLsTGnc=;
 b=sXGWNIZIMbaXaZYXNqAeMAk4RxllRxQdq9x8YkisbaVk6pCzqpQN84zyjgYZ4RdAAi
 AvAQjhxDxWdPPcSrTbDVwo7IFBKtJfgoWOVFd/5jXswSg+jM6kTJjwd5bN0ZEBtA4E62
 ySyarYHvJV5aTJg/jfm4rrId3382qN5nT/XZC0VjykzPE+v7DfmdNrMI0MkRvPvbJ5G+
 1DZfP/V8A4eLv18U2CioRJFfQ1pMH0KwsrYmYJwxx7BNSAc4PsbAR7RVgtgVBsa8xYRX
 RGTuyN3G8OWYl85lnEJ94NomUPKJZ6JLcgmJ9oakmXgYSF3HyWaCWeHNDnDnC7TXOu0b
 nKwA==
X-Gm-Message-State: AOAM531S3OsTgf9wqGabTW8pW5CKKely+Fx94VzUfA4k/fJdmdhV9XgU
 Ou9pP1dObCIOjBp6MaBVgiw37yr91IqYQjmN0KREKFa88qXIGM5gMvyAOWPKaMVQSr8jmn9Na8o
 j9LighTK0/IU4Awk=
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr17426973wmj.117.1592834374528; 
 Mon, 22 Jun 2020 06:59:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoHWAXVPnmQ2lx7J2D9yV+2Ef5HKSVoghEAvuK4wS3g6BluFTOcizo7KQ7ZvTw807VajZdlQ==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr17426950wmj.117.1592834374293; 
 Mon, 22 Jun 2020 06:59:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fd64:dd90:5ad5:d2e1?
 ([2001:b07:6468:f312:fd64:dd90:5ad5:d2e1])
 by smtp.gmail.com with ESMTPSA id p13sm7832535wrn.0.2020.06.22.06.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 06:59:33 -0700 (PDT)
Subject: Re: CFP: KVM Forum 2020 virtual experience
To: Sean Christopherson <sean.j.christopherson@intel.com>,
 kvm-forum-2020-pc@redhat.com
References: <a1d960aa-c1a0-ff95-68a8-6e471028fe1e@redhat.com>
 <391a9edc-57e3-75a8-c762-d1606fefb4ae@redhat.com>
 <20200617190531.GL26818@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb0b5cde-283a-e8b5-1879-170ed3f6ddb4@redhat.com>
Date: Mon, 22 Jun 2020 15:59:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200617190531.GL26818@linux.intel.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/06/20 21:05, Sean Christopherson wrote:
> On Wed, Jun 17, 2020 at 05:09:31PM +0200, Paolo Bonzini wrote:
>> In order to allow everyone to present at KVM Forum, including people
>> who might not have been able to travel to Dublin, we are extending the
>> submission deadline for presentations for 6 more weeks!
>>
>> * CFP Closes: Sunday, August 2 at 11:59 PM PST
> 
> Blasting the lists as I'm guessing I'm not alone in having a topic whose
> status could change substantially in the next 6 weeks...
> 
> What is the recommended course of action for people that would like to edit
> an already-submitted proposal?  I don't see any way to edit or delete via
> the web interface.

You can contact the mailing list again (closer to the deadline, as we'd
forget otherwise :)).

Paolo



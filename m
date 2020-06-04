Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E662C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD7B206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlqXl//d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD7B206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgul8-0003vl-J1
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgukV-0003Km-KX
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:37:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgukU-0000g1-2K
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591295872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DG//sXrxU0dE7wCcODkP8Q6NWrKhXxotI+u4fQcl2Q0=;
 b=RlqXl//dTiOQicLVVrsAPtKHKh0SQG3hqY+MWM35L1yBY+3B5E/U9NHXzQjDxPNqhOtYA8
 KWdmYyfr2f9hhkIFFZCUE3qyZgPE0UVbsbzXpMKTFoO6b3XZxYgSh4tVHIZOjuGhJ2myXb
 2kACPjnZtjj33GcXyYRLdCXtSR/eXtg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-n2XlZ100PPCX91_-bdxmow-1; Thu, 04 Jun 2020 14:37:50 -0400
X-MC-Unique: n2XlZ100PPCX91_-bdxmow-1
Received: by mail-wr1-f70.google.com with SMTP id c14so2753825wrm.15
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 11:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DG//sXrxU0dE7wCcODkP8Q6NWrKhXxotI+u4fQcl2Q0=;
 b=TGSD9SpUwmvn2Ap7iSNdYsoeuZJm9WlJbalFGZJoxX3r0GSctN5gwLBnkWl1IYNI4S
 ecwmwXUO4Kv2mDhLRkEbU05KHKXQdgWzo5JuirIQAfOkZVPuzWegE50C4+Eo2M8ZhOak
 BVFXw5XZtuj6TVlsGtvhs+e6CXcNpxdZHroqvO3XjhoQBkh3j82TIIl1O8vqLD7qQbiA
 QbK/0TApOT8PE3h4pyuFJSnRQyBZeLTV0XYiKN2h9c89G5kvjUj1D05N+AyPcJmpcYYA
 LhYQGahVE07Hw1ge10wx9+ZQTryfX3RhENb6sbmC9500ud/MUhIqhtDAr9jBI+t0Fh8X
 xsmQ==
X-Gm-Message-State: AOAM530iVf15XC9RlhDKIk1eAHBDa3VrdzqFF3SYekntSMLLInlr38Zc
 bsr2hDQRuQyrXrI31pbVQuubiMa/XNQC3OlB9ynDskt3Yjr9jDTVmJTKDkh5lIEdC+qG77GbEde
 NaVK5IHfeyk0KmeM=
X-Received: by 2002:a1c:c908:: with SMTP id f8mr5285773wmb.150.1591295869665; 
 Thu, 04 Jun 2020 11:37:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHMoMQg9Rk1eHrWOvkZYrjlry/hoQtD587fzOXrnBpCZh+GAUxhTs6cOsZX1r7LVgwC1zoYw==
X-Received: by 2002:a1c:c908:: with SMTP id f8mr5285755wmb.150.1591295869400; 
 Thu, 04 Jun 2020 11:37:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id k17sm9396926wrl.54.2020.06.04.11.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 11:37:48 -0700 (PDT)
Subject: Re: [PATCH 0/9] AMD SEV: Cleanup state handling
To: David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net,
 ekabkost@redhat.com, qemu-devel@nongnu.org
References: <20200604064219.436242-1-david@gibson.dropbear.id.au>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9b13bf3-2b72-1a13-d3c1-2e31c411e236@redhat.com>
Date: Thu, 4 Jun 2020 20:37:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200604064219.436242-1-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:58:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: philmd@redhat.com, brijesh.singh@amd.com, dgilbert@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/20 08:42, David Gibson wrote:
> This series has an assortment of cleanups to the AMD SEV memory
> encryption code.  Amongst other things it:
>   * Removes the confusion between struct SEVState and enum SevState
>   * Reduces use of global variables
>   * Unifies some ad-hoc structures with an existing QOM object
> 
> I made these changes along the way to building a framework for common
> handling of mechanisms for protecting guests from compromised hosts
> (such as AMD SEV, IBM's PEF and others).  However, I think the changes
> make sense on their own, so I'm sending them for inclusion now, while
> finishing the polish on the rest of those patches.
> 
> Please apply.
> 
> David Gibson (9):
>   target/i386: sev: Remove unused QSevGuestInfoClass
>   target/i386: sev: Move local structure definitions into .c file
>   target/i386: sev: Rename QSevGuestInfo
>   target/i386: sev: Embed SEVState in SevGuestState
>   target/i386: sev: Partial cleanup to sev_state global
>   target/i386: sev: Remove redundant cbitpos and reduced_phys_bits
>     fields
>   target/i386: sev: Remove redundant policy field
>   target/i386: sev: Remove redundant handle field
>   target/i386: sev: Unify SEVState and SevGuestState
> 
>  target/i386/sev.c      | 257 +++++++++++++++++++++++------------------
>  target/i386/sev_i386.h |  49 --------
>  2 files changed, 143 insertions(+), 163 deletions(-)
> 

Queued, thanks.

Paolo



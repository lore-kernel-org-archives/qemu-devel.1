Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5C2C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 07:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95E620857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 07:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDbn5vaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95E620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Ef9-0003m8-8P
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 02:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j3EeZ-0003Gp-KS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 02:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j3EeY-0002YP-Jk
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 02:47:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43085
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j3EeY-0002Xr-GA
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 02:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581839266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUwgwbBLvZ3IwaMIek2pR93LEnsleIFoBlShK/Hp9vM=;
 b=YDbn5vaNTovIIP0HsqhLYmR4mO04/rgPIqMZ0EsElatlwdlB4tMb/NqudUVVCxsTuZ8M8k
 fs6ftNRX0EM8cgyfMk5ETJGT8+0wlf8KGhJL+gYoxvhO96wzBsq0GQZU+QXdnx+w0+DtZu
 sN74uOA48BbcAZgMgsHpSchSbmXO1Yw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-u6UH5WqVMRe4a8G7kiKZ1g-1; Sun, 16 Feb 2020 02:47:42 -0500
Received: by mail-wr1-f69.google.com with SMTP id w17so6954372wrr.9
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 23:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tUwgwbBLvZ3IwaMIek2pR93LEnsleIFoBlShK/Hp9vM=;
 b=JcgBvZKkbipclOjzAuatMJRXn8Xm/Zi7Sgptznd1Awjn/Bw+5vRN5pz0CsukgrnQ8r
 4XfkfQ3zTJvT1SzNEx1MR9UxZvmgAWRhlhDyS0nOXr+lnBm6gSciqwXJuFiGMCcFzWNU
 waAUaIddPD+SJYNUfODv2tiSwl0Uc9QTy07Tnm7uZt8LJxjy760OP3erfW0xo/b7Pehg
 QFAA/TKj2TqSRZwWyh/HyqizNBTVcy9CgnBBRNQhZQsBlO6THoSqpNUbBfukMKnYA5kk
 sLEpuDNSykTnKWP5pmX2AYjA2ASY6Q5ekVXRDunDIkL57Icp7kV5MuRjlx7Gzbi1K2wT
 3g7g==
X-Gm-Message-State: APjAAAXGLI8eNq8KQB5TC2Vzs4SofnyeqNd30UTU7xs0eOJ3raG7/59p
 nm60FvmKKAuZZ2MWQaIvHCRXbo74SVfYus6sT2r90Z8Ohe69NtxqudTgSQLmRfQczQvxVfAkr6i
 mHBIHnj6voI1enl4=
X-Received: by 2002:adf:de86:: with SMTP id w6mr15160383wrl.115.1581839261306; 
 Sat, 15 Feb 2020 23:47:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwGQnW06CKqjzEAXCU7ZX5GvCHehxlkbzh3pmtkAz+Nq69Rtr9pTwBIYMfOAZGfHQm4SvtxQ==
X-Received: by 2002:adf:de86:: with SMTP id w6mr15160338wrl.115.1581839260937; 
 Sat, 15 Feb 2020 23:47:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51?
 ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
 by smtp.gmail.com with ESMTPSA id l2sm14669638wme.1.2020.02.15.23.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 23:47:40 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Orphan MIPS KVM CPUs
To: James Hogan <jhogan@kernel.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191221155306.49221-1-jhogan@kernel.org>
 <CAAdtpL7CrEAZz5GWJoYCegchQ=-hdkcih07icgoFd-ghJ3nMBw@mail.gmail.com>
 <CAL1e-=jdpp2W-B1cERU4srRQUkPTjewM3hVrndoh4nr-vPSRGA@mail.gmail.com>
 <20200216065717.GA145683@jamesdev>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ba671393-7960-1234-6c40-9a8ce29e108a@redhat.com>
Date: Sun, 16 Feb 2020 08:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200216065717.GA145683@jamesdev>
Content-Language: en-US
X-MC-Unique: u6UH5WqVMRe4a8G7kiKZ1g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe@mathieu-daude.net>,
 Paul Burton <paulburton@kernel.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/02/20 07:57, James Hogan wrote:
>> We are in the process of handling this within the company, and this
>> patch should go via MIPS tree, not trivial tree - will be updated when
>> the opinions are crystallized, and all consultations with others were
>> done. There is no rush.
> Hi Aleksandar,
> 
> I respectfully disagree. In the mean time I am still listed as
> maintainer even though this patch has reflected reality for more than 18
> months since the 2018 closure of the MIPS UK offices.
> 
> If "the company" wish to eventually crystalize their opinion and assign
> someone else this role (which they've had at least 6 weeks to do even
> since I sent the patch) they can always submit a new patch.
> 
> In the mean time I'd appreciate if somebody could take the patch ASAP.

I agree with James, the situation has already crystallized long before
the opinions will have.  You have done excellent work on the TCG side,
but neither the kernel nor the QEMU side of KVM have seen any
significant activity.  If your employer becomes more interested in KVM
then the status can be changed.

I think it's okay if we delay the patch a couple weeks more (which is
more or less when Laurent or I will send the next pull request), but
certainly not past 5.0 soft freeze.

Thanks,

Paolo



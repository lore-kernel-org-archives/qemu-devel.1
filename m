Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8C1C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DEB2064C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZkds5E4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DEB2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZoh-0004vU-4H
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ipZmn-000369-OG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ipZmm-0006dE-3h
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:31:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33104
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ipZml-0006SM-TG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578583906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVEqcHTNA7h1M7TpTRNrnVOIfq571zRDt26mkMPtEbo=;
 b=KZkds5E4Xy9u2DWomrhNkel9/kP2zPfHJRLFqL6ImWLReheNblx8cJ/TLhqsaAJepJAlwf
 FTOSyhIM7YUPZtIuPsRZDk5bvAR10S+royYCHTqFrihVOPhrYKH/x2PXm9nhIZWuG7/fB9
 bpjaxNkn+FJeSlxFfb4ma2lCkC8jVmk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-VyxUNxL_MxmxWhSyqbhQ6Q-1; Thu, 09 Jan 2020 10:31:45 -0500
Received: by mail-wr1-f70.google.com with SMTP id f15so3040924wrr.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 07:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FVEqcHTNA7h1M7TpTRNrnVOIfq571zRDt26mkMPtEbo=;
 b=MoEnBX0fSvKZ7ld/Ix9ZwMUv/Meakajg8j472LhLT1H89cYQNKbTcSkjS9MvL1idir
 yDOpJyEM90c3GdxNBPNKzZqMg05URjz5KUDudw5xEA2sxzlUb88kyabSkqFJVPKmT79K
 thMXdzbCdmJ8Uh7i8W0RPG9987/Zv93v6p7Qjcb82ziTtwrqyOw7Oe3FVShqPKTRiV35
 QLIkZKTZAbWo2jWkDYR1+pT7r015MC0ve25bdhQ0zThfY/O5FXlPQngpKUQ8rWYL7Pge
 dhT6DMZPpvmao9wC2H3FkGlWuvUfBd39aCOG0Jy9t6SOSxwhplOJ5wa10uuzBpu29h6b
 q6xg==
X-Gm-Message-State: APjAAAUqtnFybQnuB9h/SHFIM12E+DpV2LzhUEw82jJ23QUQENHKAaOs
 YTrEKIIMSXfANeJv8zL7fO4Xds0xal4kYxeHx4obI8ETCBlZseePFAcbkYtrsQ7sxkPZaqWKDdF
 dl0uIkdgP3czMUpk=
X-Received: by 2002:adf:ca07:: with SMTP id o7mr11997727wrh.49.1578583903988; 
 Thu, 09 Jan 2020 07:31:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3BsGz1g0Evn20k4LJBRVuAD+tmwdjTLmyCsS7oVZ04BBRi1zJgvl6u9ec81f3LVvFE3nsjw==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr11997694wrh.49.1578583903641; 
 Thu, 09 Jan 2020 07:31:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id i8sm9140284wro.47.2020.01.09.07.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2020 07:31:43 -0800 (PST)
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm>
 <20200109080412-mutt-send-email-mst@kernel.org>
 <20200109132242.GF6795@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3162676e-da40-7a3f-1777-2ed4f3efffe1@redhat.com>
Date: Thu, 9 Jan 2020 16:31:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200109132242.GF6795@work-vm>
Content-Language: en-US
X-MC-Unique: VyxUNxL_MxmxWhSyqbhQ6Q-1
X-Mimecast-Spam-Score: 0
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
Cc: jasowang@redhat.com, vkuznets@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/01/20 14:22, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
>> On Thu, Jan 09, 2020 at 12:22:37PM +0000, Dr. David Alan Gilbert wrote:
>>> Do we want a new memory_region_init for that or just to be able to add
>>> a flag?
>>>
>> I think a flag API is preferable since this can apply to any kind of
>> region. But can go either way, Paolo's the maintainer there.
> 
> (Copying Paolo in)
> So what exactly does this flag mean; to me it's 'no vhost' - but is it
> actually more general?

It has two more effects in addition to no vhost:

1) it is skipped when dumping the guest (is this a good or bad idea for
SynIC?)

2) accesses to the region will use the specified size (e.g. 4-bytes for
address_space_stl, 1-byte for address_space_stb) instead of a memcpy.
Doesn't really matter for SynIC regions.

If (1) is a good idea, then it's 2 out of 3 and I guess the patch is okay.

Paolo



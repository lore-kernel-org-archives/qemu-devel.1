Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C130C33C9B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7AA2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKF9psKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7AA2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomfR-0006k0-Af
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iomSt-0003ps-QA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iomSs-0005pH-IW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:51:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45382
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iomSs-0005oQ-E1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578394315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dXzyNtVfsGJ9QALhNtnYA36feVWALD6cMJ1wh1QejOU=;
 b=VKF9psKzkOeeng0BTDkN//yOp/00j5QqVu3uz+042Ne8wpyNQ7LhCZx7O6cCJ4x/13/k2J
 Jw0XPem0YT1zNUU/HOSa0vj7Ccj4QVHgz1DGf45Uut+DAZKRGVQMKVwCmU9OJCAbyO2FXM
 s9Ddz54TJYll/NDgfxsi2fK8QRNP964=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-HKDl5cMcOZKW2X6-30Hkrg-1; Tue, 07 Jan 2020 05:51:50 -0500
Received: by mail-wr1-f72.google.com with SMTP id z10so24247781wrt.21
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dXzyNtVfsGJ9QALhNtnYA36feVWALD6cMJ1wh1QejOU=;
 b=UhNaxI9+imHqDG8oxaMC4/1RlCo5bF8ws/ZYmasPj45xC/36o0RXw1k7V79kpAZOs7
 xNCwc1nVntPwqqchzWbYmxMLF3MX3+9/5wugBqmTv7L0qjW3Bjd7UdbaKIBepwF6DfHt
 4bKa8cKnsiP3yAftio+nvi5sUMhynaPtUzdWfeH5z/epaEUBPCrAyJgzYx2D2A9TQQVH
 4XtLpRTz2s2bakf28JqPSC+VTOlLi+jUu/J9Zyq6ZBNVjX7kTpAqOfv6J/apibAK4Q+J
 Uj6XEJHJXfsTLrKYa6cGeVVnoDP5NNikdiif26c/e+tDyT/00YoiEnfFnGtIc57OvBW6
 Ssow==
X-Gm-Message-State: APjAAAXEOQJnpufX3+ZbkMxF3kRijS3KwC2toJsdCSJHAzrXJb7ji/ZF
 WB1czua6SwOtd0u/fiAoDm8po9F6+++iaiVfRSo5cQXfQhLRxDiQ6cOmW4YNOetbEtkon9tW9eS
 vv9ozQxxyYYu6cT4=
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr105009896wrm.151.1578394309204; 
 Tue, 07 Jan 2020 02:51:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRRd7TBwbA1TZbxtboRr9OmcnYRC7W84RJa0UuDGxQ6j/xvgalddEwvm5hfiT3+xTf08rnQA==
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr105009872wrm.151.1578394308936; 
 Tue, 07 Jan 2020 02:51:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id x14sm26223601wmj.42.2020.01.07.02.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:51:48 -0800 (PST)
Subject: Re: [PATCH v1] hw: fix using 4.2 compat in 5.0 machine types for
 i440fx/q35
To: Cornelia Huck <cohuck@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20191223072856.5369-1-dplotnikov@virtuozzo.com>
 <20200107102426.3f31d4d6.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d5710941-b626-1b1b-a08a-f5fbc5684e7d@redhat.com>
Date: Tue, 7 Jan 2020 11:51:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200107102426.3f31d4d6.cohuck@redhat.com>
Content-Language: en-US
X-MC-Unique: HKDl5cMcOZKW2X6-30Hkrg-1
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
Cc: ehabkost@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/20 10:24, Cornelia Huck wrote:
> On Mon, 23 Dec 2019 10:28:56 +0300
> Denis Plotnikov <dplotnikov@virtuozzo.com> wrote:
> 
>> 5.0 machine type uses 4.2 compats. This seems to be incorrect, since
>> the latests machine type by now is 5.0 and it should use its own
>> compat or shouldn't use any relying on the defaults.
>> Seems, like this appeared because of some problems on merge/rebase.
> 
> Yes, I seem to have fat-fingered that while rebasing.
> 
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>  hw/i386/pc_piix.c | 1 -
>>  hw/i386/pc_q35.c  | 1 -
>>  2 files changed, 2 deletions(-)
> 
> I double checked that the other compat machines seem fine.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Queued, thanks.

Paolo



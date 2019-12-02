Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74582C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401852084F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MI+BPdiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401852084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibj2E-0004xD-4w
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ibj1O-0004KN-UV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ibj1N-0000oU-Be
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:33:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41452
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ibj1N-0000nm-84
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575282815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mraihyhi3YIgi24c3h9SupcdOAYUgWmJoQM/y+mBKYo=;
 b=MI+BPdivxObU4/dfjYXSiU36Gyt89/bMwI+8bz0UhCCisBpK/e+Jr25Babzmcz+G45009R
 pyugJ2Ut8D3UOyhXbV/GzlDneLt0mC82GNHtpggFKwzju47yu+m6d9F7KQnLFbnefWzQEC
 DWaXQBwru2ycd4QwfeftifVpnHP9vxE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-jfnUVIiFNpaO8S56ZCMVNQ-1; Mon, 02 Dec 2019 05:33:32 -0500
Received: by mail-wm1-f71.google.com with SMTP id l11so7062594wmi.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 02:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mraihyhi3YIgi24c3h9SupcdOAYUgWmJoQM/y+mBKYo=;
 b=rhBOkAsI4Th8yMfHV3ZYRWH8WlALwMue3Tu/IvKDYp6Sx/t6obtb4n+d0xK/lWjC7h
 2t8SVjw//S7DNy9vQQkaehqEbUi6myCYMOni9qxGMVd5f9VYrdBGkrZpaCzBfmVtT0U4
 ddZsyXz4uQ086wFTMyLwbbIq9B3M50tLzA9oZVZqWnIugEGEjVMP8V8qTMEVgeE7tJ78
 jjQ/+4Z4pkWoO5krBuzrR9TgMM7Y0ApF99YkVD0Yk65gVblpURPDa+kHrIRCbLS0MVsC
 XoRn/igisLfGh6W5zaFlAnVGDSIjRcCZvW67BoWqOCPXjS8aXE4Zui8SYtCdkQ+BbdEB
 oKkA==
X-Gm-Message-State: APjAAAVhYc97mHO5ak19x31hxBLjEcfLV8Nm+fYHdZdrZM7xdG9sYxr6
 aiQlD3QfpNx4Z2toauaRBZ+OSvQDgRGxzMXJ2xxUgEUEviZ4+ApPWEDHaIwz2/ssboxnbpUQYnv
 H1Ps9X8iPwgzpZC4=
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr6962538wrn.351.1575282811360; 
 Mon, 02 Dec 2019 02:33:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqyL33AjzGcnQX8PD7Hgxro1YpnGG76p3gpNDq56UycMm06jfXtcsSCE/iPjA7oCPUpU/NPK5A==
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr6962512wrn.351.1575282811048; 
 Mon, 02 Dec 2019 02:33:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id b3sm22976694wmj.44.2019.12.02.02.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 02:33:30 -0800 (PST)
Subject: Re: libcap vs libcap-ng mess
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20191128190408.GC3294@work-vm>
 <20191129093409.GB2260471@redhat.com>
 <98520a07-cf5d-a2a9-cfa4-944839b94c7c@redhat.com>
 <20191129180103.GA2840@work-vm>
 <1e59f880-1a62-3230-c56a-533f2b797525@redhat.com>
 <20191129182021.GD2837@work-vm>
 <c024ad69-2b94-cdd0-e9d3-617188d82bc3@redhat.com>
 <20191129185400.GF2837@work-vm>
 <CABgObfZjz=5vWs+-DHTaxfOEu+9Vw1+SuZLSpzxZpRNFRzNKEQ@mail.gmail.com>
 <20191202100731.GB2904@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f8d4bf2-1a75-efa4-4c3f-e774d761b872@redhat.com>
Date: Mon, 2 Dec 2019 11:33:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191202100731.GB2904@work-vm>
Content-Language: en-US
X-MC-Unique: jfnUVIiFNpaO8S56ZCMVNQ-1
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
Cc: Thomas Huth <thuth@redhat.com>, "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/12/19 11:07, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> Il ven 29 nov 2019, 19:54 Dr. David Alan Gilbert <dgilbert@redhat.com> ha
>> scritto:
>>
>>>> Yes, it's per thread.  The state can be built from
>>>> capng_clear/capng_get_caps_process + capng_update, and left in there
>>>> forever.  There is also capng_save_state/capng_restore_state which, as
>>>> far as I can see from the sources, can be used across threads.
>>>
>>> So, I think what you're saying is I need to:
>>>   a) Before we sandbox do the capng_get_caps_process
>>>
>>
>> Why not after sandboxing?
> 
> Because in our sandbox we don't have /proc and capng_get_caps_process
> tries to read /proc/.../status and fails. The old libcap code doesn't
> use /proc, it just uses capget (which the new one also uses).

"In the middle of sandboxing" would have been a more precise suggestion.
 In the virtio-9p proxy I set up the state right after the sandboxing
capng_apply, so that there is no need to do capng_get_caps_process (the
libcap virtio-9p also used cap_get_proc).  So you could capng_save_state
there.

Paolo



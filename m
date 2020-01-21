Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCA9C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA5D22522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bjz7blMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA5D22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itr7o-000812-EV
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1itr6i-0006qn-Vn
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1itr6h-00012U-0t
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:50:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40961
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1itr6g-00011d-TZ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579603801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+60uaWgGXndgNiZrImH+olEi0WAAWgQkK96eOSdOWUg=;
 b=Bjz7blMOLqD7iQjcxsU7DKFY/PAiqvzFfJWgMttYvE1xLnKIczHXNKp8BuMb6wwiSij+VJ
 0DUfYcf32AsgGvOEih4l5BrAOYOqbUq21J4Hqgcb7p5B8oNiMr7NczlG9SKr6fbGDaET1w
 HnIXWCVQqoyUXrAHTiBvrriNrO8Qamw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-G-4a69uHP-aa2RLlat_NRA-1; Tue, 21 Jan 2020 05:49:56 -0500
Received: by mail-wr1-f70.google.com with SMTP id u12so1131324wrt.15
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 02:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VedpZyonPNkDBY2/v0LF/rwBPNCXAQ2gTAogI/5IUy8=;
 b=aI/eie4DnxrZJvhC6iKlVZ8jJyF49NmzqsrFrptsoXAfFBO2fXcbNGhuASCD/q8gaB
 efvMLKUEMUDpuYsCMG613riIfFZkVmRBp2A9mTQI6+v88JqCgTt1CVFEQQgV39ttTzkz
 ivMmad6ftSuP0gy1sT7t9rdbeCT5zXU/Q5GVpjRpr90e6qxHgLJRmVV9FUYtS33Ap9mh
 UWHGHoZYnOjzM3nJA37aZ95+IoSU2fmXZwvdfsJdFixaRXIIohGFOTEltYPJkSccyXKr
 jrK7OB6O74ClX36xmnY3qSj0gLGsgShTpbLCRsbGjSn1hYRoetvIvZ6AkZbaVhXH4bp5
 wmmA==
X-Gm-Message-State: APjAAAXma20+YU8YeHlMLnDUiTDGJOezxikzDJYM4tqkuS1EyhO2B3BT
 IrmOAp8Lk1lBHI5JPH8j8d1s+2z4ysWbI4USSALom4M3uu/psKAbljQ+Bh5tfHdlV+2Fur6aNbS
 iLDjqw+MFHokVfrE=
X-Received: by 2002:a05:600c:10cd:: with SMTP id
 l13mr3814931wmd.102.1579603795122; 
 Tue, 21 Jan 2020 02:49:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6mRQkoRE8/U92+dzCsWuV+SsD6XxNbbjIKoTxusC1t1CIBtOajzQiE4y+1WaUxnddEBReUA==
X-Received: by 2002:a05:600c:10cd:: with SMTP id
 l13mr3814905wmd.102.1579603794822; 
 Tue, 21 Jan 2020 02:49:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a?
 ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
 by smtp.gmail.com with ESMTPSA id s128sm3367413wme.39.2020.01.21.02.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 02:49:54 -0800 (PST)
Subject: Re: [PATCH 2/2] pvpanic: implement crashloaded event handling
To: Eric Blake <eblake@redhat.com>, zhenwei pi <pizhenwei@bytedance.com>
References: <20200114023102.612548-1-pizhenwei@bytedance.com>
 <20200114023102.612548-3-pizhenwei@bytedance.com>
 <a26476fd-cbc7-7019-3762-67caa1c65b5a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6fc4a357-1e92-9501-6d8d-300e460cc44b@redhat.com>
Date: Tue, 21 Jan 2020 11:49:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a26476fd-cbc7-7019-3762-67caa1c65b5a@redhat.com>
Content-Language: en-US
X-MC-Unique: G-4a69uHP-aa2RLlat_NRA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: mprivozn@redhat.com, gregkh@linuxfoundation.org, qemu-devel@nongnu.org,
 yelu@bytedance.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/01/20 20:12, Eric Blake wrote:
>> +#
>> +# Example:
>> +#
>> +# <- { "event": "GUEST_CRASHLOADED",
>> +#=A0=A0=A0=A0=A0 "data": { "action": "run" } }
>> +#
>> +##
>> +{ 'event': 'GUEST_CRASHLOADED',
>> +=A0 'data': { 'action': 'GuestPanicAction', '*info':
>> 'GuestPanicInformation' } }
>> +
>> +##
>> =A0 # @GuestPanicAction:
>> =A0 #
>> =A0 # An enumeration of the actions taken when guest OS panic is detecte=
d
>> @@ -366,7 +386,7 @@
>> =A0 # Since: 2.1 (poweroff since 2.8)
>> =A0 ##
>> =A0 { 'enum': 'GuestPanicAction',
>> -=A0 'data': [ 'pause', 'poweroff' ] }
>> +=A0 'data': [ 'pause', 'poweroff', 'run' ] }
>=20
> But the comment here could be updated to mention 'run' since 5.0,
> alongside poweroff since 2.8.=A0 Not the end of the world if we don't
> annotate it, though, since instrospection still shows the difference.

Done in my local branch.



Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5581C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BFA2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8FIP7aD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BFA2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8J5W-0006Lv-Lm
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 04:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8J4j-0005tn-V4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:04:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49087
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8J4h-0007JR-4W
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597824238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZc8/16ImR1HpdGBHjVCPlrfs4XTCDvkyiSRQ8Fd1oI=;
 b=c8FIP7aDOonJ4ieOpH18LeKNQe0VObJFFFIfMrQyiNgwRmrVidR1gD0QtmGIc11dgDPXKZ
 3sOjq63hJ6YbTck43eR01Wd4VF9AMN67XwjbTiUCxgXYGVNlA80JeWS86izQvRDIoOVj8Y
 ljIKfTTU/Yt+ptW/yiiebKUPfDHhnQ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-I1vl2PsROk2J8_7HeSO-Rw-1; Wed, 19 Aug 2020 04:03:56 -0400
X-MC-Unique: I1vl2PsROk2J8_7HeSO-Rw-1
Received: by mail-wm1-f72.google.com with SMTP id p23so724873wmc.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 01:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kZc8/16ImR1HpdGBHjVCPlrfs4XTCDvkyiSRQ8Fd1oI=;
 b=eLD+BR/hKKZdj/dvyL3oLUvXcYmFJn7eU3QSqfVTCZDrEU83/2Xz9WqiGRqAwGBLxM
 cB6XhRi/S7/nWWJxzD5qsQJGr7Q4a1VRB3ou4UU0PVXUhY0QiPfW3/tGW7wMEYfNiCJI
 tz6rG2/8f0xFo5s5H50EQ4IJ2M6t9c5dbuFAorSxp+f7XOhim8nBX9Z4S7xJMy8TMCyI
 Ob6Bbyj1MtO5dTdAsfR1MT9HYaP0euf4rm72DCN7hY3wjKp7nlhdGg3jFGFEVP1S5C7E
 zxwdLEqrAc5q+qcPFsX18Re+LdQ0wP58evnYYRgug+8hPcfmpWLFt1s4tUe0Lu5cuMXv
 +M2w==
X-Gm-Message-State: AOAM532idxzhR0U0FvSRRUfLp74wWytCvlN1gI3p9zZgrVVzmEzxLE36
 60l0BN8uRRqvxGNHb0qYFzQ5G5BWjI84u2RtcGR7+cGdQu6bALVP5aj6pvGgnydfbv6LkaQpfg0
 Omi1iIiN9qbllB2Q=
X-Received: by 2002:a1c:6408:: with SMTP id y8mr3617915wmb.52.1597824235792;
 Wed, 19 Aug 2020 01:03:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybh26Z8Dj9YRwbgVc+SvtxKFg/xpIYNOYHmIHudZoFhV6hMrxBy2EkRCXKjRqh9DLQLLOgEw==
X-Received: by 2002:a1c:6408:: with SMTP id y8mr3617894wmb.52.1597824235530;
 Wed, 19 Aug 2020 01:03:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id i9sm4035479wmb.11.2020.08.19.01.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 01:03:55 -0700 (PDT)
Subject: Re: [PULL 147/150] meson: convert po/
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
References: <20200818141025.21608-1-pbonzini@redhat.com>
 <20200818141025.21608-148-pbonzini@redhat.com>
 <ee10449d-d36e-7138-42e2-1c6cdb68320a@comstyle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <15e35d49-2eee-98d5-7f8c-fd2ccb62ff33@redhat.com>
Date: Wed, 19 Aug 2020 10:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ee10449d-d36e-7138-42e2-1c6cdb68320a@comstyle.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/20 03:56, Brad Smith wrote:
> 
> 
> This last part is redundant. If glib2 and/or gtk+3 is installed then
> gettext
> is installed.
> 
> The package name is wrong as well as gettext changed from gettext to
> gettext-runtime relatively recently.

Are you sure gettext-runtime includes xgettext, and is installed if
glib2 is?

Paolo

> 
>> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
>> index b34b14fc53..5f866e09c4 100755
>> --- a/tests/vm/freebsd
>> +++ b/tests/vm/freebsd
>> @@ -39,6 +39,7 @@ class FreeBSDVM(basevm.BaseVM):
>>           "bash",
>>           "gmake",
>>           "gsed",
>> +        "gettext",
>>             # libs: crypto
>>           "gnutls",
>> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
>> index 93d48b6fdd..ffb65a89be 100755
>> --- a/tests/vm/netbsd
>> +++ b/tests/vm/netbsd
>> @@ -37,6 +37,7 @@ class NetBSDVM(basevm.BaseVM):
>>           "bash",
>>           "gmake",
>>           "gsed",
>> +        "gettext",
>>             # libs: crypto
>>           "gnutls",
>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>> index 7e27fda642..8356646f21 100755
>> --- a/tests/vm/openbsd
>> +++ b/tests/vm/openbsd
>> @@ -36,6 +36,7 @@ class OpenBSDVM(basevm.BaseVM):
>>           "bash",
>>           "gmake",
>>           "gsed",
>> +        "gettext",
>>             # libs: usb
>>           "libusb1",



Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D5C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6EC206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDKM7yyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6EC206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv07S-0003qu-SB
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 09:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iv06m-0002yZ-St
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iv06l-0003d1-Sp
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:38:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iv06l-0003bq-P1
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579876731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29ngSap+YlzXoQtrMvM9m6xaLe0OtFbyI+sHNqiLM7A=;
 b=KDKM7yyKWIxJHU3nLllsdDzt8HZI8cyaOssWDHD6DVM0XDX+0ZJH0BDaj5uwfhCY4vj0H1
 ZyzTEKJ5mcNrdftDzH7jVlpzBv8hE1ooTX+epTTdzkeynnxDiKbk9De5OqXFwa3TbMU0ma
 NYIRKLWZrO11tHhg8DKh/uI75Jaja4A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-f7dMJLjjMdefdct9xZ2YZA-1; Fri, 24 Jan 2020 09:38:49 -0500
Received: by mail-wm1-f71.google.com with SMTP id t17so813450wmi.7
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 06:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Cv4GM/ocuRhwML2ImM+MrVyzan2+ttDzeIrs5FTjt2U=;
 b=jk9Qc2WULsI+/GxUUwX4Sj7aqQdz+Z6Lbv+W/n6+cKJfZMvgVh+CPBP50ZBPUMC5Ns
 vfLUR00Pd+En+Dl4S27GDE2qQXhE4ZI7WgG5m4EOopHKXevoF6Lwt2nQEzXa4FXhWWuV
 yLD4aNBTkgewXn4ZWYyuioxtdc8IN3UP+zNFGazY99GbhCh4+tHfuOgmbwwK8Y1DWebi
 RuoiUqVEWtJKRkcGdpuoQF+bMjmtYuhr14BL81Gt3C41xMv1Nf8n1oK7PNsuuGOYEJXR
 zYt5eUmOQX2mlKL4b/caHJMJPjvgXTVySroS0ZtdM0Zec4qBFBp1KYeKAZt4qljdz15P
 LKkA==
X-Gm-Message-State: APjAAAVA0cMgXE1gxYDPgrPAafw0pIte9Q2boHtmzkFYz8h45STjr24H
 Db86A7nSMpSPISA+SFhaDAZ78Gt1UJ83CL5QZOvZxvIJtRIjZCrBJlRe2DmXc5VVH9O5lkw/Ql6
 ajrUG0iVtyIg85IY=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr3714848wmi.107.1579876727189; 
 Fri, 24 Jan 2020 06:38:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyWomUiKvZ4+CPbW8ZJs5YbXJ/7/ffwOKvU05AgVb5FnNDjNO5Els6Fy4h8dVPx/ZLeIE67Ug==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr3714829wmi.107.1579876726939; 
 Fri, 24 Jan 2020 06:38:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id z8sm7602408wrq.22.2020.01.24.06.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 06:38:46 -0800 (PST)
Subject: Re: [PULL v2 00/59] Misc (x86 and QOM) patches for 2020-01-23
To: Peter Maydell <peter.maydell@linaro.org>
References: <1579857411-12996-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-XOP=z+2NU-vebFO7qenOf-V21Vbwp-+VH5oDZfm+WGg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46eb66b2-2c6b-207b-83f3-81759955787d@redhat.com>
Date: Fri, 24 Jan 2020 15:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-XOP=z+2NU-vebFO7qenOf-V21Vbwp-+VH5oDZfm+WGg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: f7dMJLjjMdefdct9xZ2YZA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/01/20 11:11, Peter Maydell wrote:
> On Fri, 24 Jan 2020 at 09:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0d=
d40:
>>
>>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-202=
00121' into staging (2020-01-21 15:29:25 +0000)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to b0993e347e065d2323fbb051fdd5a72c95a6e872:
>>
>>   tests: fix test-qga on macosx (2020-01-24 10:14:32 +0100)
>>
>> ----------------------------------------------------------------
>> * Register qdev properties as class properties (Marc-Andr=C3=A9)
>> * Cleanups (Philippe)
>> * virtio-scsi fix (Pan Nengyuan)
>> * Tweak Skylake-v3 model id (Kashyap)
>> * x86 UCODE_REV support and nested live migration fix (myself)
>> * Advisory mode for pvpanic (Zhenwei
>=20
> Hi -- this says 'v2', which is the same as the previous one
> did, but the commit hash to fetch is different. Presumably
> it's a v3? What are the v2->v3 differences, please?

Sorry; the v2->v3 difference is just that it doesn't separate cflags
from ldflags.

Paolo



Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB96EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75EA520718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsFuaeXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EA520718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqH7-0005e6-Ng
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ibqGB-0005Av-Vi
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ibqG9-0004ZP-Vg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:17:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32776
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ibqG7-0004Yg-WF
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575310638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0GSMZZ9V3eKjzmNM/t65fUpdI6PLV1YFquD+WpF2AU=;
 b=LsFuaeXWjZ7Q3IHvqqWbFGZxsJT9EgeEV6VMsMilAazqZ1V62wBbdwfXKHmclESF0y5C45
 7ui31QUBtj1bkLe6eCVXY45cdM5USwWYHU5WIHva7Ntj3nt+9uecWCP15CWiHiHLJaVhZA
 rnGVOJorkrqn1MYSbQ94AkL/B4R0uHM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-ZHZtUc_2OUO96x4NFDyAUg-1; Mon, 02 Dec 2019 13:17:15 -0500
Received: by mail-wm1-f70.google.com with SMTP id n4so68309wmd.7
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M0GSMZZ9V3eKjzmNM/t65fUpdI6PLV1YFquD+WpF2AU=;
 b=haiIG7oA/jpFLwaW1HVTE794iD12H9hvbzYAG7gLAHLrS6Bfufzu6kFJj6QysmVfnL
 ECm3EJ06Ei45AoWLNWheSeqmSzfQ1wNcDLec1cjlXdpNi8zFJWcuI1zTtWmn2EdwTFbR
 vViU8750ZXbSm5Xs6OSs0WNghcdGoQES9Wz8TgnP5U3CT1BETxVp5q1QFxa5aMlVvVHr
 ofeyQK+WQygObktu4eNVeYOJ+y7B95sib0OzWfsixvdN4mDUyMGwJDkr4L7NTRIOvi3H
 KqytNO8vpGwkaxne9o6eHD53ANL/r3svWU6ZriiocWc0+K9xcf4Ucts1fMcc9kosXGX7
 TcYg==
X-Gm-Message-State: APjAAAXAdd+TJ7ksdSgR8foAxG0Fe5hWTjT9JpJyY/0Fjg6shaAHHrAn
 4ZSVbXKBCraATfcM/wLK1vfjMlJQCGImTbQ0i400CH22VKM04ynO8eaYFnmxa0P2ZPLLrgyTwtU
 vcO16E1FUbAdDzyg=
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr197294wrs.369.1575310633947;
 Mon, 02 Dec 2019 10:17:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEWBgm9hUopf4G+FptgvXPdScR1Ayi7z5fHGV1Ch3g5v1CqDPmjgUdgEMFGfK9Ae0OHKThdg==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr197263wrs.369.1575310633697;
 Mon, 02 Dec 2019 10:17:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id i10sm211692wmf.20.2019.12.02.10.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 10:17:13 -0800 (PST)
Subject: Re: [PATCH 2/8] docs: tweak kernel-doc for QEMU coding standards
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191129140217.17797-1-pbonzini@redhat.com>
 <20191129140217.17797-3-pbonzini@redhat.com>
 <CAFEAcA-svKVfBGRfwX6d5woqOW0z--rV3-gC9Qi9NqypYfZ=hw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0e5482b-0e51-a55a-d642-e82ee7700388@redhat.com>
Date: Mon, 2 Dec 2019 19:17:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-svKVfBGRfwX6d5woqOW0z--rV3-gC9Qi9NqypYfZ=hw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: ZHZtUc_2OUO96x4NFDyAUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 02/12/19 19:01, Peter Maydell wrote:
>> +       if (/\s*([\w\s]+?)(\s*-|:)/) {
>>             $identifier = $1;
>>         }
>>
>> @@ -1888,7 +1896,7 @@ sub process_name($$) {
>>         $contents = "";
>>         $section = $section_default;
>>         $new_start_line = $. + 1;
>> -       if (/-(.*)/) {
>> +       if (/[-:](.*)/) {
>>             # strip leading/trailing/multiple spaces
>>             $descr= $1;
>>             $descr =~ s/^\s*//;
> These two bits seem to be a third thing not mentioned
> in the commit message -- permitting either colon or
> hyphen in the "Thing: short description" introductory line,
> where kernel style insists on a hyphen.
> 
> (You could make the argument that this is an unnecessary
> drift from the kernel-doc style and we should just fix
> up all those colons...)

Perhaps we could yeah.  Problem is, there are just three hyphens (one in
include/hw/stream.h, two in include/qemu/host-utils.h) so that would be
quite a big patch.  We could do that as we add kernel-doc directive, if
you prefer that, or do it in one shot after committing this series, or
just live with the two lines changed above.

Paolo



Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DC2C4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C1F20888
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EM3qqdO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C1F20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKiLe-0004ey-Hh
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 09:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKiKJ-0003Z6-0T
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKiKG-0007qL-8v
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600781238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QLuPIPVwXsbknpb1X5ymu0XnDJFR9WmeFjDS1XFM7+M=;
 b=EM3qqdO6po5uJpmKvv3l/u7qfkVlejMvzNn7sZMAd6K2Dy5BbCNvRgWdT9vhp+mlYXecRj
 NMMeV8AvvFI9uDms7mWUVHjX2cPoNY/ol8OakJAJIPxDlsT//uxaPGz2WaTpQnRBhBn+C+
 NFPfUbB2HlJa4zhXxb448VI4Bxd2NqM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-IFbVi1gPMP6QRiZVRUzraQ-1; Tue, 22 Sep 2020 09:27:16 -0400
X-MC-Unique: IFbVi1gPMP6QRiZVRUzraQ-1
Received: by mail-wr1-f72.google.com with SMTP id o6so7395475wrp.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 06:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QLuPIPVwXsbknpb1X5ymu0XnDJFR9WmeFjDS1XFM7+M=;
 b=Cek309DYMYH+qm1wj4RmdsSMW68Ny+bNFyrc+xMWuUIyxRgnGfTR7C/h3STt4wj3eq
 UDpwjvBomW+bvM9aQOdg+SUwltHxxVo34XtqVhl+YGUQBOIJEi2STtkLxUgsAbamuBOS
 ubiIb+wpZFz5py+68K7ASCybEsL5D2JX7UOI/dwkgCz9pSfu6DTI6BWwgKtsdIinXM/Y
 uYqqZljRFVFhqY+JEwCpEXrB+FNK2aKplH71zj0GC4NmA82pvscavhjc+MrkJ0QKUkYF
 Xepxxua5pkpjZYSIwfDoJNC8HIbm3xUqVlA6lNvHkrc6fHmjZU3xPOMdf1LZGZyp7UHC
 y5LA==
X-Gm-Message-State: AOAM533/UGscFtxjuYXyap0A7E9QbghaMnBe3/HXSOWIhjijdoUe76XX
 BHPAdM07ThV67tDXVMttAx7gcQtPSL+buJ1mIOCZcQ6j4FFN47Ngkbq8jTHLQE/dnvOxY2HlWqj
 LTCZRJVRfCmZo2xg=
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr1051944wma.46.1600781235005;
 Tue, 22 Sep 2020 06:27:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYO++cHOyWCcxfshkPT++vYusX7ZbB2ePu7+yLg/QsOnWHNKNgjXN526ayF+YByPaA6Nxy5g==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr1051915wma.46.1600781234683;
 Tue, 22 Sep 2020 06:27:14 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d18sm26670984wrm.10.2020.09.22.06.27.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 06:27:13 -0700 (PDT)
Subject: Re: [PATCH] coverity_scan: switch to vpath build
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200922130806.1506324-1-pbonzini@redhat.com>
 <CAFEAcA8kovt998Ds0jbEAJTqkHmJETcHvfwqCS-JZWWW+=wLrw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <044dc012-1203-e3a8-0758-b0fcb2d932a4@redhat.com>
Date: Tue, 22 Sep 2020 15:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8kovt998Ds0jbEAJTqkHmJETcHvfwqCS-JZWWW+=wLrw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 3:18 PM, Peter Maydell wrote:
> On Tue, 22 Sep 2020 at 14:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> This is the patch that has been running on the coverity cronjob
>> for a few weeks now.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  scripts/coverity-scan/run-coverity-scan | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
>> index 6eefb4b558..7395bbfad4 100755
>> --- a/scripts/coverity-scan/run-coverity-scan
>> +++ b/scripts/coverity-scan/run-coverity-scan
>> @@ -380,15 +380,17 @@ export PATH="$TOOLBIN:$PATH"
>>
>>  cd "$SRCDIR"
>>
>> -echo "Doing make distclean..."
>> -make distclean
>> +echo "Nuking build directory..."
>> +rm -rf +build
> 
> As Philippe points out, odd name choice.
> 
> It might also be nice to steal the logic from configure
> that avoids blowing away the build directory if it
> wasn't created by this script in the first place.
> 
>> +mkdir +build
>> +cd +build
> 
> I think this 'cd' will break use of the --results-tarball
> option with a relative path (eg "--results-tarball my-tarball.tgz")
> because it will now end up interpreted relative to the build
> subdir rather than relative to the source directory.
> 
>>  echo "Configuring..."
>>  # We configure with a fixed set of enables here to ensure that we don't
>>  # accidentally reduce the scope of the analysis by doing the build on
>>  # the system that's missing a dependency that we need to build part of
>>  # the codebase.
>> -./configure --disable-modules --enable-sdl --enable-gtk \
>> +../configure --disable-modules --enable-sdl --enable-gtk \
>>      --enable-opengl --enable-vte --enable-gnutls \
>>      --enable-nettle --enable-curses --enable-curl \
>>      --audio-drv-list=oss,alsa,sdl,pa --enable-virtfs \
> 
> This comment at the top of the script:
> 
> # This script assumes that you're running it from a QEMU source
> # tree, and that tree is a fresh clean one, because we do an in-tree
> # build. (This is necessary so that the filenames that the Coverity
> # Scan server sees are relative paths that match up with the component
> # regular expressions it uses; an out-of-tree build won't work for this.)
> 
> is now out of date and needs rephrasing.

Or we can keep it as it, since commit dedad027205
("configure: add support for pseudo-"in source tree" builds")
already create a 'build/' directory.

> 
> PS: on the subject of component regexes, they seem to have
> vanished from the Coverity website. I don't suppose you have
> a backup of them, do you ? (I have a list of what the component
> names were, but not the associated regexes.)
> 
> thanks
> -- PMM
> 



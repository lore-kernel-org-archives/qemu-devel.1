Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D01C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 07:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9078B206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 07:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/O4GQBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9078B206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOcL3-0002CR-Er
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 03:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOcJW-00012G-IQ
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 03:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOcJT-0005Ox-Ut
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 03:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601711438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wf8UXdyp9nHKU+CvQDYoqkxP32IIR/kjkDWKSTuQV8o=;
 b=V/O4GQBjMp5Qjcp1tR7q8p5NuWz+6sGu7WWEOLjkfGomiDUiNLJAF/KD0rnAXknWA0IvJn
 Tns9GHe21lIEyobTLaEIy4AZJ9BY8FK7GeVHg2rXaI41+SoQqg0NYiR8HfNhnfeAr71lU1
 oR+YQ4eMK4cNTyu5roi4Q7n62ojGGQo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-ens0T7lqP_CaXRFiNNjCXQ-1; Sat, 03 Oct 2020 03:50:34 -0400
X-MC-Unique: ens0T7lqP_CaXRFiNNjCXQ-1
Received: by mail-wr1-f72.google.com with SMTP id w7so1556951wrp.2
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 00:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wf8UXdyp9nHKU+CvQDYoqkxP32IIR/kjkDWKSTuQV8o=;
 b=lzw4P9JjQqagvNXRqhw7zrh85WHw+3aAolNK0Na19IZeqvU6bCmBmAANAVfePmPRtK
 46yeeY9mHOEr2emQ/vVo/Fe9+MeqzFmVSDvfES80FzlMKnsAVIlyPRRjsHFY99nTbKhJ
 So64C2+ovUZs76Qje5gs8WjXFmQRTUciX9J5uyoSN94cLBV4zOjxzm/YwMKhYzpp9FFI
 wOP6JoTVwIFcF56WZFnqgumYWrxMIaBVXm0XUQYEhQpbg8/eSyEiqRPsZHJw6bOmGQ1Y
 WH7z7K1wBbiREOTbJZsXorLfOGx084zIhREFLFzpCxtrhTQV1Snpy9xoDmMcvqlqWlIa
 T10Q==
X-Gm-Message-State: AOAM531O61p3UIStxdEf6QSzvew8TbUbIvPed67MN4V2QjAe9BO8i3uZ
 m3DvH/DTLELY8Nh8tDo014FbwofwymzqbMUQoaVh17BTqS6W3BsrbUr53N3zr1UT1RSn5g1l8v1
 RQ1INrtAGUre3hY8=
X-Received: by 2002:adf:aa99:: with SMTP id h25mr5735982wrc.101.1601711433243; 
 Sat, 03 Oct 2020 00:50:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdSORI+THlQhz7xbo0Q00jrMnL9anXq5iDZByiBY/eIK1RnVzZ+TWw/iyb41ayxxano7M0ZQ==
X-Received: by 2002:adf:aa99:: with SMTP id h25mr5735962wrc.101.1601711433017; 
 Sat, 03 Oct 2020 00:50:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id p9sm4265440wmg.34.2020.10.03.00.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 00:50:32 -0700 (PDT)
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: luoyonggang@gmail.com, Peter Maydell <peter.maydell@linaro.org>
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
 <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
 <CAE2XoE-RnJ2j732JfxDA2A9O0Bp4KJ2rGG0LTjrDMKvRox-VBg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6417044-324c-0bec-a05c-1142dcdc6003@redhat.com>
Date: Sat, 3 Oct 2020 09:50:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE-RnJ2j732JfxDA2A9O0Bp4KJ2rGG0LTjrDMKvRox-VBg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 02:43:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 03/10/20 09:24, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Fri, Oct 2, 2020 at 9:11 PM Peter Maydell <peter.maydell@linaro.org
> <mailto:peter.maydell@linaro.org>> wrote:
>>
>> On Fri, 2 Oct 2020 at 14:05, Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>> >
>> > On 02/10/20 14:35, Peter Maydell wrote:
>> > >
>> > > It would be better to do the "see if a static library is present"
>> > > test. This isn't too hard to do in configure (compare that
>> > > six line fix to the detection of libgio). Hopefully it is
>> > > not too hard to do in meson ?
>> >
>> > Yes, something like:
>> >
>> > if enable_static
>> >   skeleton = 'int main(void) { return 0; }'
>> >   if not cc.links(skeleton, dependencies: libudev)
>> >     if get_option('mpath').enabled()
>> >         error('Cannot link with libudev')
>> >       else
>> >         warning('Cannot link with libudev, disabling')
>> >         libudev = not_found
>> >       endif
>> >     endif
>> >   endif
>> > endif
>>
>> This duplicates the information that the thing that depends
>> on libudev is mpath. Can we put this in a wrapper around
>> dependency() so that we could just say something like
>>   libudev = compile_checked_dependency('libudev',
>>                        required: get_option('mpath').enabled(),
>>                        static: enable_static)
>>
> Hi Bonzini,
> This looks like a frequently used function, can we upstrem to meson?

Yes, I think adding a "links" argument to dependency (similar to
find_library's has_headers argument) makes sense.  That would be written

    dependency('libudev',
               required: get_option('mpath').enabled(),
               static: enable_static,
               links: skeleton)

But anyway that shouldn't be a blocker for more improvements to qemu's
meson.build.  Now that we have 5-10 dependencies converted we have a
clearer idea of how to abstract the tests.

Paolo



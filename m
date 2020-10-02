Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CC6C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0962206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7We3zy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0962206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKTg-0004HS-QD
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOKPr-0001Kd-F5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOKPp-0007Wr-QS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601642641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jmu59HW7UkvPv4Er28akF4pYLmNp+6VF50IgGmse7XI=;
 b=V7We3zy1UtEYS88FzSsyxhfIudknAnO+bCxp2aaA2SyXrw324jLDD4ZswCwG9n0xJb3zl6
 pJVD5vTjC2eUyd3DSPPP/N2gy+SH7OcZ1g2hf8taa2+tXTdOWTnMnjyjIkcV2R1aC8JKGk
 EWWaChqomXpY/07HJdC3Nk+tnV5JXno=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-EGALn1SvNLCYw0RZrh_BIw-1; Fri, 02 Oct 2020 08:43:53 -0400
X-MC-Unique: EGALn1SvNLCYw0RZrh_BIw-1
Received: by mail-wr1-f70.google.com with SMTP id i10so507914wrq.5
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 05:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jmu59HW7UkvPv4Er28akF4pYLmNp+6VF50IgGmse7XI=;
 b=hLnDeUJwj4qazQtMPLK3WFoI6HxPt+n3pTS2BZmfz4kMhjy9cv0dA/gOogH5HbBBDr
 NNcqUFTh7CiPRWQ2HupuuczDOJv7omm5Ct7KUDEs5putr+uvIHASHl4PwW8YX6uBaSac
 hv/tOcAQZSRGKjUAWucyvr7d2f0brZkD3gpA9rkYB7j4FYC1tHnc/1wBBN0r6U7DH4GX
 uGkEJXLxnh5+of7Ndi48pActHKRENnx7UHUSdk6BHhxD5jw1kdJWSs3S/nTZj3DecUHN
 KjXx0XT+w4r2xQgOopCvfOz9hj0ERsmo/eJTwkQVUibhC2/HwbvR1Sz16NkHydU35zHD
 4peA==
X-Gm-Message-State: AOAM532aKBgEG2ScRHX9H7cqKwcV4S0JhzIjxDL3TyKZJtKm36wQXT7i
 CmM7Oiz8/U0POvdfT0lxIpVpklyvpDqwTPP4qCtKRCUrG0BycFoIx2lbig1MpXWUrQgFpQ68x1p
 +RdT8Xugk/iw1O3g=
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr2757289wmb.139.1601642631765; 
 Fri, 02 Oct 2020 05:43:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo4+NOzR4bfPBbiDHgU8baKhOiu/BAvPz5gSe/iyLjmTHPH4Jy2l1G24AdpGOfBEAam/iSvA==
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr2757270wmb.139.1601642631527; 
 Fri, 02 Oct 2020 05:43:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id a81sm1745216wmf.32.2020.10.02.05.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 05:43:51 -0700 (PDT)
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <CAFEAcA96sZqqSNSJT7TET8qfArLnWJr5tu1YLqFGBsnca3YoFQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6303051-496f-2fee-bd89-54b37982142e@redhat.com>
Date: Fri, 2 Oct 2020 14:43:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA96sZqqSNSJT7TET8qfArLnWJr5tu1YLqFGBsnca3YoFQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
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

On 02/10/20 14:36, Peter Maydell wrote:
> On Fri, 2 Oct 2020 at 13:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Fri, 2 Oct 2020 at 13:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> - the workaround: just leave things as they are and add
>>> --disable-libudev to your script.
>>
>> There is no --disable-udev !
> 
> ...and there's no --disable-libudev either :-)

You're right---I was sure I used some get_option but it's not
--disable-libudev; it's --disable-mpath.  That made sense when mpath was
the only thing that used libudev, but probably now we should add a
separate --disable-libudev.

Paolo



Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E34C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE60920872
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIB2TzQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE60920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXKkw-0003WF-GG
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 02:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iXKk0-00031d-Ra
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iXKjz-0004c5-Dz
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:49:32 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iXKjz-0004aF-3m
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:49:31 -0500
Received: by mail-wr1-x443.google.com with SMTP id n1so26856367wra.10
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 23:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RXwmt1lc+cUNt9Enj0eTlfx4a+2hw/FbBNInPVcEjJI=;
 b=ZIB2TzQgef7F4QYmEg8FmlrTcCbBB3Q3xWlUdIe0C+SpGIxe5oMM8nqGx1zVTrixc2
 Gb1dIWMVq0/B5P/bSo665D9St1kXdi+pzX2/XBf9lhd1BRRvHF/dWseySYv64NO03YYa
 YtBX2ix8Ge7LaRg/gZf8Fsd0x0GTQJ21xi+vWw297AY11bR/wbVLCL9LrWPyPv7HgnVW
 ybbzKIlympv1r7J2LDtNM+JQEO2A67zw0K8e48mfSOt0z2vFEN++gAGEbqAKRFG941dd
 5bU/7/34HCOLXzD5s/UTewRmM/hcXh9wQZcjJ8JE4L88TSBLzwkGK9k9V7EONUteKZlq
 Nz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RXwmt1lc+cUNt9Enj0eTlfx4a+2hw/FbBNInPVcEjJI=;
 b=NetjLGICE5XNWRdGGcJmBrYy1N7AkA0paTCp1N12uuS0wR8r3f3tT0rHeBDscaaYPM
 EsVVw/hdFu4T/YMsvUxxpWaLLRgFoQ+Ely4U0DQqlfysqYVGl8//5Y/RFANxS/7TLl+s
 Wh1Q16N+AgmiODwaVCSmhdfLXPwmJvPrR1AVtODqr+PFnsVD8lKdQR2+IZ5TSGtwHrjV
 BlLDKQk3tB0NrVRXx+m+6ky5HPHP48jKpamzHQ2admGzrIvnjoR2iGO2hDmXiKyOK22f
 GgIEgI4dj+cYBaDkInNeixD68TNOJ2NedQH9YrKl7xl8I2kT27DuKuEPCKPTSmfEvtMZ
 gAzQ==
X-Gm-Message-State: APjAAAUQ4+gJ/97yO+wYv/J41JWDkMFfoPhdKFBN31tjIVc1IdVZ5axk
 b9IzNNyvI8ZDa8qchEDArlYohBRHOikTJQ==
X-Google-Smtp-Source: APXvYqxemLzgj+c3TMOZi88x3B4zMGLhOGUVXf4eDcrkgqS7tqei7X5IUUlX7YwpUX6U1vRmzUTmig==
X-Received: by 2002:adf:ed48:: with SMTP id u8mr1459252wro.28.1574236169390;
 Tue, 19 Nov 2019 23:49:29 -0800 (PST)
Received: from [192.168.8.102] (253.red-37-10-245.dynamicip.rima-tde.net.
 [37.10.245.253])
 by smtp.gmail.com with ESMTPSA id y6sm30133250wrw.6.2019.11.19.23.49.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 23:49:28 -0800 (PST)
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <82dfa44e-0a27-080e-2653-b004c27fc3d1@linaro.org>
 <CAL1e-=gmLywnyUoySxuDPS1FQRx=WiH1kYrqEJDGAAcO5vDg4A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <59c88efa-999b-9edf-7e34-f283ac8c802e@linaro.org>
Date: Wed, 20 Nov 2019 08:49:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gmLywnyUoySxuDPS1FQRx=WiH1kYrqEJDGAAcO5vDg4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Taylor Simpson <tsimpson@quicinc.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 3:26 AM, Aleksandar Markovic wrote:
> 
> 
> On Tuesday, November 19, 2019, Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 11/19/19 6:22 PM, Taylor Simpson wrote:
>     > - Laurent suggested I split the patch into two parts: linux-user and
>     target/hexagon.  If I do that, which one should contain the changes to
>     common files (e.g., configure)?  Also, note that we won't be able to build
>     until both patches are merged.  Is that OK?
> 
>     The configure parts should be a third, last, patch.
> 
>     The series is bisectable, because before the configure patch,
>     none of the hexagon code is compiled at all.
> 
> 
> I don't think this is a good advice. Yes, at first glance, that would make the
> submitter's job easier - since he could divide the whole code into parts
> practicaly arbitrarily - but the resulting series will be of suboptimal
> quality.

How's that?  He has been asked to split the linux-user stuff from the target
skeleton stuff.  Neither of these will compile independently.  You could merge
the configure bits artificially into the second of the two patches, or you
could leave it separate.

> If the submitter was forced from the outset to add segments of his
> solution so that each step actually (not only ostensibly) compiles, he would
> also be forced to organize patches in much more coherent way, organize his code
> in much more modular way, possibly improve initial organization, additionally
> making reviews much easier.

This argument would make more sense if there were more present here than a
skeleton.  The vast majority of the work is yet to be submitted, and *will*
have to compile, be coherent, etc, just as you suggest.


r~


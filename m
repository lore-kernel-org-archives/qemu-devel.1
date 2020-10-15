Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB01C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B199A22210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDKKgpVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B199A22210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSx8B-0007Uy-Ce
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSx6d-0006NP-UP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 02:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSx6b-0002rc-Gm
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 02:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602744674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LzeqStK2SpvKHv6TcOGPcn7YA0BoRne86U2PxVkvtAw=;
 b=LDKKgpVvpsh6VHRw0EMsxiJHOWYClLFP5utnjjepdipEVEZbH1ME56JywDAWH7tsiikc3J
 cnfq2/r1gBGMuh5WDGAlsPpS/wG3Lj2bNix+BpOVkWiilgDKF8sCWSs11v4C8LqUSjkZMN
 p7o4iKGX8NTOj9VDJkxzyVMsxWKo5+I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-lVy5xbjyPe-QWBNqlwmJ8w-1; Thu, 15 Oct 2020 02:51:11 -0400
X-MC-Unique: lVy5xbjyPe-QWBNqlwmJ8w-1
Received: by mail-wm1-f71.google.com with SMTP id y83so1180898wmc.8
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 23:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LzeqStK2SpvKHv6TcOGPcn7YA0BoRne86U2PxVkvtAw=;
 b=cvn6xDR4d7rCpjsbWoVmQ+ljTNSZargd3ZvcAomfAeA2sb/NZX5L96d+15HXVJAdmR
 9XbluiHyy8WdrH2W7co0E0o5lPj40jaUU6RF8KtKdN+Jm8KC/mGETgUv2ONViCzENaDU
 2jiL4qiUl8z7N6t+TyxQUS8p/6y2NBPvWpdDTOd/tyUv/az2O77S9m7kdCfL7RCb3Dof
 XIIM6AorW3uC9tnDse0ZftM6ZoCIDnyEC9NLMN+/ccrLKfQnSkIiQjk2CPCexDpRJe7K
 8Wdp2AXaabAd9GrdiYHaTz/WJ2H6yH7SJVI4VQZQv/w7VK/x8x1OJgRa3WX6AfbZ5YrP
 SF5A==
X-Gm-Message-State: AOAM533XEvuEUE6sCYVIpsuLQTrS7eYuEdHY9/u6QGyj1pdvSeof08Jf
 vkyzoQXlp2orwvtS5O2Yvi879uXa47O4JPj4PYJb3P4mht0g/V8CsNHNWomW9psEpqczyZY0hcJ
 KC4jbRzYyO5Avis0=
X-Received: by 2002:a1c:4604:: with SMTP id t4mr2457686wma.95.1602744670325;
 Wed, 14 Oct 2020 23:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMSameBwkGRbqM8Pg2y0wrdAPvrAeB3J5ezOW6xmTQ55M55fzS85CK4OQOxlS0hjPlWauhxA==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr2457672wma.95.1602744670117;
 Wed, 14 Oct 2020 23:51:10 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n5sm2934894wrm.2.2020.10.14.23.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 23:51:09 -0700 (PDT)
Subject: Re: [PATCH] meson.build: don't condition iconv detection on library
 detection
To: luoyonggang@gmail.com, Bruce Rogers <brogers@suse.com>
References: <20201014221939.196958-1-brogers@suse.com>
 <CAE2XoE_1T8cobLaZT=gCugHozV=todSvQynNYvQ-VxXVMKxc-w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bf846ef9-79d7-d388-d53a-9de605ce37e2@redhat.com>
Date: Thu, 15 Oct 2020 08:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_1T8cobLaZT=gCugHozV=todSvQynNYvQ-VxXVMKxc-w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-level <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 6:33 AM, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Thu, Oct 15, 2020 at 6:19 AM Bruce Rogers <brogers@suse.com 
> <mailto:brogers@suse.com>> wrote:
>  >
>  > It isn't necessarily the case that use of iconv requires an additional
>  > library. For that reason we shouldn't conditionalize iconv detection on
>  > libiconv.found.
>  >
>  > Fixes: 5285e593c33 (configure: Fixes ncursesw detection under 
> msys2/mingw by convert them to meson)
>  >
>  > Signed-off-by: Bruce Rogers <brogers@suse.com <mailto:brogers@suse.com>>
>  > ---
>  >  meson.build | 16 +++++++---------
>  >  1 file changed, 7 insertions(+), 9 deletions(-)
>  >
>  > diff --git a/meson.build b/meson.build
>  > index 1a4a482492..84c8ec9541 100644
>  > --- a/meson.build
>  > +++ b/meson.build
>  > @@ -431,15 +431,13 @@ if not get_option('iconv').disabled()
>  >    libiconv = cc.find_library('iconv',
>  >                               required: false,
>  >                               static: enable_static)
>  > -  if libiconv.found()
>  > -    if cc.links('''
>  > -      #include <iconv.h>
>  > -      int main(void) {
>  > -        iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
>  > -        return conv != (iconv_t) -1;
>  > -      }''', dependencies: [libiconv])
>  > -      iconv = declare_dependency(dependencies: [libiconv])
>  > -    endif
>  > +  if cc.links('''
>  > +    #include <iconv.h>
>  > +    int main(void) {
>  > +      iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
>  > +      return conv != (iconv_t) -1;
>  > +    }''', dependencies: [libiconv])
>  > +    iconv = declare_dependency(dependencies: [libiconv])
>  >    endif
>  >  endif
>  >  if get_option('iconv').enabled() and not iconv.found()
>  > --
>  > 2.28.0
>  >
> Reviewed-by: Yonggang Luo<l 
> <mailto:brogers@suse.com>uoyonggang@gmail.com <mailto:uoyonggang@gmail.com>>

Something is certainly wrong here =)
I suppose you meant:

Reviewed-by:Yonggang Luo <luoyonggang@gmail.com>

> 
> --
>           此致
> 礼
> 罗勇刚
> Yours
>      sincerely,
> Yonggang Luo



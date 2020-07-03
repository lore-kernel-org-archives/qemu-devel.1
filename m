Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5EBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3EE20772
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iP4b1F5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3EE20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKSL-0002cQ-Pp
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrKRY-0001zR-NC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:05:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48712
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrKRW-0007cm-FO
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593777921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDIGbfLKL0OPHGowLdp7KxDTcOlo6n9dlcgnWn2Siaw=;
 b=iP4b1F5Kiw/wi99qWknUqy39hXv9xvAGd1t/lSg81iGO/thqEmrh0+x3OOG/MKQ+CwecgU
 QewXo8ToKNGfwYcG8+Ju7cXuk+q8z+pn14Fe5WrT1zQ79LEwlRI3hN+71s+Z9drQy0+KKK
 LLXOwWidtHeXXMKbR4GYfCHXeWoKdd4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-hDhGxnRHP3CQ44DLJPPrvQ-1; Fri, 03 Jul 2020 08:05:18 -0400
X-MC-Unique: hDhGxnRHP3CQ44DLJPPrvQ-1
Received: by mail-wr1-f69.google.com with SMTP id j16so26019062wrw.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 05:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CDIGbfLKL0OPHGowLdp7KxDTcOlo6n9dlcgnWn2Siaw=;
 b=nC0lkyGR68XIyRxIbVCFpEzNL0TpdGtyK8ZEmPx2oOsVMDFb6dRQv++6EJCQtMakwd
 c7jgHtSm2FKrFNgfOUPbSTpIqZPY/U3FUP1aWY/0a285fG1AkI7Hdn1QfgyC+5VbmKei
 YElstTnMZH2Dm8wcgPwG6hvCxvh5MGyPrRSI8iC3neo9ZLLOYfaTnv5SlkChxuSWNu8T
 6uGPjAeLPl1zDNRbj4k0bF8Xuby3ainxS7tweTFDEDfQufAZx5+3vXh5ZMZqGT1YgFl7
 5z85Zje82l7YZlvzpfrbh+XwHGGh/7zgW+CsFwgNSIwNawURRGRcHwqlMPlPnia0n7e6
 r9uA==
X-Gm-Message-State: AOAM531Z3nDwzcpdOhDCHRR/rWpc8yq8f3+jGiESwAZCxtIqREZbOHTr
 K5ZYHXfjD5G7PAydfXw+QkAKQenKdG/x0OD158UW0km056mTnwwjl7RIDKLZrWg4WQrc5dbsE33
 rgk8gU6hPB72DzqI=
X-Received: by 2002:a1c:2e58:: with SMTP id u85mr35697068wmu.123.1593777917677; 
 Fri, 03 Jul 2020 05:05:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKImOLT1qCrknbiSZxrg/I9wNdkrSzpc30ywOS59ye0B6oQrTn+BgM4EWm/ebOq5Wk5LbJPA==
X-Received: by 2002:a1c:2e58:: with SMTP id u85mr35697046wmu.123.1593777917391; 
 Fri, 03 Jul 2020 05:05:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b520:5163:43e4:be52?
 ([2001:b07:6468:f312:b520:5163:43e4:be52])
 by smtp.gmail.com with ESMTPSA id x124sm8626498wmx.16.2020.07.03.05.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 05:05:16 -0700 (PDT)
Subject: Re: [PULL 00/10] Modules 20200702 patches
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200702122048.27798-1-kraxel@redhat.com>
 <CAFEAcA9PVnKo8S7=bSggS2FpS5YoBexZD7nM54XFHto333_OhQ@mail.gmail.com>
 <20200703103949.7vz3dmy4br55rh4b@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9e28e08-e8d3-edd4-dcf0-af207a5ad3b8@redhat.com>
Date: Fri, 3 Jul 2020 14:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200703103949.7vz3dmy4br55rh4b@sirius.home.kraxel.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/07/20 12:39, Gerd Hoffmann wrote:
> On Fri, Jul 03, 2020 at 09:54:13AM +0100, Peter Maydell wrote:
>> On Thu, 2 Jul 2020 at 13:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>>
>>> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
>>>
>>>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.kraxel.org/qemu tags/modules-20200702-pull-request
>>>
>>> for you to fetch changes up to 474a5d66036d18ee5ccaa88364660d05bf32127b:
>>>
>>>   chardev: enable modules, use for braille (2020-07-01 21:08:11 +0200)
>>>
>>> ----------------------------------------------------------------
>>> qom: add support for qom objects in modules.
>>> build some devices (qxl, virtio-gpu, ccid, usb-redir) as modules.
>>> build braille chardev as module.
>>>
>>> note: qemu doesn't rebuild objects on cflags changes (specifically
>>>       -fPIC being added when code is switched from builtin to module).
>>>       Workaround for resulting build errors: "make clean", rebuild.
>>>
>>> ----------------------------------------------------------------
>>>
>>> Gerd Hoffmann (10):
>>>   module: qom module support
>>>   object: qom module support
>>>   qdev: device module support
>>>   build: fix device module builds
>>>   ccid: build smartcard as module
>>>   usb: build usb-redir as module
>>>   vga: build qxl as module
>>>   vga: build virtio-gpu only once
>>>   vga: build virtio-gpu as module
>>>   chardev: enable modules, use for braille
>>
>> No code review at all? :-(
> 
> Well, there have been 5 revisions on the list, partly due to bugs being
> fixed, partly with changes as response to review comments.  So it got
> some review (not much though) even though the v5 series (posted on June
> 22th, so there was more than a week time) didn't got any acks so far.
> 
>> In particular the "build: fix device module
>> builds" commit (as you note in your commit message) does not look at
>> all right.
> 
> I think this stop-gap will do fine as long as we don't have any
> target-specific modules.

Yeah, it's hackish but target-specific modules would be a huge
complication so I don't think we'd be having them anytime soon.  With
Meson removing the unnest-vars logic, the hack would also go away on its
own.  So I guess it's okay.

Paolo



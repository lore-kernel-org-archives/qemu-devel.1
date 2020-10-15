Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3D3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 09:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E8B2224A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 09:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSsti06Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E8B2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSzq4-0007OA-Kn
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 05:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSzog-0006pK-OK
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 05:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSzod-0001oa-5x
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 05:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602755092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06XTVvif8IgugfV3OCRtYipMsAeuu8HctnxW0trMhz8=;
 b=HSsti06ZtVUpkXDVZAMSZwyc4jtVhXSfh9gSTfCgfgnf3Fu/up4NFXcaSV6KX/7zRjZHc6
 1vecbSqS+1YhsAZsKhZCS8wp0JHC/7rP3RTaH7Z7s17uTU9KObncZQs7IFfmotoKdaR/ZF
 rN8rjk1G3WCKC/r5Xlhz3CF+dWlOBPo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-TPjH-dx8MoCVMiVxI1P1ig-1; Thu, 15 Oct 2020 05:44:50 -0400
X-MC-Unique: TPjH-dx8MoCVMiVxI1P1ig-1
Received: by mail-wr1-f69.google.com with SMTP id m20so1489719wrb.21
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 02:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=06XTVvif8IgugfV3OCRtYipMsAeuu8HctnxW0trMhz8=;
 b=sDmvf5tC2fO4BzEOyE8+DM2XVoUjC7s/kXOLUxGa3GZR72ZB/Zshcno49ZSQI1tiqF
 TA5dI+XeaObm+ap/U+VP/T9dfDyCaEn7N77R0g39HWikkTPFT3cuaZ7KCOERsAxZRiDp
 Qww/2MvLs0/GKLyE/7sGSGdeU9GlfpmuiQi96tbBY28Ce88Rc4ow61hHbOEiz3E1QZGp
 k97Xz7641aEE+JLiec8lyvnr9ExqXYx4794rHMe1Xu3MN1M1SS89IOAQUuaAsWRrchLt
 dAq3kfxQ3B3aka3gkteypOvyHvTyYbTarI6PaodwdGtavVxsTEf20L4Yjzwh+9zt/pBF
 zaGg==
X-Gm-Message-State: AOAM533fFskO0PVpHlbc/z3zjjbJ2IWi2iHXY39dDbrbgAL6tdLqepky
 rYvA5tdDi/TGoh1lGeaADh1DsnN9qPnwD6d29+qmlvJxWmu+LPhyVpL3rDnnxK+f+5S478mEcnJ
 3iz6mbgp57u0yNBs=
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr3442024wrm.423.1602755088808; 
 Thu, 15 Oct 2020 02:44:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvyRpnLguMPl3uFod/iWNqzHiRSU4NteLwTJxOGynDhkCBj3nP78JQZINzfJt212hjAGD1kg==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr3441997wrm.423.1602755088559; 
 Thu, 15 Oct 2020 02:44:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2110:4ced:a13b:6857?
 ([2001:b07:6468:f312:2110:4ced:a13b:6857])
 by smtp.gmail.com with ESMTPSA id a5sm3550855wrt.80.2020.10.15.02.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 02:44:47 -0700 (PDT)
Subject: Re: [PATCH 0/7] build: replace ninjatool with ninja
To: Howard Spoelstra <hsp.cat7@gmail.com>
References: <20201014135416.1290679-1-pbonzini@redhat.com>
 <CABLmASGJOFbYUhSAbKhc9s1G00Jh0vN--WaFPtaoHqsL2WuvbQ@mail.gmail.com>
 <44d3eccf-3c64-82cd-b5b2-641de6960ab5@redhat.com>
 <CABLmASE55n6h=fr8UrKOHdu1Z_P-46a9t4L0KaRxvvf0hob01w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b7446be-8334-c4db-4df4-677aab2e232c@redhat.com>
Date: Thu, 15 Oct 2020 11:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CABLmASE55n6h=fr8UrKOHdu1Z_P-46a9t4L0KaRxvvf0hob01w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/10/20 09:39, Howard Spoelstra wrote:
> 
> 
> Thanks Paolo,
> 
> Then only the issue regarding the pcbios/optionrom stuff remains ;-)
> 
> make[1]: *** No rule to make target 'multiboot.bin', needed by 'all'.  Stop.
> make: *** [Makefile:171: pc-bios/optionrom/all] Error 2
> make: *** Waiting for unfinished jobs....

It seems to work on cirrus CI: https://cirrus-ci.com/task/5383432727429120

Paolo



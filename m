Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FD7C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BE02344C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdXiCsS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BE02344C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLtNJ-0008F3-Ry
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLtLe-0007WH-4p
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLtLc-0005NP-EI
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:25:37 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601061935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJ2vhfcf/NEvjOkXMBakxUxtm6S5s31nPnOOqxaY3/I=;
 b=NdXiCsS4YHRXg3nVylbBhnHejZyAVXD+s4ypdo+/craWePSwDowqGOkdr19WBGjDWO7diG
 w6utFqsJKBEHl7RLsooIB2jBbl6W+OclWvlX2GwtPyuItI2ZQwvrd5lz81F7yA1X/pOYiG
 JuGc0kPBRRR8vlmtYq8fampLWQU8Z7g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-NZ-8U1AhMUSVh2xXWIDdEQ-1; Fri, 25 Sep 2020 15:25:33 -0400
X-MC-Unique: NZ-8U1AhMUSVh2xXWIDdEQ-1
Received: by mail-wr1-f72.google.com with SMTP id a10so1425850wrw.22
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 12:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BJ2vhfcf/NEvjOkXMBakxUxtm6S5s31nPnOOqxaY3/I=;
 b=q8IzJlyNLdRMFcC7lmT7yg/Clpodo7LpZxiq4o3GVpht7Wusiy59qks+7hRz1BIzP8
 A4sUwOn/vGVq/dj9hdEo0TNgQbPe19w23JNs9hV5uxv8SY4Xzu1WcioAwFLvB2aK4Cr4
 57KiStkrFYEJPF2i7uhDAQsUKD640y58Lii8XCSy6dwTCtTk1R8gcwmJrhFFYf6Qx4jI
 psYyPo9lyOfUdWCIq1lEnN06y1ORTEJTk2p5igGFoAjtq7YrmPgHflUO37uG4IOKJHhz
 sc77V0LAlD7YIQB9syOBGmRIYcy8W6cAAcwpGyo5A1rB26axRNUpo4r8y7+VBbXj7res
 0g3g==
X-Gm-Message-State: AOAM531GsOpl0iGvxdwJlOzEB3Xq2KRpeMatR/iBk9Pp/LGpNIIvp0H1
 pMlrDiolWw2Z0EWgDEwKPtEuZaLbKkla8rau+6PBPq7NOE+sYz5/gv87Yjp+Mq3G7EYQsvJZXQR
 l0xw+XZAs3cC5sIw=
X-Received: by 2002:a5d:634e:: with SMTP id b14mr5788615wrw.190.1601061932567; 
 Fri, 25 Sep 2020 12:25:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztvXfMXdg3TQs4ZLnaiocu60VtQOXoErU44Et+3zKeGJqXS8cmW5uBxhEIpWttriD3668ICg==
X-Received: by 2002:a5d:634e:: with SMTP id b14mr5788607wrw.190.1601061932379; 
 Fri, 25 Sep 2020 12:25:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id u66sm47980wme.12.2020.09.25.12.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 12:25:31 -0700 (PDT)
Subject: Re: I wanna fixes plugin on windows, any suggestion
To: luoyonggang@gmail.com
References: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
 <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com>
 <CAE2XoE9F5_gGsiFutW99mbPUbUb2rmG+2+9pEDKrhvu9QRwYvw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a808929b-f93c-f68d-da4e-02133b4fcb54@redhat.com>
Date: Fri, 25 Sep 2020 21:25:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE9F5_gGsiFutW99mbPUbUb2rmG+2+9pEDKrhvu9QRwYvw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 21:23, 罗勇刚(Yonggang Luo) wrote:
> That's what I am tring to fixes? what does  one import library per
> emulator, can we do this like NodeJS does?
>  NodeJS have NAPI support across platform. They create a windows .lib from
> node.exe

You'd have to create a .lib for qemu-system-aarch64.exe, one for
qemu-system-arm.exe, etc.  On Linux the same plugin will work for all
emulators.

Paolo



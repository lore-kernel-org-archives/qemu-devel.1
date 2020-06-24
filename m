Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5AEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC40F20FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jsk6SwAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC40F20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0NU-0005ND-1C
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo0ME-0004JS-6l
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:02:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46791
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo0MC-0000aZ-FN
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592985723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqecYOIBd43fxSTrvuT7CD0PKRjqFUXBEaSzG97LYbs=;
 b=Jsk6SwADqBQ53KunRBNAfkigZCIE/z0cJ3hQmekLj26r0PDbRQ2ArftKD4SUNfDqKnf0yH
 aJNnbMW1S0M44t0j3aFe3aRaH7Vu1pxb9oaf+4K93IN0tsCOyDGzFtnUG3jE8XP88Ikgt2
 lqHbq+wyj9h8Cav0FKlx7GeF68D/9d4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-LViOPEXjPeWDncRSDw0Xng-1; Wed, 24 Jun 2020 04:02:02 -0400
X-MC-Unique: LViOPEXjPeWDncRSDw0Xng-1
Received: by mail-wr1-f72.google.com with SMTP id b14so2216521wrp.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 01:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wqecYOIBd43fxSTrvuT7CD0PKRjqFUXBEaSzG97LYbs=;
 b=lulcsBpTRH39th8C+UZ7iyNtHFCkb2huqrXkXd2veGejNSyWtj4OpbbaXY1pa8XSGq
 TGQYHAhCBuRs4nYt71p0isDAfaIPEWzzPbNTld1MYNre7kUQyHVIg7fnkbS+InvH7zrf
 TgMlpDyWhIZUzdPd3I098oSSwJ5i+L6T6R8CnHycIFke/vSY1akf8R5nxbYIp4hCSKUy
 LCWXKSGjscZY+ka3MwPUv6XKO6MySwDxxW7oWWOTqRvq30tGRbQcznOKzFAu+3Ek51MF
 p72wSqqnFBtNhv2iYiehE3uOYcnI3qLxV99zRIPILBTSBdmZgPvg6jQRXNxkttjWXSbV
 YEOg==
X-Gm-Message-State: AOAM533rRleWwM7J2UrYdb1nYWQrL4MY5QEwH9RtrJYqp9abltX7ssHb
 Iad4dzHrbb3gqXdceJV4bI6S9ClV1/pkAdr63ljjv275IU3XlzP1VXtmkeIAHwndUyR55DjSGC0
 mYWVpfYHgMQ1GKjM=
X-Received: by 2002:adf:f889:: with SMTP id u9mr32311491wrp.149.1592985720947; 
 Wed, 24 Jun 2020 01:02:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys279+FHA+/c6x4yDi7fHCt22+6qcaaEBhx8H7Avb1hYqhlhFn0GYf2Z05YxN1I9hzRZmhog==
X-Received: by 2002:adf:f889:: with SMTP id u9mr32311467wrp.149.1592985720679; 
 Wed, 24 Jun 2020 01:02:00 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.253.55])
 by smtp.gmail.com with ESMTPSA id o15sm26086173wrv.48.2020.06.24.01.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 01:02:00 -0700 (PDT)
Subject: Re: [PATCH] libqos: usb-hcd-ehci: use 32-bit write for config register
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200623161852.19477-2-pbonzini@redhat.com>
 <9d1c30ab-9944-712a-16e7-c2d3240f23e1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <44bd9295-411d-6f72-923c-c15c67653ed4@redhat.com>
Date: Wed, 24 Jun 2020 10:01:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9d1c30ab-9944-712a-16e7-c2d3240f23e1@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kraxel@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/20 09:47, Thomas Huth wrote:
>>
>>   {
>>       /* hands over all ports from companion uhci to ehci */
>> -    qpci_io_writew(ehci1.dev, ehci1.bar, 0x60, 1);
>> +    qpci_io_writel(ehci1.dev, ehci1.bar, 0x60, 1);
>>   }
>>     static void pci_uhci_port_2(void)
> 
> Passes "make check-qtest-x86_64" on a s390x host, too:
> 
> Tested-by: Thomas Huth <thuth@redhat.com>

Ah, I see what you mean now, so I'll clarify.  Endianness is handled by
the memory core and libqos so for little-endian devices (such as PCI
devices) it's okay.  For big-endian using the wrong size would not work,
but it should fail the same on LE and BE hosts.  endianness-test checks
that.

Paolo



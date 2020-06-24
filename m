Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D939C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 06:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC562088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 06:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuFAsziF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC562088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnySt-0001rT-6p
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 02:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnyRj-0000gY-1N
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 01:59:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnyRh-0000fn-9R
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 01:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592978380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nW65zk8X2wG9FFjhNIdc8ASgiwwBrn7zQp+W4fhwjrA=;
 b=cuFAsziFWT06OtbJB6Ih/O37SIyymrcXTd1FyDg1qQ1C/Fgrrpulzbee3GdQXOepYpsAso
 +xOcrYbVSgYTRzYbt21BLPThBDEeb1pow183e7Je0H3aFH1lM03e1WIhHFLnwItxMrdppS
 w8mKsjo3Z+Gjop/nchBf1WdbkEH3WrI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-oOfoweVbNYqp9CyCcSnoEQ-1; Wed, 24 Jun 2020 01:59:37 -0400
X-MC-Unique: oOfoweVbNYqp9CyCcSnoEQ-1
Received: by mail-wr1-f71.google.com with SMTP id i14so1980598wru.17
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 22:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nW65zk8X2wG9FFjhNIdc8ASgiwwBrn7zQp+W4fhwjrA=;
 b=VzZrJzwszbwuaKDn/ZM48u2gzDptpyhka1owa1d5Ga8MChHBxII4DK6WkA2NfHyENV
 zgAkpEGaDPfrdxsQmCsUpSU0mQp/zydlkPCgCdwOxEy/FN/pXDRjZSO3DC+Xu4oylrHQ
 1df75xHRMrzHw4SkDox2/7Vil5V3m6yL9LTdLUb+WAesm7mBD3020sa4zN1gnS2Dg+/M
 yJSvpC7TQ4Cj2ySZIgcAhUgNP7/5T3Pai/92FRHe1HoonJWDeiBsdj34++skppWIzkxX
 Mp2AgHxALRGLXJcMJ911aRon08HgnKFqJ+nKnJXZYShsaPfMbEP/djp+ycIwvrMftXo7
 EPcw==
X-Gm-Message-State: AOAM5339lfzklYnsGXnNZNPcWfyVQJARe7cWWlPdv4x9C4mu4WuiOLgd
 jB7cXBLOIFGQCBk5cMXSZJnC2snBefbue/6pUEHe96iM0/GQ+IuW6m/h2Bn2kWp3wDbBs482kxz
 fAPfdaEe2Ns1g+lc=
X-Received: by 2002:adf:f70e:: with SMTP id r14mr30930859wrp.150.1592978376156; 
 Tue, 23 Jun 2020 22:59:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztEcC2/+i/K8P8P1OUm+mZhCE9RcMgHdr/NgSn33YZzGORcrPDVrkPf0RC1qQ10hXQOHQhZQ==
X-Received: by 2002:adf:f70e:: with SMTP id r14mr30930847wrp.150.1592978375964; 
 Tue, 23 Jun 2020 22:59:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879?
 ([2001:b07:6468:f312:24f5:23b:4085:b879])
 by smtp.gmail.com with ESMTPSA id o15sm6423162wmm.31.2020.06.23.22.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 22:59:35 -0700 (PDT)
Subject: Re: [PATCH] libqos: usb-hcd-ehci: use 32-bit write for config register
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200623161852.19477-2-pbonzini@redhat.com>
 <20200623165556-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <84a43671-862e-19dc-6f6f-ed8ee2924881@redhat.com>
Date: Wed, 24 Jun 2020 07:59:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623165556-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/06/20 22:56, Michael S. Tsirkin wrote:
> On Tue, Jun 23, 2020 at 12:18:52PM -0400, Paolo Bonzini wrote:
>> The memory region ops have min_access_size == 4 so obey it.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Makes sense.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I assume you are queueing this with the memory core change.

Yes, I am.

Paolo

>> ---
>>  tests/qtest/usb-hcd-ehci-test.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/usb-hcd-ehci-test.c b/tests/qtest/usb-hcd-ehci-test.c
>> index 5251d539e9..c51e8bb223 100644
>> --- a/tests/qtest/usb-hcd-ehci-test.c
>> +++ b/tests/qtest/usb-hcd-ehci-test.c
>> @@ -96,7 +96,7 @@ static void pci_ehci_port_1(void)
>>  static void pci_ehci_config(void)
>>  {
>>      /* hands over all ports from companion uhci to ehci */
>> -    qpci_io_writew(ehci1.dev, ehci1.bar, 0x60, 1);
>> +    qpci_io_writel(ehci1.dev, ehci1.bar, 0x60, 1);
>>  }
>>  
>>  static void pci_uhci_port_2(void)
>> -- 
>> 2.26.2
> 



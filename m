Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0889EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E6F2070A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfrQbE6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E6F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRfY-000260-2M
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbRes-0000c9-N3
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:33:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54384
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbRer-0002BE-RX
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589992408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6iVZspdcL7XN594If70FRuGddioaD7TsYgHOYb61r1A=;
 b=hfrQbE6IIxcojHNGSxQhtJsYWbmtNrldvOp84tzCaJFyis8Wp6Hl9zZlMwMuHi+UiUD/wT
 M/2udx1wodM8I+v3LNNWOQPSRu+9ay8bOmYDuhbKy0mJ1VOgW2BXxItJL+Motrtz1MtCz9
 +5kvEEgqPT1G1MK7bH8+4KkgPTBj0O8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-JtlqPOSSPIW5ihCzqRdrYg-1; Wed, 20 May 2020 12:33:23 -0400
X-MC-Unique: JtlqPOSSPIW5ihCzqRdrYg-1
Received: by mail-ed1-f70.google.com with SMTP id m6so1463110eda.16
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 09:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6iVZspdcL7XN594If70FRuGddioaD7TsYgHOYb61r1A=;
 b=Fh7BAhANQT1ibNyNt79ckaXILNvhBellXFwFhBn4puoSZHL99GMb5OhVXxL155pqIt
 dyX8KHWhQPk3IHzgVnTL/AdsR8G9K0ITfWEbFZiFsmEEzuVOgubByNXI4fBPAIzTGojm
 kxR3cZ+ND2dSnLe4jxGqr8hYPuJ/SNdMaqeGcUrDbjI0XRC5+2Vih5oIDwolohgsZ2UN
 oYpDCNw76d013Ab8ofMh2ogAaedEwQTCz4pZ3zoTp4xY/HB86Tw84dYaQ5L06gms6g66
 KSPSRvhFxNfkRVGEQhUfMiJOTsI3kTbvQ1J2ZSMkmruT59RGo1eRc23w3WMcwAfoZyGf
 UFOg==
X-Gm-Message-State: AOAM531rktoLD+qp00TUMBmpA9801gpy24cdyGJZC8LwFDytLeVY8njA
 Zof2Wd0bEFVvp7vamNp8TEv8k6ZIzIbqdy6dSd/GmlOczFwkP+ff4HwBNXJrJoFSuSfU/Cq1PvJ
 7rxgubSlKzwsvmu4=
X-Received: by 2002:a17:906:6893:: with SMTP id
 n19mr4751506ejr.354.1589992402183; 
 Wed, 20 May 2020 09:33:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrSG3qiU8mxch+udvX85ZibuV4uVxywp9m3gbEkr0U4DLVdyxHuFGIOv+wIx+5D88jgowlmQ==
X-Received: by 2002:a17:906:6893:: with SMTP id
 n19mr4751481ejr.354.1589992401891; 
 Wed, 20 May 2020 09:33:21 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b62sm2356594edf.28.2020.05.20.09.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 09:33:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] sd: disable sdhci-pci device by default
To: Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>
References: <20200520152450.200362-1-ppandit@redhat.com>
 <20200520152450.200362-3-ppandit@redhat.com>
 <CAFEAcA_WbJR9PWpw4f2jWecouSn7U0y9=0t4ek1rGwxtM6tXBQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <431930bb-ac30-62fb-11f0-c388c0e9c763@redhat.com>
Date: Wed, 20 May 2020 18:33:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_WbJR9PWpw4f2jWecouSn7U0y9=0t4ek1rGwxtM6tXBQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Kevin, Paolo, Emanuele

On 5/20/20 5:39 PM, Peter Maydell wrote:
> On Wed, 20 May 2020 at 16:28, P J P <ppandit@redhat.com> wrote:
>>
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> Disable rarely used sdhci-pci device build by default.
>>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
> 
> Doesn't this break existing working command lines? The
> device exists, some people use it. We should treat it like
> other PCI devices -- if the guest arch/machine can handle
> PCI the device should be built.

Prasad, I once tried to remove it, and Kevin said he was using it:

https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02765.html

   I do find qemu's PCI SDHCI support useful for testing.
   SeaBIOS can launch an OS from PCI SDHCI (qemu-system-x86_64
   -device sdhci-pci -device sd-card,drive=drive0 -drive
   id=drive0,if=none,file=dos-drivec) and linux has drivers for
   it as well.  A number of the Chromebooks ship with PCI SDHCI
   devices on them, so it's not an unheard of configuration.

> 
> There's obviously scope for being more general and allowing
> some kind of "only build the subset of devices we feel
> more confident abut the security of" setup (don't RH do
> something like this downstream?), but upstream we don't
> have a concept like that, we just build everything.

Prasad, again back at that time I tried to remove this (as the device 
appears unused) Paolo told me after asking explanation for his comment 
"PCI devices can be created with -device, they don't have to be added by
boards." [*] - I guess it was on IRC - to check commit 224d10ff5ae, this 
device was added with RH PCI ID because it was useful for testing:

static void sdhci_pci_class_init(ObjectClass *klass, void *data)
{
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);

     k->init = sdhci_pci_init;
     k->exit = sdhci_pci_exit;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_SDHCI;
     k->class_id = PCI_CLASS_SYSTEM_SDHCI;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     ...

This device is also nicely used as example for the qgraph testing (see 
tests/test-qgraph.c added in fc281c80202).

[*] https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02819.html

Peter, indeed the Kconfig was added to allow distributions to disable 
piece of code, and we want to keep this device in mainstream QEMU.
Distributions are free to disable it setting SDHCI_PCI=n

So to this patch:

Nack.

> 
> thanks
> -- PMM
> 



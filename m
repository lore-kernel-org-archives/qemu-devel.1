Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87298C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF4E20872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmXpVqgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF4E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzFe-00054B-Gv
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNzCY-0002zI-3h
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNzCV-0005KV-1o
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601561084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/4J2dMcvDok6wN4kWBE58Ylgno9BoZi/IgH0mxpW0Oc=;
 b=MmXpVqgj3SP1fguO6jVmFEBhDwTaStYsPDUTaotEAfQVUnfQERxgxYoUeiY1N1c3QrWTU+
 M79hC2bJq9KQlMNcBkobwmfpSt+oAhMibZJcq+dwWEQBfhNRc6+jICC9xCf6OPpUEHFzbJ
 xxHGplEpn9YebnFOYSBZsNWCUPj08D4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-SB47UmIANjC8qRtumC6tFQ-1; Thu, 01 Oct 2020 10:04:43 -0400
X-MC-Unique: SB47UmIANjC8qRtumC6tFQ-1
Received: by mail-wr1-f72.google.com with SMTP id d13so2075519wrr.23
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/4J2dMcvDok6wN4kWBE58Ylgno9BoZi/IgH0mxpW0Oc=;
 b=VkiUpl0eSvXO6Gl+yd6g23AttqfGvY0P2C4qUedkuidOdF383DtSF3ZZMz96uExCPA
 sx2bhsK+i08C8yWEHD2DwrSG8flJvxvy8MK7WDwY49I6xIR3JXUC0QlLE+EjNM64GCCT
 KFVlfPlhKTlD9BrgP5yEk1TCCJDAHKYEk6wn2gJyXILjZtLNZ9T3y82gMdBlbHWj4Wx9
 pZbpqjVDoDde7rGyuH15JT0lRTii0dk2Exzlc2ILbUNAlLYSY9gxxYV0i2Gn+kr+tYLg
 sJgAcT+dJPKVr3Um9V2mFusqt7gqXtKslZiuXTLMROrf9H8mfCZpwiocaV97bt7OGj3Z
 0mGQ==
X-Gm-Message-State: AOAM532sC8/4OKwAajX7arHfzIlrXFYiVTr5XDH431Sn7IjovzhYxydU
 Z5VKVEPWVlGx6PWgPhnhf6To9klA8l7ncDFDGvCbyDisqO7hs6RcKfGakUxlUX2fPnq0mXsTwOw
 GzHUor3K98aSFzag=
X-Received: by 2002:adf:c64e:: with SMTP id u14mr9049039wrg.373.1601561081889; 
 Thu, 01 Oct 2020 07:04:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqnBwLdx3lsj0Iwf0kXI0M9mCRZO8NSFy70yv3htZtZRJd44GjAmKNq8+9ZhPECtJm0o7LtQ==
X-Received: by 2002:adf:c64e:: with SMTP id u14mr9049013wrg.373.1601561081632; 
 Thu, 01 Oct 2020 07:04:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:86de:492a:fae3:16f2?
 ([2001:b07:6468:f312:86de:492a:fae3:16f2])
 by smtp.gmail.com with ESMTPSA id h4sm10796934wrm.54.2020.10.01.07.04.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 07:04:40 -0700 (PDT)
Subject: Re: [PATCH 08/12] tests/9pfs: refactor test names and test devices
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <2296259.KyODYMqAT8@silver> <d6f5cc89-bdac-13a9-d7bc-c7b63a10da79@redhat.com>
 <12227378.mPQFScNTDJ@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bbfcbc42-a7f4-926f-78ef-badcb7c023af@redhat.com>
Date: Thu, 1 Oct 2020 16:04:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <12227378.mPQFScNTDJ@silver>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/20 14:15, Christian Schoenebeck wrote:
> On Donnerstag, 1. Oktober 2020 13:56:42 CEST Paolo Bonzini wrote:
>> On 01/10/20 13:34, Christian Schoenebeck wrote:
>>> Paolo, I'm back at square one after changing to single-device model as you
>>> suggested:
>>>
>>> GTest: run:
>>> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/pci-
>>> device/pci-device-tests/nop
>>> Run QEMU with: '-M pc  -device virtio-9p-pci'
>>> (MSG: starting QEMU: exec x86_64-softmmu/qemu-system-x86_64 -qtest
>>> unix:/tmp/ qtest-18032.sock -qtest-log /dev/null -chardev
>>> socket,path=/tmp/
>>> qtest-18032.qmp,id=char0 -mon chardev=char0,mode=control -display none -M
>>> pc -device virtio-9p-pci -accel qtest)
>>> qemu-system-x86_64: -device virtio-9p-pci: 9pfs device couldn't find fsdev
>>> with the id = NULL
>>> Broken pipe
>>>
>>> This fundamental virtio-9p-pci test obviously needs a complete 9p command
>>> line, that is either a 'synth' driver one, or a 'local' one. But simply
>>> either picking one or another is inappropriate here. This test should run
>>> once for 'synth' and once for 'local'.
>>
>> You're right, this is in fact also a problem for virtio-blk and virtio-net:
>>
>>     /* FIXME: every test using these two nodes needs to setup a
>>      * -drive,id=drive0 otherwise QEMU is not going to start.
>>      * Therefore, we do not include "produces" edge for virtio
>>      * and pci-device yet.
>>     */
>>
>>     /* FIXME: every test using these nodes needs to setup a
>>      * -netdev socket,id=hs0 otherwise QEMU is not going to start.
>>      * Therefore, we do not include "produces" edge for virtio
>>      * and pci-device yet.
>>      */
>>
>> I still think we should do it like this, because it's closer to the way
>> that libqos will work long term.
> 
> Could you please elaborate why that long term plan bites with the working 
> solution I provided? [patches 1 and 2]

Because the long term plan is to have a socket/plug mechanism for
backends where the device can provide a default backend to plug.

The suggested solution is all good for *a different use case*, namely to
test the same device with different options.  It is just wrong for the
purpose of selecting a frontend.

It occurred to me that you could also add a default backend to the
command line with "-fsdev" (in the libqos driver), and use -set in the
test to override it.  This is ugly (-set is ugly!) but it would let you
keep the tests, so it would probably be the best solution.

Paolo



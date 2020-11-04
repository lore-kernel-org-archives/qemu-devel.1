Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6C4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DC32236F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnEIAEo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DC32236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGxM-0001SP-Of
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaGwY-0000pN-Nk
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:27:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaGwW-0001jH-Vh
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604489228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aw06nalMV1DPsFZMBKJv5oT3RYl/z3nb0C71ZaaIdFc=;
 b=JnEIAEo4mmIojZJEadmJpY8/ITxKBOo91AV7LNVglApXMbQOBVzc04GviOHL3u11z12SQj
 +LDO9BCBUEzjNNk4CojxibhHNflXbtENrAnqmC+zJVPhinZgSiI/Miwgs4xQuM7dcxSezF
 r1ie81FqgIQIlns6Y6PqiEBm2mrmWxQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-O0iNypoJNR24ipM7ZPNzpw-1; Wed, 04 Nov 2020 06:27:04 -0500
X-MC-Unique: O0iNypoJNR24ipM7ZPNzpw-1
Received: by mail-wm1-f69.google.com with SMTP id z62so1050892wmb.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aw06nalMV1DPsFZMBKJv5oT3RYl/z3nb0C71ZaaIdFc=;
 b=GRz+pNGdWUDW9wbBv/6sXtTmMLcZZQtVKJlpbNTfzvoEvA8JyFfqkOyLL7HI0fyH2o
 QPPxOdauJqJzMjDKg3ELchjdKouOBnhIzGoVg6Xdvy/IlKnNGrIT5tcvy9LlpuEllQfi
 nUvxQin0Q6G9ol3HQB2xGP3YgCO27lKV3MPjLGnbuiLVw24Nh9B5HkaF0U1SrXhbReRx
 utgAHh/yj8xnGjJal3ZbmJmlbl8IzImKd36aMOqFEdvPv49yoLxGcg1UDtIrycVmWDQp
 fTd7XCg0KO8M2ibhWfPDgr81iW2ReKZdo196qU3awEhfnZTMUFNq2RwIH4MuBxrUmhSS
 1VLQ==
X-Gm-Message-State: AOAM533UPTtc/GKY697e+e91RrtHpza7aEX9CEbP3FRPt+6gVEuoT27k
 Ud7P4xO79wo9S9+X6Etwhm7c+yl1ZWJuuP5i07j77beDxKgZ5X2ckE3HCI2Ashwf//IH8QnOrHu
 cw1VFJBeEAqQmRVY=
X-Received: by 2002:a1c:2583:: with SMTP id l125mr4015937wml.50.1604489223411; 
 Wed, 04 Nov 2020 03:27:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyC+/JtIYH28tssrJ+JLHLNOEJhSa4QBNuaW+fepSs9cQJuvnL9pMT1hoUzP1OIlKrf1N2kIg==
X-Received: by 2002:a1c:2583:: with SMTP id l125mr4015901wml.50.1604489223197; 
 Wed, 04 Nov 2020 03:27:03 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id h12sm1997498wrw.70.2020.11.04.03.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 03:27:02 -0800 (PST)
Subject: Re: [PATCH-for-5.2? 3/5] tests/acceptance: Skip incomplete
 virtio_version tests using '@skip'
To: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange"
 <berrange@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20201102144245.2134077-1-philmd@redhat.com>
 <20201102144245.2134077-4-philmd@redhat.com>
 <6fd67527-b887-54c5-8de6-4f54c8d66934@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <68b4585b-2cfd-7b24-af63-674d004d8e51@redhat.com>
Date: Wed, 4 Nov 2020 12:27:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <6fd67527-b887-54c5-8de6-4f54c8d66934@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Antony Pavlov <antonynpavlov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 12:13 PM, Thomas Huth wrote:
> On 02/11/2020 15.42, Philippe Mathieu-Daudé wrote:
>> Prefer skipping incomplete tests with the "@skip" keyword,
>> rather than commenting the code.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  tests/acceptance/virtio_version.py | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
>> index 33593c29dd0..187bbfa1f42 100644
>> --- a/tests/acceptance/virtio_version.py
>> +++ b/tests/acceptance/virtio_version.py
>> @@ -140,17 +140,20 @@ def check_all_variants(self, qemu_devtype, virtio_devid):
>>          self.assertIn('conventional-pci-device', trans_ifaces)
>>          self.assertNotIn('pci-express-device', trans_ifaces)
>>  
>> +    @skip("virtio-blk requires 'driver' parameter")
> 
> Shouldn't that be 'drive' instead of 'driver' ?

No clue, this is the previous commented line.

> 
>> +    def test_conventional_devs_driver(self):
>> +        self.check_all_variants('virtio-blk-pci', VIRTIO_BLOCK)
>> +
>> +    @skip("virtio-9p requires 'fsdev' parameter")
>> +    def test_conventional_devs_fsdev(self):
>> +        self.check_all_variants('virtio-9p-pci', VIRTIO_9P)
>>  
>>      def test_conventional_devs(self):
>>          self.check_all_variants('virtio-net-pci', VIRTIO_NET)
>> -        # virtio-blk requires 'driver' parameter
>> -        #self.check_all_variants('virtio-blk-pci', VIRTIO_BLOCK)
>>          self.check_all_variants('virtio-serial-pci', VIRTIO_CONSOLE)
>>          self.check_all_variants('virtio-rng-pci', VIRTIO_RNG)
>>          self.check_all_variants('virtio-balloon-pci', VIRTIO_BALLOON)
>>          self.check_all_variants('virtio-scsi-pci', VIRTIO_SCSI)
>> -        # virtio-9p requires 'fsdev' parameter
>> -        #self.check_all_variants('virtio-9p-pci', VIRTIO_9P)
> 
> I think I'd prefer to keep the stuff commented ... otherwise it will show up
> in the logs, giving the impression that you could run the tests somehow if
> you just provided the right environment, which is just not possible right now.

Well, we usually don't commit commented code like that.
If it is committed, it is important, then it has to show up in
the log. If you don't want it logged, why not remove it then?



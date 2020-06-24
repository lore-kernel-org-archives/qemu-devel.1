Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00209C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F5A20DD4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdebDMLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F5A20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0O7-0006Dl-2b
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo0Kl-0003IL-6b
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:00:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24724
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo0Kj-0008Ph-C7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592985636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vp8nGaZKDxCGBCvL56usX8xgqD3qaZ6uVfb20/TIRN0=;
 b=RdebDMLl8agDDRXkLPuG+Ulgw4MhcMyMtQ+yJexfmKDx4AnETf1Ubsy2XgJCKtK1taYh87
 O50gv8JXgPuOMDS502H+5254VcWsJBEpWrqEELC8IDHNmBNaBCyDh9FwLIj7MEtVgLJB+b
 a7dW/0totpXjVcAMK0tCeAHrtQRV1Xk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-NGHVypZQNbuJhh6H9uJ8qQ-1; Wed, 24 Jun 2020 04:00:34 -0400
X-MC-Unique: NGHVypZQNbuJhh6H9uJ8qQ-1
Received: by mail-wr1-f71.google.com with SMTP id d6so2198435wrn.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 01:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vp8nGaZKDxCGBCvL56usX8xgqD3qaZ6uVfb20/TIRN0=;
 b=kOkell0/P6CFPkAfSvPRwTioF/48atIXgnIfhmB0bV/HhwOLE/QkY96asLCadWQl0a
 uNqBnbc3hkea1m1T07e89T9WzxU+ow07Rl+XlIC3Dol5Xi9HQ7BgOVr+HXSNI41kkYeq
 Hd1E5Ed3/RkPnX5hUnoW5SUn+vjWT8Fl7GOJYVRce0w/LUCvoeymnDLC9emaH7xvTBcs
 xZFxVGwdHDDmSlCNOR5vLgXD2oyaSzFSN0YibTuKkIvwpfZi0lAACtS5++ExeZaw7voe
 lVjEl4ZxzBUcXg16m9R7Lhqn/vp6gpUMnbUE2qCV9Fg1g04iTQLl+KH15IfufFZV8n7X
 jauQ==
X-Gm-Message-State: AOAM533Qgq7pgE/OyjW12o0WyNxsHWF3WQI4ZFCUs+FyN3R7FT3lJC3U
 mAqHep7vQzrGtW6TZgvY1Uy4UjqUg2GqhhAx3IDOF7QEoPI28ncayWmjvh+REbQlC4d6OhtBnYw
 AFz8Wo/qMTh08e8k=
X-Received: by 2002:a1c:2e0e:: with SMTP id u14mr28630635wmu.55.1592985633194; 
 Wed, 24 Jun 2020 01:00:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjLMdvVvDnodm+0sNVCArlptpeKJPkNIqf+BbCSXiwl85zUQLDD3NLtgKvlehdaOiQ2REhLw==
X-Received: by 2002:a1c:2e0e:: with SMTP id u14mr28630614wmu.55.1592985632945; 
 Wed, 24 Jun 2020 01:00:32 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.253.55])
 by smtp.gmail.com with ESMTPSA id z1sm12301290wrh.14.2020.06.24.01.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 01:00:32 -0700 (PDT)
Subject: Re: [PATCH] libqos: pci-pc: use 32-bit write for EJ register
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200623161852.19477-1-pbonzini@redhat.com>
 <63b916b5-cca7-e2fd-5a7b-fe12984eaf45@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b695e3f-962f-112e-fa3d-11ab3f27caa4@redhat.com>
Date: Wed, 24 Jun 2020 10:00:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <63b916b5-cca7-e2fd-5a7b-fe12984eaf45@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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

On 24/06/20 09:46, Thomas Huth wrote:
> On 23/06/2020 18.18, Paolo Bonzini wrote:
>> The memory region ops have min_access_size == 4 so obey it.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   tests/qtest/libqos/pci-pc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
>> index 0bc591d1da..3bb2eb3ba8 100644
>> --- a/tests/qtest/libqos/pci-pc.c
>> +++ b/tests/qtest/libqos/pci-pc.c
>> @@ -186,7 +186,7 @@ void qpci_unplug_acpi_device_test(QTestState *qts,
>> const char *id, uint8_t slot)
>>       g_assert(!qdict_haskey(response, "error"));
>>       qobject_unref(response);
>>   -    qtest_outb(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
>> +    qtest_outl(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
>>         qtest_qmp_eventwait(qts, "DEVICE_DELETED");
>>   }
> 
> I was a little bit afraid that this could cause endianess issues on big
> endian hosts, but I gave it a try on a s390x machine and it seems to
> work fine.
> 
> Tested-by: Thomas Huth <thuth@redhat.com>

Also because this is "pci-pc.c". :))  But seriously: if anything this
would fix big endian bugs, not break them.

Paolo



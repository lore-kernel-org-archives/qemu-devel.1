Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDB9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 06:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885352088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 06:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvelpOR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885352088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnySf-0001Vf-Oa
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 02:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnyRX-0000Qm-Tg
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 01:59:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30849
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnyRV-0000aL-FT
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 01:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592978367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUiQPbjgFKl0hgRMK+Wa6QVsk4cITYmGSaP1v+ie5To=;
 b=MvelpOR+oz4M4R6VC2YdvG8/wo71Q4XzVYd+fJl+4+IT0F3PDNIw/yRyAUUdBM66V9J1tG
 fw71ltIBZwP7KoGzH/zuQckKa/Szs5c2Lklqw64OnKYYyiJpZ0Hz6tRfJgaQ6mR2Fn0qEj
 ZNwhFCJ41m6KL1o96kdWbDUA5SfXDMY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-hZyBnIkxOZiE-ar6Yv7OJw-1; Wed, 24 Jun 2020 01:59:25 -0400
X-MC-Unique: hZyBnIkxOZiE-ar6Yv7OJw-1
Received: by mail-wr1-f71.google.com with SMTP id p10so1978758wrn.19
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 22:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XUiQPbjgFKl0hgRMK+Wa6QVsk4cITYmGSaP1v+ie5To=;
 b=F9SlTlipMRJxtr2dZGh76TD+o4JvGqnqemvV901p9uRNC+p+h1kscO5VfbN+2G+3SZ
 2ZrQz9B7znewHDJ4B457iSLsZYdoo9bDTezAHRcM/x1MOkiVKO+6OFplLu9XD1Z/ANzz
 iEbRts2UyevLj6eyAPG43ZLgiP1KNo9dDZ7vUC4S8fCEH9HnhnJn95r9tymLta58l57q
 SzrIBtWZf2rHlCMPgYP40ZEGNgqsTKVEe80MHUuSg8QwRcg3udOMYGUXfp1BYURz/Nxp
 V6bUrX8qA0mVoUBx/sOSvN7UYoER9TLowsnkxFXOvI/J9ky/DR+B2iBvkkYOK1B9I8iG
 mbsw==
X-Gm-Message-State: AOAM531NxypQoSEoHsuA19mTzSKpkkynRplfQNL3UUGVDoi6KgvHbMLC
 KVP3yDe4sXrt6qN3WSdCjKhHX0+787M3pUXKJ00GKtxqrXNF9RFlxiq37iMrgi7UKCpRVV84ZxG
 Kmjrb3kBhTBSGcW0=
X-Received: by 2002:adf:afc3:: with SMTP id y3mr30016073wrd.277.1592978364251; 
 Tue, 23 Jun 2020 22:59:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrLKT2zBrqSBiF9jZ+DpRg42z/Dj6dNI5wWZtLo2VTKz2l/xQWBJ1hl+hPS8rcOKdh4eVCrQ==
X-Received: by 2002:adf:afc3:: with SMTP id y3mr30016064wrd.277.1592978364025; 
 Tue, 23 Jun 2020 22:59:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879?
 ([2001:b07:6468:f312:24f5:23b:4085:b879])
 by smtp.gmail.com with ESMTPSA id z16sm15872000wrr.35.2020.06.23.22.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 22:59:23 -0700 (PDT)
Subject: Re: [PATCH] libqos: pci-pc: use 32-bit write for EJ register
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200623161852.19477-1-pbonzini@redhat.com>
 <20200623165527-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb61b6b2-96ce-1f1a-70b3-0bcf25afea09@redhat.com>
Date: Wed, 24 Jun 2020 07:59:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623165527-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/06/20 22:55, Michael S. Tsirkin wrote:
> On Tue, Jun 23, 2020 at 12:18:51PM -0400, Paolo Bonzini wrote:
>> The memory region ops have min_access_size == 4 so obey it.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I assume you are queueing this with the memory core change?

Yes, I am.

> 
>> ---
>>  tests/qtest/libqos/pci-pc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
>> index 0bc591d1da..3bb2eb3ba8 100644
>> --- a/tests/qtest/libqos/pci-pc.c
>> +++ b/tests/qtest/libqos/pci-pc.c
>> @@ -186,7 +186,7 @@ void qpci_unplug_acpi_device_test(QTestState *qts, const char *id, uint8_t slot)
>>      g_assert(!qdict_haskey(response, "error"));
>>      qobject_unref(response);
>>  
>> -    qtest_outb(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
>> +    qtest_outl(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
>>  
>>      qtest_qmp_eventwait(qts, "DEVICE_DELETED");
>>  }
>> -- 
>> 2.26.2
> 



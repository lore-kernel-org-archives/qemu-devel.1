Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C051FC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F2D206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F2D206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsQSe-0002Wp-VI
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 07:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsQRZ-00015i-27
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsQRX-0004tm-TV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:37:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52217)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsQRX-0004sz-KA
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:37:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so56829209wma.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 04:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4W7yWniuF20HEUzmuYmR4smJCca7BGfYr/UM9hFHMck=;
 b=N4PHpTfU6PdSAiCerf2v2QiLHXmD74F1m4NzXCTnsRNJgKjyJ5DzVYjHCzASZpVJC9
 wKSdp1DplL7PY8zT0hLgwGvl1pjwAxl9sLKSlwFj3507qG0TOBWdOqdG5JYaNahxd7aa
 18mUa/KrOmle0pyz49AtIvDQcxrM8l2vC4QRjBHnI5b+c1IwBrYyYe0nci1Af88O8wrG
 NYNJMTL9LfATuU0qI3JzHK51i16cjMnFaF2FKj7tvLiqbrvxe5g0Tl4XGyXkuPACDeuG
 1rxnPJ8JaJAGaDeOpeFJP33+82bZkoNctI1OqAzRH6ebh10H+2sOYmjTLEaWSx9zeMKt
 aZPg==
X-Gm-Message-State: APjAAAW1OJo17KQBvIAovjuj62wAm5ueesmRuhPvKavCHmXf1ybnrorS
 Wt3vrKo0VA/tQIStNMjfVPKc0g==
X-Google-Smtp-Source: APXvYqz7erF0BTo2bgrIhV7kjeJQhjp1A+qOquXCk1QQtKGQQ7hm7rBu7s3qkfQ3kjzOLQGIqMirdQ==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr34806727wma.176.1564486641739; 
 Tue, 30 Jul 2019 04:37:21 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i12sm76679636wrx.61.2019.07.30.04.37.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 04:37:21 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20190729223605.7163-1-jsnow@redhat.com>
 <7324bc78-1d7b-7b7f-272d-c2932651b007@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <075eaba0-7e50-b240-7679-825c5bd03e0f@redhat.com>
Date: Tue, 30 Jul 2019 13:37:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7324bc78-1d7b-7b7f-272d-c2932651b007@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] Revert "ide/ahci: Check for -ECANCELED in
 aio callbacks"
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
Cc: Fam Zheng <fam@euphon.net>, Shaju Abraham <shaju.abraham@nutanix.com>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/07/19 11:54, Philippe Mathieu-Daudé wrote:
> Hi John,
> 
> On 7/30/19 12:36 AM, John Snow wrote:
>> This reverts commit 0d910cfeaf2076b116b4517166d5deb0fea76394.
>>
>> It's not correct to just ignore an error code in a callback; we need to
>> handle that error and possible report failure to the guest so that they
>> don't wait indefinitely for an operation that will now never finish.
> 
> Is this 4.1 material? It looks so.

Perhaps could have been last week, but now I suggest Cc qemu-stable and
delaying it to 4.2.

Paolo

>> This ought to help cases reported by Nutanix where iSCSI returns a
>> legitimate -ECANCELED for certain operations which should be propagated
>> normally.
>>
>> Reported-by: Shaju Abraham <shaju.abraham@nutanix.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  hw/ide/ahci.c |  3 ---
>>  hw/ide/core.c | 14 --------------
>>  2 files changed, 17 deletions(-)
>>
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>> index 00ba422a48..6aaf66534a 100644
>> --- a/hw/ide/ahci.c
>> +++ b/hw/ide/ahci.c
>> @@ -1023,9 +1023,6 @@ static void ncq_cb(void *opaque, int ret)
>>      IDEState *ide_state = &ncq_tfs->drive->port.ifs[0];
>>  
>>      ncq_tfs->aiocb = NULL;
>> -    if (ret == -ECANCELED) {
>> -        return;
>> -    }
>>  
>>      if (ret < 0) {
>>          bool is_read = ncq_tfs->cmd == READ_FPDMA_QUEUED;
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index 6afadf894f..8e1624f7ce 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -722,9 +722,6 @@ static void ide_sector_read_cb(void *opaque, int ret)
>>      s->pio_aiocb = NULL;
>>      s->status &= ~BUSY_STAT;
>>  
>> -    if (ret == -ECANCELED) {
>> -        return;
>> -    }
>>      if (ret != 0) {
>>          if (ide_handle_rw_error(s, -ret, IDE_RETRY_PIO |
>>                                  IDE_RETRY_READ)) {
>> @@ -840,10 +837,6 @@ static void ide_dma_cb(void *opaque, int ret)
>>      uint64_t offset;
>>      bool stay_active = false;
>>  
>> -    if (ret == -ECANCELED) {
>> -        return;
>> -    }
>> -
>>      if (ret == -EINVAL) {
>>          ide_dma_error(s);
>>          return;
>> @@ -975,10 +968,6 @@ static void ide_sector_write_cb(void *opaque, int ret)
>>      IDEState *s = opaque;
>>      int n;
>>  
>> -    if (ret == -ECANCELED) {
>> -        return;
>> -    }
>> -
>>      s->pio_aiocb = NULL;
>>      s->status &= ~BUSY_STAT;
>>  
>> @@ -1058,9 +1047,6 @@ static void ide_flush_cb(void *opaque, int ret)
>>  
>>      s->pio_aiocb = NULL;
>>  
>> -    if (ret == -ECANCELED) {
>> -        return;
>> -    }
>>      if (ret < 0) {
>>          /* XXX: What sector number to set here? */
>>          if (ide_handle_rw_error(s, -ret, IDE_RETRY_FLUSH)) {
>>



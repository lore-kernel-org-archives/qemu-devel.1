Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA4C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A47F20828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MV5P7dwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A47F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6CKk-0000FH-9V
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6CJx-0007mF-HK
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6CJw-0005Wv-C4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:54:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6CJw-0005Vw-95
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582545283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9lAZl2l9q15faWurxhUzFvthbni94ghw7tLIRbZAeI4=;
 b=MV5P7dwZAkhq2MzF8ua3rkSb5N3/l6sqOFcOtSN3wX0VafWpOcAUWCYKAZMAHEGmJ0vqOS
 qRrBmeQR9KmT+5h13k8rd5bZsvoEEjeYWuqc5EPSUuZG0Ikkk3EgnokcvbEPe1rNvBqk55
 nmKHIJeCSetH6MbDIdAJKurReuXBxdA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-MASo8fKMNGOdIlGZDB5ixw-1; Mon, 24 Feb 2020 06:54:39 -0500
X-MC-Unique: MASo8fKMNGOdIlGZDB5ixw-1
Received: by mail-wr1-f69.google.com with SMTP id w6so5479074wrm.16
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 03:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9lAZl2l9q15faWurxhUzFvthbni94ghw7tLIRbZAeI4=;
 b=I7nwF2yQpnEP4cJiPIVxAeDl59GX3rxnixaTHk7Y7h5oJso3ritIPOkhugSYDT5M5H
 2bZb0vm53JSeF9ZwfwzovLAQ/SiCuF7DuIFArDPgc8ZVUWGupwKo2px3xn8aPMfA7I2U
 bqqLz+A9aH67+wWuZAoeFzJhBlLbFcI++sBM+AqkejmoNsl8n0RLbQ2b+wPIwtUPoRFs
 JweNcILPjpJkUU3yi2W3OeiwPn1yoyFSicmWIgpfKIky02lhsl7GFp7qa8iQyiFCybsD
 b4cfZcHNQ2WFsxwiBlMIowx/kza5hh8BRisVrGDr51guG1BMPNDk34/dSr5cNb8P6LxU
 cRVA==
X-Gm-Message-State: APjAAAUL3YXaobdgYp+3RVh0U5FeQN7+g/1FNRvoSQjVQKosHYzeADbV
 o22a+sImuhur46FF/VZAw8WBtTQUipmXHqraGoo8aBahO32MZaSks0Mahg1qlJwnaSU4nwJ2Cim
 jbS7w2JnWoCifQ3U=
X-Received: by 2002:a1c:750e:: with SMTP id o14mr16690914wmc.156.1582545278793; 
 Mon, 24 Feb 2020 03:54:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsNRJ0OCVLZoNuqXJaLhobXIR6nWXPLP1qjGiMDXm7JoK6daLQiu9F2qN8AUjtcEaOsFLs5g==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr16690885wmc.156.1582545278551; 
 Mon, 24 Feb 2020 03:54:38 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a62sm18286162wmh.33.2020.02.24.03.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 03:54:38 -0800 (PST)
Subject: Re: [PATCH 0/2] qemu/queue.h: clear linked list pointers on remove
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org
References: <20200224103406.1894923-1-stefanha@redhat.com>
 <158254173238.10132.7761755657862330006@a1bbccc8075a>
 <20200224113903.GD1896567@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d3fa195d-d6cc-438f-517b-676b2642df71@redhat.com>
Date: Mon, 24 Feb 2020 12:54:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224113903.GD1896567@stefanha-x1.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, pbonzini@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 12:39 PM, Stefan Hajnoczi wrote:
> On Mon, Feb 24, 2020 at 02:55:33AM -0800, no-reply@patchew.org wrote:
>> === OUTPUT BEGIN ===
>> 1/2 Checking commit f913b2430ad3 (qemu/queue.h: clear linked list pointers on remove)
>> ERROR: do not use assignment in if condition
>> #65: FILE: include/qemu/queue.h:314:
>> +    if (((head)->sqh_first = elm->field.sqe_next) == NULL)              \
>>
>> total: 1 errors, 0 warnings, 59 lines checked
> 
> The same pattern is used elsewhere in this file.  This code comes from
> BSD and doesn't comply with QEMU's coding style.

Checkpatch is right, assigning out of the if statement makes the review 
easier, and we can avoid the 'elm' null deref:

#define QSIMPLEQ_REMOVE_HEAD(head, field) do { \
-    if (((head)->sqh_first = (head)->sqh_first->field.sqe_next) == NULL)\
+    typeof((head)->sqh_first) elm = (head)->sqh_first; \
+    (head)->sqh_first = elm->field.sqe_next; \
+    if (elm == NULL) { \
          (head)->sqh_last = &(head)->sqh_first; \
+    } else { \
+        elm->field.sqe_next = NULL; \
+    } \
  } while (/*CONSTCOND*/0)



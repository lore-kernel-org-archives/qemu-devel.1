Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03FAC4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F5E20BED
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABRCcUMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F5E20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWPbQ-0001hm-0z
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 15:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPaU-0001BK-MK
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPaS-00080Y-7R
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603569142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdQe7st9WHRpqAtZaOF56cFaxdtGTorLaxlgcvGXPxI=;
 b=ABRCcUMc7fj6dwUC44CN7RbGyppBEEcK2YLCOdhKOKSJS/aIQ28Ibb+i0TyILH2XLSVj6h
 uzfrQGEobflt0JJbeD1eSNp1kfua2rYe/wTn3s7Ev1EylHC7pHrMqZ6mSYCN2i2i58FrYT
 NL5ht49IAlvbA68c1x7nNdD577d88I8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-3E6qaLSBNByzyR6vU-hXVQ-1; Sat, 24 Oct 2020 15:52:20 -0400
X-MC-Unique: 3E6qaLSBNByzyR6vU-hXVQ-1
Received: by mail-wr1-f70.google.com with SMTP id v5so3701489wrr.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 12:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OENZQ3eb2mGrR8488Lk5BSlqlyIxvxjPs5sY/sHC5b8=;
 b=kaVP3gJ2iaZ6gDeO2i4X/T3GXJT6maJQ8NE3BbGSZGQJF0ew+4o+b5jyawSBibXlEb
 MZZ3Jz2njeaWbie6fqrB81QalLbAPM3siw/aNm/wnnfmYGN3zvT7ld10SYNQx7VgzFkD
 fPlYWEhbwm6N6DKTnPNSzggbm6QqMMQ5AGKUOC+NxuOnpTk4Kcz8k7DqC3sGNCzAieJ2
 XWLSjBL3Mz+RjijOD/1U0GDKmBRt+ZbJJrrfcY5ZHZgYAcVdkdzpzau2PHKEFr6gGnjq
 wO/VGSbFZ5DVhG83AcLDiFpFS+5bYeMIKV0m7zYc2/HPXpAB6KJTsTbSVSuVSAmbmqRN
 oj7w==
X-Gm-Message-State: AOAM532FkljQEGkhz+unXwYSsopvsCgZjQNPYj8I/KPdO7gJTkrO0wUZ
 El4Nu4Z12Y0Tm5YKf96R+memWxD3Tn63+xJvX4+N1pwE/AoLDRGUiVFkq5P93IqtNaOl6KEE8wI
 cFzHOtNHoBn8/7tg=
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr9179258wrr.19.1603569139792; 
 Sat, 24 Oct 2020 12:52:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXORQjh1GURkzNr6va8qcuLdFOQk+OuO9kBl5PHP5DkPkYkijQ5Ic06xoBHQlhN4g+OJEIfw==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr9179236wrr.19.1603569139602; 
 Sat, 24 Oct 2020 12:52:19 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y10sm12926863wrq.73.2020.10.24.12.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 12:52:18 -0700 (PDT)
Subject: Re: [PATCH 03/16] util/vfio-helpers: Pass minimum page size to
 qemu_vfio_open_pci()
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20201020172428.2220726-1-philmd@redhat.com>
 <20201020172428.2220726-4-philmd@redhat.com>
 <20201022140050.GD761187@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6194679c-2cee-fd51-bfe3-0a295a0f851e@redhat.com>
Date: Sat, 24 Oct 2020 21:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022140050.GD761187@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 15:52:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/20 4:00 PM, Stefan Hajnoczi wrote:
> On Tue, Oct 20, 2020 at 07:24:15PM +0200, Philippe Mathieu-Daudé wrote:
>> @@ -724,7 +725,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>>           goto out;
>>       }
>>   
>> -    s->page_size = MAX(4096, 1u << (12 + NVME_CAP_MPSMIN(cap)));
>> +    s->page_size = MAX(min_page_size, 1u << (12 + NVME_CAP_MPSMIN(cap)));
> 
> Is there a guarantee that the NVMe drive supports our min_page_size?

No, good point!

> 
> Stefan
> 



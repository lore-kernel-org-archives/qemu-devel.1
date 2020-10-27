Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18C9C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4451921556
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdEdJbe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4451921556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXP9r-0004Py-BM
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXOzK-0000HY-DS
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXOzH-00074C-Sg
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603805166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xc9OiJOFIfLzlwCKot9DVHwYHcB9xqYERuLb+Q0yU1o=;
 b=ZdEdJbe2nRMm4hJi/vwlCBtIOTvZD46NfzoDyGfN4Su4MVYbJm3+HqvTY3YeqgWAoE3aLV
 xSy+NDjnQ8RTSic5Y3kSHmgQbc4Qsk+a+fkx1iF/Fo0ezZCsFCgk8fOjPLd28n955zBdXx
 4UxMvDkFiN8k3EAx4Slgi1+ld/x3FMk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-pxbaoKzKNy-XOAK6ou26lQ-1; Tue, 27 Oct 2020 09:26:05 -0400
X-MC-Unique: pxbaoKzKNy-XOAK6ou26lQ-1
Received: by mail-wr1-f71.google.com with SMTP id 91so724837wrk.20
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xc9OiJOFIfLzlwCKot9DVHwYHcB9xqYERuLb+Q0yU1o=;
 b=n+R93ynHohHbwz0MvqGfpo7WQW/vOK2KBs55LIOLIgfR83ItGv8NzDhHKmorIXg4ws
 iswP+hR7ktHtOZ4Gbtp7vmu2XnHsfsWZiSTyDNubK0pV7riz+vL30Dg7q2r/i6TxVN0p
 gfG0Y1/vTsqJTR2DVkJZpS3alx22IgZSz4Co2A/En8u1CNgvmYGxAyqLj7kgI0l3vhmz
 v1WpqmwVIX9jMfRscSxDCuMLpgyl1MoizWkGAywJVGXsyAEJIrLAmJgSkzK3UInJDoYY
 a5dbkPq3flh+CeWLCXaT0iDAy1/pPUqoIMMRECsnhW/BEuoOumMSpkyC02rLRqKzIN6G
 Bmuw==
X-Gm-Message-State: AOAM530e/Kmtar9NroJzE0GcyBBR+NIXNl4/c6ue+mStmwwdiKrE1khe
 i9967vYIEZkqCdnvlNM4RhVrkPBXTiJMQI0JzISO8Kw2My+eG1UlFr9t/pBuvf/+c2H+LXb5DAN
 6zJEDHSgwWPI+h4k=
X-Received: by 2002:adf:f101:: with SMTP id r1mr3111775wro.392.1603805164000; 
 Tue, 27 Oct 2020 06:26:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8HIWYH5B3T9A3JEybryRuputXsnf+MdgvNLApKHtz5JvYRqgW5nysxsU7NPdNNH9dDOkeBA==
X-Received: by 2002:adf:f101:: with SMTP id r1mr3111730wro.392.1603805163499; 
 Tue, 27 Oct 2020 06:26:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id b193sm353600wmb.2.2020.10.27.06.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 06:26:02 -0700 (PDT)
Subject: Re: [PATCH 12/15] s390: remove bios_name
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-13-pbonzini@redhat.com>
 <a680d773-6cfa-7aac-b5d2-20e267bd5c59@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c88c8591-6d51-2537-e62b-700698f5f42b@redhat.com>
Date: Tue, 27 Oct 2020 14:26:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <a680d773-6cfa-7aac-b5d2-20e267bd5c59@de.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/10/20 09:38, Christian Borntraeger wrote:
>>  
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index e52182f946..a521eba673 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -258,7 +258,8 @@ static void ccw_init(MachineState *machine)
>>      /* get a BUS */
>>      css_bus = virtual_css_bus_init();
>>      s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdline,
>> -                      machine->initrd_filename, "s390-ccw.img",
>> +                      machine->initrd_filename,
>> +                      machine->firmware ?: "s390-ccw.img",
> Adding the elvis operator is actually a fix, no?
> 

I think it was already doing the equivalent here in s390_ipl_realize

        if (bios_name == NULL) {
            bios_name = ipl->firmware;
        }

        bios_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);

so it was just an encapsulation violation on part of the IPL device.

Paolo



Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12866C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611CF206F1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R12F7vYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611CF206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZtmp-0005GM-Cx
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZtm4-0004on-K6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:42:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZtm3-0007G9-3O
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604400166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRAR7hoNpsNTwu6XCVJhKcwx9aGV+moxjxEhp7crUkM=;
 b=R12F7vYH5gW2OeDLq2Y5Xoc21aPHXgop6y7tkJ4SflWp8WaNGPqNUimBlV4yakMEMrctcR
 gSQEjIm9sGq/TUSokMhK2oUv6f8xiu5isCGc77vezHOD1RZiEQWXFMQZofzPhDomRRRz+f
 p+gf7KogUTpYjNgIYYpK43D7xAXu+18=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-6A_89pwwN8q2AuAG2ItmjQ-1; Tue, 03 Nov 2020 05:42:44 -0500
X-MC-Unique: 6A_89pwwN8q2AuAG2ItmjQ-1
Received: by mail-wr1-f70.google.com with SMTP id j15so7674821wrd.16
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 02:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jRAR7hoNpsNTwu6XCVJhKcwx9aGV+moxjxEhp7crUkM=;
 b=cs40Eo+7z5P594quVLacczDzOTP6VS1P5Mpsuq+EIkvz5azkOaw6KIgYhctiqT4tHu
 gC6q7O7yMYN1kgmLO6/MY3fx1FG3NU2GzdlQBV590Yj1gLjXJbdU1oJ+7RoSsg6AIT/9
 6iGX7VdMwfeFiDnaqMn+yQn9noD0aBI2HIorqGOUVnS6UtrNJbdZQhASKO7w4xTUtjXz
 z/G2oI7T+2mv5Rzw+9evtXX539yZlo57OhpMJBymV04mzdofQcmyJsy+CtjjxrKmJfjC
 f/idK3W6dKgNBuIzLaXLqKqVT1oSh+m3xKC69geDapO+eeUJfYykbVAWv2Gy2sFYdala
 1/WQ==
X-Gm-Message-State: AOAM530ih/h/+D65rW7Ky7rmbaKbgkZtCOhA2Hsi91qkNe+1A0xDW+cN
 UiL1WP+SZaFf9jzoLEMsFU8frphl+0ZPIOLi405XvS6Jm3vdxDJhmqvinFDcwBmxvuWa2x3SUZK
 NvflgNxRCxMY/tWU=
X-Received: by 2002:a05:6000:107:: with SMTP id
 o7mr25127349wrx.354.1604400163553; 
 Tue, 03 Nov 2020 02:42:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypNDECRSRG2HwaKJT7Ddn9PI7DdoHY+4vMFMrUEjVayyER2FcccuDGO0oGZnKJilVHCOQ3cQ==
X-Received: by 2002:a05:6000:107:: with SMTP id
 o7mr25127329wrx.354.1604400163419; 
 Tue, 03 Nov 2020 02:42:43 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id h7sm25565733wrt.45.2020.11.03.02.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 02:42:42 -0800 (PST)
Subject: Re: [PATCH] target/i386: tracing: format length values as hex
To: Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20201103100745.160409-1-dovmurik@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <185b4ff0-d960-89cb-c280-8b2971f35132@redhat.com>
Date: Tue, 3 Nov 2020 11:42:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103100745.160409-1-dovmurik@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 11:07 AM, Dov Murik wrote:
> Three trace events had a literal "0x" prefix but the 'len' values were
> formatted in decimal base.  Keep the prefix and format the numbers as
> hex, as is usually the case for length of memory regions.
> 
> Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
> ---
>  target/i386/trace-events | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>



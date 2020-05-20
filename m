Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8C0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596E9207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4cpaJ6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596E9207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbM0I-0004i0-J8
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbLz4-0003CQ-CG
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:29:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28938
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbLz3-0000fm-Fb
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589970596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sm2JIWJ2x2QMZ7pxcWlbuxvXy3baAqenq2UZalN4G1U=;
 b=F4cpaJ6J0oWrC7wI9IFBjL3fcQM3v4aMBzvbF/7GIaY93NIScmwBOlFpuyyvM4C0iYbbkG
 lMfzzY+jVYncMQsrNHc/iEcumoUQuFmUWnoYGhNti3NgrqZCWAFhURXp6TBBjpl9ETN4RX
 fu9YZHAooL0E3uoVeAWtWeX4BPPb8pk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-8GDSMoPuPbO1X0IFv5hq-w-1; Wed, 20 May 2020 06:29:49 -0400
X-MC-Unique: 8GDSMoPuPbO1X0IFv5hq-w-1
Received: by mail-wr1-f70.google.com with SMTP id g10so1215429wrr.10
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 03:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sm2JIWJ2x2QMZ7pxcWlbuxvXy3baAqenq2UZalN4G1U=;
 b=UyZzkohA4S25d92Y9wb2EtqaSd8Yc5ykm/OYNGH6mIFn0fT+z+j44dXGDZDe/kHUJa
 XpxgdgwtT7unPc6F6tOp6sqXvha5WhMvFkyzqIupycJbe3SaaAQSE1LyJ7It7LQcdHVU
 5oftpRcn7VYBc8l5p7MaigZqMVv9FCjHKza9Z743IDUA8V/HLFNIvsjaAlv+TkmIJ0a7
 IffIsD/ZODo+/S4Prm9oBrwQfTYhXDgXsb2eiGfKQvBLU4myN154UETfVADDr2CSyxv5
 ak7Mvq41eJ44YFVd/6qD58ETR4SPK14wg18n9iG2QPea2p2os6quqw7dW/w2mMYmKHmA
 U8NQ==
X-Gm-Message-State: AOAM530/aBEhFJsHqmPksTpz8zhNNluVNn4lGC9Hkd9YyvPRjvVIk1TZ
 Sv0yAxsK9WpDzZCWLSmKWwurV+ozQ1nEJ6JbCaFLHWsmOwOSR4LnDC7/wH55DYxgzajYfoVVcy6
 p1m8T9nHnQX9zO/w=
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr4282787wmr.49.1589970588477; 
 Wed, 20 May 2020 03:29:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzOWBqhTZ5FlG0Wv4yJ0Y9a3a8u9OBhPqdfuNdj8f3G5g8RJCDYBDQQaDPGwIXR+zLcXZBVA==
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr4282758wmr.49.1589970588213; 
 Wed, 20 May 2020 03:29:48 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v5sm2370135wrr.93.2020.05.20.03.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 03:29:47 -0700 (PDT)
Subject: Re: [EXTERNAL] Re: [PATCH] WHPX: Assigning maintainer for Windows
 Hypervisor Platform
To: Sunil Muthuswamy <sunilmut@microsoft.com>, Stefan Weil <sw@weilnetz.de>,
 "Justin Terry (SF)" <juterry@microsoft.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Mike Battista <Mike.Battista@microsoft.com>
References: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <BN8PR21MB1297D3D88C41B6AFADE36DCCB6110@BN8PR21MB1297.namprd21.prod.outlook.com>
 <ecc9b0c5-7cd7-1f8d-d10c-bee7aff8fa01@redhat.com>
 <BN8PR21MB12974CEDAEC173FC8CD626DFB6100@BN8PR21MB1297.namprd21.prod.outlook.com>
 <6b5c046a-af4b-8adf-e3a2-64d904c9ff16@weilnetz.de>
 <SN4PR2101MB0880A6DE49500BCA0B1898EBC0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3349c1dc-bc9a-6a74-41b2-2d6ebb29eec5@redhat.com>
Date: Wed, 20 May 2020 12:29:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB0880A6DE49500BCA0B1898EBC0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: 1879672@bugs.launchpad.net, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sunil,

On 5/19/20 11:59 PM, Sunil Muthuswamy wrote:
>> -----Original Message-----
>> From: Stefan Weil <sw@weilnetz.de>
>> Sent: Thursday, February 20, 2020 11:54 PM
>> To: Justin Terry (SF) <juterry@microsoft.com>; Philippe Mathieu-Daudé <philmd@redhat.com>; Sunil Muthuswamy
>> <sunilmut@microsoft.com>; Eduardo Habkost <ehabkost@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>> Henderson <rth@twiddle.net>
>> Cc: qemu-devel@nongnu.org
>> Subject: Re: [EXTERNAL] Re: [PATCH] WHPX: Assigning maintainer for Windows Hypervisor Platform
>>
>> Am 19.02.20 um 16:50 schrieb Justin Terry (SF):
>>
>> Hello Justin, hello Sunil,
>>
>> just a reminder: we still have the problem with the proprietary license
>> for the required Microsoft header files.
>>
>> Can you estimate when this will be solved?
>>
>> Regards,
>> Stefan
>>
> 
> Adding Mike Battista, who is on the SDK team and can help provide some clarity around the questions about SDK licensing.
> 

To ease communication and track the changes over time regarding this 
problem, I opened a ticket on Launchpad:
https://bugs.launchpad.net/qemu/+bug/1879672

Last time (Sept 2019) Justin Terry contacted Microsoft legal department 
for guidance but no update since.
This is unfortunate as we can not let the community use this feature, 
neither can we keep testing WHPX to avoid code bitrot.

Can you meanwhile provide Azure CI builds using WHPX enabled?

Regards,

Phil.



Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F17FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47FD8207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCfeVw/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FD8207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLxB-0000mT-9H
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbLwI-0008EG-82
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:27:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25137
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbLwH-0000Ru-Gj
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589970424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVSGKa9QJ5UaN5VkA7QNtPZa/lOGyKzyenKT1fE5/b8=;
 b=cCfeVw/nhvDFicYX7rKpv9mChYVNAhl1JmoH8WOAWGtvsrDSAk/ZEbxGpGTvFuNJlMEaPz
 9xmmnHnbO6+ql1L4AtpqVYdU+pPudNJksrdJg2ydGzjT3wo+NGs2snwcjVKmep99CL4byZ
 SSECFKAK9JrWs0ZxlnRt4/oiewF0euw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-Rks_hnrzM0m5q4V_uhfUwQ-1; Wed, 20 May 2020 06:27:03 -0400
X-MC-Unique: Rks_hnrzM0m5q4V_uhfUwQ-1
Received: by mail-wr1-f70.google.com with SMTP id p2so1220629wrm.6
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 03:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZVSGKa9QJ5UaN5VkA7QNtPZa/lOGyKzyenKT1fE5/b8=;
 b=Gv+RibIF2bINSmsai73puamWCLf7Y/uX+JU/JxL96EcV1kW7RU1iERu99VezfoXvT8
 i6iCKJ5f9QWmb0/bhHMC1Tw1Rgvr2RfLu5WNoXB5RdsR0FwhoqARe4+v45BLBz9IslBb
 mR+CoJ/vWtMC+4hjeNnnWt82Z+BAz7sBax2yIjFwOhqJlkulLytM1doo+cZeONS8v+TT
 NGUg3NP8jcP1yQ/yixqFYGset+R+VGjzYlCwJ5S2zBeisqSlrzXG4S5juHBtZRlJ5lRt
 +xMUKlCyb1Nf3fhNGFtw1CR6RYKXMWEHMA3e1WZDsE5FziT517MS3CBQ2bTB+ELJ297d
 FdjA==
X-Gm-Message-State: AOAM533BDp+MWqVcvyCKakqSvJ5fxBUV8ZlvN04FUOBFnP0pqkTlOo/S
 gNEpJZ6PC+gYrJj40JnUm9yCKdS7w2iSQ0B9Zee14HSz+MLFHInTG0mYdQx7Ve95nun93sm7R9I
 tK8U3i30YNPCNBsI=
X-Received: by 2002:a1c:80d0:: with SMTP id b199mr3941265wmd.93.1589970422248; 
 Wed, 20 May 2020 03:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoBZK9xFFUb+UnIvkzHcrtkXj09l76CIwlkRQ1JDeaHUTL75kvFywndGXQMggvCvGZjWhCbA==
X-Received: by 2002:a1c:80d0:: with SMTP id b199mr3941241wmd.93.1589970421933; 
 Wed, 20 May 2020 03:27:01 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r11sm610446wre.25.2020.05.20.03.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 03:27:01 -0700 (PDT)
Subject: Re: [PATCH v2] WHPX: support for xcr0
To: Sunil Muthuswamy <sunilmut@microsoft.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <MW2PR2101MB1116F07C07A26FD7A7ED8DCFC0780@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <1c446cc0-8a22-41d6-fe38-db0b7333ed89@weilnetz.de>
 <MW2PR2101MB111666F06FADEC582CAE4184C0780@MW2PR2101MB1116.namprd21.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8a787221-0c91-3a65-1527-6d329466a6a1@redhat.com>
Date: Wed, 20 May 2020 12:27:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB111666F06FADEC582CAE4184C0780@MW2PR2101MB1116.namprd21.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

+launchpad ticket

On 11/7/19 11:52 PM, Sunil Muthuswamy wrote:
>>> You will need the Windows 10 SDK for RS5 (build 17763) or above to
>>> to be able to compile this patch because of the definition of the
>>> XCR0 register.
>>>
>>> Changes since v1:
>>> - Added a sign-off line in the patch.
>>
>>
>> I am not very happy with the current situation which suggests using non
>> free header files from the Microsoft Windows SDK, thus making it
>> impossible to produce QEMU executables for Windows with WHPX support
>> without having legal complications.
>>
>> Could you please add the required headers with a suitable license to the
>> QEMU source code? That would clarify the license issue and make builds
>> with WHPX much easier because those files would not have to be extracted
>> from a very large SDK installation.
>>
>> It would also be acceptable if Microsoft could update the license
>> comments in those files and use a QEMU compatible license.
>>
> I agree in principle that there should be an easier way to consume the Windows
> SDK headers without having to play around with the licenses. I also agree that
> that will make life lot easier for many developers. I am reaching out
> internally here to see what can be done about this, but, that might take some
> time. Meanwhile, is it possible to make some progress on this patch?
> 
>> Kind regards
>> Stefan Weil
>>
>>
> 



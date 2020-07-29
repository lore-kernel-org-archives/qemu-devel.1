Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE826C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86E6206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzY4RAVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86E6206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0oZV-0002Rk-TX
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0oWT-0006NP-4O
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:01:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28923
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0oWQ-0000qa-Md
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596038497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8nUgHmZDHlcYcZgpKyAYpuwb4GCg6YuZRnvHKb6rPM=;
 b=LzY4RAVAcseDFkD5U72UG+Un0W7f34I4V3wMja8o60CWkURV8AW+OLQgSxlYw+obofT9KL
 w1xvPCAhmIU7MQG0LINQALUsOmnv5GYCTshEwFjVyRCjjw7UYw80bEHSbrq7JLQ5lBK7l2
 05fXrQ5gU4LPyJaWXt0KUCH00eqFReY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-cjjoPsuMND6OUq7N9MQm2A-1; Wed, 29 Jul 2020 12:01:35 -0400
X-MC-Unique: cjjoPsuMND6OUq7N9MQm2A-1
Received: by mail-ej1-f70.google.com with SMTP id l18so8621912ejn.17
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 09:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I8nUgHmZDHlcYcZgpKyAYpuwb4GCg6YuZRnvHKb6rPM=;
 b=oaRPMnWFwuFLnlluPwVX400rJPOT4YhYieXrU7RspPiwc5255vsoyCP51NcTtzEEZx
 W+hBCX/MFDnKeeD8LDhAKT/Q6kpPphU0lDdEc/cnNv97noCAPcnVCFfi3R64a2chZzW5
 r6rH4XMpFF6jR05YCc+cCyoSWvi0e6LMjAtXqTu1jYmzNfW/LsEvsECCWNx2ymOU2B4B
 mrJjPhACo20PUyXN+IRYGa1VzZOmodym+3+Yb0Oz3O+8eDlh/EoaY83LIEiF3P1RyR0B
 gpdQulm14Zu15e+9xO4+SOTy/aHgnUiBMu1J6GFVCk6VGnyx20NDlPnS5B9f1aoaWmfV
 +BzA==
X-Gm-Message-State: AOAM532nFP8ptR9Hi7De2VB4XdDUVbUydxmbVJdOznDzVnGw+5JehOg7
 YbNmFNhfNNHkECDgjoGSKakc6kqIFUNWUNRZ86oXG0qIZOBGRRVkxne1VSTgZGwCPtUXi0RlVr7
 czeH/unTNKnddI2Q=
X-Received: by 2002:a17:906:b890:: with SMTP id
 hb16mr21319837ejb.376.1596038493929; 
 Wed, 29 Jul 2020 09:01:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhlkmYIU4DDO03VWayNenOpUHWzy0IjLFMT/zgG0WRsEFx7sk1NfYJFoXYd1nv9pEZkeiVlw==
X-Received: by 2002:a17:906:b890:: with SMTP id
 hb16mr21319806ejb.376.1596038493654; 
 Wed, 29 Jul 2020 09:01:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:101f:6e7:e073:454c?
 ([2001:b07:6468:f312:101f:6e7:e073:454c])
 by smtp.gmail.com with ESMTPSA id dc12sm1933349ejb.124.2020.07.29.09.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 09:01:32 -0700 (PDT)
Subject: Re: sysbus_create_simple Vs qdev_create
To: Eduardo Habkost <ehabkost@redhat.com>
References: <87tuy6k9pa.fsf@dusky.pond.sub.org>
 <20200717162312.GR1274972@habkost.net> <87r1t6hc0f.fsf@dusky.pond.sub.org>
 <20200720155955.GV1274972@habkost.net> <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
 <87lfj4f6nz.fsf@dusky.pond.sub.org>
 <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
 <20200728224733.GP225270@habkost.net>
 <422d7879-3fdc-d38e-259f-2477b9d3c169@redhat.com>
 <20200729143241.GS225270@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78767e1f-4124-cb6e-ead6-25fd415027c7@redhat.com>
Date: Wed, 29 Jul 2020 18:01:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200729143241.GS225270@habkost.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/20 16:32, Eduardo Habkost wrote:
> On Wed, Jul 29, 2020 at 11:54:35AM +0200, Paolo Bonzini wrote:
>> On 29/07/20 00:47, Eduardo Habkost wrote:
> [...]
>>> Do we really need need QOM children to be accessible using the QOM
>>> property API?
>>>
>>> Using the same code for both user-configurable properties and for
>>> the list of children of a QOM object might have saved some time
>>> years ago, but I'm not sure this is still a necessary or useful
>>> abstraction.
>>
>> The main thing we get from it is that the QOM paths treat children and
>> links the same, and links are properties.  To be honest it's not a
>> feature that is very much developed, so perhaps we can remove it but we
>> need to evaluate the impact of losing it.
> 
> Are link properties usable by -device/device_add/-object/object-add?

Not sure exactly what you mean, but there is DEFINE_PROP_LINK and it's
used to link devices to objects.  Is it ever used with an actual path
rather than just the id of something in /objects?  Probably not.

Paolo



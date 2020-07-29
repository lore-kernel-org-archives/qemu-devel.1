Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7BBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A6220FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gg940ro5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A6220FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ojX-0007B4-RC
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0oio-0006kJ-L4
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:14:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0oim-0002Z6-7N
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596039262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFy2IHMFRbk08t+94TMJtAMyPYx9dlv8gzf695teYVE=;
 b=Gg940ro5ncYPjjRxtmNsYfCBNGsSCtZM/Ovok0Fq73DNR0dW30RFivNJKKPNRwBP5GyY6x
 DDCNbVAq+cleOrqIPkcJ69rKkZGK0QdSY6/hkFf/5TAjflwL6qJ9xC+iUKD27zt0ZxvLUX
 BkHOzXO//Udr/LyAjdftfVgEWP2G+bw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-NFX6UXa7P3Ox9FFdYUOYMw-1; Wed, 29 Jul 2020 12:14:20 -0400
X-MC-Unique: NFX6UXa7P3Ox9FFdYUOYMw-1
Received: by mail-ej1-f71.google.com with SMTP id e22so3289107ejx.18
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 09:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IFy2IHMFRbk08t+94TMJtAMyPYx9dlv8gzf695teYVE=;
 b=UugZMpT84T8fE6aq1J4ZCc39xHpKdZYKHs1Di3PTTOmcFsHi9DKQZJdwyWxSdFCb5L
 BC1uE8FWFAVgyY3ndLmlH4om2+HU9sLt0nS+keKQwhBp3NbrIoe7qfDj1MYgfPOGokTI
 OW4jUoN/gjRbonmi6wKNQ/1N8f629TN8ce3xihsW8VgpSWywg+5PsvgucZD3Vah9H77U
 f4oTK4T1WD81ggWtyGCLxJ40CMkZ20EI2oCgIQhUb9uDLTq82qcwsZIEaTE3OFbR9I5+
 VtOT0dEpzy8bC98LLEt//fm0TwkDUfpVC8vin6R6PYr/ox/qzYqnVbvSBEhaf4xPc56J
 KFkw==
X-Gm-Message-State: AOAM5317pTEhA3T9yku4Ui2O9ajBwDUgXO4c5jtjkFELoNWXnPbjX1eG
 +xWeSdXWBUaQWgZJCfYeX9EO34WRfe0YjvAgbNsPbOyNUYl6l6NXuwi2VlOCr9K4X0PEvoQIQIm
 1UiEnQn5nXL1QhbM=
X-Received: by 2002:a17:906:c04f:: with SMTP id
 bm15mr21393048ejb.207.1596039259742; 
 Wed, 29 Jul 2020 09:14:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR905MCd12ziD/iSj1D7WuqxU6Z2WMANfshFP8MbLookVrdNGpLVB5NpWvWiGl7yCTsBBjNQ==
X-Received: by 2002:a17:906:c04f:: with SMTP id
 bm15mr21393031ejb.207.1596039259539; 
 Wed, 29 Jul 2020 09:14:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:101f:6e7:e073:454c?
 ([2001:b07:6468:f312:101f:6e7:e073:454c])
 by smtp.gmail.com with ESMTPSA id z22sm2196873edx.72.2020.07.29.09.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 09:14:19 -0700 (PDT)
Subject: Re: sysbus_create_simple Vs qdev_create
To: Eduardo Habkost <ehabkost@redhat.com>
References: <87r1t6hc0f.fsf@dusky.pond.sub.org>
 <20200720155955.GV1274972@habkost.net> <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
 <87lfj4f6nz.fsf@dusky.pond.sub.org>
 <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
 <20200728224733.GP225270@habkost.net>
 <422d7879-3fdc-d38e-259f-2477b9d3c169@redhat.com>
 <20200729143241.GS225270@habkost.net>
 <78767e1f-4124-cb6e-ead6-25fd415027c7@redhat.com>
 <20200729160849.GW225270@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a65bd24a-9de7-68db-5bed-5b836200b947@redhat.com>
Date: Wed, 29 Jul 2020 18:14:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200729160849.GW225270@habkost.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:17:30
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

On 29/07/20 18:08, Eduardo Habkost wrote:
>>>> The main thing we get from it is that the QOM paths treat children and
>>>> links the same, and links are properties.  To be honest it's not a
>>>> feature that is very much developed, so perhaps we can remove it but we
>>>> need to evaluate the impact of losing it.
>>> Are link properties usable by -device/device_add/-object/object-add?
>> Not sure exactly what you mean, but there is DEFINE_PROP_LINK and it's
>> used to link devices to objects.  Is it ever used with an actual path
>> rather than just the id of something in /objects?  Probably not.
> I mean: are link properties settable from the command line or
> QMP, as an argument to -device/device_add/-object/object-add?

Then yes.

Paolo



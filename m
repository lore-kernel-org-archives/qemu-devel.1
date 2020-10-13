Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951F2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B68420708
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBhLrSbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B68420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSGCY-0001Jk-I4
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 05:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSG7P-0007xF-3b
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSG7M-00004t-TD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602579431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f7xC8daW8feq2LJMp5AREWIucg+D2WcTexpk34bJmzY=;
 b=dBhLrSbha6Az5YL6KE90uoWdTaMe+UEt/KBqOOS0DttuhSfzTmeqxuI3pQ1sIsg3dKcC0A
 m8TgoqKItubnSqaytD6YpQniOzfwP10U9wSEQZyq/95vS79rGTrtMEbwrfB/oeyWra5NRF
 wP/71btIIHCumIbOE4O0rv5jFcdpD6M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-Xe3qgV_yOg2-hZKypoAGZQ-1; Tue, 13 Oct 2020 04:57:08 -0400
X-MC-Unique: Xe3qgV_yOg2-hZKypoAGZQ-1
Received: by mail-wr1-f71.google.com with SMTP id b6so10514466wrn.17
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 01:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f7xC8daW8feq2LJMp5AREWIucg+D2WcTexpk34bJmzY=;
 b=qpdq69cj5kDpT5h+/E0ZYwH477fJDKLvae226+e3hHYxk8e9VaHpPVKuv463nJp8yp
 fmLDOeor4ZvPLgSGpl7hntlKC8eOBl0x/Xwfc5PjLbQ1YmPgppiXTj7M7DIj9qRpwhow
 IcZjHbDwE5AYWzVrYfWe2f4MYpnN54Uo8e6m1vxsdynLBMtZGsisVUwsBiCPHZ2iIeSS
 Gy4oCK/RQzQl/7dc4dlIriYWhrGooZ4N/YtjGTW8kg8plN2YZ0C8KGUmfnwgT1KmU7Om
 Dnp4V//t1R5eQpDcKeYmhlhqR07rbaz7IAApgeXa5rwoHgWZoIDMWk1+sYdlh3W99IZe
 2Thw==
X-Gm-Message-State: AOAM533TTl84BIaXqYMXU0qiOOJAoq8dEpeIfogIV/DA5mF5MEJ97zzk
 ZIPAIukh8T6CtRVOLgsFJn4gQnu+LKPQ+qHRZU1/hAZYDZO7C7hvrZ8mDYdBDuZUfl3B05B5nNn
 BCGFUv2R0lLWgIig=
X-Received: by 2002:adf:e94b:: with SMTP id m11mr33770883wrn.35.1602579427052; 
 Tue, 13 Oct 2020 01:57:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgrlyBZKmbcZI3CrPy1KoxgOGlktg2zgpsENSU9SyLrSsUmwKvS0qsRtT3VdJW1N5upQrxJw==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr33770856wrn.35.1602579426788; 
 Tue, 13 Oct 2020 01:57:06 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c1sm28603304wru.49.2020.10.13.01.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:57:05 -0700 (PDT)
Subject: Re: acceptance-system-fedora failures
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, Kevin Wolf <kwolf@redhat.com>
References: <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
 <59d2a787-bcd4-7283-693b-09ea04c16dc6@redhat.com>
 <6068346f-b034-9321-0eea-29233c23a300@redhat.com>
 <78ce9ac1-d2a1-9dc0-bf38-f9ac34b2f203@ispras.ru>
 <14ee7cc6-42ca-fd86-241b-ed85e26693f7@redhat.com> <878sci1dt0.fsf@linaro.org>
 <d86c9425-dcb2-7fa7-1f6f-bd7b8dab53c1@ispras.ru>
 <c5e6f7ea-93c4-a46a-dfee-7699c08c1060@redhat.com>
 <4f4eee5e-e8cd-0595-cccc-8b648773c9ba@ispras.ru>
 <43eac2fb-7325-9e9f-ce13-d0774638753f@redhat.com>
 <20201008115018.GD4672@linux.fritz.box>
 <a1230ec4-13ae-3a0b-5b8a-71c9c87250ac@ispras.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d0e0d513-099d-2976-acbd-650a95a06a6d@redhat.com>
Date: Tue, 13 Oct 2020 10:57:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <a1230ec4-13ae-3a0b-5b8a-71c9c87250ac@ispras.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 12:37 PM, Pavel Dovgalyuk wrote:
> On 08.10.2020 14:50, Kevin Wolf wrote:
>> Am 08.10.2020 um 12:26 hat Philippe Mathieu-DaudÃ© geschrieben:
>>> On 10/7/20 3:11 PM, Pavel Dovgalyuk wrote:
>>>> On 07.10.2020 15:49, Philippe Mathieu-DaudÃ© wrote:
>>>>> On 10/7/20 2:20 PM, Pavel Dovgalyuk wrote:
>>>>>> On 07.10.2020 14:22, Alex BennÃ©e wrote:
>>>>>>>
>>>>>>> Philippe Mathieu-DaudÃ© <philmd@redhat.com> writes:
>>>>>>>
>>>>>>>> On 10/7/20 10:51 AM, Pavel Dovgalyuk wrote:
>>>>>>>>> On 07.10.2020 11:23, Thomas Huth wrote:
>>>>>>>>>> On 07/10/2020 09.13, Philippe Mathieu-DaudÃ© wrote:
>>>>>>>>>> Thanks, that was helpful. ... and the winner is:
>>>>>>>>>>
>>>>>>>>>> Â Â Â Â Â Â  commitÂ Â  55adb3c45620c31f29978f209e2a44a08d34e2da
>>>>>>>>>> Â Â Â Â Â Â  Author:Â  John Snow <jsnow@redhat.com>
>>>>>>>>>> Â Â Â Â Â Â  Date:Â Â Â  Fri Jul 24 01:23:00 2020 -0400
>>>>>>>>>> Â Â Â Â Â Â  Subject: ide: cancel pending callbacks on SRST
>>>>>>>>>>
>>>>>>>>>> ... starting with this commit, the tests starts failing. John, 
>>>>>>>>>> any
>>>>>>>>>> idea what
>>>>>>>>>> might be causing this?
>>>>>>>>>
>>>>>>>>> This patch includes the following lines:
>>>>>>>>>
>>>>>>>>> +Â Â Â Â Â Â Â  aio_bh_schedule_oneshot(qemu_get_aio_context(),
>>>>>>>>> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  
>>>>>>>>> ide_bus_perform_srst, bus);
>>>>>>>>>
>>>>>>>>> replay_bh_schedule_oneshot_event should be used instead of this
>>>>>>>>> function, because it synchronizes non-deterministic BHs.
>>>>>>>>
>>>>>>>> Why do we have 2 different functions? BH are already complex
>>>>>>>> enough, and we need to also think about the replay API...
>>>>>>>>
>>>>>>>> What about the other cases such vhost-user (blk/net), virtio-blk?
>>>>>>>
>>>>>>> This does seem like something that should be wrapped up inside
>>>>>>> aio_bh_schedule_oneshot itself or maybe we need a
>>>>>>> aio_bh_schedule_transaction_oneshot to distinguish it from the other
>>>>>>> uses the function has.
>>>>>>>
>>>>>>
>>>>>> Maybe there should be two functions:
>>>>>> - one for the guest modification
>>>>>
>>>>> aio_bh_schedule_oneshot_deterministic()?
>>>>>
>>>>>> - one for internal qemu things
>>>>>
>>>>> Not sure why there is a difference, BH are used to
>>>>> avoid delaying the guest, so there always something
>>>>> related to "guest modification".
>>>>
>>>> Not exactly. At least there is one non-related-to-guest case
>>>> in monitor_init_qmp:
>>>> Â Â Â Â Â Â Â  /*
>>>> Â Â Â Â Â Â Â Â  * We can't call qemu_chr_fe_set_handlers() directly 
>>>> here
>>>> Â Â Â Â Â Â Â Â  * since chardev might be running in the monitor I/O
>>>> Â Â Â Â Â Â Â Â  * thread.Â  Schedule a bottom half.
>>>> Â Â Â Â Â Â Â Â  */
>>>> Â Â Â Â Â Â Â  
>>>> aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
>>>> Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  
>>>> monitor_qmp_setup_handlers_bh, mon);
>>>
>>> I don't understand the documentation in docs/devel/replay.txt:
>>>
>>> ---
>>> Bottom halves
>>> =============
>>>
>>> Bottom half callbacks, that affect the guest state, should be invoked
>>> through
>>> replay_bh_schedule_event or replay_bh_schedule_oneshot_event functions.
>>> Their invocations are saved in record mode and synchronized with the
>>> existing
>>> log in replay mode.
>>> ---
>>>
>>> But then it is only used in block drivers, which are not
>>> related to guest state:
>>
>> Pavel can tell you the details, but I think the idea was that you need
>> to use this function not when the code calling it modifies guest state,
>> but when the BH implementation can do so.
>>
>> In the case of generic callbacks like provided by the blk_aio_*()
>> functions, we don't know whether this is the case, but it's generally
>> device emulation code, so chances are relatively high that they do.
>>
>> I seem to remember that when reviewing the code that introduced
>> replay_bh_schedule_event(), I was relatively sure that we didn't catch
>> all necessary instances, but since it worked for Pavel and I didn't feel
>> like getting too involved with replay code, we just merged it anyway.
> 
> That's right.
> Block layer does not touch guest by itself.
> But it includes callbacks that may invoke interrupts on finishing disk 
> operations. That is why we synchronize these callbacks with vCPU through 
> the replay layer.

Instead having to remember to use replay_bh_schedule_event when
guest state is modified else the code is buggy, what about expecting
replay used everywhere, and disabling its use when we know guest state
is not modified?

> 
> Pavel Dovgalyuk
> 



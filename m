Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17229C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 06:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF8F22249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 06:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHV6jc4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF8F22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV7Qf-0006Cd-Sm
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 02:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kV7Pt-0005ls-As
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 02:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kV7Pn-0001Dp-AF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 02:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603260962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdyHmrwI3HN5xJDTae9ggOq6QdXvYewk8xnKV0ICPKE=;
 b=NHV6jc4CHN3TAx+YDuAxr9bde7vLBaJseIj1bWmajvG8NGkiJkNpYohAu+tUraSqDwhLkS
 pjHbHACUyA1g3F/LaXJ+/K9ALft86XTuR+8yqNxHddqddrGvS0UirClzCbpPkNNZ8v/4Zy
 h0wFy0kg6pVEmXmFYgJp8UCb+n3acwQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-2U5-YSZdOnaRr0qsdki-eQ-1; Wed, 21 Oct 2020 02:15:58 -0400
X-MC-Unique: 2U5-YSZdOnaRr0qsdki-eQ-1
Received: by mail-ej1-f71.google.com with SMTP id c10so1232189ejm.15
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 23:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SdyHmrwI3HN5xJDTae9ggOq6QdXvYewk8xnKV0ICPKE=;
 b=DwhAELvuPi0jVw/nUdstAKQMWErZXOUX4mGM180eZZIycHBurzXKruSmkUg2ebjbyE
 R4WsHSurWQBiWZxaFJwHAXCxkWpBxHlaF5aIuj7D7OYD5l5Ik8YXRHIuS9oBgMy87hG1
 jQsLHtXbH8Jo0xBWZ/l/9/X469TutXtZvzfaTRKbUAkUEx0wVriMfFbDAh0kTb2tD+8k
 QLgYE/8havt4Ap5JgvQWsT3cNLQc5ERA3bwUi6TAEumYis/0reH0TdENl9S4KXxd+PJB
 LBcxof7VrUnFzgXSJjV/GFYnnc1gcWwnJ+fXTyN8eOSxBzHboHM3sUi0x9wWxikqfOk0
 D7qQ==
X-Gm-Message-State: AOAM530dxs8OCvJNN4I9sy2bdGaJG0BIQlCJhQgrLxqMuV18S5jZ/ZVg
 asRbKig/FrHOjO9MoCd/7Tb2+FeUrNcR0PZ6RED6kXXhpXyEMh+eSIJIHtKV1V/hrGC6fyDJwjO
 w7HR9Kf8UilA82pY=
X-Received: by 2002:a05:6402:3045:: with SMTP id
 bu5mr1544428edb.232.1603260957471; 
 Tue, 20 Oct 2020 23:15:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaPWbaHKBtNshgGsgrVUF9hkIqCSXzbN+TUn6vAzYgmmwrDo7bWsnArJJAybowuU185PXrzw==
X-Received: by 2002:a05:6402:3045:: with SMTP id
 bu5mr1544400edb.232.1603260957154; 
 Tue, 20 Oct 2020 23:15:57 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id f28sm1319159edc.94.2020.10.20.23.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 23:15:56 -0700 (PDT)
Subject: Re: [PULL v3 2/6] tests/9pfs: change qtest name prefix to synth
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1603111175.git.qemu_oss@crudebyte.com>
 <5436271.QZMOO6KbSo@silver> <20201020120057.42c85b2e@bahia.lan>
 <2028136.PJCruPdmoF@silver>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a32254c2-7428-0889-d76b-6bc35e2a619a@redhat.com>
Date: Wed, 21 Oct 2020 08:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <2028136.PJCruPdmoF@silver>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cristian,

On 10/20/20 1:54 PM, Christian Schoenebeck wrote:
> On Dienstag, 20. Oktober 2020 12:00:57 CEST Greg Kurz wrote:
>> On Tue, 20 Oct 2020 11:43:18 +0200
>>
>> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
>>> On Dienstag, 20. Oktober 2020 09:36:10 CEST Philippe Mathieu-Daudé wrote:
>>>> On 10/8/20 8:34 PM, Christian Schoenebeck wrote:
>>>>> All existing 9pfs test cases are using the 'synth' fs driver so far,
>>>>> which
>>>>> means they are not accessing real files, but a purely simulated (in
>>>>> RAM
>>>>> only) file system.
>>>>>
>>>>> Let's make this clear by changing the prefix of the individual qtest
>>>>> case
>>>>> names from 'fs/' to 'synth/'. That way they'll be easily
>>>>> distinguishable
>>>>> from upcoming new 9pfs test cases supposed to be using a different fs
>>>>> driver.
>>>>>
>>>>> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>>>> Message-Id:
>>>>> <e04e75acb849b085c6d6320b2433a15fa935bcff.1602182956.git.qemu_oss@crud
>>>>> eby
>>>>> te.com> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>>>
>>>> Harmless, but don't need to sign twice ;)
>>>
>>> Ah, I thought that's the common way, as Greg's PRs contained 2 SOBs as
>>> well, i.e. I thought this was intended to outline the patch author and
>>> submaintainer were the same person.
>>>
>>> BTW I actually did not explicitly add the 2nd SOB. It was rather added by
>>> the patchwork client automatically. So maybe it should be fixed in the
>>> client to detect an already existing SOB line? Or am missing something
>>> here?
>> Yeah this is the reason why my sob appears twice on patches authored by
>> me, and since this is harmless I never really investigated how to fix
>> pwclient :)
> 
> Well, I would usually offer my 'I can look at it' at this point, but I am
> reluctant this time as I assume it will end up as my recently suggested libqos
> patches where I did not get any response from the officially assigned
> maintainers; not even a simple 'nack'.

I was just watching your contributions and suggested an improvement
because something in your new workflow seems mis-configured (other
maintainers don't have this problem). I didn't asked you to fix a
bug in a different tool. I apologize if I was unclear and you
understood it this way.

Regarding your issue with a different series, I suppose you already
read:
https://wiki.qemu.org/Contribute/SubmitAPatch#If_your_patch_seems_to_have_been_ignored
and
https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor

You'll see that maintenance can be very time consuming, and we are
overcrowded from time to time when there is rush. I doubt maintainers
are ignoring your patches, as most of them try to do their best.
You might help them by reviewing patches for them, so they have time
to process your series.

Regards,

Phil.



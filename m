Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE4BC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A12B21655
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3YVlZJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A12B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnQI-0000BQ-4j
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHnOK-0007F1-NG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:15:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51324
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHnOH-0006SJ-Ft
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600085724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ycflhAXoRWUgwYduPeZuY0qfxZReiaU5fcdMS4yqFzE=;
 b=J3YVlZJPCf++l5Rv2g7kAyInDxubVF3omXts2QxrMYiECAz1p1DZK+jHqZvLhgQ/N5bfE7
 2Nickv1xAgZ7TzEvrU/r67OBCujfpM0fC4Ndiwwk93ncTvCeWxOiH2aBJxLUUKFHVBndUw
 veQWe0EsntlfZfIyHb5H3G7HKAtpLVQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-UC22CETDMKa3iJr8M7kAxw-1; Mon, 14 Sep 2020 08:15:20 -0400
X-MC-Unique: UC22CETDMKa3iJr8M7kAxw-1
Received: by mail-wr1-f70.google.com with SMTP id 33so6806942wrk.12
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ycflhAXoRWUgwYduPeZuY0qfxZReiaU5fcdMS4yqFzE=;
 b=EgtoexgeeIan8XZlWttALVvGOfrpoTgD/HqEOLXDwxoTCHUI4d0yaD7iZgpdIL1psh
 p/WNjqLa5uzSQLF2pAHKo43OUpAsUS7LPSEXnL+PKpIxa9xmqVTYvrDhedG2mfmcejG/
 dK18X/rq7rcrREdsp/DItze+iw6vPsFS8tfuntpGNKll/Ifv6ZnlkzLkBC1xV5OfyRXB
 fMqxuFRPL1XfmK6m7X+8TkI1/7tHRGF0FBEfQhomzL9ar0zXDhIjJwLvF802NdYIow0N
 2enlfgY2lAwYi6Zd6MN/hOIU1mSMwfn9B9AbpW6MZ34zEzWFpKGcoVewXlAn/SxYODgX
 I2Ig==
X-Gm-Message-State: AOAM5335iD62ce7IT3jfvLM3x1va5aAyVRPIhfeRUJzEDnPU+GiFvYRF
 z2IyytmdkVO0mA/3abomz2tfnzP719V64E3j5UXwy7dCBSjRTQ8vH6zu1Kp6SQMltUpc8MJIAzp
 7dGjrgoObbtEJSoA=
X-Received: by 2002:a1c:4943:: with SMTP id w64mr14339556wma.62.1600085719307; 
 Mon, 14 Sep 2020 05:15:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhhE/Q6s5ubOymy78A0se2Q0Zsj/F5ZGFK7gU8Z36Asqn5Q/pFaCa0ONUDY4/UyBbpo2pneQ==
X-Received: by 2002:a1c:4943:: with SMTP id w64mr14339538wma.62.1600085719101; 
 Mon, 14 Sep 2020 05:15:19 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id j7sm20673692wrs.11.2020.09.14.05.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 05:15:18 -0700 (PDT)
Subject: Re: [PATCH v5 3/8] qapi: Restrict balloon-related commands to machine
 code
To: Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>
References: <b9401e89-2598-74f7-5e92-885c522b7599@redhat.com>
 <CD01CCE8-2E17-4234-82E8-37DE94E62DD3@redhat.com>
 <87lfhcppsx.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <d446f5a6-2547-b32b-75dd-f38410effc57@redhat.com>
Date: Mon, 14 Sep 2020 14:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87lfhcppsx.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 1:21 PM, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>>> Am 14.09.2020 um 11:42 schrieb Philippe Mathieu-Daudé <philmd@redhat.com>:
>>>
>>> ﻿+Laurent and David
>>>
>>>> On 9/14/20 11:16 AM, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>>
>>>>> Only qemu-system-FOO and qemu-storage-daemon provide QMP
>>>>> monitors, therefore such declarations and definitions are
>>>>> irrelevant for user-mode emulation.
>>>>>
>>>>> Restricting the balloon-related commands to machine.json
>>>>> allows pulling less declarations/definitions to user-mode.
>>>>
>>>> How this affects user mode is not obvious to (ignorant) me.  Can you
>>>> provide a clue?
>>>
>>> I guess this was discussed with David at some point.
>>>
>>> Maybe the QMP commands are not exposed via HMP, making this
>>> code unreachable?
>>>
>>> Anyhow user-mode binaries don't use the memory ballooning feature,
>>> this is specific to system-mode emulation.
>>>
>>> Laurent/David, do you have some more trivial explanation?
>>
>> Agreed.
>>
>> No memory ballooning device -> no memory ballooning :)
> 
> I understand why user mode doesn't need device models.  What I don't
> understand offhand is how balloon-related stuff in misc.json ends up
> pulling "declarations/definitions to user-mode".  What exactly is being
> pulled where before the series, and no more afterwards?
> 
> Is it just the code generated for the QAPI stuff you move, or is it
> more?

As of this series, this is only QAPI generated code.
(code which pulls in unwanted declarations/definitions
that should be poisoned, but we can't because of this).

I didn't feel the need to enumerate what is removed from
user-mode, because from the diff (and no link failure)
I thought it was obvious. I can do, but that would be
simply copy/pasting the QAPI changes.

Part 3 start to remove things, but I kept that separated.



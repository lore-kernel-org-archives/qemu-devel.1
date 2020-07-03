Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44665C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FED206BE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hp/xkMq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FED206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGYB-0000lf-BC
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 03:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrGXb-0000A2-LS
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:55:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrGXZ-0005KU-T9
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593762921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cg6IXIv//ETs0sfhqMJNiWVEYzUQlnfqdx6klhaw+r8=;
 b=Hp/xkMq4FKqoMKMnDFE2YUwR3P9VwPllzMSSGRgjwKMKPh9an79rfC5R4BNQ1zuPcDCiH0
 TQQWBj08UmCXDc0DEePWYaIQiDdLheoN4seZNziUhpl8T1FoeaKEiBsFFnNHlnquBRZxEc
 sFRVx7rx2oOfgk+9sON6RztKnCZXTg0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-AkUmnbiWMzek0Pz_nIyxWQ-1; Fri, 03 Jul 2020 03:55:19 -0400
X-MC-Unique: AkUmnbiWMzek0Pz_nIyxWQ-1
Received: by mail-wr1-f70.google.com with SMTP id b8so16962582wro.19
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 00:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Cg6IXIv//ETs0sfhqMJNiWVEYzUQlnfqdx6klhaw+r8=;
 b=LHIteshvb/BFpDIGUb7HS/HBytx6jzuqmQedP+Qp66uLH1Eg2g728v0+wGx2+kVTAj
 5g2xGUfqQ4FqdjE78S7q8rdEwi6ILq3Y3OeWpqWUnGjMNeOitYkaOkhAC7GgPG69/PUp
 hdoBTTLH4tRWW2LmvMgQuq7BAUmPGsaIigUSnIdlz/rUIPQE/3wZ9HqamnLoWds+rA5x
 CIoCntq55crCnjM+0QFFZSKq8r6sxcKsFQDeinbVYF3wHNZV83N9eM+f7N1u3XAY2i0s
 WFoBPwcTVpE+q1u3Xq3g8WOgwCW98wCXQWQqjuxURVo9O+5rYm30gDZ/1KHpjhVGh/Dh
 QwLg==
X-Gm-Message-State: AOAM533JTVXTVXd+bbnGIRcRDah/Hn6wxeIlbS+QxxdDvVxgK3PUF3Fb
 dIvxgMs6xA55B26gY0+W+uKKsMKLuJEdezUxpnwDm0TA4PnJEMhJO83tONzbQoPHjlUAdjkyxg+
 k2UBBSePDa498kcg=
X-Received: by 2002:a1c:7311:: with SMTP id d17mr24593836wmb.60.1593762918354; 
 Fri, 03 Jul 2020 00:55:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOj/yJRTnXb7dzsi4366NFR2ld0ZeMm32u1PQpRQOo9uOs6ytZJVXEngz8GwqhMWzGtXNMLg==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr24593823wmb.60.1593762918144; 
 Fri, 03 Jul 2020 00:55:18 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 65sm13923026wre.6.2020.07.03.00.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 00:55:17 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/block/nvme: handle transient dma errors
To: Kevin Wolf <kwolf@redhat.com>
References: <20200629202053.1223342-1-its@irrelevant.dk>
 <159346486377.15477.6186679362319226240@d1fd068a5071>
 <20200629213408.qlehce2mtgqodqd6@apples.localdomain>
 <30b8117f-25bd-e50b-98cb-db2e0a2690d0@redhat.com>
 <20200703075059.GA5285@linux.fritz.box>
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
Message-ID: <08564e95-2ccf-2b1b-e8cb-64a3dedca668@redhat.com>
Date: Fri, 3 Jul 2020 09:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703075059.GA5285@linux.fritz.box>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, k.jensen@samsung.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, kbusch@kernel.org, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 9:50 AM, Kevin Wolf wrote:
> Am 01.07.2020 um 14:58 hat Philippe Mathieu-DaudÃ© geschrieben:
>> On 6/29/20 11:34 PM, Klaus Jensen wrote:
>>> On Jun 29 14:07, no-reply@patchew.org wrote:
>>>> Patchew URL: https://patchew.org/QEMU/20200629202053.1223342-1-its@irrelevant.dk/
>>
>>>> --- /tmp/qemu-test/src/tests/qemu-iotests/040.out       2020-06-29 20:12:10.000000000 +0000
>>>> +++ /tmp/qemu-test/build/tests/qemu-iotests/040.out.bad 2020-06-29 20:58:48.288790818 +0000
>>>> @@ -1,3 +1,5 @@
>>>> +WARNING:qemu.machine:qemu received signal 9: /tmp/qemu-test/build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,path=/tmp/tmp.Jdol0fPScQ/qemu-21749-monitor.sock -mon chardev=mon,mode=control -qtest unix:path=/tmp/tmp.Jdol0fPScQ/qemu-21749-qtest.sock -accel qtest -nodefaults -display none -accel qtest
>>>> +WARNING:qemu.machine:qemu received signal 9: /tmp/qemu-test/build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,path=/tmp/tmp.Jdol0fPScQ/qemu-21749-monitor.sock -mon chardev=mon,mode=control -qtest unix:path=/tmp/tmp.Jdol0fPScQ/qemu-21749-qtest.sock -accel qtest -nodefaults -display none -accel qtest
>>
>> Kevin, Max, can iotests/040 be affected by this change?
> 
> The diffstat of this series looks like it doesn't touch anything outside
> of the nvme emuation, which isn't used by this test, so at least I'd say
> it's not the fault of the patch series.
> 
> I think test cases use SIGKILL primarily in timeout handlers, so maybe
> the test host was overloaded and didn't shutdown QEMU in time so it was
> killed. There is no actually failing test case:
> 
>  ...........................................................
>  ----------------------------------------------------------------------
>  Ran 59 tests
> 
> You would have 'F' or 'E' for fail/error instead of '.' otherwise.

TIL how to read that line :)

Thanks for your analysis Kevin!

> 
> Kevin
> 
>>>
>>>
>>> Hmm, I can't seem to reproduce this locally and the test succeeded on
>>> the next series[1] that is based on this.
>>>
>>> Is this a flaky test? Or a bad test runner? I'm of course worried when
>>> a qcow2 test fails and I touch something else than the nvme device ;)
>>>
>>>
>>>   [1]: https://patchew.org/QEMU/20200629203155.1236860-1-its@irrelevant.dk/
>>>
>>
> 



Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C402C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0042D20760
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eq4aTgz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0042D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLnK-0007lh-8X
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiLm6-00077f-AE
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:41:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33387
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiLm4-0000x9-Vr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591638088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZtoVXEDo5CrucRAtuYS9Wn21HPqpAX7NqqUUzHvlsJM=;
 b=eq4aTgz1Y+ZSXBlU/vzwqvYVyr832UTAmFaA3diI/TGO172hs0SogmE5KaNJ/TwPWSNHks
 hzgHTIMi6DDt/KGe8XMe8QE/6gR1hiBD562uXU4fw+KIN242itCrSJnn8CKI14yovMOL4Y
 XakJdsFRsOo4HLpQM+L0JAUNqw69gCU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-nlSNgRZQOeKHhu3eCOlkWg-1; Mon, 08 Jun 2020 13:41:12 -0400
X-MC-Unique: nlSNgRZQOeKHhu3eCOlkWg-1
Received: by mail-wr1-f69.google.com with SMTP id r5so7472385wrt.9
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 10:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZtoVXEDo5CrucRAtuYS9Wn21HPqpAX7NqqUUzHvlsJM=;
 b=a4cLu7Kx64LmNq17hTI+hybYSnKWMW4uPZG5vzsK2IAQt9W4xlnRo4eRN+vrXxqfjx
 NJL4xXUPimvO2GpyjsxScSXtPg4+Z0QiLIxcFShdsxWgovoLT6lx6mo48/LLrao9WZkP
 w44aZXJzzIbVpkYF43gOvUR2Pzk4HJD/BaoOCj2eSQQpAjDHBVIVTRmRDfQWBsVT9mwF
 Sk2Zpk7YJVYUVq1Mmg6AkYaQt3vuzm+T9OYP5irzWyYuGiXFaeHffxoiCIccK20AhVdm
 4E82W84JyOPK8AsiCrJZBQA8pGEfNIKesy0HXi4N4BpUD6kW7DwiJ4NU72UaU1rdJxex
 CMmQ==
X-Gm-Message-State: AOAM532Gk4B6YM/v5n7Cz8t95voWcnE7LAe82j/B3U0isZZN+TdM39aN
 nSu4TlemN3PE+bfuUkmtDa1t9IssXC5plkzA9sxJbFM/Fb7LteVBm6c8ncFNQmBpLQSr0pRgXnC
 zgO2KTDbI45s4O50=
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr460909wmf.18.1591638071679; 
 Mon, 08 Jun 2020 10:41:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiKmNkocnJj8CIs4JSu/2jEMg01FxOt3OBu/eUfZdtSTJYaui1nDmOqI7woIcS8j3VFlYhHA==
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr460884wmf.18.1591638071482; 
 Mon, 08 Jun 2020 10:41:11 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z206sm239284wmg.30.2020.06.08.10.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 10:41:10 -0700 (PDT)
Subject: Re: [PATCH v3 00/16] python: add mypy support to python/qemu
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
References: <20200604202236.25039-1-jsnow@redhat.com>
 <20200605092630.GE5869@linux.fritz.box>
 <502e4f4d-6770-61a7-1496-9cb244f9ddd3@redhat.com>
 <20200608153327.GD6419@linux.fritz.box>
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
Message-ID: <130e4383-8c33-c3f2-55b2-1ec45a5214cc@redhat.com>
Date: Mon, 8 Jun 2020 19:41:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200608153327.GD6419@linux.fritz.box>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 5:33 PM, Kevin Wolf wrote:
> Am 08.06.2020 um 17:19 hat John Snow geschrieben:
>>
>>
>> On 6/5/20 5:26 AM, Kevin Wolf wrote:
>>> Am 04.06.2020 um 22:22 hat John Snow geschrieben:
>>>> Based-on: 20200604195252.20739-1-jsnow@redhat.com
>>>>
>>>> This series is extracted from my larger series that attempted to bundle
>>>> our python module as an installable module. These fixes don't require that,
>>>> so they are being sent first as I think there's less up for debate in here.
>>>>
>>>> This requires my "refactor shutdown" patch as a pre-requisite.
>>>
>>> You didn't like my previous R-b? Here's a new one. :-)
>>>
>>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>>>
>>
>> I felt like I should address the feedback, and though I could have
>> applied the R-B to patches I didn't change, it was ... faster to just
>> re-send it.
>>
>> Serious question: How do you apply people's R-Bs to your patches? At the
>> moment, it's pretty manually intensive for me. I use stgit and I pop all
>> of the patches off (stg pop -n 100), and then one-at-a-time I `stg push;
>> stg edit` and copy-paste the R-B into it.

wget https://patchew.org/QEMU/${MSG_ID}/mbox
git am mbox

Where ${MSG_ID} is the Message-Id of the series cover letter.

>>
>> It's easier when I'm just pulling other people's patches from the ML,
>> the patches tool handles it for me. It's updating my own patches that's
>> a drag and prone to error.
> 
> It's a manual process for me, too. Just that I don't use stgit, but
> 'git rebase -i'.
> 
> Kevin
> 



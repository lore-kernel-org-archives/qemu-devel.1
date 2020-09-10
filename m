Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24730C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979FD20882
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gj6iN3bX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979FD20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSHl-0002Tl-Gm
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGSGg-0001pR-1j
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:30:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGSGd-0006Ju-Mc
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599766198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BHkMIgOZBG+wH8xR/xeeDlfdmsFL2cbLSgJVvx3u7Co=;
 b=Gj6iN3bXHqcM0NsFsfI0YmL9RVcECx9xeZlgOapyrkbLT7cZArykE7IgE6CIoWQLQXZOVJ
 UepR0PPY+TrkoDWx7g+IICugTd2v4/oTkp+yozuljltygd07AqjIMWfn8EdpNVbXuzmHhb
 PHH5qq4PSJ4tet7+40KKRLAQ7TKbVs0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-EywBEzUDNFWD34e9bGAdUw-1; Thu, 10 Sep 2020 15:29:47 -0400
X-MC-Unique: EywBEzUDNFWD34e9bGAdUw-1
Received: by mail-wr1-f72.google.com with SMTP id o6so2594731wrp.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 12:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=BHkMIgOZBG+wH8xR/xeeDlfdmsFL2cbLSgJVvx3u7Co=;
 b=htWTOGFrVLBeBf8VRqu9RA0bD1hIj241DKh8zEz+LuWGbW3h1trnaDyEMRIP12XmQY
 2elC/u7w0xSz8Wkvz56pBCK/Q8wTOLjCbTUxJENdJyWkSyXLvjLMqP3pJ0/0cNOBQ4p4
 3TDO9O5T6dFt/SwMFJZ3EHGIXww8/Xp6rLLjMCSJehi6e2Jq5eLrhPpL/ZGn3Evg4xHh
 6o3HsXdjjBJgUZG/lHB5dMehk7Zco+oFmvjhJ5raMnkzaemGSOrvJIR/haJ8hvb5HqPu
 fZeBm8wabTEyIwD54Mgh1nSW0IUk3fhLdYrNjjhmPquVVUWwkhhtiy/lNq+6dSEmYT8o
 7z4Q==
X-Gm-Message-State: AOAM531ZEnU47Y4Wt2gD+G8dHZz5fc5oaCDbFYLYJH9kASwcfbcLuVK1
 9dlWDc2j9ld9ri7VO4B+wN4udCN+i+6AyH1XUw3qteAEO83jU8wbLFU28S1IJzMf7Sl97FiHi2i
 jow5bogaJE58YxeE=
X-Received: by 2002:a1c:e108:: with SMTP id y8mr1513892wmg.179.1599766185694; 
 Thu, 10 Sep 2020 12:29:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1wb1d+Y578nOboV2mqGJWOh2HcEO5S8qir7ZVXVHk+Mnqmgva/25zhXzIErecXCGScs++Pg==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr1513861wmg.179.1599766185355; 
 Thu, 10 Sep 2020 12:29:45 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m4sm11168187wro.18.2020.09.10.12.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 12:29:44 -0700 (PDT)
Subject: Re: [PATCH 00/77] Patch Round-up for stable 5.0.1, freeze on
 2020-09-10
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
 <70866614-8053-4a87-b3a6-c7448dcff56f@redhat.com>
 <159976179054.29065.10842850828338907813@sif>
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
Message-ID: <0d47b817-3160-df88-2939-e14bb6c446d0@redhat.com>
Date: Thu, 10 Sep 2020 21:29:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <159976179054.29065.10842850828338907813@sif>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 8:16 PM, Michael Roth wrote:
> Quoting Philippe Mathieu-Daudé (2020-09-04 04:20:00)
>> On 9/3/20 10:58 PM, Michael Roth wrote:
>>> Hi everyone,
>>>
>>> The following new patches are queued for QEMU stable v5.0.1:
>>>
>>>   https://github.com/mdroth/qemu/commits/stable-5.0-staging
>>>
>>> Patch freeze is 2020-09-10, and the release is planned for 2020-09-15:
>>>
>>>   https://wiki.qemu.org/Planning/5.0
>>>
>>> Please respond here or CC qemu-stable@nongnu.org on any additional patches
>>> you think should be included in the release.
>>
>> Candidates:
>>
>> b638627c723 ("hw/sd: Fix incorrect populated function switch status data
>> structure")
> 
> I get the following breakage with this patch applied, and also see the
> error upstream, so I've left these out for now:

Thanks, confirmed :/

> 
>   mdroth@sif:~/w/qemu-build2$ AVOCADO_ALLOW_LARGE_STORAGE=1 tests/venv/bin/avocado run -t machine:orangepi-pc tests/acceptance/
>   /home/mdroth/dev/kvm/qemu-build2/tests/venv/lib/python3.6/site-packages/avocado/plugins/run.py:214: FutureWarning: The following arguments will be changed to boolean soon: sysinfo, output-check, failfast, keep-tmp and ignore-missing-references.
>     FutureWarning)
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_initrd
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_initrd
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_sd
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_sd
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bionic
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9
>   JOB ID     : 1efcdbf82a9cb1313078641c403802980018b53d
>   JOB LOG    : /home/mdroth/avocado/job-results/job-2020-09-10T11.08-1efcdbf/job.log
>    (1/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi: PASS (4.41 s)
>    (2/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_initrd: PASS (17.86 s)
>    (3/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_sd: PASS (51.11 s)
>    (4/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bionic: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n{'name': '4-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bionic', 'logdir': '/home/mdroth/avocado/job-results/job-2020-09-10T11.08-1efcd... (90.58 s)
>    (5/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n{'name': '5-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9', 'logdir': '/home/mdroth/avocado/job-results/job-2020-09-10T11.0... (90.64 s)
>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2 | CANCEL 0
>   JOB TIME   : 255.19 s
>   JOB HTML   : /home/mdroth/avocado/job-results/job-2020-09-10T11.08-1efcdbf/results.html



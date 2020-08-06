Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EF1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACA9221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFaHPmoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACA9221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dPd-0006vJ-E0
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3dOJ-0005MH-HR
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:44:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3dOG-0007Hk-Su
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596710691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qGlc93/gOoQJE0NHjYFr0HLC7OORJMHDTpVrqjUMGUY=;
 b=CFaHPmozG/eA0syT/M6it7ievs3/cYu+Oe8VlpjiWjv3yx/lb7W5flluX41L7yNcUXAbpj
 vQhtyEtqWp0iYXfQASkl3WDTbTPtOua5yJtRTzUCCONOfvTPdMvPjfANxEOvS/RJZphLXz
 2fdJL5w93rdIJyVy39iVA2tSELwJ678=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-bbdJQzQ6MBWM7xwAE1i7nQ-1; Thu, 06 Aug 2020 06:44:49 -0400
X-MC-Unique: bbdJQzQ6MBWM7xwAE1i7nQ-1
Received: by mail-wr1-f72.google.com with SMTP id e12so14647689wra.13
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qGlc93/gOoQJE0NHjYFr0HLC7OORJMHDTpVrqjUMGUY=;
 b=b2zPNJJxmdymxEyU5r+u/cZIB3vAenlQhRidhjCeI6JOz//26XfgDJRIRtWcWPqCSP
 6wPJC9cWAFemHyYhVx7lESqzfCasKKm0YGhqjKkYlY+jYw0TFJVtFAR+tAd6fL0s2UdH
 Xy27WVCheqAhDfR2mJynnNmJDBZe3B9oj4FJq3/MGeoSi+XpvmAcV2my/K0Nsnihycd2
 V60COBMSrmPOI/+0j5c3u6niuk9gHypZJ9dFd2J9vFwApczFndaXrVkcAtaaFjmppJ+7
 MjbZHPk5sugP0Pc8IealQwsbpjz8jUzjBRtUGhCgpd7MsaURMjB28VjLqCtcKogh5Fff
 wZkQ==
X-Gm-Message-State: AOAM533Fr5ufPg0iNQxwQclIbPLjnYENwNpGYJ5NXhxlNaWj5yZh3rrY
 V/E0R+V1LQnD2Xh/jS6LOpCanW0MJDn+J5xxYqdX2nQ30PhMNAhdUidCtr/RIf6X1VwvBHYqkv0
 bQVniDtpplxrUXl4=
X-Received: by 2002:a7b:c401:: with SMTP id k1mr7210077wmi.18.1596710686958;
 Thu, 06 Aug 2020 03:44:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXoW3yXCRWYxydr8l4LttUu5UiGb8jRUAfphhfpD43IbdUd5JdJ6v7/N9ECWGIk9S+owyIAg==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr7210059wmi.18.1596710686719;
 Thu, 06 Aug 2020 03:44:46 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id i14sm7095032wrc.19.2020.08.06.03.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 03:44:45 -0700 (PDT)
Subject: Re: [PATCH 1/1] qga: add command guest-get-disks
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
References: <cover.1596704579.git.tgolembi@redhat.com>
 <c6994b4db0f59b487f235aca692ca3430317ea2b.1596704579.git.tgolembi@redhat.com>
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
Message-ID: <bd4987e4-606b-6d52-4d59-602df71f6fb0@redhat.com>
Date: Thu, 6 Aug 2020 12:44:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c6994b4db0f59b487f235aca692ca3430317ea2b.1596704579.git.tgolembi@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 11:03 AM, Tomáš Golembiovský wrote:
> The command guest-get-fsinfo can be used to list information about disks and
> partitions but it is limited only to mounted disks with filesystem. This new
> command allows listing information about attached root disks of the VM. This is
> usefull for management applications for mapping virtualized devices or
> pass-through devices to device names in the guest OS.
> 
> Output is similar to the list of partitions of guest-get-fsinfo, except that
> the disks are mapped instead of partitions.
> 
> Example output:
> 
> {
>   "return": [
>     {
>       "serial": "SAMSUNG_123456789",
>       "bus-type": "sata",
>       "bus": 0,
>       "unit": 0,
>       "pci-controller": {
>         "bus": 0,
>         "slot": 31,
>         "domain": 0,
>         "function": 2
>       },
>       "dev": "/dev/sda",
>       "target": 0
>     },
>     ...
>   ]
> }
> 
> Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c | 91 +++++++++++++++++++++++++++++++++++++++++++-
>  qga/commands-win32.c | 83 ++++++++++++++++++++++++++++++++++++++++
>  qga/qapi-schema.json | 13 +++++++
>  3 files changed, 186 insertions(+), 1 deletion(-)

Not sure this is better, but splitting this in 3 could help different
people reviewing (developers not familiar with the Windows API might
feel not comfortable adding a R-b tag for the POSIX part, and
reciprocally).

1/ qapi + stubs
2/ POSIX implementation
3/ Win32 implementation



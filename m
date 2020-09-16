Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA964C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7C2206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7RA+iu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7C2206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISdD-0006PQ-AT
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIScQ-0005Ot-EJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIScN-0004UZ-Jo
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600244202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0Yh9xdfCzuciSNTS76MNbTzou5+9Kqf2xY5MhJDxKBw=;
 b=c7RA+iu2lXjLjrMqyw5ZgR5QYV43praFZA7f+X9CTEQJebEZYvRy3BHaT6sGgpFFlv8VIQ
 QzqO6Fv9NdJbNGT4K/SyV1v8IidJ1E5gFjCuc7bbXF41HKFqcINez3Y0N6OqFVSUfFxAqR
 OJaBrMNGarAgjIJL0dcDCamLq9gtaUY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-WQeB5WeCP4GIewU4wW14mw-1; Wed, 16 Sep 2020 04:16:39 -0400
X-MC-Unique: WQeB5WeCP4GIewU4wW14mw-1
Received: by mail-wm1-f71.google.com with SMTP id s24so549598wmh.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 01:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0Yh9xdfCzuciSNTS76MNbTzou5+9Kqf2xY5MhJDxKBw=;
 b=WR3WHN0adl20Fcqb1bsjrK5gm5gLoqf711nj2RCImYKv17iDgwBt6k68vpPrsSqeD+
 Ff6nVx4gTOx7jghECtHztrIL3ETs/jc0nJd+h3sFkkNlpI/f+JD6xOBabMyK+CKvJyPO
 677IVjZKGKfSl3PSItPtvtJq4tQqk/RaaPhG6zVa+MsHB4kQ9Y3rRmxHxwESRsQUsDsO
 Sm/HpPwvIUkWyGS2bWEVuP/PM+OaYS6qVPXs9KInfMC37VGoI3rDWcZLeFYUDGuf23Zr
 gZlqmuT8GR/XH1cGJZc6rwqRlCgJS807BrT/JEeuKg5vFjR/Eu56JpfQpG79s0IfDle3
 /TvQ==
X-Gm-Message-State: AOAM531tzJd2cdi2N6RKsIimmuAtkrsddQessK1oLWhXDHiOyKp6qFxd
 bLhJhvHMMm4k2kY5PdrllgPf+NP1P3Pi8MhyQEa44Q1skJR4A7BzQYt+P9bmT8Eq91wmjgy+Xn9
 zyoa9gIOfsQiK288=
X-Received: by 2002:adf:9c93:: with SMTP id d19mr26011456wre.275.1600244198390; 
 Wed, 16 Sep 2020 01:16:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN6hgiRcJRhdIopa7sRn7LG2A+0rxQJofEKY/qTIPu/UJeLWC+Wj0I2N5f/6CAtfBmTX7m9Q==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr26011432wre.275.1600244198202; 
 Wed, 16 Sep 2020 01:16:38 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i3sm31080315wrs.4.2020.09.16.01.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 01:16:37 -0700 (PDT)
Subject: Re: Python 3.5 EOL; when can require 3.6?
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <495bd2bd-4f38-8fe2-e758-82acbecd0d04@redhat.com>
 <436800a3-7645-52f7-5fea-134d883c0a7b@redhat.com>
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
Message-ID: <4c9c74a7-9fed-b90a-f0cf-1b791c9b4cb5@redhat.com>
Date: Wed, 16 Sep 2020 10:16:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <436800a3-7645-52f7-5fea-134d883c0a7b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 10:02 AM, Thomas Huth wrote:
> On 16/09/2020 09.53, Philippe Mathieu-Daudé wrote:
>> On 9/16/20 9:43 AM, Markus Armbruster wrote:
>>> We require Python 3.5.  It will reach its "end of life" at the end of
>>> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
>>> already does for its Python parts.
>>>
>>>
>>> [*] https://www.python.org/downloads/release/python-3510/
>>
>> Not answering your question, but it would help to start a table
>> of "oldest package released" versions, with our supported distributions
>> as columns and package names as row.
>>
>> This way when new distributions are released (and oldest dropped from
>> our side) we can add/remove a column and see the oldest version we aim
>> to support.
> 
> That's quite a bit of extra work - I think it's enough to look up the
> versions on repology instead, e.g.:
> 
> https://repology.org/project/python/versions

Clever :) So maybe we can script that.

> 
>  Thomas
> 



Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572B8C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14F92072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SydNvWff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14F92072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoDz-0005Cz-RV
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIoCl-0004Ia-8F
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIoCg-0001Di-GV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600327177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qeSl6k6hauEbNZ6bSrEAPvGnE47CLrfVrhR41SsW1mA=;
 b=SydNvWff6s8cm6FZoi2ySVPe/pbUk6+c3aE2P6AzU8FV4Vhmbjn7Mo++RYWVa/UVmnM5DV
 JCXMV3wSnCQRlg6O27az8gBp70cmKYb4bBYoeDFUMWkdRZYVnaO6yrd4stPfIUGVsUa50J
 VP4qXJfBYOQ0Q0nJg+weQ8sAYvlbvzk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-Q-LjZeJiNM-PD9y1ujFvEw-1; Thu, 17 Sep 2020 03:19:36 -0400
X-MC-Unique: Q-LjZeJiNM-PD9y1ujFvEw-1
Received: by mail-wr1-f72.google.com with SMTP id r16so507930wrm.18
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qeSl6k6hauEbNZ6bSrEAPvGnE47CLrfVrhR41SsW1mA=;
 b=jTgkK65u7zZFYFlLRf0H8c2/oM2SGblyjhXowb623Xk54NNwcLbIM2UIEtbPa4qRpV
 ny0Ze89Pv1uLGznKF3qTfINFy08mNwEErhGW+u6ufy384Ne8x+R8BQdauQqRyUm1ziYT
 kTsXiHAD1qySwNV7TwUCpbIy37U2Fy7Jwh1H/otNelK/8qDDgBo77O4E3Vfd9HWuNzd6
 3+2RFzDb6sXBhbXUIMVW+GasBn49RWSFRKTClRX4jnNrnAgbuv5IajK445zT+FOGlRw/
 5nhkLkclChrYUZLNF4P7/NxzFo0iKHy/z9SHUh9ROzAImI8wPXIogCVLlwxdh0cWg1sF
 Wy1g==
X-Gm-Message-State: AOAM532sKlNDbHdeHOz9znOVtgkN7ZJ7ohYjygCrT8zpc4hd7pXvDJ0z
 ik+vEtqvsaTFAaYZbdXvQ3fvm0A23ZGZsujQhIGfvse8OEmXnSoTZ4tLUAgI6poufdEVx5hVNOq
 EK0ExZjVyWh7OAUM=
X-Received: by 2002:a05:600c:2252:: with SMTP id
 a18mr9069739wmm.154.1600327171514; 
 Thu, 17 Sep 2020 00:19:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyma22C0tJDb37dyRtes+F6vuDVtFZbxt3Yx/IEAnwhXWROSgyyfIuBeJg5dk//cvpnAIll+w==
X-Received: by 2002:a05:600c:2252:: with SMTP id
 a18mr9069711wmm.154.1600327171231; 
 Thu, 17 Sep 2020 00:19:31 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 2sm9233676wmf.25.2020.09.17.00.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 00:19:30 -0700 (PDT)
Subject: Re: [PATCH 0/3] qom: Replace INTERFACE_CHECK with OBJECT_CHECK
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200916193101.511600-1-ehabkost@redhat.com>
 <CAJ+F1CLo=mz6LhRTx0PTF-NiabiaCNwm-U=7VEhQXUmryQoqvw@mail.gmail.com>
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
Message-ID: <40730966-469a-de4d-29bd-03c7c409b3cf@redhat.com>
Date: Thu, 17 Sep 2020 09:19:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLo=mz6LhRTx0PTF-NiabiaCNwm-U=7VEhQXUmryQoqvw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 11:31 PM, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Sep 16, 2020 at 11:35 PM Eduardo Habkost <ehabkost@redhat.com
> <mailto:ehabkost@redhat.com>> wrote:
> 
>     This series replaces INTERFACE_CHECK with OBJECT_CHECK because
>     both macros are exactly the same.
> 
>     The last patch is a new run of the OBJECT_CHECK ->
>     DECLARE*_CHECKER* converter script that will convert the former
>     INTERFACE_CHECK-based macros.
> 
> 
> Well, at least having a different macro allows to tweak qom
> implementation or replace it with something different more easily.
> 
> I have some wip branch somewhere where I actually made Interface a
> different beast than Object (it was saving some fields, and avoiding
> some potentially wrong casts iirc - I didn't bother to upstream that
> yet). Also I have a different branch where I played with GObject to
> replace qom. In both cases, your proposal would have, or would make, the
> work more complicated.

Considering "wip branch not bothered to upstream" as "fork",
your comment from [*] applies here...

  You can't blame upstream from doing cleanups and modernization, or
  stagnating. Forks are forks, with all the pain they carry. If they
  want to avoid the maintenance cost, they have to do the extra effort
  to get it upstream. This is also a "sneaky way" to remind them that
  effort is better spent in this direction.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg720284.html



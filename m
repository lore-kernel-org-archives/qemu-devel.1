Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B041C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3D02053B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKpCk+4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3D02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Sgf-0007ks-7m
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0Sg2-0007D4-8g
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:42:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26442
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0Sfz-0005jc-WD
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595954523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VQJeN45hknZBCgWJDhu8xNs7llVTlBmMr/y4KF1oyZ0=;
 b=TKpCk+4fTlXzZyCWqD/Ce5fXEavuFergkn0N9qzGOVBtVWP4bdRIarpIWBD37qb+DyBoYU
 Jp1M4V6dU1Orprt7KaSoSU6qV8NfCaIH+2brMYVbZj/2+TkUQinpD0+wVKL+jDbd0qe41T
 Gf0eAjIVcere2ADenZmpDv0zQ5JKSCM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-sn-0WfXwOk2qHGn-Yi7bRg-1; Tue, 28 Jul 2020 12:42:01 -0400
X-MC-Unique: sn-0WfXwOk2qHGn-Yi7bRg-1
Received: by mail-wr1-f70.google.com with SMTP id w7so3227320wre.11
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=VQJeN45hknZBCgWJDhu8xNs7llVTlBmMr/y4KF1oyZ0=;
 b=HJWCPyNdZWYgva/XeCNT7jgCLwQswfLmeEiHpcwBQzpBREuTwh2am2rWcNiQxJrQ+b
 Rgd8pZ6YHms9OS+f16ufnDxoCwogcO9es/qypFRggHMVDzU3kYhayZ0mnRZO7pQ6s9VO
 mSv/nk84jzTkvMq43/hW6sEK/ylCw4wodTjLAW0bE3mvoi8MM3ZTIpZWLM90p1g0TrZx
 TTZM7MAk5qSLMNfcj/uSI8o1yIhbDHuAPtBZVkk7OhtOBhRol1G/UsfMR4edsavXN+yy
 upxmAoyq+yeoYF6GdoHMq6zgwcYVJVc4zAsEBJklQJNwYTFTH1cdYM8Z0BxQi0/LG778
 Omug==
X-Gm-Message-State: AOAM533BymtBT8wbSpHBu+KAdXQU0YdPAwJKtL7mFZHGl1WT890lwXmn
 +Yl+vrmZ7mKM4TK6zXkYGb9IM00mi8Lw6k5ijQLzMygaLPbn3TgFxI+5j2XSsidq9CsTDJSjv77
 OLCMaZI+jTv1Tmco=
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr4711408wme.27.1595954520149; 
 Tue, 28 Jul 2020 09:42:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwujv9oFAcIUInaOWyVE58PKtwwZf0aXQXGc/qE02GgNjFXu7nxqm2D8FmHR199r8yjOqmFWg==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr4711367wme.27.1595954519424; 
 Tue, 28 Jul 2020 09:41:59 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id g188sm6160471wma.5.2020.07.28.09.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 09:41:58 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
 <20200720172210.GA3987025@localhost.localdomain>
 <CAFEAcA8BD3BoJB9FAmeuZc8fKFNZywJT2LdGON670uM8ATdhZw@mail.gmail.com>
 <20200728155052.GA389264@localhost.localdomain>
 <CAFEAcA99fVFKwc6ju1w=2FRn9_UNhroGLRfZm+2hq_qMK-eNKA@mail.gmail.com>
 <20200728163357.GB393320@localhost.localdomain>
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
Message-ID: <04162abe-93dc-03a5-c28e-3bb312ce0244@redhat.com>
Date: Tue, 28 Jul 2020 18:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200728163357.GB393320@localhost.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/28/20 6:33 PM, Cleber Rosa wrote:
> On Tue, Jul 28, 2020 at 05:08:50PM +0100, Peter Maydell wrote:
>> On Tue, 28 Jul 2020 at 16:51, Cleber Rosa <crosa@redhat.com> wrote:
>>>
...
>>>> OTOH I can't see anything on that web page that suggests that
>>>> it's submitting jobs to the s390 or aarch64 boxes -- is it
>>>> intended to?
>>>>
>>>
>>> All the jobs for that pipeline have been created as expected, for
>>> instance:
>>>
>>>    https://gitlab.com/qemu-project/qemu/-/jobs/659874849
>>>
>>> But given the recent changes to the GitLab YAML adding other phases,
>>> it's waiting for the previous phases.
>>
>> The page now says "This job has been skipped"...
>>
> 
> I saw that, and I was very disappointed... I double checked the
> machines, the runners status, tag names and they all seem to be OK.
> 
> So, I think the reason for the skip (there's an open issue on GitLab
> itself about not communicating to users the reason) is that GitLab
> does a late evaluation of the job condition.  For those jobs the
> condition is:
> 
>    rules:
>    - if: '$CI_COMMIT_REF_NAME == "staging"'
> 
> Which by the time the job was evaluated it was no longer true (there
> was new content on the staging branch).  There are multiple ways to
> solve the problem, including (and in my order of preference):
> 
>  1. using '$CI_COMMIT_BRANCH' instead of '$CI_COMMIT_REF_NAME', given
>     that the pushed branch name should be kept stable even if the content
>     (thus reference name) changes
> 
>  2. not changing anything if you believe that under normal
>     circunstances one pipeline for the staging will be running at a
>     time.

For mainstream, usually one at a time is enough, because if you tests
various and one is merged, then you need to rerun on top of the merged
one, so it is not very useful.

For other users, it is useful. I'd certainly finish a patch, run the
script, switch branch in another console, do some other work, run
another instance of the script concurrently with the 1st one, etc...

> 
> I'll prepare a new version with #1, unless you have a strong feeling
> against it.
> 
> - Cleber.
> 
>> thanks
>> -- PMM
>>



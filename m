Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23CEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 03:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFB920663
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 03:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhDThCKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFB920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlOnP-0003uq-Nj
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 23:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlOmi-0003Qp-G7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 23:30:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlOmf-0007oI-TH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 23:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592364640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XTEs5PVK7R8o106y73W2FwDQibZdURRllpIj8FPCHns=;
 b=ZhDThCKSsc9riKPTYHi7Uf1XYEmkWxS6Edgd7qo6BwcYcQxxDur8NnCwEzJlfzv8z7bkYB
 Pv4/6v8v8s+QV4Qq3+fm02pepbFyS3J6P52V58GGYNE9kPaWA65aafPNIWyGnm+D3pusvJ
 stgqGx0yQp6CIt77oE6lvAks8MCTP9E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-7UuxOl8zOpmpqXL-FRcAoA-1; Tue, 16 Jun 2020 23:30:36 -0400
X-MC-Unique: 7UuxOl8zOpmpqXL-FRcAoA-1
Received: by mail-wm1-f70.google.com with SMTP id j128so289616wmj.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 20:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XTEs5PVK7R8o106y73W2FwDQibZdURRllpIj8FPCHns=;
 b=cKJoP0mSW1YH0vwOuxivHPYV2SaGoivHOCoAcAJhRM7d0Qny6MDijA5RQicL9hpyYo
 awI4EeHeZMqmLFQn/OFeH5SZwcwAlL7IsGAIGWjGSHXObbJXG1w2+sk72hm8bbT/QFog
 0Y5EhK3FpDmyO/UNmEp24Tz2L55W1cyeD7eTucmKWuVsM45gLBePR950waDuFoRgUhSH
 0L5Sy64CEyoE5y4S8tAeA32zC+T2Pwsc8KV2zhKT/zqx7yREf2FZ7wJMURq2iFGU/pA6
 FlN38RwRtI41cC8plBvGukG/iRJrKUKGWwYAft3RwBsYyzqA2DjikAOktA0zH9tgtvEo
 3Kcw==
X-Gm-Message-State: AOAM532zuHYJpUMzWN8hnKVTEJDQZgH4zJegIlfwZooo9/3CQppf9IPk
 foLpRuL0LMguahYGPNVbK4lCec6J5f7T4b6+p7Pj3Cy3VWBhL/nz7v4HUUulls3G7BrNgNBDkTx
 CMVYZ0WJYBf80e6E=
X-Received: by 2002:adf:c391:: with SMTP id p17mr5738973wrf.243.1592364634987; 
 Tue, 16 Jun 2020 20:30:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNw+UTfVvJulMnOpfS8kp87UyC2Q5nou20LbAUGatk8Fs+rX3Ab9u1cszKg+09w/G6VrVq2Q==
X-Received: by 2002:adf:c391:: with SMTP id p17mr5738945wrf.243.1592364634509; 
 Tue, 16 Jun 2020 20:30:34 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id r7sm6074129wmh.46.2020.06.16.20.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 20:30:33 -0700 (PDT)
Subject: Re: [PULL 00/84] QOM patches for 2020-06-15
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
 <CAFEAcA8iy3qzzbcM_X_Xgzz+KOcZ+Nq4=3q=Lag6hpuwrBCb4Q@mail.gmail.com>
 <e9febd4f-97ea-7832-fae1-14cbd7c9a73d@redhat.com>
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
Message-ID: <01b69a4e-44f1-9d89-f92e-7b4efed0eb3d@redhat.com>
Date: Wed, 17 Jun 2020 05:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e9febd4f-97ea-7832-fae1-14cbd7c9a73d@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 22:15:44
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 5:26 PM, Thomas Huth wrote:
> On 16/06/2020 14.26, Peter Maydell wrote:
>> On Mon, 15 Jun 2020 at 21:43, Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:
>>>
>>>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://repo.or.cz/qemu/armbru.git tags/pull-qom-2020-06-15
>>>
>>> for you to fetch changes up to b77b5b3dc7a4730d804090d359c57d33573cf85a:
>>>
>>>   MAINTAINERS: Make section QOM cover hw/core/*bus.c as well (2020-06-15 22:06:04 +0200)
>>>
>>> ----------------------------------------------------------------
>>> QOM patches for 2020-06-15
>>>
>>> * Make "info qom-tree" show children sorted
>>> * Fixes around device realization
>>> * Rework how we plug into devices into their parent bus
>>
>>
>> Applied, thanks.
>>
>> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
>> for any user-visible changes.
> 
> This pull requests (with the patch "qdev: qdev_init_nofail() is now
> unused, drop") apparently broke some iotests:
> 
>  https://gitlab.com/qemu-project/qemu/-/jobs/597414772#L4376
> 
> Can you please have a look?

Fix sent:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg04730.html

> 
>  Thanks,
>   Thomas
> 
> 



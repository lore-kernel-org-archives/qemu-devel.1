Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE4EC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CAA20704
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iimMsu2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CAA20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVs81-0002Gu-W2
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 04:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVs6W-0000l8-5i
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVs6U-0006ix-Lj
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603440433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YH7soUrbpMwOavOi4ky8xSq0KFSlsUajDzn9G+M1WWI=;
 b=iimMsu2B0h55VwdQk29c5H9UmHF+IQ4LD7mQYIMrenRH+jqkMjygzniJaCtqliOlC/i2t7
 EP8BMKGJ8Trv3BTDj5SD+3ZvocF8IsdPwiHNQLL6uk8HxtAmSeFyPEDq6kPeACGsavOUTS
 vwMpXJ7bLOX/ml3pY88MIGe4nVu6IfU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-lWkcmfy0Nk68yeJEUSh8Eg-1; Fri, 23 Oct 2020 04:07:12 -0400
X-MC-Unique: lWkcmfy0Nk68yeJEUSh8Eg-1
Received: by mail-wr1-f71.google.com with SMTP id r8so304442wrp.5
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 01:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YH7soUrbpMwOavOi4ky8xSq0KFSlsUajDzn9G+M1WWI=;
 b=N1CxQ1MD89eYUMyIWDMPjnekrT/NYtOI7M1FA5Znp2tm7Jf+TG7APjAB/g3KyhYxUv
 lOK4DsIgtEYicy2z+QxA04URRF9RSVUhRYqN+tZPwV7sATjeWa7cVDEpDsYkdlQuPgNe
 l8rYW5Pf9oil+Iynl4mmEJfp02I6yzJCxbq9UZEdsMzAOG95p8tjKT5lX8YI07kArT99
 TvH5Vzsap2qhBQJZ5InQSV5LQ7//AGz0sRwPznC4Yg4qBZKJ8QTs7VUA8f5wQQCV/R/V
 pwDogGsUUuKIDlw7bTBu3NSzy0sLdtewfW2OmqXgR6vSe1lGnUXA5eSGYrFlgLV+Vqvv
 RyiQ==
X-Gm-Message-State: AOAM532fiux6IwL+ExmDg3CEldwUFgpd704e7V+q4GJkvxxPricqzDsK
 s8EWJ9RWt89lQllFEAX7kK7ESkckKgl1aihTkgOyxgv7L+TKIgfV/91KexR/Kl57fbqDeK4xH5T
 H1SJltilS9p3iTDo=
X-Received: by 2002:a5d:654d:: with SMTP id z13mr1259405wrv.6.1603440430832;
 Fri, 23 Oct 2020 01:07:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPZdqrSbg0Gb4gDjchGh88J5/CJ2zhMeVYzOCFmEfv8UXWdZaBqL4Dhe6TMgtyDc/0izWgOQ==
X-Received: by 2002:a5d:654d:: with SMTP id z13mr1259394wrv.6.1603440430642;
 Fri, 23 Oct 2020 01:07:10 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 67sm1688102wmb.31.2020.10.23.01.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 01:07:10 -0700 (PDT)
Subject: Re: [PATCH 4/4] test/docker/dockerfiles: Add missing packages for
 acceptance tests
To: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201023073351.251332-1-thuth@redhat.com>
 <20201023073351.251332-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9191ef94-c040-8474-ed8f-5a6e7b53c706@redhat.com>
Date: Fri, 23 Oct 2020 10:07:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023073351.251332-5-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 9:33 AM, Thomas Huth wrote:
> Some of the "check-acceptance" tests are still skipped in the CI
> since the docker images do not provide the necessary packages, e.g.
> the netcat binary. Add them to get more test coverage.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/docker/dockerfiles/centos8.docker      | 1 +
>   tests/docker/dockerfiles/debian-amd64.docker | 3 +++
>   tests/docker/dockerfiles/fedora.docker       | 1 +
>   tests/docker/dockerfiles/ubuntu2004.docker   | 1 +
>   4 files changed, 6 insertions(+)

Finally...

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>



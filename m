Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFBFC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940732311A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGh4KOAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940732311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJFt3-000102-Gk
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 08:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJFrG-0008H0-2Q
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJFrA-00066d-T1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600433475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IE58CgE/qgbug5DtLZPcqz7VHaWu/lpx2cfUP9OZwEw=;
 b=JGh4KOABnD9J6xPUGIns0dBpEv5jbGY0pD71NpWy8HQl89r9B/OY65MhWaBRJsbNvfSySi
 ImgOZBHYlqK68K4t/jibedlb0kIAoMHASI52NB65mmK+aYJaX8g78EErGhex5Ryfx2t/54
 w/9If4aUPd2Xn1OArFXqCJ6nRlejac0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-8HNzPgujNfqpzY_5Z_JWSQ-1; Fri, 18 Sep 2020 08:51:14 -0400
X-MC-Unique: 8HNzPgujNfqpzY_5Z_JWSQ-1
Received: by mail-wm1-f70.google.com with SMTP id m10so1436735wmf.5
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 05:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IE58CgE/qgbug5DtLZPcqz7VHaWu/lpx2cfUP9OZwEw=;
 b=tKCgIjdGoYC5yyS5K5OyIDI41nCd+eP0SL1A6dLNctdVjSXYKN7jfxOxcVAPklxOl/
 KcaLv8gIF7f5tzmvVQ+vgA9A3r8VUEM56yf1V8CTQQHKkjPzd+Lvi1NkymhNk7JwZHZP
 878aEgtwRkaF2+6rAgNDel4fVJxubFrtlzEMd7WzG3nSfND05KpMy0rHtzEK/OWHdDfW
 nCFO0Ob5ZfOP18564tzag6i379qjiu2jSAYwBW5N7pdYgOMO4eU+R/m7QtcHPtJcEVyw
 0U0tq4ncVradMGUqSZs7UlWsqc+6FMgIAnzo5Uo8K1wAbW8wlo0VZDPIetCtyPp8LMJ0
 dXXw==
X-Gm-Message-State: AOAM533D9lbzgfOyBwXxBXKDZRg7IoHTWnFSBtD5RDY0YFcr1sDwBVED
 6HOD2Ud61pRnMhfAwwQ7/y523dhQFh08AUw7ygyLSGmoP9NkMoRgWsL6fY3C86eF6P8vBCUJujn
 gP6pCw1STSuDJDM0=
X-Received: by 2002:adf:f190:: with SMTP id h16mr38184657wro.202.1600433472735; 
 Fri, 18 Sep 2020 05:51:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmCQ+GUCqAA9RJLU5a6YSbd8yk8iD3ub3FzifajvgK+aCP4EF4C8sJVRYuHa8OhlzuDmReIQ==
X-Received: by 2002:adf:f190:: with SMTP id h16mr38184636wro.202.1600433472504; 
 Fri, 18 Sep 2020 05:51:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:69b4:4715:609f:385f?
 ([2001:b07:6468:f312:69b4:4715:609f:385f])
 by smtp.gmail.com with ESMTPSA id 18sm4748512wmj.28.2020.09.18.05.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 05:51:11 -0700 (PDT)
Subject: Re: [PATCH 0/6] Update Travis from Xenial to Bionic and Focal
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org
References: <20200918103430.297167-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36232a27-4d8b-70b0-3996-5981e3a279ac@redhat.com>
Date: Fri, 18 Sep 2020 14:51:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918103430.297167-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/20 12:34, Thomas Huth wrote:
> According to our support policy, we do not support Xenial anymore.
> Time to switch the Travis jobs to Focal or Bionic instead now.
> 
> Paolo Bonzini (2):
>   meson: move libudev test
>   meson: move libmpathpersist test

Can you skip these since I'm going to send a pull request today?

Paolo



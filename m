Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ED1C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C595E2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4T+YlPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C595E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icRGd-0002k1-1G
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 04:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icQZF-00055h-C0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icQZ2-0003YT-TQ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:03:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37008
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icQZ2-0003Lh-Nx
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575450193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AunsICv+tc9ByKDHB67N3AR9wBDUA6R0R700dp0nRsM=;
 b=f4T+YlPkJKw0znsVL96RHzGnOWAbggu2dTQz4rW8QQxZrZpCuGvpgJehCO8ghYW4oLrzV+
 Oq52YRFcbm/uLUMZSBFsoJkjLh5KpM80V+0uuhJaMoBO7f1SzSvH0I+JuqIsEH7xKAmrSO
 C8Z7rO50BzAKoBofNSwFzlQSI+MYdZw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-0NFXzwsXPeCI66W7gcnYRQ-1; Wed, 04 Dec 2019 04:03:10 -0500
Received: by mail-wr1-f70.google.com with SMTP id r2so3323787wrp.7
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 01:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AunsICv+tc9ByKDHB67N3AR9wBDUA6R0R700dp0nRsM=;
 b=Up0z6vrhTidy5Um2CKo4kz7yUlEPmejmfpnR54wN32GYTmQGGR6I2w4MOxQbZW6Qb7
 DZb/9VTZcoxqS9pF/rzdDBUoFh/Ap2he9tB+cY9siMW3oU+jwYtZKFm5Zhze74dqZcUh
 OFhTcHgqZwQrDCQbfvSXywfFqgXGUxZF+pHEgaDExEfPNJbv0SjYeJ0SKwo2Fvfi1jqC
 4WAK4olaxcqk5cq/XTIO5eUBvz8zXG1MsMVAapJuW8bA7Mg2Uo0vgeO7QxRVqtNs7UaH
 UuJCTbK7NRHbPo4Uex6p/G90gNZk53H900f3gTcW9d9l1RtneWBveMKZuU9YyqdGSemO
 H+lg==
X-Gm-Message-State: APjAAAV7Og5EqfsfRNP9XvgA5MnEkGThdFc/BRSIEFybEgl6xvwJ6aD8
 10kBM29Z4HjfSpbe/C92xJwf+ooCixi1lmQ81+yLAAxOLjp1C7f6S0dY7zBeqh0YdGIJnxrRC7g
 gcDn0r85DlScv/sQ=
X-Received: by 2002:a7b:c004:: with SMTP id c4mr37831513wmb.45.1575450189834; 
 Wed, 04 Dec 2019 01:03:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzofYsUKxTVohcM6lK2TK6wXEdnIC4MzT+dlZFmSWDAVJzlaIy5vJwZw6IiqEv+b59ncu4fhA==
X-Received: by 2002:a7b:c004:: with SMTP id c4mr37831490wmb.45.1575450189566; 
 Wed, 04 Dec 2019 01:03:09 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id c2sm7263359wrp.46.2019.12.04.01.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 01:03:08 -0800 (PST)
Subject: Re: [PATCH 02/10] hw: arm: add Xunlong Orange Pi PC machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-3-nieklinnenbank@gmail.com>
 <b14e5a75-ebe3-311e-60a8-3f71b0874a10@redhat.com>
 <CAPan3Woz7+1K9Yth6MfHqLfjcDMh8xGVzTShN7gi3XM8W_BNnw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <239606dc-3545-c3f7-1e11-429f53994147@redhat.com>
Date: Wed, 4 Dec 2019 10:03:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3Woz7+1K9Yth6MfHqLfjcDMh8xGVzTShN7gi3XM8W_BNnw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 0NFXzwsXPeCI66W7gcnYRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: b.galvani@gmail.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 8:33 PM, Niek Linnenbank wrote:
> Hello Philippe,
> 
> Thanks for your quick review comments!
> I'll start working on a v2 of the patches and include the changes you 
> suggested.

Thanks, but I'd suggest to wait few more days to give time to others 
reviewers. Else having multiple versions of a big series reviewed at the 
same time is very confusing.
I have other minor comments on others patches, but need to find the time 
to continue reviewing.



Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A96DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455F1208A7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDcp7y2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455F1208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdDsR-0005Kb-Hh
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 10:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdDqH-0002mz-KM
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:12:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49763
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdDqG-0005Nu-MG
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590415956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VgSuwoGE19pbIkSHpSGDDt8PRMouWyW6fcaHBYAmI7s=;
 b=dDcp7y2f/lVacyCQWcLBOBxOl6ut5mNWWickVPN+PNcrkdvBEmsstopvu7NXeZoaG3Trtn
 CHX6pXpQTCK3NCVeuFJfyyt3NRHpUr2CZs62DUZuF9y2roGPsFDbWx+ljfVdX2Y+7z8keA
 trsWomCCOrZFWtZsWb28+yW3paFF/9w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-q9blvNc4M8WOel3bfjgH1A-1; Mon, 25 May 2020 10:12:34 -0400
X-MC-Unique: q9blvNc4M8WOel3bfjgH1A-1
Received: by mail-ed1-f69.google.com with SMTP id bo26so7491574edb.22
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 07:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=VgSuwoGE19pbIkSHpSGDDt8PRMouWyW6fcaHBYAmI7s=;
 b=ejQsd9+YHkHLZrwrf1n8vK3XPqOH3hI4tooWdwHkmCgx9vwEYtpMZ6PnfWvZXnUjGM
 1y1izfmST3pho5dHcbRuxlg9VeRRJfgzetzKEBFmNQuYfRVKuEg8duDp30WqoWCiPX9b
 kzaS+LesZHAtKo19O4CtGcK+VwW8VCrU/Ln7HtrkQ4uIspTYw2Mt5tlNpFNkdldrm9oP
 bXAyrDDn/BrBC0X2PHl8oJxhqlxG95S1noqpWQq13ljfzpE1cH1TThK7IOQYCrMgeymt
 lawv1VMXu6jbSj3IrgX0yGYFbKsTO+huCnAc2VIwd2pQT9kexOvGqsmwb31Dm873k6OB
 HzwQ==
X-Gm-Message-State: AOAM531NoUq1NiEaAydiVO+1bAOqbc+cS6AsKORANANHeFwbk9LvXCev
 LK43VXJoavKxgT9LKGWZS91Dc5HRWVNENPJxu4pWbRCN1LFw7u+a7KNEsi4eOz0ZQgbc3nKqlU/
 a2bQ3ygp/b/DqrRs=
X-Received: by 2002:a05:6402:308f:: with SMTP id
 de15mr15695135edb.108.1590415953299; 
 Mon, 25 May 2020 07:12:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3aAQHRQosl/0KIT4ifa8uVRrEc2sizlXa+ofcZk4hQqLSWGR07UZ+YYWa+cjnLaZPn8lMvA==
X-Received: by 2002:a05:6402:308f:: with SMTP id
 de15mr15695093edb.108.1590415952971; 
 Mon, 25 May 2020 07:12:32 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id fi9sm15289851ejb.5.2020.05.25.07.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 07:12:32 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] qapi/misc: Restrict LostTickPolicy enum to machine
 code
To: qemu-devel@nongnu.org
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-3-philmd@redhat.com>
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
Message-ID: <81463e0f-a06a-0693-b6f7-a319f2cfc216@redhat.com>
Date: Mon, 25 May 2020 16:12:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316000348.29692-3-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:28:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 3/16/20 1:03 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  qapi/machine.json            | 32 ++++++++++++++++++++++++++++++++
>  qapi/misc.json               | 32 --------------------------------
>  include/hw/rtc/mc146818rtc.h |  2 +-
>  hw/core/qdev-properties.c    |  1 +
>  hw/i386/kvm/i8254.c          |  2 +-
>  5 files changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index de05730704..07ffc07ba2 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -415,6 +415,38 @@
>  ##
>  { 'command': 'query-target', 'returns': 'TargetInfo' }
>  
> +##
> +# @LostTickPolicy:
> +#
> +# Policy for handling lost ticks in timer devices.  Ticks end up getting
> +# lost when, for example, the guest is paused.
> +#
> +# @discard: throw away the missed ticks and continue with future injection
> +#           normally.  The guest OS will see the timer jump ahead by a
> +#           potentially quite significant amount all at once, as if the
> +#           intervening chunk of time had simply not existed; needless to
> +#           say, such a sudden jump can easily confuse a guest OS which is
> +#           not specifically prepared to deal with it.  Assuming the guest
> +#           OS can deal correctly with the time jump, the time in the guest
> +#           and in the host should now match.
> +#
> +# @delay: continue to deliver ticks at the normal rate.  The guest OS will
> +#         not notice anything is amiss, as from its point of view time will
> +#         have continued to flow normally.  The time in the guest should now
> +#         be behind the time in the host by exactly the amount of time during
> +#         which ticks have been missed.
> +#
> +# @slew: deliver ticks at a higher rate to catch up with the missed ticks.
> +#        The guest OS will not notice anything is amiss, as from its point
> +#        of view time will have continued to flow normally.  Once the timer
> +#        has managed to catch up with all the missing ticks, the time in
> +#        the guest and in the host should match.
> +#
> +# Since: 2.0
> +##
> +{ 'enum': 'LostTickPolicy',
> +  'data': ['discard', 'delay', 'slew' ] }
> +
>  ##
>  # @NumaOptionsType:
>  #
> diff --git a/qapi/misc.json b/qapi/misc.json
> index c18fe681fb..2725d835ad 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -7,38 +7,6 @@
>  
>  { 'include': 'common.json' }
>  
> -##
> -# @LostTickPolicy:
> -#
> -# Policy for handling lost ticks in timer devices.  Ticks end up getting
> -# lost when, for example, the guest is paused.
> -#
> -# @discard: throw away the missed ticks and continue with future injection
> -#           normally.  The guest OS will see the timer jump ahead by a
> -#           potentially quite significant amount all at once, as if the
> -#           intervening chunk of time had simply not existed; needless to
> -#           say, such a sudden jump can easily confuse a guest OS which is
> -#           not specifically prepared to deal with it.  Assuming the guest
> -#           OS can deal correctly with the time jump, the time in the guest
> -#           and in the host should now match.
> -#
> -# @delay: continue to deliver ticks at the normal rate.  The guest OS will
> -#         not notice anything is amiss, as from its point of view time will
> -#         have continued to flow normally.  The time in the guest should now
> -#         be behind the time in the host by exactly the amount of time during
> -#         which ticks have been missed.
> -#
> -# @slew: deliver ticks at a higher rate to catch up with the missed ticks.
> -#        The guest OS will not notice anything is amiss, as from its point
> -#        of view time will have continued to flow normally.  Once the timer
> -#        has managed to catch up with all the missing ticks, the time in
> -#        the guest and in the host should match.
> -#
> -# Since: 2.0
> -##
> -{ 'enum': 'LostTickPolicy',
> -  'data': ['discard', 'delay', 'slew' ] }
> -
>  ##
>  # @add_client:
>  #
> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
> index 10c93a096a..58a7748c66 100644
> --- a/include/hw/rtc/mc146818rtc.h
> +++ b/include/hw/rtc/mc146818rtc.h
> @@ -9,7 +9,7 @@
>  #ifndef HW_RTC_MC146818RTC_H
>  #define HW_RTC_MC146818RTC_H
>  
> -#include "qapi/qapi-types-misc.h"
> +#include "qapi/qapi-types-machine.h"
>  #include "qemu/queue.h"
>  #include "qemu/timer.h"
>  #include "hw/isa/isa.h"
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 2047114fca..59380ed761 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -4,6 +4,7 @@
>  #include "qapi/error.h"
>  #include "hw/pci/pci.h"
>  #include "qapi/qapi-types-block.h"
> +#include "qapi/qapi-types-machine.h"
>  #include "qapi/qapi-types-misc.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/ctype.h"
> diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
> index 876f5aa6fa..22ba6149b5 100644
> --- a/hw/i386/kvm/i8254.c
> +++ b/hw/i386/kvm/i8254.c
> @@ -25,7 +25,7 @@
>  
>  #include "qemu/osdep.h"
>  #include <linux/kvm.h>
> -#include "qapi/qapi-types-misc.h"
> +#include "qapi/qapi-types-machine.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>  #include "qemu/timer.h"
> 



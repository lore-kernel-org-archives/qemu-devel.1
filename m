Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9ECC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE3E215EA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmjUtW30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE3E215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfgyA-0003K9-0j
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 04:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55031)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hfgxS-0002tF-Ph
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hfgxQ-0006NH-Ro
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:37:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hfgxQ-0006L5-K1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:37:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id f17so1998844wme.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=xDjoCChNpNiCWQhcn/S32ApZm/GGo5ZANNR0LJE0MH0=;
 b=dmjUtW30gcodD/UAKxQiBogLGYf22+Fc/WoseFP53atO1WHHF8OXDy0cxsynHaUqKN
 ZrjZpHksrebOTjjbIxPJ90RerLImT8kKl14LIkrld6lj5bW7GqKNRhtgdnrf0HdjbJ1e
 hpbF9zn4aESMBYmVUw2iNdKK2yVcnpwn1DiAlmFbckS8hL6zn3PpJmj1bT8Bs6wVIvUa
 mnhSdbS/RfHzCUfZl7qQX0HoNZLoGE0Fo+OJr3M3fLRVREcDK10GCA7JO43knNK4AjW8
 84c1wv8Flg6tWbMp4s8+8FiBlPQwTexHFRi80U4XIsf+KpgZZvJ+RWUc5xCzJSc+F9ed
 yGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=xDjoCChNpNiCWQhcn/S32ApZm/GGo5ZANNR0LJE0MH0=;
 b=j2fiRYxmuIMfNL4l3v/R7z4jyAn+BYvo8oREEj1GmZ4yUfBcAF5v8yl417mLY63qfJ
 ZIjuJbRfIM3gQWhHwmWveyBU/E2Bjb0gKUj2xhMVaodr2NSdKlXhELzKcSCNPxe77SPq
 +LxYkiQnm3kiw4kZ5Dh2huaoOhpzqaNyIS5rhcpG+5wcKtzlddB/c/at7WIZAnOQo3LE
 gmmRAgGDFCnsAlBSV2EtMJgkATX8e9BCuBmdL/2QWwpmQI7AFP/kxomwvxt3QQDbh/jN
 a7RgZJifngJMGmfPh5pke2kIEJUad2bTUhoDXjBYu9cz2OvFvUMzPySn39mP50F3UEUz
 4ndQ==
X-Gm-Message-State: APjAAAXQkwDjYrhZv6vIdv7ODtzzL8Up4puucijbzCWiBCeEbfs3RzBj
 jgMYF2Y21S7oYjwxMPfloudBoNEx
X-Google-Smtp-Source: APXvYqwHDZholp3F7/stoPFNJ7U7VE8ces5vkC1XOtXs5nYquGKpGDTHoBTec1zItwkl6SZ/c+EvuA==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr20156036wmj.64.1561451859181; 
 Tue, 25 Jun 2019 01:37:39 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
 by smtp.gmail.com with ESMTPSA id t140sm2317222wmt.0.2019.06.25.01.37.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 01:37:38 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190608233447.27970-1-ehabkost@redhat.com>
 <20190608233447.27970-2-ehabkost@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <87a3a814-a576-faac-fd2d-0626a4eb38db@gmail.com>
Date: Tue, 25 Jun 2019 11:37:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190608233447.27970-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qmp: Add deprecation information to
 query-machines
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/9/19 2:34 AM, Eduardo Habkost wrote:
> Export machine type deprecation status through the query-machines
> QMP command.  With this, libvirt and management software will be
> able to show this information to users and/or suggest changes to
> VM configuration to avoid deprecated machines.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Take a much simpler approach: add a simple `deprecated` bool
>    field, instead of including a human-readable message and
>    suggested alternatives
> ---
>   qapi/misc.json | 7 ++++++-
>   vl.c           | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4fdd3..fca793d39c 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2018,12 +2018,17 @@
>   #
>   # @hotpluggable-cpus: cpu hotplug via -device is supported (since 2.7.0)
>   #
> +# @deprecated: if true, the machine type is deprecated and may be removed
> +#              in future versions of QEMU according to the QEMU deprecation
> +#              policy (since 4.1.0)
> +#
>   # Since: 1.2.0
>   ##
>   { 'struct': 'MachineInfo',
>     'data': { 'name': 'str', '*alias': 'str',
>               '*is-default': 'bool', 'cpu-max': 'int',
> -            'hotpluggable-cpus': 'bool'} }
> +            'hotpluggable-cpus': 'bool',
> +            'deprecated': 'bool' } }
>   
>   ##
>   # @query-machines:
> diff --git a/vl.c b/vl.c
> index cd1fbc4cdc..f825d2159c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1428,6 +1428,7 @@ MachineInfoList *qmp_query_machines(Error **errp)
>           info->name = g_strdup(mc->name);
>           info->cpu_max = !mc->max_cpus ? 1 : mc->max_cpus;
>           info->hotpluggable_cpus = mc->has_hotpluggable_cpus;
> +        info->deprecated = !!mc->deprecation_reason;
>   
>           entry = g_malloc0(sizeof(*entry));
>           entry->value = info;

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel




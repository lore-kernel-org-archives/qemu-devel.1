Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D09C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA6B2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U88kbmNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA6B2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRs5-00042r-Dq
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbRpk-0001kn-Vd
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:44:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbRpj-0004Ao-0E
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589993082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTnawR5TkPuOfheuAEvLin0DGEsJw9m6e4akfoTANXY=;
 b=U88kbmNaNrTEriJOHZDT4ZCbTvtfhRHTg3Cxn0WrZt9ZtXwCPamlXP115mcz/rMMvGIz/i
 KCWfiOJGlELhFL13qSX3GwKFTvKHJTVgL4N+0Q6aypS/QpFOF1zqltKyP7BqpXaiaD5BFw
 BHeeagnvsrj5lbRd5NoGw4HF+onO0kY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-0qFjQYhUPTulK0QgcQcc5A-1; Wed, 20 May 2020 12:44:39 -0400
X-MC-Unique: 0qFjQYhUPTulK0QgcQcc5A-1
Received: by mail-ej1-f72.google.com with SMTP id pw1so1578933ejb.8
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 09:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pTnawR5TkPuOfheuAEvLin0DGEsJw9m6e4akfoTANXY=;
 b=Amst1VSBOnPzYOtiyM2tsASx8Z393Ckd52hWcisDLbRbENDY15q13twvdA85gOSUvJ
 i3YYshPuvAXo/VsIlzWo8nCCsurxe1Tf8NgcGJaKKCVgA97SoEK4hhpO1eoXQ+P/krJY
 pKh+P3VR1Od8xBAPKUKRJH8QI28d0pYx5QuHRb2Z1LBwfsS33Pb1LY0QasoIwK2osO9l
 P/0aaC5YgZIoUgPf0UrjDKxogVZ8tuwrrtfJW3Wgg/dc5KRNPlBD5IWqoasqc7hDqcB7
 XkCw3i2qIoYHFO/hjEB15V8f96L2oFsMqUHYT5e3IxZwwEMZdnVCMwGKgDcDeK+9pkLO
 bKaQ==
X-Gm-Message-State: AOAM533a/98KvR5oUr6lyz8n7F44c3y0SUTt2hZYjPEO335i/K6/w6Dw
 KrZLWmsVMVq0Rof8/158t9i4JNEEN/xa6RyNu1vNrtvqJwub2To2EyYTtWUlfi2TCziJ9tQEmpt
 cyTdMBrDw8ijZ7YU=
X-Received: by 2002:a17:906:1917:: with SMTP id
 a23mr4288114eje.506.1589993077949; 
 Wed, 20 May 2020 09:44:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPrlPmI7WPmIS2qWzjs+64B1DfppLru8LbD7RzvS/emxYvvanbetqtumXs928aVCJp/FCJUw==
X-Received: by 2002:a17:906:1917:: with SMTP id
 a23mr4288089eje.506.1589993077666; 
 Wed, 20 May 2020 09:44:37 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m2sm2353094ejb.33.2020.05.20.09.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 09:44:37 -0700 (PDT)
Subject: Re: [PATCH 1/2] hmp: Implement qom-get HMP command
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com
References: <20200520151108.160598-1-dgilbert@redhat.com>
 <20200520151108.160598-2-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1dafb128-1db4-2be0-9fcc-7c5315413396@redhat.com>
Date: Wed, 20 May 2020 18:44:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520151108.160598-2-dgilbert@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, clg@kaod.org, afaerber@suse.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 5:11 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> This started off as Andreas Färber's implementation from
> March 2015, but after feedback from Paolo and Markus it morphed into
> using the json output which handles structs reasonably.
> 
> Use with qom-list to find the members of an object.
> 
> (qemu) qom-get /backend/console[0]/device/vga.rom[0] size
> 65536
> (qemu) qom-get /machine smm
> "auto"
> (qemu) qom-get /machine rtc-time
> {
>      "tm_year": 120,
>      "tm_sec": 51,
>      "tm_hour": 9,
>      "tm_min": 50,
>      "tm_mon": 4,
>      "tm_mday": 20
> }
> (qemu) qom-get /machine frob
> Error: Property '.frob' not found
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   hmp-commands.hx        | 14 ++++++++++++++
>   include/monitor/hmp.h  |  1 +
>   qom/qom-hmp-cmds.c     | 18 ++++++++++++++++++
>   tests/qtest/test-hmp.c |  1 +
>   4 files changed, 34 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 7f0f3974ad..250ddae54d 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1790,6 +1790,20 @@ SRST
>     Print QOM properties of object at location *path*
>   ERST
>   
> +    {
> +        .name       = "qom-get",
> +        .args_type  = "path:s,property:s",
> +        .params     = "path property",
> +        .help       = "print QOM property",
> +        .cmd        = hmp_qom_get,
> +        .flags      = "p",
> +    },
> +
> +SRST
> +``qom-get`` *path* *property*
> +  Print QOM property *property* of object at location *path*
> +ERST
> +
>       {
>           .name       = "qom-set",
>           .args_type  = "path:s,property:s,value:s",
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index e33ca5a911..c986cfd28b 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -96,6 +96,7 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict);
>   void hmp_info_numa(Monitor *mon, const QDict *qdict);
>   void hmp_info_memory_devices(Monitor *mon, const QDict *qdict);
>   void hmp_qom_list(Monitor *mon, const QDict *qdict);
> +void hmp_qom_get(Monitor *mon, const QDict *qdict);
>   void hmp_qom_set(Monitor *mon, const QDict *qdict);
>   void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
>   void object_add_completion(ReadLineState *rs, int nb_args, const char *str);
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index cd08233a4c..a8b0a080c7 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -12,6 +12,8 @@
>   #include "qapi/error.h"
>   #include "qapi/qapi-commands-qom.h"
>   #include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qstring.h"
>   #include "qom/object.h"
>   
>   void hmp_qom_list(Monitor *mon, const QDict *qdict)
> @@ -62,6 +64,22 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
>       hmp_handle_error(mon, err);
>   }
>   
> +void hmp_qom_get(Monitor *mon, const QDict *qdict)
> +{
> +    const char *path = qdict_get_str(qdict, "path");
> +    const char *property = qdict_get_str(qdict, "property");
> +    Error *err = NULL;
> +    QObject *obj = qmp_qom_get(path, property, &err);
> +
> +    if (err == NULL) {
> +        QString *str = qobject_to_json_pretty(obj);
> +        monitor_printf(mon, "%s\n", qstring_get_str(str));
> +        qobject_unref(str);

Simple, does the job, lovely!

> +    }
> +
> +    hmp_handle_error(mon, err);
> +}
> +
>   typedef struct QOMCompositionState {
>       Monitor *mon;
>       int indent;
> diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
> index f8aa5f92c5..b8b1271b9e 100644
> --- a/tests/qtest/test-hmp.c
> +++ b/tests/qtest/test-hmp.c
> @@ -61,6 +61,7 @@ static const char *hmp_cmds[] = {
>       "p $pc + 8",
>       "qom-list /",
>       "qom-set /machine initrd test",
> +    "qom-get /machine initrd",
>       "screendump /dev/null",
>       "sendkey x",
>       "singlestep on",
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>



Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5670C5517A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D2122228
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScEyMppX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D2122228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb548-0006oS-VA
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 11:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb53F-0006MB-No
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:57:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb53C-0008I9-J6
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604681840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1E0QBKESAHXJzxchxF7cJTnMe/DpdidM6SoHtjCqA8E=;
 b=ScEyMppX3CbGxGcYOWLQw9prD7RA+qC/83qBAAe2COUKG44Nmt/Gld6rzIqJo8zKblwIM0
 E6Z8hAwiZElvCKuHBrcHnbOpt5dctevS5nYD0xxbPkhOc5Tzj2zJfBK7WJWW9xhEXZUBO3
 2bblIcxHy1eSEXF3E+6gRsO1vp/bxX4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-xIED1Kq1NI-fFcdwiPVBhw-1; Fri, 06 Nov 2020 11:57:19 -0500
X-MC-Unique: xIED1Kq1NI-fFcdwiPVBhw-1
Received: by mail-wm1-f71.google.com with SMTP id 8so653134wmg.6
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 08:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1E0QBKESAHXJzxchxF7cJTnMe/DpdidM6SoHtjCqA8E=;
 b=PFIlwAncQxuDLZssrWlGCxfR3rQxo0d2WLtrXAfYxZrsXsukriCZtH4Fo0IdrQXD4O
 3PR0DEdjCZJUNgAEhgwkpAKj9Bh2dVgB+JsHN7XtXWNYNccBR9rMbxQlX7lu9nbxGubT
 YF6z5181+jH5aD93ogIRntO4Wv7P8+bmj6nWQF5ws86NIuawGsOidzr+wTNaIGle8zm0
 Gzf94RMEIJEANfTVaNAC6jijVyGIbvrL+HEMi5hflQvVDqA+rdg3ONPn1Er6bpwqmc1l
 uDIUKPgjnmZNVkFyGCGTtMX+OioATAhyJdqbSntj6UT6VufmQJYy81imQGXaalDk5xaK
 O9Dg==
X-Gm-Message-State: AOAM531s1otpqnBLpGJO8UWqBJEaWLf6THJgDjRpIbSrVVtWDctwlxvp
 fjaTSchCZ3Zu7gx7cyAe/axaeZdqjo2p9nTZazeZOcCcGajofi3K5T/sCkjjiTdDuTHTkMRuEez
 tdUONHjcNmVIEqcc=
X-Received: by 2002:a7b:cc05:: with SMTP id f5mr492775wmh.123.1604681837937;
 Fri, 06 Nov 2020 08:57:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsJxiQ6RxKIfOkBARItaBCNbS/Dbbh1ZPN/ehibKZNprY6iSnE3+JfM3kiXWl2s9irm5DU2Q==
X-Received: by 2002:a7b:cc05:: with SMTP id f5mr492759wmh.123.1604681837756;
 Fri, 06 Nov 2020 08:57:17 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n22sm2955211wmk.40.2020.11.06.08.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 08:57:16 -0800 (PST)
Subject: Re: [PATCH 1/1] Change the order of g_free(info) and tracepoint
To: David Edmondson <dme@dme.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 alex.williamson@redhat.com, cjia@nvidia.com
References: <1604669964-27222-1-git-send-email-kwankhede@nvidia.com>
 <cunr1p6tr1h.fsf@zarquon.hh.sledj.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5eccaf99-3fad-f24a-6cbb-439ac83c34b2@redhat.com>
Date: Fri, 6 Nov 2020 17:57:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <cunr1p6tr1h.fsf@zarquon.hh.sledj.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: mcrossley@nvidia.com, qemu-devel@nongnu.org, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 4:59 PM, David Edmondson wrote:
> On Friday, 2020-11-06 at 19:09:24 +0530, Kirti Wankhede wrote:
> 
>> Fixes Coverity issue:
>> CID 1436126:  Memory - illegal accesses  (USE_AFTER_FREE)
>>
>> Fixes: a9e271ec9b36 ("vfio: Add migration region initialization and finalize
>> function")
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> 
> Maybe "fix use after free in vfio_migration_probe" as a summary?

Yes please :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Reviewed-by: David Edmondson <dme@dme.org>
> 
>> ---
>>  hw/vfio/migration.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 3ce285ea395d..55261562d4f3 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -897,8 +897,8 @@ int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
>>          goto add_blocker;
>>      }
>>  
>> -    g_free(info);
>>      trace_vfio_migration_probe(vbasedev->name, info->index);
>> +    g_free(info);
>>      return 0;
>>  
>>  add_blocker:
>> -- 
>> 2.7.0
> 
> dme.
> 



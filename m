Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A41C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 06:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04720207F7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 06:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJmXZpi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04720207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh5l9-0002Ru-AJ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 02:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jh5kc-00021n-CP
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 02:22:46 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:46000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jh5kb-0006gl-3J
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 02:22:45 -0400
Received: by mail-pg1-x534.google.com with SMTP id n23so4644701pgb.12
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 23:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cftRtSIcXBZJ50+Kj10l2Rtn0GY6HW7U3eWUxXdNBEg=;
 b=ZJmXZpi0d/ChVp2ScbuIelFbuuEbvOuD19UkATC4o1LjG3XupJJSM/2VE7H1BRHI0g
 /6FOIcmttQFjs/RXuhIHtUB3DSpFkQW0MrMVNwKYEyEpQyoZak07I3vemy+nD/auJ5ag
 tWX0EkcVrWrrST86joLp8uPVTIhDWqXzzrraTwyZuPzFbaP8Jkp/1eIa2brLZlXtRSWf
 bDTsfyW6XIda0GTT8JN/mWuosl6ymtI0N0ATGhqB2Q1RfP0tgu1G7SCLtWYRRQDqJxkt
 o3EBMrRAxhsIElSQ/ztkLxn5jCW5fkkhhZCcNEXw2ETIv2nOfBkCILHN6cJWfb9q42XW
 qsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cftRtSIcXBZJ50+Kj10l2Rtn0GY6HW7U3eWUxXdNBEg=;
 b=HGwlkonbf+ZN27ZsIDJB1kWvTMeh55eHMVU2IBrKKJViYqE0pVr8waqAXIitLIcWmA
 yUY5GRJIhZc9dXsrjuOJLt1d04f+rAwCiNC8SZEHrrq8WQw+F69tJXIIo4Pgp2KCdqn1
 nyJdcbe2aMY9m+6lN45/geFOoQTREX+HVYJX1BqPpg61cpNyKBRDLbQU0wOgSONB3Mp0
 onRMnkNeHv2GXsbtWRlQOLKYNEkbx/jRe9LJIJpWijbhu/V4vbLKwj0y1KWCTyQ8rldO
 62KMvoOSbI2MbacVHN5XEgOZSURR61+jDEauKCngGSNNJib/1Oq1rZmZRQp8ZFdjWCLO
 qyZw==
X-Gm-Message-State: AOAM530O4DfvqIXT2yWZaW2DMwjd70oZJl40/kiUhWfxx+1JxOlOGwaP
 fYuwNwZq9jVRJPHNd4bAUd4=
X-Google-Smtp-Source: ABdhPJzViDznS0B019zDXBo5E+yuZN7yYCpY9eIuPOJ3F2CwSLyjiHmBWflU4xFlFrDNfGNdr8N+rg==
X-Received: by 2002:a65:614f:: with SMTP id o15mr7648446pgv.244.1591338163458; 
 Thu, 04 Jun 2020 23:22:43 -0700 (PDT)
Received: from localhost (tunnel570486-pt.tunnel.tserv25.sin1.ipv6.he.net.
 [2001:470:35:3d5::2])
 by smtp.gmail.com with ESMTPSA id a16sm5578976pgk.88.2020.06.04.23.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 23:22:42 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 5 Jun 2020 14:22:38 +0800
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v8 4/4] new qTest case to test the vhost-user-blk-server
Message-ID: <20200605062238.bkpcfd7rl2h5d3md@r>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200604233538.256325-5-coiby.xu@gmail.com>
 <b8b6c706-e726-e7db-8a1c-ad6fce6ce461@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b8b6c706-e726-e7db-8a1c-ad6fce6ce461@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=coiby.xu@gmail.com; helo=mail-pg1-x534.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, bharatlkmlkvm@gmail.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 05, 2020 at 07:01:33AM +0200, Thomas Huth wrote:
>> diff --git a/tests/qtest/libqos/vhost-user-blk.h b/tests/qtest/libqos/vhost-user-blk.h
>> new file mode 100644
>> index 0000000000..ef4ef09cca
>> --- /dev/null
>> +++ b/tests/qtest/libqos/vhost-user-blk.h
>> @@ -0,0 +1,44 @@
>> +/*
>> + * libqos driver framework
>> + *
>> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License version 2 as published by the Free Software Foundation.
>
>... but you've missed the header here :-(

Thank you for reminding me of this issue!

>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index 49075b55a1..a7b7c96206 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -31,40 +31,9 @@
>>  #include "qapi/qmp/qlist.h"
>>  #include "qapi/qmp/qstring.h"
>>
>> -#define MAX_IRQ 256
>>  #define SOCKET_TIMEOUT 50
>>  #define SOCKET_MAX_FDS 16
>>
>> -
>> -typedef void (*QTestSendFn)(QTestState *s, const char *buf);
>> -typedef void (*ExternalSendFn)(void *s, const char *buf);
>> -typedef GString* (*QTestRecvFn)(QTestState *);
>> -
>> -typedef struct QTestClientTransportOps {
>> -    QTestSendFn     send;      /* for sending qtest commands */
>> -
>> -    /*
>> -     * use external_send to send qtest command strings through functions which
>> -     * do not accept a QTestState as the first parameter.
>> -     */
>> -    ExternalSendFn  external_send;
>> -
>> -    QTestRecvFn     recv_line; /* for receiving qtest command responses */
>> -} QTestTransportOps;
>> -
>> -struct QTestState
>> -{
>> -    int fd;
>> -    int qmp_fd;
>> -    pid_t qemu_pid;  /* our child QEMU process */
>> -    int wstatus;
>> -    int expected_status;
>> -    bool big_endian;
>> -    bool irq_level[MAX_IRQ];
>> -    GString *rx;
>> -    QTestTransportOps ops;
>> -};
>
>Why do you have to move struct QTestState and friends to the header
>instead? I'd prefer if we could keep it here if possible?

tests/qtest/vhost-user-blk-test.c needs to talk to qemu-storage-daemon's
QMP. Thus I g_new0 a QTestState struct to make use of related functions
like qtest_qmp and this requires the QTestState struct definition.


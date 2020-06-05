Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9527C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86ADA2075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMNKyfKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86ADA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhCOo-0000J3-Ov
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 09:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jhCNk-0007uV-89
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:27:36 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jhCNj-0004dY-58
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:27:35 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ga6so2591850pjb.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=qxLp17jtTQ8Qb9sb6DJzjZ3qnsnUcLJIZAW+mFFcCiw=;
 b=hMNKyfKul3cES3nS+ZpcfAD6UAGhGRj3ZYUmVsXNWUSwpoFNtw+s0io1mB9XUXcJqI
 DUU+6B5P8CPmnx3DJufDc+TibWz90dwN8+Ghgx+gQc4z/XJZmExsvzlT6gqRjtZEMJNg
 3J6O4Gs7F48v/sHVl+NJpuWIHJwu8P2ylsfKk5q8biUz7EErAJDbNc85cahJ/byJBgMd
 1jDbhvLgDPG8xirPBH1sfAIiuCz29P5BHtqVrwjRSgCKxzvTe5iW9J3kDGa/8RGn6uSW
 uFwNtMTDM65YASHl3z8xIE0WAhJMQ2+YDXtsOAq/ycGrdvX6X0fZDSHEHRFEmYyOXu6s
 vZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qxLp17jtTQ8Qb9sb6DJzjZ3qnsnUcLJIZAW+mFFcCiw=;
 b=mVDNR6DPABVLSyg9lQE5DwBB5+LbIMekRIwRUfFofYvWRSRcj8usJEs4+cSiVf2H9b
 f16ck4z6tFEuANAYbB9orYFuzWH0MLUjmKpxiHszD2vVOUCl0/mLRobQ8sg+RYlcE5Gc
 kvvnrfQUfQhjg6CT5AHUQxLaNF03PnJG1yqT4q7/gMAUPwbEjpro2GyQN7UCjUb4CxnH
 ZTdCMkHHSNbKDazZExSGrT9S8OmvnsFjQZ8ue99//fl2CUaTCKTYSYDpCaBPJhr/BYv+
 jKiCtcS0xOdyUphJ1kIAe1Bb3rYMFp3kMKq3GLksrMVBesfrUF1js96gsoVmUwXhO5Wj
 BAcA==
X-Gm-Message-State: AOAM530kt+V2AkXkIK+Pj9RDPVKQ/ttu8ctxVatLXO9Rfeps1w2kzPqp
 pEnfuZacnQTEQdk8KWFVdsU=
X-Google-Smtp-Source: ABdhPJywtvWqzuTcwa+TlX2fI5gJ0EfDbtAiiCNAT2w00iLYl4uv5JYo2MgYFUBU4/uBSersEZGlBg==
X-Received: by 2002:a17:90a:8c8e:: with SMTP id
 b14mr2908243pjo.222.1591363653652; 
 Fri, 05 Jun 2020 06:27:33 -0700 (PDT)
Received: from localhost (tunnel570486-pt.tunnel.tserv25.sin1.ipv6.he.net.
 [2001:470:35:3d5::2])
 by smtp.gmail.com with ESMTPSA id s11sm7412754pfh.204.2020.06.05.06.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:27:32 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 5 Jun 2020 21:27:28 +0800
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v8 4/4] new qTest case to test the vhost-user-blk-server
Message-ID: <20200605132728.qki62dubz7leqcs5@r>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200604233538.256325-5-coiby.xu@gmail.com>
 <b8b6c706-e726-e7db-8a1c-ad6fce6ce461@redhat.com>
 <20200605062238.bkpcfd7rl2h5d3md@r>
 <9c5e6e80-4ba3-dae0-1314-5eebf7cacd2b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c5e6e80-4ba3-dae0-1314-5eebf7cacd2b@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=coiby.xu@gmail.com; helo=mail-pj1-x1044.google.com
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

On Fri, Jun 05, 2020 at 11:25:26AM +0200, Thomas Huth wrote:
>On 05/06/2020 08.22, Coiby Xu wrote:
>> On Fri, Jun 05, 2020 at 07:01:33AM +0200, Thomas Huth wrote:
>>>> diff --git a/tests/qtest/libqos/vhost-user-blk.h
>>>> b/tests/qtest/libqos/vhost-user-blk.h
>>>> new file mode 100644
>>>> index 0000000000..ef4ef09cca
>>>> --- /dev/null
>>>> +++ b/tests/qtest/libqos/vhost-user-blk.h
>>>> @@ -0,0 +1,44 @@
>>>> +/*
>>>> + * libqos driver framework
>>>> + *
>>>> + * Copyright (c) 2018 Emanuele Giuseppe Esposito
>>>> <e.emanuelegiuseppe@gmail.com>
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License version 2 as published by the Free Software Foundation.
>>>
>>> ... but you've missed the header here :-(
>>
>> Thank you for reminding me of this issue!
>>
>>>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>>>> index 49075b55a1..a7b7c96206 100644
>>>> --- a/tests/qtest/libqtest.c
>>>> +++ b/tests/qtest/libqtest.c
>>>> @@ -31,40 +31,9 @@
>>>>  #include "qapi/qmp/qlist.h"
>>>>  #include "qapi/qmp/qstring.h"
>>>>
>>>> -#define MAX_IRQ 256
>>>>  #define SOCKET_TIMEOUT 50
>>>>  #define SOCKET_MAX_FDS 16
>>>>
>>>> -
>>>> -typedef void (*QTestSendFn)(QTestState *s, const char *buf);
>>>> -typedef void (*ExternalSendFn)(void *s, const char *buf);
>>>> -typedef GString* (*QTestRecvFn)(QTestState *);
>>>> -
>>>> -typedef struct QTestClientTransportOps {
>>>> -    QTestSendFn     send;      /* for sending qtest commands */
>>>> -
>>>> -    /*
>>>> -     * use external_send to send qtest command strings through
>>>> functions which
>>>> -     * do not accept a QTestState as the first parameter.
>>>> -     */
>>>> -    ExternalSendFn  external_send;
>>>> -
>>>> -    QTestRecvFn     recv_line; /* for receiving qtest command
>>>> responses */
>>>> -} QTestTransportOps;
>>>> -
>>>> -struct QTestState
>>>> -{
>>>> -    int fd;
>>>> -    int qmp_fd;
>>>> -    pid_t qemu_pid;  /* our child QEMU process */
>>>> -    int wstatus;
>>>> -    int expected_status;
>>>> -    bool big_endian;
>>>> -    bool irq_level[MAX_IRQ];
>>>> -    GString *rx;
>>>> -    QTestTransportOps ops;
>>>> -};
>>>
>>> Why do you have to move struct QTestState and friends to the header
>>> instead? I'd prefer if we could keep it here if possible?
>>
>> tests/qtest/vhost-user-blk-test.c needs to talk to qemu-storage-daemon's
>> QMP. Thus I g_new0 a QTestState struct to make use of related functions
>> like qtest_qmp and this requires the QTestState struct definition.
>
>Hm, ok, could that maybe be solved by introducing a wrapper function to
>libqtest.c instead? Something like qtest_create_state_with_qmp_fd() or so?
>Moving a define with a generic name like MAX_IRQ to a header really does
>not sound like a good idea to me, so if that idea with the wrapper
>function does not work out, could you please at least rename MAX_IRQ to
>QTEST_MAX_IRQ or something similar?
I didn't realize the QTestState struct is supposed to be hidden from the user and
not directly accessible. To typedef a struct in a header file and define
the struct in the c file is a new trick for me:)

This idea of creating a wrapper function qtest_create_state_with_qmp_fd
works as expected. Thank you!




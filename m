Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F511C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1F62078D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHgZWPii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1F62078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPPcI-0005oO-I2
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 08:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPPaM-0004V5-Ge
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 08:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPPaI-0005VC-VD
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 08:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601900837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8NJOvh1cLBLWtKb17eeU3bsmu28QA/Fd3HnaAEC7Irg=;
 b=NHgZWPii3edEMr0pWKKE2CYia/N8dp/ABk4HlxuWvKWIxekOslXI5qyqbYcVkHE22fARMM
 8C7ihF9UxKjxb9ZaVElp/DHsIUFL4MIkdJSwK0ldDpHLpDm0x+/B5RtSC9CKai5dRisnBv
 HQ5mMUSs7UuTkq4+Kz0t9PSg6hAx9b4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-4ZVpnz5MOxyM2-0tOTgoag-1; Mon, 05 Oct 2020 08:27:14 -0400
X-MC-Unique: 4ZVpnz5MOxyM2-0tOTgoag-1
Received: by mail-wr1-f69.google.com with SMTP id f11so1739328wro.15
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 05:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8NJOvh1cLBLWtKb17eeU3bsmu28QA/Fd3HnaAEC7Irg=;
 b=CnEjiGyBc1m+ZwYYIqLpp/wXAwJIpvB1cm2UJ9MOCNcIbtXVAXEs4x9Lunmr4LBptz
 FHBdQVBev+OhtNCaaG4VzxtXbQ+yM5A8ivFptbgQV/QV2e6Ja2RjNyn0BA+JnW72SYxz
 lsdBwq2Z/fqQSsHpuy3ehuERZGppul2Ey+3PZE8/kzH4Hru0QtyI60gLAUWDP+Hr+eIk
 HTa1r93C2M5R6Aw4NxXpdTGzp2dCfSWMXW/xZo1W8Oz11tLOdpidr8EY6X6hPNFov+QB
 M+kovYx4bKO5YVxnifQPMqU5e6AVh9KMVA3mbnS8DawDU97zPPbzDx8F3K9usqjdWIx0
 Usgw==
X-Gm-Message-State: AOAM532ZKmHlJX8E3Bu6gSR1hYiAB5Nf1xf/y6C53e1kc1f/vuJe2flq
 DcU24oLQyKcXYxixMnUQ0a3Uc2MDMKowZq3LOdf9xnr/Ob3aW1QDkGPRl+fTq7nyG4lHvp/8YW/
 SePsblYpc7CSxXpQ=
X-Received: by 2002:a5d:4409:: with SMTP id z9mr906274wrq.236.1601900832883;
 Mon, 05 Oct 2020 05:27:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBbK7v9PpLifyj4HRTKi27U56AnN6pX4NwXCkmTYAWZPnNOlowJ9LsW+wCOF8vI2JTHkR/QA==
X-Received: by 2002:a5d:4409:: with SMTP id z9mr906245wrq.236.1601900832656;
 Mon, 05 Oct 2020 05:27:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2e86:3d8b:8b70:920c?
 ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z11sm13207433wru.88.2020.10.05.05.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 05:27:12 -0700 (PDT)
Subject: Re: [PATCH v7 00/14] Reverse debugging
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160174516520.12451.10785284392438702137.stgit@pasha-ThinkPad-X280>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d81369e-3e20-444a-1ad4-197edc0245a9@redhat.com>
Date: Mon, 5 Oct 2020 14:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160174516520.12451.10785284392438702137.stgit@pasha-ThinkPad-X280>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 alex.bennee@linaro.org, mtosatti@redhat.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com, philmd@redhat.com,
 zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/20 19:12, Pavel Dovgalyuk wrote:
> GDB remote protocol supports reverse debugging of the targets.
> It includes 'reverse step' and 'reverse continue' operations.
> The first one finds the previous step of the execution,
> and the second one is intended to stop at the last breakpoint that
> would happen when the program is executed normally.
> 
> Reverse debugging is possible in the replay mode, when at least
> one snapshot was created at the record or replay phase.
> QEMU can use these snapshots for travelling back in time with GDB.
> 
> Running the execution in replay mode allows using GDB reverse debugging
> commands:
>  - reverse-stepi (or rsi): Steps one instruction to the past.
>    QEMU loads on of the prior snapshots and proceeds to the desired
>    instruction forward. When that step is reaches, execution stops.
>  - reverse-continue (or rc): Runs execution "backwards".
>    QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
>    and replaying the execution. Then QEMU loads snapshots again and
>    replays to the latest breakpoint. When there are no breakpoints in
>    the examined section of the execution, QEMU finds one more snapshot
>    and tries again. After the first snapshot is processed, execution
>    stops at this snapshot.
> 
> The set of patches include the following modifications:
>  - gdbstub update for reverse debugging support
>  - functions that automatically perform reverse step and reverse
>    continue operations
>  - hmp/qmp commands for manipulating the replay process
>  - improvement of the snapshotting for saving the execution step
>    in the snapshot parameters
>  - avocado-based acceptance tests for reverse debugging
> 
> The patches are available in the repository:
> https://github.com/ispras/qemu/tree/rr-200901
> 
> v7 changes:
>  - updated snapshot info output format
>  - fixed qcow2 snapshot-related tests

Sorry, I'm still seeing a failure

timeout 15  /home/travis/build/bonzini/qemu/build/qemu-system-aarch64 -monitor none -display none -chardev file,path=memory-replay.out,id=output -icount shift=5,rr=replay,rrfile=record.bin  -M virt -cpu max -display none -semihosting-config enable=on,target=native,chardev=output -kernel memory

qemu-system-aarch64: terminating on signal 15 from pid 38312 (timeout)

https://travis-ci.com/gitlab/bonzini/qemu/jobs/395029273

Paolo



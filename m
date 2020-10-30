Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45D4C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B2720756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYvYObrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B2720756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWAZ-0005ng-UW
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYW7k-00032A-Mh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYW7i-00072S-Bf
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604070924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zm331ISzY+wdNeofPTl4+CzEGhRGPiQrXLmfNYGiVOo=;
 b=ZYvYObrdW/MOJPkyY99GgqZEcXadaOa05BBpCs1MohpnYM2Z2Y9/O+vvxCCNyTcx4pBaji
 PZYEEzBJVHMjzWieYFD+XQt+LfuAXIw0afW9sdeF2GeeHctxHNZAx7iwNCJzAFV4csh+Vp
 WU6GxbAeAPpUdvpZpY7esFfiUEZ9cqQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-Fbc5BvOcOoSvbKK0Z7iZ9A-1; Fri, 30 Oct 2020 11:15:21 -0400
X-MC-Unique: Fbc5BvOcOoSvbKK0Z7iZ9A-1
Received: by mail-ot1-f70.google.com with SMTP id i25so2412813otj.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 08:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zm331ISzY+wdNeofPTl4+CzEGhRGPiQrXLmfNYGiVOo=;
 b=RORzjUc7J6+MM0ZYrnACbFMxBDRTSirMVs0YeMGEKCqe/L2LA1XlIdaGBIEhvk2Y8Y
 glk58NajfEmfJTB2dpz3vU8pysEysh/H02w/8WRIn4Mve00RJbTyq5enqB8qHokcqMml
 ZgbhazzEQgEqMBnrWCASMyAEjOBPI0taaEGENXk3ddQZ/b0YCYrlXPZRBaDoZrwDUBTe
 rZ/JBa1MFfQ+MNq76+KTkBxPJgKJ6SJLIob+Cwfwr2WjXNehxGDLAeHMHrK7qzMI/y2M
 VnejfZUKK3R5lyDntFbl+mTfF7XKdTv/F4k2QfwwAif47m/5jGzTaiSYQed3BGwsGEYr
 rctA==
X-Gm-Message-State: AOAM531xfad724iMXBFOthoovUJhZYltyjTKSnpmJTJ6GIQ6ovq1lnQp
 u7qFOuR8odx7ZwQRWoI2ro1anP5LBQVX6oZGx08gnBCgNsTN50GjtOW5zmzTPiNqzCZqieZAJ0+
 V0pByZgL+k24qSDfcNCNBDF4uwk+1KP0=
X-Received: by 2002:a9d:6419:: with SMTP id h25mr2119910otl.79.1604070921034; 
 Fri, 30 Oct 2020 08:15:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWtT0biTHK9KSzBC4advdxfQo/zFvLsJTbgWWr2+w/uWqa8/aBoQKlSvaufGoLybUbcuPUKIxgLUmhA1WfeQ0=
X-Received: by 2002:a9d:6419:: with SMTP id h25mr2119886otl.79.1604070920702; 
 Fri, 30 Oct 2020 08:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201006072947.487729-1-pbonzini@redhat.com>
 <20201006072947.487729-35-pbonzini@redhat.com>
In-Reply-To: <20201006072947.487729-35-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 30 Oct 2020 16:15:09 +0100
Message-ID: <CAP+75-XRQ4uqhtn12kPe9gOrH269rOpW3SowHEj_KqkX=zAeoQ@mail.gmail.com>
Subject: Re: [PULL 34/37] gdbstub: add reverse continue support in replay mode
To: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pavel,

On Tue, Oct 6, 2020 at 9:41 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> This patch adds support of the reverse continue operation for gdbstub.
> Reverse continue finds the last breakpoint that would happen in normal
> execution from the beginning to the current moment.
> Implementation of the reverse continue replays the execution twice:
> to find the breakpoints that were hit and to seek to the last breakpoint.
> Reverse continue loads the previous snapshot and tries to find the breakpoint
> since that moment. If there are no such breakpoints, it proceeds to
> the earlier snapshot, and so on. When no breakpoints or watchpoints were
> hit at all, execution stops at the beginning of the replay log.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Message-Id: <160174522930.12451.6994758004725016836.stgit@pasha-ThinkPad-X280>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  exec.c                    |  1 +
>  gdbstub.c                 | 10 +++++-
>  include/sysemu/replay.h   |  8 +++++
>  replay/replay-debugging.c | 72 +++++++++++++++++++++++++++++++++++++++
>  softmmu/cpus.c            |  5 +++
>  stubs/replay.c            |  5 +++
>  6 files changed, 100 insertions(+), 1 deletion(-)
...
> +static void replay_continue_stop(void *opaque)
> +{
> +    Error *err = NULL;
> +    if (replay_last_breakpoint != -1LL) {
> +        replay_seek(replay_last_breakpoint, replay_stop_vm_debug, &err);
> +        if (err) {
> +            error_free(err);
> +            replay_continue_end();
> +        }
> +        return;
> +    }
> +    /*
> +     * No breakpoints since the last snapshot.
> +     * Find previous snapshot and try again.
> +     */
> +    if (replay_last_snapshot != 0) {
> +        replay_seek(replay_last_snapshot - 1, replay_continue_stop, &err);
> +        if (err) {
> +            error_free(err);
> +            replay_continue_end();
> +        }
> +        replay_last_snapshot = replay_get_current_icount();
> +        return;
> +    } else {
> +        /* Seek to the very first step */
> +        replay_seek(0, replay_stop_vm_debug, &err);
> +        if (err) {
> +            error_free(err);
> +            replay_continue_end();
> +        }
> +        return;
> +    }

Coverity (CID 1433220) reports this is dead code:

> +    replay_continue_end();
> +}
> +



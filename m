Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A975BFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 21:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E26321835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 21:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVJQq5xU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E26321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLDAq-0003Kg-KK
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 17:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1iLD9p-0002Y6-A6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1iLD9n-0006QF-IZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:18:05 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:45872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1iLD9n-0006Q7-Dw; Thu, 17 Oct 2019 17:18:03 -0400
Received: by mail-qt1-x843.google.com with SMTP id c21so5725496qtj.12;
 Thu, 17 Oct 2019 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vaEKmaPeq1xSe702SZ3lyHA8uaCT2MpximewTaGvhWY=;
 b=dVJQq5xU82rIxiCqlynn6EdSyuKoF1oJ3hsaNJFTTrKwXlkgkqtTkM6PSH9kAtl5N9
 +pPLN4gAjt5w+PoVTokM5o0PkOgLtPuXW5MJWqIDYfcqGeOTRqxRiNZhrErd9MfFEg2W
 dz/tiqCwleBUSraIrvcHtUeqS0F7TMQ+eNLP3vSj/RbU6Z5Mj7mTC83htcSXwhswZgFe
 d68lBvdh4Cwshp1rF2XVcLHCeUTGxvKUESE3eIqAPAv93k46a8hzt92oIrpc/hEphw2/
 XSWfkH5mFKBhk7E61qK29C/ZH0hoW1VKRylcYUq6rlpRf4zjkLE4StclljrO254Lamai
 dl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vaEKmaPeq1xSe702SZ3lyHA8uaCT2MpximewTaGvhWY=;
 b=spwgWSsNKBqXXYMOcCZDpxnxxexAChICmQ2zSuEqRqZ0BlythntF2+K7qwnQ4FwIAi
 EHezdbhTz5FHYOP/DZHlr/VvFsgoa1MSjYidSTpQooVj+TUzZ3Q+MdP3k77kDKwPaBq8
 iqJmtD3wOp5TugR3oDH1t1RCckh3FNkRGYRxsPX21dmXHOJkbe4VH4fp0n5ED8M26ReU
 F+471ehF08kODjhZjUQAMP0x3uZHkQOUDIhc0tZBHnubVzUZQSrpsfidIcPUjNyBHE60
 YgViYUrYPPvZJPW4UX1dyVJ2nSGB3LxYrqwBaKenwhvkn5CNGoZPROkYrGTHUUBvMAQh
 vy6w==
X-Gm-Message-State: APjAAAWHpx1qEN62oCnivvCDnN1WvWFI2a+vyE2QSnzr8EluRfcgH+cl
 4VQoGwQkUhfhiXUW+OFVhA==
X-Google-Smtp-Source: APXvYqyla5RBT/44/oPWqYf5VQmBz9futWzy+c/2SFWzZy0o2LNrs4u+nuRfjFTFYu9PS6W89MrALQ==
X-Received: by 2002:ac8:38bb:: with SMTP id f56mr6120253qtc.154.1571347082604; 
 Thu, 17 Oct 2019 14:18:02 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id d2sm1573133qkj.123.2019.10.17.14.18.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Oct 2019 14:18:02 -0700 (PDT)
Date: Thu, 17 Oct 2019 17:17:59 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
Message-ID: <20191017211758.ownflk2c7mzv3poh@gabell>
References: <20191016143410.5023-1-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016143410.5023-1-drjones@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

Thank you for posting the patches, they seems to work well
because the softlockup is gone and the timestamp jump of
dmesg and ftrace record also disappeared after the guest
is virsh resume'ed.

Let me add comments.
I think the kvm-adjvtime behavior should be the default.
How about introducing 'kvm-noadjvtime' parameter instead?
kvm-noadjvtime is to provide the old behavior.

That is because the time jump occurs timeout for timers even though
the timer doesn't reach the timeout in the guest time.

For example, below flow shows that user and/or kernel sets timer A
for +10 sec and B for +20 sec in Guest, then Guest is suspended and
it passes 60 sec, then Guest is resumed. Timer A and B go off because
the Guest timestamp (TS) is jumped to 63. That is unexpected timer
behavior for Guest.

 Host TS(sec) Guest TS(sec) Event
 ============ ============= =============================
 00           00            Guest: Set timer A for +10 sec
 01           01            Guest: Set timer B for +20 sec
 03           03            Host: virsh suspend Guest
 63           63            Host: virsh resume Guest
                            Guest: Timer A and B go off

I believe kvm-adjvtime behavior is as following. So Time A
and B go off as expected time. So, kvm-adjvtime behavior should
be the default.

 Host TS(sec) Guest TS(sec) Event
 ============ ============= =============================
 00           00            Guest: Set timer A for +10 sec
 01           01            Guest: Set timer B for +20 sec
 03           03            Host: virsh suspend guest
 63           03            Host: virsh resume guest
 70           10            Guest: Timer A goes off
 81           21            Guest: Timer B goes off

Thanks,
Masa

On Wed, Oct 16, 2019 at 04:34:05PM +0200, Andrew Jones wrote:
> v2:
>  - move from RFC status to v1
>  - put kvm_arm_vm_state_change() in kvm.c to share among kvm32.c and kvm64.c
>  - add r-b's from Richard
> 
> 
> This series is inspired by a series[1] posted by Bijan Mottahedeh about
> a year ago.  The problem described in the cover letter of [1] is easily
> reproducible and some users would like to have the option to avoid it.
> However the solution, which is to adjust the virtual counter offset each
> time the VM transitions to the running state, introduces a different
> problem, which is that the virtual and physical counters diverge.  As
> described in the cover letter of [1] this divergence is easily observed
> when comparing the output of `date` and `hwclock` after suspending the
> guest, waiting a while, and then resuming it.  Because this different
> problem may actually be worse for some users, unlike [1], the series
> posted here makes the virtual counter offset adjustment optional and not
> even enabled by default.  Besides the adjustment being optional, this
> series approaches the needed changes differently to apply them in more
> appropriate locations.  Finally, unlike [1], this series doesn't attempt
> to measure "pause time" itself.  Simply using QEMU_CLOCK_VIRTUAL, which
> only ticks when the VM is not stopped, is sufficient.
> 
> I've based this series on the SVE series[2] because we're adding a new
> CPU feature (kvm-adjvtime) and the SVE series introduces CPU feature
> documentation, probing, and tests that we can then immediately apply
> to kvm-adjvtime.
> 
> Additional notes
> ----------------
> 
> Note 1
> ------
> 
> As described above, when running a guest with kvm-adjtime enabled it
> will be less likely the guest OS and guest applications get surprise
> time jumps when they use the virtual counter.  However the counter will
> no longer reflect real time.  It will lag behind.  If this is a problem
> then the guest can resynchronize its time from an external source or
> even from its physical counter.  If the suspend/resume is done with
> libvirt's virsh, and the guest is running the guest agent, then it's
> also possible to use a sequence like this
> 
>  $ virsh suspend $GUEST
>  $ virsh resume $GUEST
>  $ virsh domtime --sync $GUEST
> 
> in order to resynchronize a guest right after the resume.  Of course
> there will still be time when the clock is not right, possibly creating
> confusing timestamps in logs, for example, and the guest must still be
> tolerant to the time synchronizations.
> 
> Note 2
> ------
> 
> Userspace that wants to set KVM_REG_ARM_TIMER_CNT should beware that
> the KVM register ID is not correct.  This cannot be fixed because it's
> UAPI and if the UAPI headers are used then it can't be a problem.
> However, if a userspace attempts to create the ID themselves from the
> register's specification, then they will get KVM_REG_ARM_TIMER_CVAL
> instead, as the _CNT and _CVAL definitions have their register
> parameters swapped.
> 
> Note 3
> ------
> 
> I didn't test this with a 32-bit KVM host, but the changes to kvm32.c
> are the same as kvm64.c. So what could go wrong? Test results would be
> appreciated.
>  
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05713.html
> [2] https://patchew.org/QEMU/20191001125845.8793-1-drjones@redhat.com/
> 
> Thanks,
> drew
> 
> 
> Andrew Jones (5):
>   target/arm/kvm64: kvm64 cpus have timer registers
>   timer: arm: Introduce functions to get the host cntfrq
>   target/arm/kvm: Implement cpu feature kvm-adjvtime
>   tests/arm-cpu-features: Check feature default values
>   target/arm/cpu: Add the kvm-adjvtime CPU property
> 
>  docs/arm-cpu-features.rst | 27 +++++++++++++++++-
>  include/qemu/timer.h      | 16 +++++++++++
>  target/arm/cpu.c          |  2 ++
>  target/arm/cpu.h          |  3 ++
>  target/arm/cpu64.c        |  1 +
>  target/arm/kvm.c          | 59 +++++++++++++++++++++++++++++++++++++++
>  target/arm/kvm32.c        |  3 ++
>  target/arm/kvm64.c        |  4 +++
>  target/arm/kvm_arm.h      | 25 +++++++++++++++++
>  target/arm/monitor.c      |  1 +
>  tests/arm-cpu-features.c  | 48 +++++++++++++++++++++++++------
>  11 files changed, 179 insertions(+), 10 deletions(-)
> 
> -- 
> 2.21.0
> 
> 


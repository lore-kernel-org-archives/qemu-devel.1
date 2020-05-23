Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53984C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 21:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0F6207D4
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 21:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="fW9oZS44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0F6207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcbpF-0006kY-8l
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 17:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcboY-00065k-DD
 for qemu-devel@nongnu.org; Sat, 23 May 2020 17:36:19 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:35375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcboV-00082I-KE
 for qemu-devel@nongnu.org; Sat, 23 May 2020 17:36:18 -0400
Received: by mail-qt1-x842.google.com with SMTP id z18so11263727qto.2
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=F15VVDw5KVf3BIXAM4AHqRsjVBgL0J+hAL6p6fX3rwI=;
 b=fW9oZS44Gu/nKlDlxlBpYTH7iNd9JNTYkgu8ficqwSXWd/74gpeW7vN6dkX+dkGrCR
 fB6AvcijK6adduT6vNzHjI4eIM838+0+KgryCh1CB4GZSpgCzzR/J1egvC6Z8nNJjy6z
 UtSNUZcfcfYOXr27LkfbhpUKT/Lv4c4xSLaCde9Vjs+dRczr+3r1P1UzArRcvRAdIOBJ
 xxGcfPDlpSmEu9lbe+hyVeAg11PsmppUQj+JBTVJYNL/+cRi3Ka1EKLCBcwHCQu04N3F
 v7IdAqQUvnGcNLVsaC1qnT2U5JKZXHCkrDjjhqD7CjbY6GGwSoosfnFjy+wQZAS6Y7sP
 r+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=F15VVDw5KVf3BIXAM4AHqRsjVBgL0J+hAL6p6fX3rwI=;
 b=Qihv6H0MBJSOkC0f6w5A8T1rHq2eQ2Abjg7KnJlOADmEmlBGDESfdgZ2OhdH7UltAO
 ZL1VRYFYee4nU/6Z9O0b7cUyL60AoMIyehCMoJkyldes2x08HZAn0UAwjADnG7ZJBir1
 j6zxkwFCz58iHCzr9/agHjYzP69Se/WkD/6zCmc4ofQq0qwg8rXdYnfmjoZ5yWIfXwJX
 mSOpktH3TMpxAq4CnlJW7x2hEiTP266mkAIXdRwBE2x4/+3XArUmFIOUwjO7C14foPZ4
 FebR4vJkgsahpm2g7DzVLjge5FQm9oDk6hUhMHsKZw5H2wAMHyjG9a3NucBEJocsLg8+
 Ybhw==
X-Gm-Message-State: AOAM533f3222x0ovi85koy7yamcwSiXcVq2kJmmpm5VgDsauSF+i4IeQ
 l080ESpbbhDUlRRA1r4/kR/hlw==
X-Google-Smtp-Source: ABdhPJxmub3qLD3cTNdN6wTOJhA9wc4gKzd7Gqxml/TGMMwRJ2Qm1FFwi29x7N1RrIVDublCDr9nBw==
X-Received: by 2002:ac8:2c44:: with SMTP id e4mr22740689qta.13.1590269774005; 
 Sat, 23 May 2020 14:36:14 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id m33sm11174520qte.17.2020.05.23.14.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 14:36:13 -0700 (PDT)
Date: Sat, 23 May 2020 17:36:12 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 00/19] Add Thread Sanitizer support to QEMU
Message-ID: <20200523213612.GJ382220@sff>
References: <20200522160755.886-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::842;
 envelope-from=cota@braap.org; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 12:07:36 -0400, Robert Foley wrote:
> This patch series continues the work done by Emilio Cota and others to add
> Thread Sanitizer (TSan) support to QEMU.
> 
> The starting point for this work was Emilio's branch here:
> https://github.com/cota/qemu/commits/tsan
> specifically this commit: 0be125fc0afd47218b34d2019abdd19b644f3199
> 
> The purpose of this patch is not to fix all the TSan warnings, but to enable
> the TSan support so that QEMU developers can start using the tool.  
> We found this tool useful and even ran it on our recent changes in
> the cpu-locks series.
> Clearly there is work to do here to clean up all the warnings. :)  
> We have made a start to cleaning up these warnings by getting a VM to boot 
> cleanly with no TSan warnings.  
> We have also made an effort to introduce enough of the TSan suppression
> mechanisms, so that others can continue this work.

Thank you for doing this work! Great to see this finally coming along.

What are your plans wrt the per-cpu-lock branch? Given that some of
the races reported here are fixed there, I think it would make sense to
defer those patches to the per-cpu-lock series (i.e. patches 2/19, parts
of 13/19, and 18/19) so that this series goes in first (it is a lot
less likely to break anything).

Also, I would not worry too much about rushing to bring warnings to
0; what's important is that with the warnings we now know where to
focus on, and then we can carefully fix races. In particular I think
all annotations we add must have a comment, since otherwise we are
at the risk of blindlessly silencing warnings of real races.

> Issues:
> - When running docker-test-quick under TSan there are several tests which hang
>   - The unit tests which seem to hang under TSan:
>     test-char, test-qdev-global-props, and test-qga.  
>   - If we comment out those tests, check-unit finishes, albeit with 
>     a couple of warnings. :)

I've noticed another issue (that I did not notice on my previous
machine), which is that tsan blows up when in qht we lock all
of the bucket's locks. We then get this assert from tsan, since
it has a static limit of 64 mutexes held at any given time:

FATAL: ThreadSanitizer CHECK failed: /build/llvm-toolchain-10-yegZYJ/llvm-toolchain-10-10.0.0/compiler-rt/lib/sanitizer_common/sanitizer_deadlock_detector.h:67 "((n_all_locks_)) < (((sizeof(all_locks_with_contexts_)/sizeof((all_locks_with_contexts_)[0]))))" (0x40, 0x40)
    #0 __tsan::TsanCheckFailed(char const*, int, char const*, unsigned long long, unsigned long long) <null> (qemu-system-aarch64+0x49f9f5)
    #1 __sanitizer::CheckFailed(char const*, int, char const*, unsigned long long, unsigned long long) <null> (qemu-system-aarch64+0x4b651f)
    #2 __sanitizer::DeadlockDetectorTLS<__sanitizer::TwoLevelBitVector<1ul, __sanitizer::BasicBitVector<unsigned long> > >::addLock(unsigned long, unsigned long, unsigned int) <null> (qemu-system-aarch64+0x4aacbc)
    #3 __sanitizer::DD::MutexAfterLock(__sanitizer::DDCallback*, __sanitizer::DDMutex*, bool, bool) <null> (qemu-system-aarch64+0x4aa22e)
    #4 __tsan::MutexPostLock(__tsan::ThreadState*, unsigned long, unsigned long, unsigned int, int) <null> (qemu-system-aarch64+0x49ded8)
    #5 __tsan_mutex_post_lock <null> (qemu-system-aarch64+0x48175a)
    #6 qemu_spin_lock /home/cota/src/qemu/include/qemu/thread.h:245:5 (qemu-system-aarch64+0xb1283b)
    #7 qht_map_lock_buckets /home/cota/src/qemu/util/qht.c:253:9 (qemu-system-aarch64+0xb1283b)

A workaround for now is to run qemu with TSAN_OPTIONS=detect_deadlocks=0,
although selectively disabling tsan for qht_map_lock/unlock_buckets would
be ideal (not sure if it's possible).

Another warning I'm reliably seen is:
WARNING: ThreadSanitizer: double lock of a mutex (pid=489006)
    #0 pthread_mutex_lock <null> (qemu-system-aarch64+0x457596)
    #1 qemu_mutex_lock_impl /home/cota/src/qemu/util/qemu-thread-posix.c:79:11 (qemu-system-aarch64+0xaf7e3c)

  Location is heap block of size 328 at 0x7b4800114900 allocated by main thread:
    #0 calloc <null> (qemu-system-aarch64+0x438b80)
    #1 g_malloc0 <null> (libglib-2.0.so.0+0x57d30)

  Mutex M57 (0x7b4800114960) created at:
    #0 pthread_mutex_init <null> (qemu-system-aarch64+0x43b74d)
    #1 qemu_rec_mutex_init /home/cota/src/qemu/util/qemu-thread-posix.c:119:11 (qemu-system-aarch64+0xaf815b)

But this one seems safe to ignore.

Thanks,
		E.


Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DDAC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022DB2051A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNugCwK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022DB2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6BI-0004HE-31
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1is6AM-0003W5-0D
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1is6AK-0007ze-Le
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:30:33 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1is6AK-0007zA-D5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:30:32 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so4052991wma.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 06:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jDeWn4KMWvKfXeptFKRM1nCWg4CoKMdgNTp06h55Gws=;
 b=DNugCwK8GOTzSRJmhO6ZTZG8EBgPdkx95wp6FIuJRTXCwxIU1Jqc0EmdirxRbwZkGP
 L12iOhl9/B67/smNXWpI7blst5n7SAc1/Q1tDl+YeFU4UGIPxt/zbly8+1dCW7/kf0sb
 XaCghhyHSffs/3X3FFF5OWxCHGj1a43/82e6PeCNt7K1ZF6CVxX7RrahVqV1sexQhm5l
 8lsceM85fQHaZ3P/foI7P8yjZ0ANGNHsbCtaZm7rd78Ue2k9VGs/kYHSOvKqsvA5mhRQ
 qexxXY4PGmxD80qWxHO9BVj5fcKtkZvNJ6UV1H/kzQKThwO3fbS8zA2cvyRsJBRCACIj
 rtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jDeWn4KMWvKfXeptFKRM1nCWg4CoKMdgNTp06h55Gws=;
 b=WIv74QCXZJVV5F59iz5zMJwh1gt+cPK5kK2bSRS0W5mFRo6HYkOau7iBoAYDUR6A0u
 TRia8ROz9WRxmKPwF/WNyF2W4uqmRDvBZl7Ux5TFomTLU6+zS7u7t3aWQRo32oz3kRJc
 hPjB8ZfBwqovdCCWlKSpHs6F1xuoV+LvW6vKMhiW/tLzUHtp2ct3rRkH+r7urVVfehvW
 jZqx/8WCXwFtzAh4i5e0drfj1vIKGSdRHiPnxvEFXKQecA7yJvMJg1z0O/5LMFMOPj2K
 1iiPfP0JbUv/JsFHxPlwddyU/I64J8fwByfxsYK0YLA3+QLzZsj00DEtN5ddVOmSpC76
 LVtA==
X-Gm-Message-State: APjAAAX7u7+Y48GK/Tg70S7MHlGIH72W9E4ZpxS0gpRM0qRw59h7fMzp
 KC8uj5KPB+I0JLY4f80VfLJwKQ==
X-Google-Smtp-Source: APXvYqx2pXQMBW7h3d5lgeKlg+un/K0xuTtL1xKYr05bM/zf9EDtCShbyZKBHs1ZisBpMRqxKVt+dQ==
X-Received: by 2002:a7b:cd11:: with SMTP id f17mr6597250wmj.48.1579185031062; 
 Thu, 16 Jan 2020 06:30:31 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i16sm5163926wmb.36.2020.01.16.06.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 06:30:29 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FA601FF87;
 Thu, 16 Jan 2020 14:30:28 +0000 (GMT)
References: <20200114210921.11216-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/3] linux-user: Implement x86_64 vsyscalls
In-reply-to: <20200114210921.11216-1-richard.henderson@linaro.org>
Date: Thu, 16 Jan 2020 14:30:28 +0000
Message-ID: <87imlblbi3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, riku.voipio@iki.fi,
 laurent@vivier.eu, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The x86_64 abi has a legacy vsyscall page.  The kernel folk
> have been trying to deprecate this since at least v3.1, but
>
> (1) We don't implement the vdso that replaces vsyscalls,
> (2) As of v5.5, the vsyscall page is still enabled by default.
>
> This lack is affecting Peter's linux-user testing.
>
> The dependency is not obvious because Peter is running the tests
> on x86_64, so the host is providing a vsyscall page to qemu.
>
> Because of how user-only memory operations are handled, with no
> validation of guest vs host pages, so long as qemu chooses to
> run with guest_base =3D=3D 0, the guest may Just So Happen to read
> the host's vsyscall page.
>
> Complicating this, new OS releases may use a kernel configured
> with CONFIG_LEGACY_VSYSCALL_XONLY=3Dy, which means the the vsyscall
> page cannot be read, only executed.  Which means that the guest
> then cannot read the host vsyscall page during translation and
> will SIGSEGV.
>
> Exactly which of these many variables is affecting Peter's testing
> with Ubuntu 18.04 of my TCG merge, I'm not exactly sure.  I suspect
> that it is the change to drop the textseg_addr adjustment to user-only
> static binaries.  IIRC bionic does not support -static-pie, which is
> the preferred replacement.  This could mean that the host and guest
> binaries overlap, which leads to guest_base !=3D 0.
>
> I vaguely remember someone (Paolo?) implementing something like
> this many years ago, but clearly it never got merged.
>
> In any case, this emulation has been missing for too long.
>
>
> r~
>
>
> Richard Henderson (3):
>   target/i386: Renumber EXCP_SYSCALL
>   linux-user/i386: Split out gen_signal
>   linux-user/i386: Emulate x86_64 vsyscalls

And realising I didn't read it properly:

/x86_64-linux-user/qemu-x86_64 ~/lsrc/linux.git/tools/testing/selftests/x86=
/test_vsyscall_64
[WARN]  failed to find vDSO
        no vsyscall map in /proc/self/maps
[RUN]   test gettimeofday()
[RUN]   test time()
[RUN]   getcpu() on CPU 0
[RUN]   getcpu() on CPU 1
[RUN]   Checking read access to the vsyscall page
[OK]    We do not have read access: #PF(0x4)
[RUN]   Make sure that vsyscalls really page fault
**
ERROR:/home/alex/lsrc/qemu.git/linux-user/x86_64/../i386/cpu_loop.c:185:emu=
late_vsyscall: assertion failed: (ret !=3D -TARGET_EFAULT)
qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x7f6eed=
31b613

--=20
Alex Benn=C3=A9e


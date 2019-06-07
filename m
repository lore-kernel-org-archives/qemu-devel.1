Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989CEC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F0520B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwY6p3fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F0520B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEvP-000643-Kv
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZEsI-00054F-4e
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZEsG-0001cE-L4
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:25:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZEsG-0001a5-DF
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:25:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id m3so2191022wrv.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yrTmg6m6zwK1mxwAMHX5sRfYhuRiHtdGE0AYTWxXtOw=;
 b=WwY6p3fgOreDc1K6ZbDxIK8vJpe5lYBKE3YmzwNtg96luCa8x/4oJi7BINkRxvX2WV
 BvBSas4fUAL2RryzK5XYk//i1dD23Ioep7I8uPdfWY5J8ndUuiVB2v09z1np0Hzi8vEg
 0S4u0fwpe57np/ru9zwn+CGyIKn5LsF1OFMz8DWfUq9JI22MLcy29buRZkmBGBOb17Tf
 Crpk8NxkwKha0uXLdBMUt+Q9pr6LW6VHmzs1mM6RP/K2equhxYUm76z1tUU4/luBAF+h
 y+/SEM6I0SDRYkTv3cXispXCTK1DFoTN5qKmBoi4KDP3NurZ8YI05xZUUUq/tQlzd0rs
 KRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yrTmg6m6zwK1mxwAMHX5sRfYhuRiHtdGE0AYTWxXtOw=;
 b=iZRVNeUtqrTgT05FHDzyL67PIyxfzkr4vEqKziFQKAkQRX9WDs1ty8AArJeyST2uhl
 O3O6WYhsIDLIPEXSR6ktGdK6CusGEEgHZZMiiliZFLQ81QMUZ87k9O/MO+UIET0rHVVR
 HIRvjNz0ZnvEQ7GzN1m7Wgfyv207kbyzIJIuUsiOUoBPjkmU0zkX68+lEmiVLlILipnL
 rKtjzBZPq9/AqxVWcVBu3/uWsHjEbyUB0SyA90TRlOaFxF1B7G2mYHhMLQdDPT81+Ck1
 3c+ohEUT1ZtBDIFlN6TADePWN9QkYAusuEhbiUdV8acDZN66pkjPre58ZyqolOpnEb+l
 I7Jg==
X-Gm-Message-State: APjAAAVtOD0xFRfWk17at76rHyl1rd1N0wxYcmgV3Ybxh/sXQN3L8q0i
 Ql6uTUG8zbIigUeGg1AtIvTmoQGU9yw=
X-Google-Smtp-Source: APXvYqw+5wm+eaUEkjtO3kPZdLJQZ2lcRhXlexikJliMvEXwozwRISNqFiD0YhgFXQEYyW8dNyfzLw==
X-Received: by 2002:a5d:52c7:: with SMTP id r7mr32601887wrv.110.1559913939048; 
 Fri, 07 Jun 2019 06:25:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d18sm2088525wrn.26.2019.06.07.06.25.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 06:25:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D6A01FF87;
 Fri,  7 Jun 2019 14:25:37 +0100 (BST)
References: <20190607090552.12434-1-alex.bennee@linaro.org>
 <CAFEAcA8uT68z7dd85JH30v6PDzABtwZs6MjLui5jJFEW3Niybw@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA8uT68z7dd85JH30v6PDzABtwZs6MjLui5jJFEW3Niybw@mail.gmail.com>
Date: Fri, 07 Jun 2019 14:25:37 +0100
Message-ID: <87ef45sf1q.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PULL 00/52] testing, gdbstub and cputlb fixes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Jun 2019 at 10:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> The following changes since commit 0d74f3b4277a7ecb0ccb80c865797d11f8e46=
6f5:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull=
-request' into staging (2019-06-06 14:09:14 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-testing-gdbstub-cputlb-0=
70619-1
>>
>> for you to fetch changes up to 611a3db380ef9f670c5c82837c4889f7e19ded10:
>>
>>   gdbstub: Implement qemu physical memory mode (2019-06-07 08:39:03 +010=
0)
>>
>> ----------------------------------------------------------------
>> Various fixes and updates:
>>
>>   - editor config tweak for shell scripts
>>   - iotest updates (still not default for make check)
>>   - various docker updates
>>   - gcc/ubsan updates for travis
>>   - clean-ups for tests/vm including autoinstall
>>   - semihosting fix for Coverity
>>   - fixes for cputlb in 64-on-32 cases
>>   - gdbstub re-factor + maintainership update
>>
>
> This seems to break the tests/vm testing I do. Eg openbsd:
>
> hackbox mergebuild: seq openbsd
> make: Entering directory '/home/peter.maydell/qemu-openbsd/build'
> python3 -B /home/peter.maydell/qemu-openbsd/tests/vm/openbsd  --debug
> --image "/home/peter.maydell/.cache/qemu-vm/images/openbsd.img"
> --force --build-image
> /home/peter.maydell/.cache/qemu-vm/images/openbsd.img
> ### Downloading install iso ...
> ### Preparing iso and disk image ...
> Formatting '/home/peter.maydell/.cache/qemu-vm/images/openbsd.img.tmp',
> fmt=3Dqcow2 size=3D21474836480 cluster_size=3D65536 lazy_refcounts=3Doff
> refcount_bits=3D16
> ### Booting installer ...
> DEBUG:root:QEMU args: -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
> file=3D/home/peter.maydell/.cache/qemu-vm/images/openbsd.img.tmp,if=3Dnon=
e,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
> -cdrom /home/peter.maydell/.cache/qemu-vm/images/openbsd.img.install.iso
> DEBUG:qemu:VM launch command: 'qemu-system-x86_64 -chardev
> socket,id=3Dmon,path=3D/var/tmp/tmpcex0zicz/qemu-6023-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
> socket,id=3Dconsole,path=3D/var/tmp/tmpcex0zicz/qemu-6023-console.sock,se=
rver,nowait
> -serial chardev:console -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
> file=3D/home/peter.maydell/.cache/qemu-vm/images/openbsd.img.tmp,if=3Dnon=
e,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
> -cdrom /home/peter.maydell/.cache/qemu-vm/images/openbsd.img.install.iso'
> DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
> DEBUG:QMP:<<< {'return': {}}
> DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments':
> {'command-line': 'info usernet'}}
> DEBUG:QMP:<<< {'return': 'VLAN -1 (vnet):\r\n  Protocol[State]    FD
> Source Address  Port   Dest. Address  Port RecvQ SendQ\r\n
> TCP[HOST_FORWARD]  13       127.0.0.1 37043       10.0.2.15    22
> 0     0\r\n'}
> console: *** read timeout ***

This seems to be a bug with the QEMU's installed on hackbox. If I do:

  set -x QEMU /home/alex.bennee/lsrc/qemu.git/x86_64-softmmu/qemu-system-x8=
6_64

(in this case current PR)

And run the vm-test targets they work (or at least the ones I've tried
so far, I'm just kicking off a full build).

--
Alex Benn=C3=A9e


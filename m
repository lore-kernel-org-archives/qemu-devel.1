Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E978C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 20:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779E1207DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 20:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OpyuHvsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779E1207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2hMn-0001ML-6s
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 16:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2hJ1-0000kv-LC
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 16:43:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:47077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2hIz-0004UJ-1H
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 16:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596487400;
 bh=xf0m145lJ+YIMGuIoVJYUn5XjpjrGTBWDFrWe9Du6vU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=OpyuHvsvYG+TkflM4eg0bGUO7E1+tsMmwXwh2069c1WCaghjI4Xk5D1y9spN7bnsR
 nnQwT1oIbPZcWNpFSvwMe7YT8INGQXvemKT26OwpfPgCFQOuPl13474Vf1xftAPtpL
 zO4YUHond4Lrv2mLnT+ONzv/PPiCkkv8uKBjPI5A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.134.145]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mulm5-1kuNz92bkR-00rqBK; Mon, 03
 Aug 2020 22:43:20 +0200
Subject: Re: [PATCH v2 4/4] hw/display/artist.c: fix out of bounds check
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200801131357.17379-1-deller@gmx.de>
 <20200801131357.17379-5-deller@gmx.de>
 <20200803173604.qtryrjnnubcpgoxq@mozz.bu.edu>
 <20200803183252.74z3czd2o5t2twjp@mozz.bu.edu>
 <20200803191021.dgqkmqajjutt4wei@mozz.bu.edu>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <6aa44e95-9db9-cbb5-2562-ddf18fea8341@gmx.de>
Date: Mon, 3 Aug 2020 22:43:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200803191021.dgqkmqajjutt4wei@mozz.bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6UyF/bMArUzQnlZ0FEWcTU8fT4/VR1c4oAV5XUXLh8wc9QUtyKg
 +N15ZOzjGVWlpseAf5fO7xSHcarIq2MTH5UZHkmIkye7mqxX20gyYWTAM3VoYGKQ15O9Y2D
 ftRqesl/365QQYPuRbG0oLtdqOqY4lBM9gMxs7YJ7wKxJ26XSllakHyCbOAy1l1XUnkdZTz
 p167iqmBg/ET9ChG0yO8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jMz9YEuxMGQ=:vBRhYnVAgYapJgzVsusyLX
 bySXifU2kHY5ctbeePTuKwQxLwf+LTeiM4BGR4FLEIXohqVY9oOVoEC1RHkriOq4mggWq0kWu
 e8hFTpOesLEV51j8cDkZzq4DjXVYcXwBRNYRAI7YwO0kroAginTsGnWmWARM+5Sfut4tXdFWS
 PzdY10h0lmrqX2oqdGnINxlIS7h64n6gMyYRpyaJsWb5EOLJVwu11yVwA8/dnsOd6vOBqE7qS
 XN6wW2c7wmARSdwkxeTY128YY8IVbplN6lLKQdsjpbx4TD7wKxkuz3wNoB7iVIR/gW02Sr9uY
 ESbxgFfCHUtRNdA2UiN4Sfy/ThHek7uRnf4OftlJyP0i3swVTq9s+diuqEorzAd9lCzXjL17u
 m3CDSZtBCGgIH3eBAWMvdLl4M3twVP3XKP2J99GWUlsfZaekIFi1ghb4lt3SxSwrVTY+3pTjO
 zCt9wDRDuMkG163J5PqJMzdHL2TJOxkpVXKuESO6d4v0C5UfLnAdI7f2pxkq/BHTzR8hqbAOG
 pUjplToJhTFIsSvhcbNoYh0/UTL2hyo2sbUtI8Ojdo+eA7Sx9pZy4bBqeKI93NWpeV7hPtlTm
 9znFvYCR9ubyklyEPRopk25VLZ689SjiQm2YKZDkJNE6bWzjh9AFZaRyFyMuJhDTMazr4ZKeE
 2mcvbd0MRDvyc52mweiIOjbhMD/07S9jCKJwaKstKetGj/xji+DkzHAgEHWrYsKJuAebAa3N9
 2UUOCIf2+Si6FOEwgAigdWjZWNx5q1sqe1j3lcU6nXv9lU22ZTs1WtOX37DGiIKQWmxUxTMgM
 bOSzBqHTTypAHZHhGWFaBqeoGWqtI5M80WaROVTf9ldWSWayS0rPpmI6XZydTqmWGLrGfMWrE
 NqJyHPo3vX9exT5F69z8kxQbbktTYHVQ5MHgYnoKvkFcgdM7dxg/fiKSVQp6YWfkY4l9RuAbk
 mE0HBQ+zEVqp63liNqhnMKyAEapiylusILqXtMWBnBwMsikjsUUXAUNUf+lPUsX2ppBIWxUAp
 MJ/8clB85pz/3ntiVmxf7ovX1jEZz1GNdFV11qb/7MJmRtTzq1lqGWMZfxyZZ/WjLC/WhFIAp
 EBOkWVwsw+focpx8qmc3s5D2s0qZfDPu1sDtr21FUFakUd5TTZkEjUHGUTGQYcCktQ358Ds+O
 ka8QaNIkW+i9r83XnLCi4TcNT/vkE/ybGtjzidLCrDLXZXSAhKR/rhVpbr0sC2y3K2bguheV9
 20nikTrj0mYbqvgI5
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 16:43:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03.08.20 21:10, Alexander Bulekov wrote:
> On 200803 1432, Alexander Bulekov wrote:
>> On 200803 1336, Alexander Bulekov wrote:
>>> Hi,
>>> I applied this patch, but I can still trigger a segfault and heap
>>> overread through artist_reg_write -> fill_window. I dont know if these
>>> problems are related to what this patch fixes. If not, let me know and
>>> I can create a separate launchpad report for these.
>>
>> And another one through draw_line...
>> cat << EOF | ./hppa-softmmu/qemu-system-hppa -display none \
>> -qtest stdio -accel qtest
>> writeq 0xf8100e02 0x4f4f4f4f4f939600
>> EOF
>
> I missed that Phil already submitted a report here:
> https://bugs.launchpad.net/qemu/+bug/1880326
>
> and sent a patchset
> https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D178879

Alexander, thanks for finding the bugs, and, Phil, thanks for the patches!

I'll test & review it tomorrow and add into the pull request if Ok.

Helge


>
>> =3D=3D13563=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x7f3=
fe4d403fd (pc 0x55ae401eb392 bp 0x7ffea90ca2d0 sp 0x7ffea90ca1e0 T0)
>> =3D=3D13563=3D=3DThe signal is caused by a READ memory access.
>>     #0 0x55ae401eb392 in artist_rop8 /hw/display/artist.c:284:14
...


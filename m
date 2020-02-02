Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62174C35240
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 09:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216642067C
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 09:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DK/Ju5QZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216642067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyBRy-0007fI-BA
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 04:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyBRJ-00071w-Kh
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyBRG-0001Y6-PI
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:21:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30423
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyBRG-0001We-MG
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580635269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=gs25T6EIjRHJEWWYUHKI0dmsx/iBfpDHz734QjDy3pQ=;
 b=DK/Ju5QZNXtQghI4Tm+EQdtKMkoahHzlTBaTUFUj/MmsTNRpuQcx9Gld2Vunf/nyljL9Qd
 5YfC05ffwx4TuOIxOboiAujsnrv5SjzQhjjp49bhf6Ha5Hkw1KaQaRmkMTG8VDBN6b+Nqt
 e14YgVYaJ8JXb5N690pGCQ0/D5e6Lic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-CUQAAgLuNpOMz2MhLQgU1Q-1; Sun, 02 Feb 2020 04:20:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98EE71882CD4;
 Sun,  2 Feb 2020 09:20:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-47.ams2.redhat.com [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D13C287059;
 Sun,  2 Feb 2020 09:20:49 +0000 (UTC)
Subject: Re: [PULL 32/41] target/mips: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
 <20200108034523.17349-33-richard.henderson@linaro.org>
 <7c714bf4-2e5c-c17b-5a06-72d63e06d3a4@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d73c9f85-c153-3076-5657-819b61cd0c5d@redhat.com>
Date: Sun, 2 Feb 2020 10:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7c714bf4-2e5c-c17b-5a06-72d63e06d3a4@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: CUQAAgLuNpOMz2MhLQgU1Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/02/2020 21.12, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Richard,
>=20
> On 1/8/20 4:45 AM, Richard Henderson wrote:
>> The separate suffixed functions were used to construct
>> some do_##insn function switched on mmu_idx.  The interface
>> is exactly identical to the *_mmuidx_ra functions.  Replace
>> them directly and remove the constructions.
>>
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> I'm seeing a regression since commit 7dd547e5a (however I'm not sure
> this particular commit introduced the regression, or instead revealed it)=
.
>=20
> I get a hang when booting a I6400 CPU on Malta:
>=20
> $ qemu-system-mips64el -cpu I6400 -serial stdio \
>   -kernel vmlinux \
>   -append "clocksource=3DGIC console=3DttyS0 printk.time=3D1"
[...]

Thanks for the bisection, Philippe, that saved me quite a bit of time
doing it myself: The same problem also exists with the big-endian
version - this is also the commit that broke the Day 22 image of the
QEMU advent calendar 2018:

 https://www.qemu-advent-calendar.org/2018/download/day22.tar.xz

  Thomas



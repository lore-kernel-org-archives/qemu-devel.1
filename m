Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33269C32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 06:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE2A20848
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 06:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDqMnOxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE2A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioM9g-0003bJ-S0
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 01:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ioM90-00039Y-HO
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 01:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ioM8x-0000iL-2a
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 01:45:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ioM8w-0000e3-KZ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 01:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578293137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jO8S9ctInXLxdKpCAmcsvls85J+UWUy3R+t37w3IXxs=;
 b=QDqMnOxnso6xagCw1ctcpuKRbmgxIYx2ZgLJtrZfpezpTMvAQv9Ta5Ll0TzwWZz/vklY1r
 fII7Z1AxiVl2jzqSAF4Ib3XeT6EpzSSWan30y/aPaD2fHp4ZomKNPGTz6fi4SOI9d5GV5t
 rVdL0eFctU+rIvKwpbWLXflWURSt/jo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-nR3NvCYgPAC7GWQeN-ozjw-1; Mon, 06 Jan 2020 01:45:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3513107ACC5;
 Mon,  6 Jan 2020 06:45:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE9C660C87;
 Mon,  6 Jan 2020 06:45:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D8D419B25; Mon,  6 Jan 2020 07:45:26 +0100 (CET)
Date: Mon, 6 Jan 2020 07:45:26 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [Qemu-devel] What should a virtual board emulate?
Message-ID: <20200106064526.zh6rt4wbibfjrscu@sirius.home.kraxel.org>
References: <20190319144013.26584-1-pbonzini@redhat.com>
 <alpine.BSF.2.21.9999.1903192350550.11467@zero.eik.bme.hu>
 <87imwe847x.fsf_-_@dusky.pond.sub.org>
 <CAAdtpL5Z1OXqZ_zzA0RLq9soydNtTFt2oCOEfui1rq19bLKUgA@mail.gmail.com>
 <d9d5ac96-c0f5-dd83-d305-10e20c745dd1@redhat.com>
 <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: nR3NvCYgPAC7GWQeN-ozjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> 78c37d88f1b8b0b3ebcc632c458f0c3779fe2951 is the first bad commit
> commit 78c37d88f1b8b0b3ebcc632c458f0c3779fe2951
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Tue Mar 19 15:37:19 2019 +0100
>=20
>     mips-fulong2e: obey -vga none
>=20
>     Do not create an ATI VGA if "-vga none" was passed on the command lin=
e.

> 1/ the Radeon chip is soldered on the motherboard,
>=20
> 2/ the default BIOS expects the Radeon chip to be
>    unconditionally present,
>=20
> I insist this patch is incorrect for the particular case of the Fuloong2e
> board. I plan to revert it when I post the test.

Yep.  IMHO devices which you can't unplug on the physical board should
be present even with "qemu -nodefaults".

cheers,
  Gerd



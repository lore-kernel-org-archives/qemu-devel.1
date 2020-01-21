Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D233AC33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFDA21734
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWpI1q74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFDA21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itmAZ-0005sM-SI
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 00:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1itm9y-0005SK-Ny
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1itm9w-0003lc-IH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:33:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37830
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1itm9w-0003ku-2i
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579584782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iX9rdrOgW6eXhs6U7rsdfxpXKdEc94deRi7vmjrQuiA=;
 b=fWpI1q74pJIdIjEX1/t+g0wHwz8izVhzSqphekiMNnJ2TcjLpivZbUZJVhg6O2YqhCNxlv
 gmc137mEB+3oMM9H5aGVFtXuNua+fKCloi4ivISYuxFMdkqyCyYiKwSywt+3ITbK71wI8z
 0rjevRkMzPkmDW2IMLZ0/ts/2vcvDK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-pP8xcB7UPf6gNO--xQczsA-1; Tue, 21 Jan 2020 00:33:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A6F9184AD2A;
 Tue, 21 Jan 2020 05:32:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 299F45D9D6;
 Tue, 21 Jan 2020 05:32:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80C0A1138600; Tue, 21 Jan 2020 06:32:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] What should a virtual board emulate?
References: <20190319144013.26584-1-pbonzini@redhat.com>
 <alpine.BSF.2.21.9999.1903192350550.11467@zero.eik.bme.hu>
 <87imwe847x.fsf_-_@dusky.pond.sub.org>
 <CAAdtpL5Z1OXqZ_zzA0RLq9soydNtTFt2oCOEfui1rq19bLKUgA@mail.gmail.com>
 <d9d5ac96-c0f5-dd83-d305-10e20c745dd1@redhat.com>
 <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
 <6b5459b5-deb2-e70c-deab-fa7246b43e38@redhat.com>
Date: Tue, 21 Jan 2020 06:32:51 +0100
In-Reply-To: <6b5459b5-deb2-e70c-deab-fa7246b43e38@redhat.com> (Paolo
 Bonzini's message of "Sat, 18 Jan 2020 21:46:17 +0100")
Message-ID: <877e1lml18.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: pP8xcB7UPf6gNO--xQczsA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 04/01/20 22:16, Philippe Mathieu-Daud=C3=A9 wrote:
>> 1/ the Radeon chip is soldered on the motherboard,
>>=20
>> 2/ the default BIOS expects the Radeon chip to be
>> =C2=A0=C2=A0 unconditionally present,
>>=20
>> I insist this patch is incorrect for the particular case of the
>> Fuloong2e board. I plan to revert it when I post the test.
>>=20
>> BTW I'm not using --nodefault, I'm running default ./configure:
>>=20
>> qemu-system-mips64el -M fulong2e -bios pmon_2e.bin \
>> -display none -vga none -serial stdio
>
> But if you're not specifying -nodefaults, why are you specifying a
> configuration that your BIOS does not support?  You should just remove
> -vga none and leave in -display none.

Is there any use for -vga none with this machine?  If no, then rejecting
it cleanly would be nicer than having the machine hang.



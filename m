Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADD7C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4538F2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYcHCng5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4538F2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQWX-0005aG-GA
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQVI-0004sF-UM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQVG-0007u0-JA
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:53:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47047
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQVG-0007rP-G6
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585936393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H529rtZ0TN4I1+HCsrzJINnZseN+poJpG4qtjyvjDig=;
 b=QYcHCng5wtXzDKv0BIolliWo7242CtyxLyi6SRArYQt29rAI2HQY8YIXU/U/XqqMrNdjso
 iwSCEdgA9j8pleR2t5T2/HjCJZ0qCwVM0s02y+RCEXP+2v0MOEGF4xJnPTCK95vbRF3ajL
 Ggb/GxK08l/JCCgLqvG8abI6tasa3Io=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-q5olPnvoNjK_iRLT3hKQ0Q-1; Fri, 03 Apr 2020 13:53:07 -0400
X-MC-Unique: q5olPnvoNjK_iRLT3hKQ0Q-1
Received: by mail-ed1-f71.google.com with SMTP id i10so6106776edk.13
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1VA98oNVWz7SqUTNvo1NAoiIC7S0Y83T0p7iYkAvaPY=;
 b=bgedF8QIR0a2qzTMllh6PYLxDMTL2n+fEGaLP21rDZqom5PJjkzuHFDRcG1LsPjwKF
 ACOcI5d0/4iE6Lo6TZIlCGQe84Di2uXg1jkddePKwm2lW2/Iluy0gStvDyeklh6MNkZB
 JzagZgGDKteoiUo4OW1HkfsXDwZVzcEYmtKBJnzu+cP+KfivvHtaMFGca0VZdCYrve4N
 zvQWt4CnktZeyHAqGZmXwQV7hGNeSNDLymmiU0wHbBVjSArpPjShdECDR4Vq2vbkeYKO
 Mh5NYkxHgm90FjRsFdqHPg263cCmf5Q3sFwJXT+9YR86Mamree0qBCvFuTmr1zV+Y32Q
 bBvA==
X-Gm-Message-State: AGi0Pubs7kGJnatyfwVk4pDIrJA1NFGomlW1M+6Z5I83kWIVP9PV7vEY
 Fla/BA1LOlh40eDxqg8IolgJdoxjHWkD2YUb0fiPh/zwpAJJQny7Humz+a/J4X5h2AcljtrJZBu
 2k7G+jIaKeIvtBVg=
X-Received: by 2002:aa7:c607:: with SMTP id h7mr8966572edq.73.1585936386152;
 Fri, 03 Apr 2020 10:53:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypKzt2HufSVIs7T92OEiiXVQ0XZux6Ey806Zs6pHEfbnboWqrW8Hrra/UUWyLqdXg14c+OEh9Q==
X-Received: by 2002:aa7:c607:: with SMTP id h7mr8966529edq.73.1585936385913;
 Fri, 03 Apr 2020 10:53:05 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v13sm1506007edj.62.2020.04.03.10.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 10:53:05 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 00/12] hw: Add missing error-propagation code
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200325191830.16553-1-f4bug@amsat.org>
 <87r1x8vet0.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dbee4e3d-afba-827d-4950-2ac9b99419ab@redhat.com>
Date: Fri, 3 Apr 2020 19:53:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87r1x8vet0.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus, Peter.

On 3/31/20 3:23 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
>> This series is inspired of Peter fix:
>> "hw/arm/xlnx-zynqmp.c: fix some error-handling code"
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg691636.html
>>
>> Add a cocci script to fix the other places.
>>
>> Based-on: <20200324134947.15384-1-peter.maydell@linaro.org>
>=20
> I skimmed the code patches [PATCH 02-12/12], and they look like bug
> fixes.  Other reviewers raised a few issues.
>=20
> I also skimmed the Coccinelle script [PATCH 01].  Peter pointed out a
> few things it apparently missed (e.g. in review of PATCH 06+11).
> Moreover, the bug pattern applies beyond object_property_set() &
> friends.  Perhaps the script can be generalized.  No reason to hold
> fixes.  We may want to add suitable notes to the scipt, though.
>=20
> Can you address the reviews in a v2, so we can get the fixes into -rc1,
> due today?

Status on this series (sorry I didn't update earlier).

I addressed Peter's comments, improved/simplified/documented the cocci=20
script (which I split in smaller ones).

Peter suggested other functions can be checked too, not only the=20
"^object_property_set_.*" matches. Indeed, more patches added. Some are big=
.

Another suggestion is replace in init() 'NULL' Error* final argument by=20
&error_abort. This can be another series on top.
However I noticed we can reduce the error_propagate() generated calls in=20
many places, when both init()/realize() exist and the property set is=20
not dependent of parent operation, by moving these calls from realize()=20
to init(). Another cocci script. But to make sense it has to be run=20
previous the "add missing error_propagate" one.

While writing the cocci patches, I had 3 different Coccinelle failures.
Failures not due to a spatch bug, but timeout because C source hard to=20
process. Indeed the C source code was dubious, could get some=20
simplification rewrite. Then spatch could transform them. More patches=20
in the middle.

Now I'm at 47 patches, the reviewed patches at the end of the series.
Too much for RC2. Since I don't think these are critical bugs, but=20
improvements, are you OK to postpone this series to 5.1?

If you think a patch deserves to be in 5.0, point me at it and I can=20
send it ASAP with comments addressed. Else I'll post my series as=20
-for-5.1 soon.

Regards,

Phil.



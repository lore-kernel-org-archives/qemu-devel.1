Return-Path: <SRS0=vKWr=3A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA3AC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 00:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100582064C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 00:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgi3Nkkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100582064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq585-0003kX-7n
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 19:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1iq57K-0003Jf-0w
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 19:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1iq57I-0006Sk-V2
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 19:59:05 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:42465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1iq57I-0006Q1-Pk
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 19:59:04 -0500
Received: by mail-yw1-xc41.google.com with SMTP id l14so1425800ywj.9
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 16:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=j+Gii0GKlMGo6+HLeGHZcy3x0TPv2uyfat5O+8hAtX4=;
 b=Mgi3NkkzhrNVz/FKE1/VGcoQWDoAcumjJ7Ap+3j1YJaY0rrUp5H21MHmDM1BFscbyu
 7cvEotqUwtZ6Kb5Vuvs/F4xo958gMI31W8iRw1iAZZHvp8p5dDusKi3xtAQLc2YHYCz9
 tq0tf2ozRwhb0XenKgXtupReSp4qMVIs21izatlwWvHekpHIf1HwMJ5brCtgeHxNt4io
 oDAUov1DU+ompwEYUvAgGqo8xc3Gm5a/Us+m4GnDH1G0V4iSm5GYpv8yb6mytjzW6L5+
 89LlwlMxhcXlIAUXlKKH1hGQr/3QMLN+QOao/aZ7OusOBJnysbfKL1XnjMK17vgdwz4M
 6hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=j+Gii0GKlMGo6+HLeGHZcy3x0TPv2uyfat5O+8hAtX4=;
 b=gGr3CSNGjQgDfo6LPrQEmEgYS0APhlNBj8NvfssCC/bkOQfiwFrWJrc4WejnEf8gWv
 FM9rQOO4POkOOYQ95TRB6huv3hQ4rybPP1UYGlLLjd6UM26YkFnTkkZtfW43nJnfheTP
 /skub/9R2HhIqZPzUHZm3iYrwOthb9L9IBzmrNEw7vnM3xX5Fa5/Oopqf8nrQIxiFwY7
 GEDcWzJCQt7aN6BoynDGsjcdNISBk1r8MEUWk+8/AG6xJ9lO6llV2fDR52r2We3LeVJW
 Uzr8LXv8NZQT7pcXuY45EwviuPmtgoVxc+xPEo0jU9zlxXEFqVZl+SoBE6AoLqAKJ51Q
 YIfQ==
X-Gm-Message-State: APjAAAU/SWEY8O/AIHHE+bkPCOZ3IRCLd4Ba0r0Ynzg02ZfVYk6+Hd7u
 hRVgCk3G0B1JSzFOSAyl7W4=
X-Google-Smtp-Source: APXvYqx/LXFMYToltRIJ1UbgfGTveo7Pth0dl2fnRsqLjHtNwY0qVVf5Fc4nXyYPRa899gTCmipdnw==
X-Received: by 2002:a81:b60d:: with SMTP id u13mr5095123ywh.382.1578704343902; 
 Fri, 10 Jan 2020 16:59:03 -0800 (PST)
Received: from [192.168.0.9] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id r66sm1877200ywh.57.2020.01.10.16.59.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jan 2020 16:59:03 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] Implement the Screamer sound chip for the mac99
 machine type
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
Date: Fri, 10 Jan 2020 19:59:01 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <8FCF0DF9-2132-4CA1-8701-22891E769FD4@gmail.com>
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
 <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu Developers <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Jan 10, 2020, at 7:32 PM, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 =
<dirty.ice.hu@gmail.com> wrote:
>=20
> On 2020-01-05 02:58, Programmingkid wrote:
>> I found the patch that breaks Screamer sound support for =
qemu-system-ppc. It is this:
>> commit 2ceb8240fa4e4e30fb853565eb2bed3032d74f62
>> Author: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>
>> Date:   Thu Sep 19 23:24:11 2019 +0200
>>     coreaudio: port to the new audio backend api
>>          Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n =
<DirtY.iCE.hu@gmail.com>
>>     Message-id: =
586a1e66de5cbc6c5234f9ae556d24befb6afada.1568927990.git.DirtY.iCE.hu@gmail=
.com
>>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reversing this patch should make the Screamer patch work with the =
current git version of QEMU.
>=20
> Hi,
>=20
> Unfortunately it's not that simple to simply revert the patch since =
the old backend api no longer exists.  Also I don't have a Mac so it's =
almost impossible for me to test the results.  I looked at the specified =
commit and I think I found a problem, could you please apply the =
attached patch on the current git master and check whether it solves the =
problem?  If yes I'll turn it into a proper patch.
>=20
> Regards,
> Zoltan
>=20
> <coreaudio_test.diff>

Sorry it did not fix the problem. I only hear pops occasionally. Most of =
the time only silence can be heard.

Thank you for the patch.=20=


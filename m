Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860ACA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7228E222D4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtZhbOx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7228E222D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRYVB-0001Vl-FO
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <atar4qemu@gmail.com>) id 1iRYUV-00016a-GV
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1iRYUU-0001fZ-Bo
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:17:39 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1iRYUU-0001fT-7W
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:17:38 -0500
Received: by mail-io1-xd43.google.com with SMTP id c6so17540499ioo.13
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 01:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=380iTR3QmdaInzfVMzLWIGKv9XGppI8/LDL2HPTAIbM=;
 b=qtZhbOx0JH1SuaDrYxfhEL0n4keCc3pJt7iPrZnKpknwKRmLNH95VY8LszaetFiU64
 Mel4BiimPON1lguzj0fwsUI9K6SXiAH4FFRsAbxVis8f/rvH2zKDcVLOW76412l27zJ5
 cSUb+o0US6a+Ucy/oesivlEHq3gQYRdSxTIhXSOphW1sKqZQkj9wUr1sX3S8dGsrCVxo
 dJmtTs/IgpGR4f8IZ63dIuKQbS4RJJZ3nVN+eTLdn6k6CxqJyg3QWKeD1EdkY4OjMhHM
 9HqJXF4FUYlRJcnnWE4bJ3Rj/LSe6+n9tLqG4GYezrTxi/URplnIJ5hqfHgml/g+dbPQ
 JCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=380iTR3QmdaInzfVMzLWIGKv9XGppI8/LDL2HPTAIbM=;
 b=d7zWHoEbRqO7NBnBYw0FzXCqGw4u87wJBLayDr4VtNEPoVW1/5tv437QdoJbGoEZ14
 us0ItUe5xmwcu0qlCUPAJ8H0ah0JsjwGyKA5ZFx1Evp4AWwxQrfOJcCxS0kw1RlX4fB3
 prsM7Cz0Jmo7+lK4BCjYqhAEV9PSKnMJwCpDr6ASd1N/tDrbABwFRYGw2NB+SO6iMK+Q
 kXudTWS7xbsnGfvHubfkRrSc/wMUW/oS9kFqx2dx2xWmEBR+efg94Jya15RxHfYdNRlN
 aH70mkg1Z9j1YY7z9YvmISsVNlg3Xf9EOKu1RxKEbtS75Lbzt7FwJgH8JRROVYr6KC8a
 ERnw==
X-Gm-Message-State: APjAAAWCbkeeF2wPpYVU3st0aymaw3/SeDmq7/J3KYrbQRdg/MUjCUYI
 lx1QJK9CNctkKLX15F8iRUfmgoljktWQYn2/Yyw=
X-Google-Smtp-Source: APXvYqwNgLabXt39l1j/IPLBepZEV0CKLCwZIPIvPi0z4aZBEkuRubIddaGSSV0MSoMbjmDK40i5cLupuZdZ00NS7YU=
X-Received: by 2002:a02:84ae:: with SMTP id f43mr3500322jai.8.1572859057119;
 Mon, 04 Nov 2019 01:17:37 -0800 (PST)
MIME-Version: 1.0
References: <CA+gXNfhCRT1kPq4KVumXwRiJvVaXYZZBRhs-QsVNKv+WzeMM+A@mail.gmail.com>
 <54af7410-569e-2b4b-70ed-f09039014bda@redhat.com>
 <56403a22-d48e-5bb3-15c5-904e2e7c667d@ilande.co.uk>
In-Reply-To: <56403a22-d48e-5bb3-15c5-904e2e7c667d@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 4 Nov 2019 10:17:25 +0100
Message-ID: <CACXAS8CVEbSGu7v4fLyGb-w95CZbw-1foM5=Mvs=yu7QsxspOA@mail.gmail.com>
Subject: Re: Sparc Solaris 10
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Zainuddin AR <zar1969@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 3, 2019 at 10:01 PM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 02/11/2019 19:56, Philippe Mathieu-Daud=C3=A9 wrote:
>
> > Cc'ing the SPARC maintainers.
> >
> > On 11/1/19 4:49 AM, Zainuddin AR wrote:
> >> Hi,
> >>
> >> I like to find to find out if you have a working qemu on solaris 10 or=
 11. I have
> >> tried the qemu-sun4vniagara but without networking. Is the networking =
support for
> >> niagara version available?
>
> I'm not particularly familiar with sun4v, however I'm not aware of any cu=
rrent work
> in this area. Do you know which network driver is typically used with sun=
4v?

The sun4v NIC is currently not implemented. It's well documented in
the opensparc documentation though, so if anyone has time for that,
adding it to QEMU is doable.

At the moment there is just a serial line which can probably be used
for ppp or slip, but I haven't tried it yet.

--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu


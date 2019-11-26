Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F065C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F3CD2075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="batue4dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3CD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZgoy-0006Ap-5k
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 14:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZggb-0000Wn-V6
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZggZ-0002po-Vy
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:39:45 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45993)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZggX-0002oJ-BD
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:39:42 -0500
Received: by mail-ot1-x342.google.com with SMTP id r24so16939435otk.12
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CMieSxx92kHmYXgqxBsDoLoIrxWrDv052ytOwMRJ1yY=;
 b=batue4dx1UqxceLmFKoklXKtEVepcci6UOeFGYTXIzU3u7azaOn5KNxIwHE63k+++n
 HFtCNxZbdcFZlD29Jn7o9ldV2W1joIquScqU/hZEVS0VEmZk2k2f18yqVpmI/nlCAiWb
 WqHd3uhtwo1TTU7FFx/IdULTuoJ9bfhkB4HFMJK0Uaod/iAr/mhm86jQnwCjBzB+8Lks
 9p6SupvXg4HbWhPuNEBk27Ndjq/uP9r2DZAslgmz1imAnNd75N86VxD0fjxriMoYPnn4
 ZlO8fkPkN+0RwQgi/24Wrp554FKqkwkNjuzpHY1SKNB1fpxzJYoFfzDn0HTKZ36tKD5T
 RsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CMieSxx92kHmYXgqxBsDoLoIrxWrDv052ytOwMRJ1yY=;
 b=B6tNNdCt/Fw4bgqgn6D1HwU6r5S6MZuQWLktR0TcuvOporrkR8RQhGENmjDYhsSRHv
 pIlDFFklIzNLdVwzWhe5vnFtccXICA3EhBMCBiKMsCykKnqy46t0yRkXer3QziO0hhhi
 IIsQdaAgmaATqeU2L6l/DxOuwVJt4+BHV9w7xMjePi4GBJOqCy5d3pfbY/1/CRiFKAmL
 gEe7o3HfgKy/gM329HxeAVamze+XubdqVzFA0PM8KEkWcxETjmElBFFZUyGBqs2YCsg+
 C/TGCLQgUokBZhsoeLZmQcTQiaJ1nrCC3ea4d4WRbfdw0ewqcC7h9DNqe49a3sIskJLy
 ZKQQ==
X-Gm-Message-State: APjAAAX4ZvLuUfIbwujOQRUHNpG4nXVZ4C9NvrShnsp9MaqrPgN+acms
 m+s458lcEtPKgX6f1ez97ZqiVgqfsfiirtHaHI8=
X-Google-Smtp-Source: APXvYqyz7ackH7yHeuzpcwqXOt4dduyR7LWdZsdH5HqYjTWOyYXS0ZX0gmS+o2ca0jKRquBWCXnyAqTORGGRWIJn7PY=
X-Received: by 2002:a05:6830:81:: with SMTP id a1mr554550oto.64.1574797179399; 
 Tue, 26 Nov 2019 11:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-18-mrolnik@gmail.com>
 <CAL1e-=gBBFRxAsDnRyQqiZSLWhMmfyp2YXge4E12VaEmEG=a9g@mail.gmail.com>
 <CAK4993jvnA+rkBQzyp7jCY5Vo6TLzL8A7uN+ah8hmJa3-d4YFg@mail.gmail.com>
In-Reply-To: <CAK4993jvnA+rkBQzyp7jCY5Vo6TLzL8A7uN+ah8hmJa3-d4YFg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 26 Nov 2019 20:39:28 +0100
Message-ID: <CAL1e-=hzDtugeN37fPsck9ZsOBS1EbWW4YExz8TeMm+S305nAQ@mail.gmail.com>
Subject: Re: [PATCH v36 17/17] target/avr: Update MAINTAINERS file
To: Michael Rolnik <mrolnik@gmail.com>, Sarah Harris <S.E.Harris@kent.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 8:06 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> Aleksandar,
>
> there was an email from Sarah, stating that she does not want to be a maintainer.
>

But this is for "reviewer" role, not "maintainer".

Sarah?

> On Tue, Nov 26, 2019 at 5:17 AM Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
>>
>>
>>
>> On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>>
>>> Include AVR maintaners in MAINTAINERS file
>>>
>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>> ---
>>>  MAINTAINERS | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 5e5e3e52d6..ad2d9dd04a 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -163,6 +163,15 @@ S: Maintained
>>>  F: hw/arm/smmu*
>>>  F: include/hw/arm/smmu*
>>>
>>> +AVR TCG CPUs
>>> +M: Michael Rolnik <mrolnik@gmail.com>
>>> +S: Maintained
>>> +F: target/avr/
>>> +F: hw/misc/avr_mask.c
>>> +F: hw/char/avr_usart.c
>>> +F: hw/timer/avr_timer16.c
>>> +F: hw/avr/
>>> +
>>
>>
>> I had a strange feeling that something is missing here, and I finally realized what that was:
>>
>> R: Sarah Harris <S.E.Harris@kent.ac.uk>
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04225.html
>>
>>
>>
>>>  CRIS TCG CPUs
>>>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>>>  S: Maintained
>>> --
>>> 2.17.2 (Apple Git-113)
>>>
>
>
> --
> Best Regards,
> Michael Rolnik


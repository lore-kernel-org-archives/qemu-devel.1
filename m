Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F1EC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B7920672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqH60DfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B7920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWOv-00034C-4O
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLWNw-0001Zb-AW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLWNu-0002uw-Kg
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:22:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLWNs-0002sO-NJ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:22:10 -0400
Received: by mail-wm1-x341.google.com with SMTP id d202so449327wmd.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JtOUmlddJfiiuQ89uisdNRcm83fl7vqOjpFFcB74WbM=;
 b=WqH60DfMS9DnPYEuIwdioBViI7+GV6fUG3idD1y7gV7OYNW7hXarmJc4Tbww4pzbQk
 ++qG8P77RutdO0nLEBuimQoHa5BTqQLNZ8h+EHmDzXEz6nJuiJs9sWo8/5s/D3NKMS8e
 TbaTHcba+IhTDoulH8ypzrMUkMoMzoGdHnnFMxMYyS54qj2revwOYVAbca/E5/lideDX
 RxnW6AorYx38AwpFoWCquuGFVLbZ4wKbk5u3+H8i29i1+ikYVPcrbxATBnrW7GN455v1
 wXOy2Nq0nq0rOyHT3aYwjhNlc/oanOrB6r98eDLZm2BFOsUjP9yzjlnxG6nAtf3c7Ugu
 jaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JtOUmlddJfiiuQ89uisdNRcm83fl7vqOjpFFcB74WbM=;
 b=UEjbSav4rTY/bNSACUZH4qw9Z1Q/T4grsnAeJMUesB3uOy2pEkHQ/Dptf5qF/Q3P3L
 tEqSiGquwlNAl2fHvx8+ZaUtkRj2WiAqN6Sh1t0Wcj5anlOxKLHjoR5r+S4VrsggWVyN
 e1DAWwKJhDS9jkAG5wM1igX8pQNP3NG+z+W7ll0BoNvySmJGYCoCmQojMfXTkiY286H3
 IeiaXUNH3GTFaXKPL8Cpi8htj0qkAzsCeP9huusiOq8qTNUCF1qQdsL+V+r0o6F81LXp
 AgzJz/TzaxOaBed3bUwr5iQtomoHotZaGsh1y7yGOpsgEA0KXog71jAgCqp0Cq/ufrDh
 GleQ==
X-Gm-Message-State: AGi0PuYOgzlLxcsoGZwKGzBOFA4ZSVyd/1MPzTKkkJ8IX29s5Ehbtcxq
 1K2iRmuTHrNUcnvrg8qMeR0Cfw==
X-Google-Smtp-Source: APiQypIEAi/vjNIzbt8CBqVxV3Qugyan5DvcjkbiRhJ9aCFL+ZqUwqiP7ghAOaw1r68YiZkfgSC45g==
X-Received: by 2002:a1c:e407:: with SMTP id b7mr351661wmh.32.1586197326659;
 Mon, 06 Apr 2020 11:22:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a67sm473564wmc.30.2020.04.06.11.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 11:22:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EF63F1FF7E;
 Mon,  6 Apr 2020 19:22:04 +0100 (BST)
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-7-philmd@redhat.com> <87zhboaaf5.fsf@linaro.org>
 <CAKJDGDbXMknOLw-xGGR3HJriCQB_-+1A5+eqf0DMb_hd6u99HA@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Willian Rampazzo <wrampazz@redhat.com>
Subject: Re: [PATCH-for-5.1 6/8] tests/Makefile: Add fetch-acceptance-assets
 rule
In-reply-to: <CAKJDGDbXMknOLw-xGGR3HJriCQB_-+1A5+eqf0DMb_hd6u99HA@mail.gmail.com>
Date: Mon, 06 Apr 2020 19:22:04 +0100
Message-ID: <87o8s4a303.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 qemu-devel <qemu-devel@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Her?= =?utf-8?Q?v=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Willian Rampazzo <wrampazz@redhat.com> writes:

> On Mon, Apr 6, 2020 at 12:41 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>>
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> > ---
>> >  tests/Makefile.include | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/tests/Makefile.include b/tests/Makefile.include
>> > index 51de676298..90f457593c 100644
>> > --- a/tests/Makefile.include
>> > +++ b/tests/Makefile.include
>> > @@ -906,6 +906,13 @@ get-vm-image-fedora-31-%: check-venv
>> >  # download all vm images, according to defined targets
>> >  get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FE=
DORA_31_DOWNLOAD))
>> >
>> > +fetch-acceptance-assets: check-venv
>> > +     $(call quiet-command, \
>> > +            $(TESTS_VENV_DIR)/bin/python -m avocado \
>> > +            --show=3D$(if $(DEBUG),avocado.test,$(AVOCADO_SHOW)) asse=
ts fetch \
>> > +            tests/acceptance/*py, \
>> > +            "AVOCADO", "tests/acceptance")
>> > +
>>
>> I'm wondering if we could expand this to a rule per-test group and
>> therefor allow parallel fetching of groups of assets?
>
> This is a valid idea! Additionally, my suggestion is to organize the
> tests by subdirectories under `tests/acceptance/`. Doing so makes it
> easy to handle the target rule, adding the subdirectory to the assets
> fetch command instead of listing specific tests for each group. Making
> a list of tests for each group requires extra editing to the makefile
> target when a new test is added. This can lead to new tests being
> missed in their groups by mistake.

I'd use wildcards to build up the groups so the Makefile doesn't need to
be messed with again.

>
>>
>> >  check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>> >       $(call quiet-command, \
>> >              $(TESTS_VENV_DIR)/bin/python -m avocado \
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--=20
Alex Benn=C3=A9e


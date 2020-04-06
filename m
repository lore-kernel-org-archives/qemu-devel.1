Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68157C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3802A20672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HI83OVsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3802A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWIQ-0002rE-Bp
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jLWE9-0003dk-BZ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jLWE8-0001F6-84
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:12:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jLWE8-0001BD-57
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586196720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6g71dqhfYpY6ip8qssxsq95Ylu99ddk1f+WNGX/f8fw=;
 b=HI83OVsZQdc5ha4poZ9XHfq2LGz7fQjNY4xNgITgOxEXEAsfJwc5ho3ZTXQVrsp5HzrG0T
 J57f++6GtdJIkrzCAH/NqNVU7wuWe0swcYRDIOkyNwp7xbm7BulRD5yyN2y0NzJjeB9JCh
 eE13qHg8QMbLNEufKL6uA+UoFDoCJAk=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-J8h1bzTEMlCnx1jFGxc6Ng-1; Mon, 06 Apr 2020 14:11:58 -0400
X-MC-Unique: J8h1bzTEMlCnx1jFGxc6Ng-1
Received: by mail-ua1-f72.google.com with SMTP id c4so145301uap.15
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 11:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6g71dqhfYpY6ip8qssxsq95Ylu99ddk1f+WNGX/f8fw=;
 b=sW7ok2QsHHdotYNGOTmKaZwOC3wKR7cZE3CpkCoEC8NmMsWmVzRRL1jHyen2+/yxGc
 dKb5raeceWQq4LI6EhniLfcWzFla6hEDgJToShwQ1+S5w+F03t05lxUveoTB2VIwu1/3
 IuEtz0ycFBrnbaRhm3dYfNTtFwfrPQ7M1/teoqHfQa6ewJG63gErejJ2J65YgUZycjn2
 DIJBhkmwkew+RccgH4rVA/t64I3usLENkwXI1gBqOiokW+3Z5R7jigNlBwsspYWtESvq
 IC4MHdFy5fJPsT3aHjfx7aXnBRXCfZV5b8Z4RIHciXQD68KG3knokJk+qbtbkYoolTuQ
 48xg==
X-Gm-Message-State: AGi0PuZICJhbWVxJTCmSWpa4yQBzpykzz6aSrpX1g0FxGJPfx4SpiQu0
 RdtpG2jS6icva/jAdYiwu94WdnGvnEvTjtLCcQjSFT29KVv/B0DM2PsmoO2JVngwgGiyKE9GRXr
 C429AmagyHU0VSsj39xPlyrGiMZpEVr0=
X-Received: by 2002:a67:1947:: with SMTP id 68mr781467vsz.145.1586196717930;
 Mon, 06 Apr 2020 11:11:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypLTGQHeZGuuMQRAq1E4dmi+3I9X4k3TUWEfwmg7LIFyNtleXHj+KXjNv8/3DcmxVTbnvl05HxKLUYn5B0PGpvM=
X-Received: by 2002:a67:1947:: with SMTP id 68mr781430vsz.145.1586196717432;
 Mon, 06 Apr 2020 11:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-7-philmd@redhat.com>
 <87zhboaaf5.fsf@linaro.org>
In-Reply-To: <87zhboaaf5.fsf@linaro.org>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Mon, 6 Apr 2020 15:11:46 -0300
Message-ID: <CAKJDGDbXMknOLw-xGGR3HJriCQB_-+1A5+eqf0DMb_hd6u99HA@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 6/8] tests/Makefile: Add fetch-acceptance-assets
 rule
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 qemu-devel <qemu-devel@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 6, 2020 at 12:41 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  tests/Makefile.include | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 51de676298..90f457593c 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -906,6 +906,13 @@ get-vm-image-fedora-31-%: check-venv
> >  # download all vm images, according to defined targets
> >  get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FED=
ORA_31_DOWNLOAD))
> >
> > +fetch-acceptance-assets: check-venv
> > +     $(call quiet-command, \
> > +            $(TESTS_VENV_DIR)/bin/python -m avocado \
> > +            --show=3D$(if $(DEBUG),avocado.test,$(AVOCADO_SHOW)) asset=
s fetch \
> > +            tests/acceptance/*py, \
> > +            "AVOCADO", "tests/acceptance")
> > +
>
> I'm wondering if we could expand this to a rule per-test group and
> therefor allow parallel fetching of groups of assets?

This is a valid idea! Additionally, my suggestion is to organize the
tests by subdirectories under `tests/acceptance/`. Doing so makes it
easy to handle the target rule, adding the subdirectory to the assets
fetch command instead of listing specific tests for each group. Making
a list of tests for each group requires extra editing to the makefile
target when a new test is added. This can lead to new tests being
missed in their groups by mistake.

>
> >  check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
> >       $(call quiet-command, \
> >              $(TESTS_VENV_DIR)/bin/python -m avocado \
>
>
> --
> Alex Benn=C3=A9e
>



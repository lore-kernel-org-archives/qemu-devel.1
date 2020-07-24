Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B4AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184972065E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1o+9mRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184972065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz2kr-0002J4-An
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 14:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jz2kJ-0001qN-1k
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:48:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jz2kG-0004cE-3k
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595616514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUFQX4zPKbQSFFGnP+eXp6keU1U74XI//kLvIx5Rjpk=;
 b=X1o+9mRZlzV/z07Te608mP5yw9u4kCtCoLNdrVhjNNA4ZcOh0+DmXhD95PfVXl5EaDE84w
 GYgeOujUtlCCISm6cUQNiBIt3QZaEjMNtkfqM0wXLG5695NRDFo8Ew035U87HzakldegWT
 Gq7r0QvJqW6xsLZEK537dYeYFcpzcR0=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-Y3iHBQICNu6Em-eHbKcxzw-1; Fri, 24 Jul 2020 14:47:17 -0400
X-MC-Unique: Y3iHBQICNu6Em-eHbKcxzw-1
Received: by mail-vk1-f198.google.com with SMTP id k126so2001255vkg.22
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 11:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TUFQX4zPKbQSFFGnP+eXp6keU1U74XI//kLvIx5Rjpk=;
 b=oy50HfyH7+P8Ce3daFIt63K88+/TW85uwrWLyD+5EoSwirI9ckmD8DyfsO372JEVIK
 FiWCZfeMbL3UhnQObriBQ9/vn+s91DDqBDN6NJCrPYcdYQcpPPCEj/0YyvaY2I2A5ULP
 lBPg2pxvvwqNPDYvJ4BJuMkcvyrqhH9NXtuMJcvARKPa3dsYZErI0QQOD8zyOA7FdKOe
 EoE8BqROcQHEMN0O+TIv0Hf1uRsqjKRMPELBClWIWaKPwFCNpmldt+Gjlxo5A10zihi9
 86yuB8vC9sPO2TZIMN0nWDIqd2XNXsS5pm73nGGRRMlfvt5ubkeY/2WdaWjQjlzkdFNw
 Un8g==
X-Gm-Message-State: AOAM533Rxz/T8vP/rBF4wZNwf5H+SwuPHstiULIwtJTuV8vG7jmlD975
 i1W7cpebS5YYjQamkF2Bc66vvuk5zT/Lq4uD3Avyz+Ef/PexzQCO2mar5GjSR3KeVCRFTgJB8YZ
 baHHJUhwQxw0oDeySJ2HAOafHzvC9ELg=
X-Received: by 2002:ab0:4d4d:: with SMTP id k13mr9430500uag.113.1595616436877; 
 Fri, 24 Jul 2020 11:47:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+/RrYqdRM0GHov47b2myUl+AWACxzL/Ecc8vpgucbaFZoWo5/A57AEasxcWp76L1b9ZZ5hhWJvP1IMkIaHq4=
X-Received: by 2002:ab0:4d4d:: with SMTP id k13mr9430479uag.113.1595616436567; 
 Fri, 24 Jul 2020 11:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200724073524.26589-1-f4bug@amsat.org>
 <20200724073524.26589-3-f4bug@amsat.org>
 <a6ef896a-2fd6-605b-eeda-20d679451306@redhat.com>
In-Reply-To: <a6ef896a-2fd6-605b-eeda-20d679451306@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Fri, 24 Jul 2020 15:47:05 -0300
Message-ID: <CAKJDGDaXSftLfJA1LzhkvtVBZdGrMXGScz+qA+vDeNZWyG3y9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests: Exclude 'boot_linux.py' from fetch-acceptance
 rule
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:23:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel <qemu-devel@nongnu.org>, Willian Rampazzo <willianr@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 24, 2020 at 3:26 PM Wainer dos Santos Moschetta
<wainersm@redhat.com> wrote:
>
> Hi Philippe,
>
> On 7/24/20 4:35 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > The boot_linux.py file triggers an exception:
> >
> >    $ make fetch-acceptance
> >    AVOCADO tests/acceptance
> >    Fetching assets from tests/acceptance/empty_cpu_model.py.
> >    Fetching assets from tests/acceptance/vnc.py.
> >    Fetching assets from tests/acceptance/boot_linux_console.py.
> >    Fetching assets from tests/acceptance/boot_linux.py.
> >    Traceback (most recent call last):
> >      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packa=
ges/avocado/__main__.py", line 11, in <module>
> >        sys.exit(main.run())
> >      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packa=
ges/avocado/core/app.py", line 91, in run
> >        return method(self.parser.config)
> >      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packa=
ges/avocado/plugins/assets.py", line 291, in run
> >        success, fail =3D fetch_assets(test_file)
> >      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packa=
ges/avocado/plugins/assets.py", line 200, in fetch_assets
> >        handler =3D FetchAssetHandler(test_file, klass, method)
> >      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packa=
ges/avocado/plugins/assets.py", line 65, in __init__
> >        self.visit(self.tree)
> >      File "/usr/lib64/python3.7/ast.py", line 271, in visit
> >        return visitor(node)
> >      File "/usr/lib64/python3.7/ast.py", line 279, in generic_visit
> >        self.visit(item)
> >      File "/usr/lib64/python3.7/ast.py", line 271, in visit
> >        return visitor(node)
> >      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packa=
ges/avocado/plugins/assets.py", line 139, in visit_ClassDef
> >        self.generic_visit(node)
> >      File "/usr/lib64/python3.7/ast.py", line 279, in generic_visit
> >        self.visit(item)
> >      File "/usr/lib64/python3.7/ast.py", line 271, in visit
> >        return visitor(node)
> >      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packa=
ges/avocado/plugins/assets.py", line 171, in visit_Assign
> >        self.asgmts[cur_klass][cur_method][name] =3D node.value.s
> >    KeyError: 'launch_and_wait'
> >    make: *** [tests/Makefile.include:949: fetch-acceptance] Error 1
>
> Currently the acceptance tests use Avocado 7.6. I bumped to 80.0 (latest
> released) here and that error is gone. Could you double check?
>
> Regards,
>
> Wainer

Hi Wainer, thanks for looking at this problem.

This bug was fixed here
https://github.com/avocado-framework/avocado/pull/3665, on release 78
of Avocado. It was reported by Philippe at that time. I think we
forgot to bump the Avocado version here.

>
> >
> > Exclude it for now. We will revert this commit once the script is
> > fixed.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >   tests/Makefile.include | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 238974d8da..7c9cf7a818 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -950,7 +950,7 @@ fetch-acceptance: check-venv
> >               $(TESTS_VENV_DIR)/bin/python -m avocado \
> >               $(if $(V),--show=3D$(AVOCADO_SHOW)) \
> >               assets fetch \
> > -            $(wildcard tests/acceptance/*.py), \
> > +            $(filter-out tests/acceptance/boot_linux.py,$(wildcard tes=
ts/acceptance/*.py)), \
> >               "AVOCADO", "tests/acceptance")
> >
> >   check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>



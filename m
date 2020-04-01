Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2945C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 20:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4AD20719
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 20:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKdP7E6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4AD20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJk2A-0008VV-LM
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 16:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jJk14-0007op-Qw
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 16:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jJk12-0002gV-NS
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 16:31:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44322
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jJk12-0002gD-IX
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 16:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585773072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xLEaDvVzHZC01pEaVim74+LBaHnEyvLX+yYBd/YG80=;
 b=EKdP7E6nTR2GUVQdVr2LTmns78II6oKuT1tNotX871bIYqC3o0ZsHtN4wOxh4UGXpeqSkM
 huAH+LG3L3+xnF3vSKkI6xPGcssBhxx3PhQ5vhnk0Am6vzGkfUqUXSebI48sjLbSLgzvmg
 7qs9KW6gWZITo4L9G/8g9xIzVhnYIWQ=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-wjOR09UGNLalmk_G0ianAA-1; Wed, 01 Apr 2020 16:31:09 -0400
X-MC-Unique: wjOR09UGNLalmk_G0ianAA-1
Received: by mail-vs1-f71.google.com with SMTP id o4so388393vsq.9
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 13:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3xLEaDvVzHZC01pEaVim74+LBaHnEyvLX+yYBd/YG80=;
 b=i8HR/hmzxgHAXofk1g3rD2K5egE29XyqAeORtRumeBGWKCwpr4rdU4CrZSl7u+qejS
 vrFW7rBhjBGZ5msHNyVmwSy/3X75DCdOoMdpS7cKSb0Guo2mRRara5qKKTHJAJWaTYN1
 GA28K+z0JEuKHUebX+x6YsOH77z9b8SH4wQT6pqupYbAhsBrufWrJ6djXJol1AmVhTGo
 /VsuFIuknb694pzuee2QSKVCVnsqxzgy71HXiFt7QUxedOtZbwuL6RhyPMpHO2HDIXsV
 l6mvIi5VWmWtwsq6COJrPMUM5nV6vEXwZljTS4l9VE/i4dc5/+meZWTdHb1gC6XVVZ8R
 LxkA==
X-Gm-Message-State: AGi0PuaA4A6QwT+ThXrGkwpnpFZjyKswl1rkEZ/qbAbwgewPocambTGI
 LOqkGRlwTC4P/hhVfEzCND5g1+DYwPL3O3CUCYqqGDZ/lkzpx9kAYN0Z23T4+rCrzoupfLIceUi
 jxESGbuFwqYu7tGVheUDJVQ0D2YJfa/Q=
X-Received: by 2002:a1f:2992:: with SMTP id p140mr17546334vkp.97.1585773068452; 
 Wed, 01 Apr 2020 13:31:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypIzpGzhGfNaeCJCAo+ZvwkMBrJ1fyr9iB0BjjwxSLzhbbQAwQzPdTccwF73UZR0w00Vm54wz5QIBfDKDHj7Ntk=
X-Received: by 2002:a1f:2992:: with SMTP id p140mr17546303vkp.97.1585773068194; 
 Wed, 01 Apr 2020 13:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-2-f4bug@amsat.org>
 <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
 <e5384733-7812-1e05-fdf1-92c08c457c4f@redhat.com>
 <CAKJDGDaE_OjqigaxXSJRkv7wfouLV-tsDQaXnWJXpn4F8DkPwQ@mail.gmail.com>
 <96219ba3-c114-0cec-8ace-bc19b254077a@redhat.com>
In-Reply-To: <96219ba3-c114-0cec-8ace-bc19b254077a@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Wed, 1 Apr 2020 17:30:57 -0300
Message-ID: <CAKJDGDbXeDrDWgxoZ=+LwPmexestnXJxqD5Mcrq9C4Aiy9x3dg@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 1/7] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 1, 2020 at 5:21 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
 <snip>
> Odd, with avocado-framework=3D=3D76.0 I get:
>
> https://travis-ci.org/github/philmd/qemu/jobs/669851870#L4908
>
> Traceback (most recent call last):
>    File "/usr/lib/python3.6/runpy.py", line 193, in _run_module_as_main
>      "__main__", mod_spec)
>    File "/usr/lib/python3.6/runpy.py", line 85, in _run_code
>      exec(code, run_globals)
>    File
> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6zsite-packa=
ges/avocado/__main__.py",
> line 11, in <module>
>      sys.exit(main.run())
>    File
> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-packa=
ges/avocado/core/app.py",
> line 91, in run
>      return method(self.parser.config)
>    File
> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-packa=
ges/avocado/plugins/assets.py",
> line 291, in run
>      success, fail =3D fetch_assets(test_file)
>    File
> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-packa=
ges/avocado/plugins/assets.py",
> line 200, in fetch_assets
>      handler =3D FetchAssetHandler(test_file, klass, method)
>    File
> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-packa=
ges/avocado/plugins/assets.py",
> line 65, in __init__
>      self.visit(self.tree)
>    File "/usr/lib/python3.6/ast.py", line 253, in visit
>      return visitor(node)
>    File "/usr/lib/python3.6/ast.py", line 261, in generic_visit
>      self.visit(item)
>    File "/usr/lib/python3.6/ast.py", line 253, in visit
>      return visitor(node)
>    File
> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-packa=
ges/avocado/plugins/assets.py",
> line 139, in visit_ClassDef
>      self.generic_visit(node)
>    File "/usr/lib/python3.6/ast.py", line 261, in generic_visit
>      self.visit(item)
>    File "/usr/lib/python3.6/ast.py", line 253, in visit
>      return visitor(node)
>    File
> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-packa=
ges/avocado/plugins/assets.py",
> line 171, in visit_Assign
>      self.asgmts[cur_klass][cur_method][name] =3D node.value.s
> KeyError: 'launch_and_wait'
> /home/travis/build/philmd/qemu/tests/Makefile.include:910: recipe for
> target 'fetch-acceptance-assets' failed
>
> This launch_and_wait comes from:
>
> tests/acceptance/boot_linux.py:88:    def launch_and_wait(self):

Sorry about that. This is a known bug, see
https://github.com/avocado-framework/avocado/issues/3661. It is fixed
upstream and will be available in the next release of Avocado.

Willian



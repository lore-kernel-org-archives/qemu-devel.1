Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59511C4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE9324699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BglioF/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE9324699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Iv3-00053v-Bp
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7IuF-0004Gj-7h
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7IuA-0001Md-0w
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:08:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7Iu9-0001ME-Sn
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582808921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wQPbJcOqw+XN7HfItx73DM4KbIp2VUGPQcud0GTG3qc=;
 b=BglioF/n/+BtwGezIwg9eeEzDB7F82Z2jyks7jb2VuE3RmsLfs5htba5ZGqWN7DI7sWjVj
 vY7jVVT5JPlJfxIjWN/GdhL5eadCApRnkiLYWXYSijWLfZZhCzmhxchQHXj/NcHXqdT2Fz
 G3cutP6nb+7ezsFgrcXIr6H0dceMv3s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-ua2yyaPQM6WEwy1y9FbloQ-1; Thu, 27 Feb 2020 08:08:36 -0500
X-MC-Unique: ua2yyaPQM6WEwy1y9FbloQ-1
Received: by mail-wr1-f72.google.com with SMTP id o9so1285606wrw.14
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wQPbJcOqw+XN7HfItx73DM4KbIp2VUGPQcud0GTG3qc=;
 b=q//mzSqMmkPje4xgJzY6xW++X8bd2KIjcUFwBuk/F9xjCpjj8rmDSM2WOzTvgFX8g8
 NCCPQzxcL1QJ11qyaauRJiBrf32/1r7qDKFnV+IR6GUJmz+/V6rN6gYPGz8NJbFTkMzi
 vVQl6bK8hUOPpWSXReEoBVDgPQUENM8oAhM1mvyHXcQr2ccAyAposYigO4i7nElDvLb/
 K9dQYFenGq7Hzl9t99CGZB8MyD0N3zHPVf/3U2IfiLz06MxEuMgLSIddg5zmht8IdAsU
 F+EFyWYV7FhHWa48HicKKRZU3ncuNgfP5hCvGvi/hFdVfVFSf/vYuvDGkEbbaS2RULVb
 RRCQ==
X-Gm-Message-State: APjAAAXKVwK9pqGUVcYHachL/IpQ2SeESxeY2K50dGmVlHhC8OMXzS/o
 NkwN1UWd6xvO+lgfjApfTYKHXDRrgScDQBEsL0+9BIzy+qKLL1JIZ8/Zxa6bEZ9NvXCYD9Aa050
 jgGZAu60vijYzGFY=
X-Received: by 2002:a1c:960c:: with SMTP id y12mr5241249wmd.9.1582808912626;
 Thu, 27 Feb 2020 05:08:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8nb+0YLDh5IhZzJT880WnFsAFMW0qE975lKIs60G6OnI1YOZrt+PCOGy/oLL6beNvC7Tv5g==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr5241216wmd.9.1582808912213;
 Thu, 27 Feb 2020 05:08:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:30cb:d037:e500:2b47?
 ([2001:b07:6468:f312:30cb:d037:e500:2b47])
 by smtp.gmail.com with ESMTPSA id z16sm7795579wrp.33.2020.02.27.05.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:08:31 -0800 (PST)
Subject: Re: [PATCH 01/18] qemu-doc: convert user-mode emulation to a separate
 Sphinx manual
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-2-pbonzini@redhat.com>
 <CAFEAcA-Qf_rC-EFNvmiFZtF1hhipL4qcPt8iOeK9pjAwOsPC2w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b651b07-f7c5-b8e9-d5df-a868af82d9ef@redhat.com>
Date: Thu, 27 Feb 2020 14:08:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Qf_rC-EFNvmiFZtF1hhipL4qcPt8iOeK9pjAwOsPC2w@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/02/20 12:07, Peter Maydell wrote:
> On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The final addition to the set of QEMU manuals is the user-mode emulation
>> manual, which right now is included in qemu-doc.texi.  Extract it and
>> convert it to rST, so that qemu-doc.texi covers only full system emulation.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> I'm going to wade in and start making review comments, but
> I'm happy to just take on this series and clean it up myself
> for a v2 (I'd like to quickly get to a base where I can start
> on dealing with the last bits of qemu-doc conversion that
> deal with hxtool.)
> 
> Did you do the conversion to rST automatically? If so then
> it would be useful to give the runes used in the commit message.

I started from the pandoc conversion but, unlike the others, this one
was reviewed, so I didn't include the command line.

Paolo

>> ---
>>  Makefile            |   8 +-
>>  docs/user/conf.py   |  18 +++
>>  docs/user/index.rst |  16 +++
>>  docs/user/main.rst  | 295 ++++++++++++++++++++++++++++++++++++++
>>  qemu-doc.texi       | 337 --------------------------------------------
>>  5 files changed, 336 insertions(+), 338 deletions(-)
>>  create mode 100644 docs/user/conf.py
>>  create mode 100644 docs/user/index.rst
>>  create mode 100644 docs/user/main.rst
> 
> A new manual also needs to be added to docs/index.html.in
> and to docs/index.rst.
> 
> (Compare 0928523a1230a69 which added the system manual.)
> 
>>
>> diff --git a/Makefile b/Makefile
>> index 15f8e53d05..73d8ed2b6a 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -786,6 +786,7 @@ distclean: clean
>>         $(call clean-manual,interop)
>>         $(call clean-manual,specs)
>>         $(call clean-manual,system)
>> +       $(call clean-manual,user)
> 
> This doesn't apply to current master because of the addition
> of the 'tools' manual, but the fixes to the conflicts are easy.
> 
>>         for d in $(TARGET_DIRS); do \
>>         rm -rf $$d || exit 1 ; \
>>          done
>> @@ -843,6 +844,7 @@ install-sphinxdocs: sphinxdocs
>>         $(call install-manual,interop)
>>         $(call install-manual,specs)
>>         $(call install-manual,system)
>> +       $(call install-manual,user)
>>
>>  install-doc: $(DOCS) install-sphinxdocs
>>         $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
>> @@ -1036,7 +1038,8 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
>>  sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
>>              $(MANUAL_BUILDDIR)/interop/index.html \
>>              $(MANUAL_BUILDDIR)/specs/index.html \
>> -            $(MANUAL_BUILDDIR)/system/index.html
>> +            $(MANUAL_BUILDDIR)/system/index.html \
>> +            $(MANUAL_BUILDDIR)/user/index.html
>>
>>  # Canned command to build a single manual
>>  # Arguments: $1 = manual name, $2 = Sphinx builder ('html' or 'man')
>> @@ -1069,6 +1072,9 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
>>  $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
>>         $(call build-manual,system,html)
>>
>> +$(MANUAL_BUILDDIR)/user/index.html: $(call manual-deps,user)
>> +       $(call build-manual,user,html)
>> +
>>  $(call define-manpage-rule,interop,\
>>         qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
>>         virtiofsd.1 virtfs-proxy-helper.1,\
>> diff --git a/docs/user/conf.py b/docs/user/conf.py
>> new file mode 100644
>> index 0000000000..b3e1b2318a
>> --- /dev/null
>> +++ b/docs/user/conf.py
>> @@ -0,0 +1,18 @@
>> +# -*- coding: utf-8 -*-
>> +#
>> +# QEMU documentation build configuration file for the 'system' manual.
> 
> Should say 'user'.
> 
>> +#
>> +# This includes the top level conf file and then makes any necessary tweaks.
>> +import sys
>> +import os
>> +
>> +qemu_docdir = os.path.abspath("..")
>> +parent_config = os.path.join(qemu_docdir, "conf.py")
>> +exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
>> +
>> +# This slightly misuses the 'description', but is the best way to get
>> +# the manual title to appear in the sidebar.
>> +html_theme_options['description'] = u'User Mode Emulation User''s Guide'
>> +# One entry per manual page. List of tuples
>> +# (source start file, name, description, authors, manual section).
>> +man_pages = []
> 
> You can just not specify man_pages at all if the manual
> doesn't create any manpages (devel and specs are like this):
> docs/conf.py sets it to [] by default.
> 
>> diff --git a/docs/user/index.rst b/docs/user/index.rst
>> new file mode 100644
>> index 0000000000..c81d2898cd
>> --- /dev/null
>> +++ b/docs/user/index.rst
>> @@ -0,0 +1,16 @@
>> +.. This is the top level page for the 'system' manual.
> 
> Should say 'user'.
> 
>> +
>> +
>> +QEMU User Mode Emulation User's Guide
>> +=====================================
>> +
>> +This manual is the overall guide for users using QEMU
>> +for user-mode emulation.  In this mode, QEMU can launch
>> +processes compiled for one CPU on another CPU.
>> +
>> +Contents:
>> +
>> +.. toctree::
>> +   :maxdepth: 2
>> +
>> +   main
> 
> The top level document looks a bit odd with this toctree
> which has a single level 1 entry whose title is basically
> the same as the whole manual's title, but it gives us a
> structure we can expand later I guess.
> 
> thanks
> -- PMM
> 



Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B54C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3E92074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gc12Yu4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3E92074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAc9k-0007gd-Ko
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kAc8v-0007BY-Dn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:49:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38336
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kAc8t-00038r-2j
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598374189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pr0KHOmj/hWyEsnsF2gbvRN6yoYd4tu53ta9sFYo2Ec=;
 b=gc12Yu4JbWRxNpO3ldtw+gqQDBWlXZQ3SM1J3ejCnGV2fd6Vc6wxtziluhZfz8WlrECoy7
 gXCbpLY9jBXSVl3NJ0v8g2h47iRZaaMBlUEvK+e8hjAIcuzFIEh2FPYq1uxMCN11SoeLSI
 J7+kXbqEnrBBf1q49DZ8jSGg88jHyqk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-hutyej6NM_KOBgJHInMqpA-1; Tue, 25 Aug 2020 12:49:47 -0400
X-MC-Unique: hutyej6NM_KOBgJHInMqpA-1
Received: by mail-io1-f69.google.com with SMTP id x12so4118422iow.7
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 09:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Pr0KHOmj/hWyEsnsF2gbvRN6yoYd4tu53ta9sFYo2Ec=;
 b=eDk7TB4jU+HfxNSWowzs/ZYCjGRtTv6XAL+FC9v+rLcrZWoQeb6fAF3FRVemi188/b
 GKSZtodF9qkUVfZFJe9OAWGUW+oRXg7ZWPkxddLjbx9bO5GWaIUGB0lAQaRn4eyDFYeL
 y83p2yQ6ZM2oMiMHoStkujOxZOYZwJwkW7X6gTyw/8xM5/qxu3j/c0Gk6lf4M2qhNCFg
 Z3ezbygudp67K/mLzD/lycWERuWzURJmBxPanOaFkcl1qA3Fvg9maSbk0S0n0qqa4iLM
 chK2/AlJFJJuGEqV9QfeU1zOyCgcoQcRteazypW9uFFbcSdjvYuxHCWkn3+ObYNT0Vfp
 mWRQ==
X-Gm-Message-State: AOAM530OHLd/TM/Ow37D8GeSW23ZJbgGryCl7GE6qZeIX6JNldW9MZo5
 0vAM+BgIq3n1OgebdfxeAtk9BQRK0MiFSQn28kNWrXWeWMx9+pLEnyV6hpOCxasPp4BgpNSXNem
 KiCvQbW6llBP9pzn+WCiqP9SDrQXu5O8=
X-Received: by 2002:a5d:9ac5:: with SMTP id x5mr10092789ion.111.1598374186569; 
 Tue, 25 Aug 2020 09:49:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxamCouJtBiFh2qbT7I3KEG5U6snPZAGwgtoHu5GC5plBLLmqQM/rXpAx0FMqXw5rg6EaT4LG+VpURmSKvQNFQ=
X-Received: by 2002:a5d:9ac5:: with SMTP id x5mr10092771ion.111.1598374186288; 
 Tue, 25 Aug 2020 09:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200825150409.346957-1-marcandre.lureau@redhat.com>
 <CABgObfbW5NMu4-NxiTNYF1NxiXt9pgyueJwv+vqdyQ5gySd+bQ@mail.gmail.com>
In-Reply-To: <CABgObfbW5NMu4-NxiTNYF1NxiXt9pgyueJwv+vqdyQ5gySd+bQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2020 20:49:35 +0400
Message-ID: <CAMxuvazbx51vcNSQfaGXhhuF-zrk6ixwhTMn2Bbfu0axQk5rww@mail.gmail.com>
Subject: Re: [PATCH 0/5] meson: mingw installation fixes & nsis conversion
To: Paolo Bonzini <pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 10:39:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: sw <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Aug 25, 2020 at 8:38 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Whenever we fix these bugs I would rather avoid adding duplicates between=
 options and config-host.mak, so that we can sooner or later get rid of con=
fig-host.mak.

This is not adding things to config-host.mak.

> For the same reason, I think all options should have a sensible default s=
o that in the end it will be possible to do "meson setup". Do you think it'=
s possible to extend the series in this direction?

The options I added also have default values.

I think trying to remove (or just move) variables would be a separate
goal from this series. It's already not completely trivial to get the
conversion working without regression, as you probably know :) better
not to mix goals imho.

>
> Paolo
>
> Il mar 25 ago 2020, 17:04 <marcandre.lureau@redhat.com> ha scritto:
>>
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Hi,
>>
>> The following patches fix installation path when cross-compiling Windows
>> version, and move the NSIS build rule to meson.
>>
>> Marc-Andr=C3=A9 Lureau (5):
>>   meson: pass confsuffix option
>>   meson: use meson datadir instead of qemu_datadir
>>   meson: add docdir option and pass pre-prefix qemu_docdir
>>   meson: use meson mandir instead of qemu_mandir
>>   meson: add NSIS building
>>
>>  Makefile                           | 56 -----------------------------
>>  configure                          |  2 ++
>>  contrib/vhost-user-gpu/meson.build |  2 +-
>>  docs/meson.build                   |  4 +--
>>  meson.build                        | 32 +++++++++++++++--
>>  meson_options.txt                  |  2 ++
>>  pc-bios/descriptors/meson.build    |  2 +-
>>  pc-bios/keymaps/meson.build        |  6 ++--
>>  pc-bios/meson.build                |  2 +-
>>  scripts/nsis.sh                    | 58 ++++++++++++++++++++++++++++++
>>  tools/virtiofsd/meson.build        |  2 +-
>>  trace/meson.build                  |  2 +-
>>  12 files changed, 101 insertions(+), 69 deletions(-)
>>  create mode 100755 scripts/nsis.sh
>>
>> --
>> 2.26.2
>>
>>



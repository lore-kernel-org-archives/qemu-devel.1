Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C8C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F5C21707
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaFoadSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F5C21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCvG-0002WP-14
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kQCuf-00025T-0k
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kQCuc-0005gR-3H
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602090450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/j7gDD9ZGMGnARgqJcWMTHQAyER+kLpgakbbSaCMlA=;
 b=UaFoadSH7Kwg4Lg1xpPJDobTt/9QlJeanCtP/9/gNBHJ7Jmbre2StjJRii8neaQxtzkRcu
 pdhAaoDzoMG/qs0L5XI14d+Hh73I46hSX90bZeYzahJYiEgElaG58qDDJhKoVSNsLLq3CK
 8S2o2uowBnWfc+5f1a04iZ4tmsQYdqI=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-2hjueKmcOQSnNHN3qmBxCw-1; Wed, 07 Oct 2020 13:07:29 -0400
X-MC-Unique: 2hjueKmcOQSnNHN3qmBxCw-1
Received: by mail-vs1-f70.google.com with SMTP id a11so402076vsd.10
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 10:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q/j7gDD9ZGMGnARgqJcWMTHQAyER+kLpgakbbSaCMlA=;
 b=dwa4Mnb3wIi/8vUzbjCeJ5yX7l2cu/F8vzWoGnWU4H42BXfDzOcfndpBdxK6RYyQT5
 yLJBm/5e5cta8uaNLsgR1pukPNRVa2Xkw79AFT5t9N20zV/qN5RThkBx/iH5M//yHr2b
 3Z2y6fKG8aeIYPGpkM0wBiczYz+TFzs4BPGfX3KC10i/pKoqUbLcncBfktJqvqtuZC2F
 h0G58MrcMRhgadhWgYRSBzmyCgQYdizY/gfdKK3l5XuIpWwt06o9FxcM/H6WxfGVlV4P
 vUtGRfujCZIM2CLgEN0KvFAkzYtXDfBY9VgiAmTTx+TqmUePrd/B/skjLxWD/B10ykWj
 kctg==
X-Gm-Message-State: AOAM53104uOXsuYWaG48yBMFAqlKawOSXJ7kV+2WJa+CIBw7BhnKDo/0
 fZSLuW1xraVs9r092hyAxMl3MmZ6xLqPbOwk5AJlAF3/YT2lnatqF8IV4+Haz2/UKW+ffqVv1tM
 LEEDMRAPe14A/F169m4h7LTJ5vnlNyTg=
X-Received: by 2002:a05:6102:224d:: with SMTP id
 e13mr2587928vsb.45.1602090448514; 
 Wed, 07 Oct 2020 10:07:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRsz61XwLzyE9AFjr33+YR8ur8gY0gZQZaRRQ0YsekGbRQKRR7Ts+sj3xHrvBUJ/giJNOHJN0vN0xW85E+TFI=
X-Received: by 2002:a05:6102:224d:: with SMTP id
 e13mr2587898vsb.45.1602090448306; 
 Wed, 07 Oct 2020 10:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201007160038.26953-1-alex.bennee@linaro.org>
 <20201007160038.26953-23-alex.bennee@linaro.org>
In-Reply-To: <20201007160038.26953-23-alex.bennee@linaro.org>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Wed, 7 Oct 2020 14:07:17 -0300
Message-ID: <CAKJDGDZbgDbj=+ih+cd4Wdkv2P2h3hpqTtucZSP-XFzhUmnP8g@mail.gmail.com>
Subject: Re: [PATCH v1 22/22] tests/acceptance: disable machine_rx_gdbsim on
 GitLab
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 7, 2020 at 1:37 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> While I can get the ssh test to fail on my test setup this seems a lot
> more stable except when on GitLab. Hopefully we can re-enable both
> once the serial timing patches have been added.

Fair enough!

>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/acceptance/machine_rx_gdbsim.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/mac=
hine_rx_gdbsim.py
> index 0c72506028..32b737b6d8 100644
> --- a/tests/acceptance/machine_rx_gdbsim.py
> +++ b/tests/acceptance/machine_rx_gdbsim.py
> @@ -22,6 +22,7 @@ class RxGdbSimMachine(Test):
>      timeout =3D 30
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_uboot(self):
>          """
>          U-Boot and checks that the console is operational.
> --
> 2.20.1
>
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>



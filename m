Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2DDC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED52120658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIcoz4GD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED52120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFiEi-0003o5-VU
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kFiE8-0003K9-O0
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kFiE5-0007BP-IN
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599589216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jvlpPoSj7pyP9gpc3myQo1eavLoAV/LQv9NAFJNFpi4=;
 b=PIcoz4GDn9d8fIYhEJp39MR04ax21XGuLnVmZVNp7sOBwuMdT8D4kuLVNPIJwB33YQP0Dz
 FA7XFi8hcQapB32G1sU+w/go8CExDobjZrFDlCPw1JMfErVsdTHdJKtQG85QKzhmxhcJj9
 zhIYPygpELfHHoGNgndlu0BGTDQBpHQ=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-inDPfLpBOrKLSoNrLNmbxg-1; Tue, 08 Sep 2020 14:20:00 -0400
X-MC-Unique: inDPfLpBOrKLSoNrLNmbxg-1
Received: by mail-vk1-f200.google.com with SMTP id o18so78151vke.23
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jvlpPoSj7pyP9gpc3myQo1eavLoAV/LQv9NAFJNFpi4=;
 b=XshnQPHbYLw3P4z7sGG/jaOJ3UTzT/jzX27NDSi5j/L/zCF0PSERd5u4bqifmJIWiG
 a76KlCQxKha4JLiMdFPJApqUcUKtEOGKCaFZWmLrpHOleDHP1u/X4TShWLYAnKm1COtp
 mcGw8rMCAQvu2DGINDL+TMwt156GdHdVEmNVcndM+kCf98Gc1RuUtgqWgxxQqlyJTZwd
 1tSIMNMvwxzjut5AMMfJpKN5L49Bx9qq3iHORchTOQMOng1rGcHF2h9wnuhx9pA9BKE3
 2PP54pG6h9hplwHf1jcKx/pIQGiObouX/ohO2/KgBi6a4+jSUPS0B2iB7+pmcKUJMrqL
 arrg==
X-Gm-Message-State: AOAM531YvLPQgCy0ofS5nwD1m8aR3/WkOU9K5VixUeShEDNV3w8sJj72
 /fi2VA4wl2E5GAuHOJrdBsTZ7b9i9ccHs377t+pAp2predy43tMXcCJjBmkeraFJtVgSZlwnyB8
 REQ57b9yHyzMbLxsG53Sh65H0+0ViY2I=
X-Received: by 2002:ab0:4387:: with SMTP id l7mr274245ual.133.1599589200014;
 Tue, 08 Sep 2020 11:20:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0ju5/FXusHC+jkjf0B84aJOZg9UDCfD7gdvkgErzQNALrMLEtBxAXh6AeDXhj+6HZCo9ymdNIdIV2xkJIYl0=
X-Received: by 2002:ab0:4387:: with SMTP id l7mr274219ual.133.1599589199773;
 Tue, 08 Sep 2020 11:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200907042000.415931-1-crosa@redhat.com>
 <20200907042000.415931-3-crosa@redhat.com>
In-Reply-To: <20200907042000.415931-3-crosa@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 8 Sep 2020 15:19:49 -0300
Message-ID: <CAKJDGDZxML6ONPMphCtchNqoWps_C+h+Mk75KqMkQeTiZ8grfw@mail.gmail.com>
Subject: Re: [PATCH 2/4] boot linux test: update arm bionic URL
To: Cleber Rosa <crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:54:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 7, 2020 at 1:20 AM Cleber Rosa <crosa@redhat.com> wrote:
>
> Which uses an xz compressed file, which has builtin support for
> decompression on avocado.utils.archive.  So the check for P7ZIP can be
> dropped, and extraction logic simplified.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 751b47b8fd..c75c512c8b 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -22,12 +22,6 @@ from avocado.utils import process
>  from avocado.utils import archive
>  from avocado.utils.path import find_command, CmdNotFoundError
>
> -P7ZIP_AVAILABLE = True
> -try:
> -    find_command('7z')
> -except CmdNotFoundError:
> -    P7ZIP_AVAILABLE = False
> -
>  """
>  Round up to next power of 2
>  """
> @@ -687,7 +681,6 @@ class BootLinuxConsole(LinuxKernelTest):
>          self.vm.wait()
>
>      @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
> -    @skipUnless(P7ZIP_AVAILABLE, '7z not installed')
>      def test_arm_orangepi_bionic(self):
>          """
>          :avocado: tags=arch:arm
> @@ -695,14 +688,13 @@ class BootLinuxConsole(LinuxKernelTest):
>          :avocado: tags=device:sd
>          """
>
> -        # This test download a 196MB compressed image and expand it to 1GB
> +        # This test download a 275MB compressed image and expand it to 1.1GB
>          image_url = ('https://dl.armbian.com/orangepipc/archive/'
> -                     'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
> -        image_hash = '196a8ffb72b0123d92cea4a070894813d305c71e'
> -        image_path_7z = self.fetch_asset(image_url, asset_hash=image_hash)
> -        image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
> -        image_path = os.path.join(self.workdir, image_name)
> -        process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
> +                     'Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz')

I see you bumped the version here because version 19 is not available
in the URL anymore, so it is fine for me.

> +        image_hash = 'b4d6775f5673486329e45a0586bf06b6dbe792199fd182ac6b9c7bb6c7d3e6dd'
> +        image_path_xz = self.fetch_asset(image_url, asset_hash=image_hash,
> +                                         algorithm='sha256')
> +        image_path = archive.extract(image_path_xz, self.workdir)
>          image_pow2ceil_expand(image_path)
>
>          self.vm.set_console()
> --
> 2.25.4
>

Except for the subject and description seaming a bit confusing as
pointed by Philippe, the changes look good to me.

Reviewed-by: Willian Rampazzo <willianr@redhat.com>



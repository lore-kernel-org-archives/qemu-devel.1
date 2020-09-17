Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34522C43463
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 21:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9142320870
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 21:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esa42m+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9142320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ1Qj-0005pn-H6
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 17:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kJ1Op-0005DZ-JM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 17:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kJ1On-0000wv-Bp
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 17:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600377899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKEPrBBDnTFTQTu0dUb1zmpdTZgXigqAm7fA981m2QY=;
 b=esa42m+U2BuavJQ68xYPTEMR+LZIzT14njH9a0rXBk5JT9Z3gwZkT4iOUWngdy0xdO3Yx0
 Kf6nF0kBotesQGUxoRO0hmZMkTlbRFo63CdNYUdNWH5usQ5ZB/CcUy+EXRmXP1WBdbtZ70
 ojZE/zvlvl5s3XYsjWjDPxBFE8i6kvI=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-ch-G88wFNuWwK5XcSPYh6g-1; Thu, 17 Sep 2020 17:24:53 -0400
X-MC-Unique: ch-G88wFNuWwK5XcSPYh6g-1
Received: by mail-vk1-f198.google.com with SMTP id e4so791668vkb.18
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 14:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CKEPrBBDnTFTQTu0dUb1zmpdTZgXigqAm7fA981m2QY=;
 b=qoC5P1xl0+4KQUwr/Mhl2NDdIWY7O+/R/vpkYJmWDeBnvE6rrCWux8euf0B/1ui5o9
 fLEbTOxz3ODKVThAVZ5K/D1ZBFIZqa5TQp77ywBCgerEipeanfm8sKj/ZPlm6ddNf+bX
 KyfDuJY4dvMrSMO2mjSlZaZGrqevi064uP4FHtoHRq5X5tg1sIt4Xs4AaSSW/wV4MKhJ
 USi568OZDprEcD/K96g1lbUIUqVR8IZjgh+Ol+AV7gADUPnPOmbZnmOULNIbLXlyxZao
 lfFhB/sDXYJ3CRBIRD+34ekAHoijpLMAjv8QD3DTqZqx3NNrSZ1LuV77P66GmvDfydYD
 rkrQ==
X-Gm-Message-State: AOAM530lhXZtyGQseHDOdytVliupZjZJh61c05mEqeLX1mrxt+0DAikB
 paGyC96zuWjc/MYmUaM3BBS0uoxOXdCaCuuoXRxHItu4oXwB82fJT6Ny13GT8Yo674fFMVzATt/
 xTBkdaa/COV9TPydRNUOAAElaoE77Bfo=
X-Received: by 2002:ab0:2652:: with SMTP id q18mr16465906uao.124.1600377892554; 
 Thu, 17 Sep 2020 14:24:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6p2FQN6YO9d81OtG6vJDuhKwrCO4B4Qp6bnhmT//lJh2UNBj/Ytz1BkHuDAgaaQEGq1C2xYKbbvHlYlqkhhM=
X-Received: by 2002:ab0:2652:: with SMTP id q18mr16465895uao.124.1600377892301; 
 Thu, 17 Sep 2020 14:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200917163954.50514-1-philmd@redhat.com>
In-Reply-To: <20200917163954.50514-1-philmd@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Thu, 17 Sep 2020 18:24:41 -0300
Message-ID: <CAKJDGDbVkyOAzB21doq790Vq-ZE2TYENjrav9-HwAaTJ=CpC6g@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: Disable tests dependent of unreliable
 apt.armbian.com
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 1:41 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Armbian servers are not very reliable and confused the GitLab CI
> users a few times this month (path updated, archives moved, and
> now the SSL: CERTIFICATE_VERIFY_FAILED "certificate has expired"
> error). Time to disable these tests.
> Users can still use the artifacts from the cache (or manually add
> them to the cache).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 10 ++++++++++
>  tests/acceptance/replay_kernel.py      |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 4a366ce93e4..68534693109 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -485,6 +485,8 @@ def test_arm_exynos4210_initrd(self):
>          self.wait_for_console_pattern('Boot successful.')
>          # TODO user command, for now the uart is stuck
>
> +    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
> +                'Test artifacts fetched from unreliable apt.armbian.com'=
)
>      def test_arm_cubieboard_initrd(self):
>          """
>          :avocado: tags=3Darch:arm
> @@ -525,6 +527,8 @@ def test_arm_cubieboard_initrd(self):
>                                                  'system-control@1c00000'=
)
>          # cubieboard's reboot is not functioning; omit reboot test.
>
> +    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
> +                'Test artifacts fetched from unreliable apt.armbian.com'=
)
>      def test_arm_cubieboard_sata(self):
>          """
>          :avocado: tags=3Darch:arm
> @@ -651,6 +655,8 @@ def test_arm_quanta_gsj_initrd(self):
>          self.wait_for_console_pattern(
>                  'Give root password for system maintenance')
>
> +    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
> +                'Test artifacts fetched from unreliable apt.armbian.com'=
)
>      def test_arm_orangepi(self):
>          """
>          :avocado: tags=3Darch:arm
> @@ -676,6 +682,8 @@ def test_arm_orangepi(self):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
>          self.wait_for_console_pattern(console_pattern)
>
> +    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
> +                'Test artifacts fetched from unreliable apt.armbian.com'=
)
>      def test_arm_orangepi_initrd(self):
>          """
>          :avocado: tags=3Darch:arm
> @@ -718,6 +726,8 @@ def test_arm_orangepi_initrd(self):
>          # Wait for VM to shut down gracefully
>          self.vm.wait()
>
> +    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
> +                'Test artifacts fetched from unreliable apt.armbian.com'=
)
>      def test_arm_orangepi_sd(self):
>          """
>          :avocado: tags=3Darch:arm
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_=
kernel.py
> index b79fc8daf8e..7b4310fccf3 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -127,6 +127,8 @@ def test_arm_virt(self):
>          self.run_rr(kernel_path, kernel_command_line, console_pattern, s=
hift=3D1)
>
>      @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
> +                'Test artifacts fetched from unreliable apt.armbian.com'=
)
>      def test_arm_cubieboard_initrd(self):
>          """
>          :avocado: tags=3Darch:arm
> --
> 2.26.2
>
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>



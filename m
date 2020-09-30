Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F4DC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E5820754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuEn9zLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E5820754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNc6d-0007zF-0z
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kNc61-0007TA-4F
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kNc5y-00042h-I0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601472273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=stVcbDfdLQzTa80M5DmjetElKyIutbnN14+FcKZcDXM=;
 b=JuEn9zLlnT0f9LbmMQ7lxlajAbHk/tHjB4vSIgGAKsIh7lNxjFXs2tCXfWEuSvC9gNA8KL
 /FW4uhvmAR45bGZG19g91PQ6XoUHP/Jp/usGscKZbre62cPKxm+Gd+yAUj0OoeBysdbBSg
 CI55N9iQiaWOQtEAb/kq0J9W1837cJQ=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-XxU27SwBNKCKCMKup1ajWA-1; Wed, 30 Sep 2020 09:24:29 -0400
X-MC-Unique: XxU27SwBNKCKCMKup1ajWA-1
Received: by mail-vs1-f70.google.com with SMTP id h8so170688vsh.19
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 06:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=stVcbDfdLQzTa80M5DmjetElKyIutbnN14+FcKZcDXM=;
 b=LA9QjxVjwaSWhpcW6Lktv8Bp9bfyT8XIuGGJs0wAbq+oH1x8BTR5rcIxL7Y61yxw8C
 cMeS5p//Uo9CZFjouqODaDnZQfvlpTGpfDTfA9hhfsDKbCO+Cml9eRGX6ivm0YSnLY5d
 vLeyclMiVVFxwpiytQYyXs3+2PQ1lmUA+mkFvbbiLTysmVx9t8mz6s/Br9NoECB0bj9u
 N9yfVrQqawisbGKihOQJ/kvzlnafqT7IM2O3PVB9NztvngtXK3P7EzsepbsNwy5r9AK8
 GKnJKyecLdvuziEZeUQZ9Og3fAbm7U9K6233zMd7myRy7BkwwAEp7m3yJMgeLkVCbSP9
 5dPA==
X-Gm-Message-State: AOAM533A6aF8Jccghlqvqx0CUEhxSW3MdELbTCTsjgKgErLiP2YRpaGZ
 9VZ2k6kytoZiApXeIEZSyrVoA/6Ma7cOtw0wZqjNn7bufu6PWmG38MB8efqtPABkK0e9HWhEdS9
 l6kWxsLway8NpFyFhB+yRCxvaxIMFw5A=
X-Received: by 2002:a1f:acc9:: with SMTP id v192mr1299961vke.19.1601472267900; 
 Wed, 30 Sep 2020 06:24:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHcBjDryiDprmnybUyB+gW4jUuddM7G4l31RdW1pfb6IAiJgCBXzQwgIyztcH9zFwx1aDEkWwLXQHV7a24ElU=
X-Received: by 2002:a1f:acc9:: with SMTP id v192mr1299944vke.19.1601472267679; 
 Wed, 30 Sep 2020 06:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200929224857.1225107-1-philmd@redhat.com>
In-Reply-To: <20200929224857.1225107-1-philmd@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Wed, 30 Sep 2020 10:24:16 -0300
Message-ID: <CAKJDGDZeBxjjkGt2o6SjKSMc9avT0YUWAXkBnt7zqtW0xopkAQ@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: Add a 'virt_kvm' test using the GICv3
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Willian Rampazzo <willianr@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 7:49 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The current 'virt_kvm' test is restricted to GICv2, but can also
> work with a GICv3. Duplicate it but add a GICv3 test which can be
> tested on some hardware.

Fair enough! :)

>
> Noticed while running:
>
>  $ avocado --show=3Dapp run -t machine:virt tests/acceptance/
>  ...
>  (2/6) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_kvm: ERR=
OR: Unexpected empty reply from server (1.82 s)
>
> The job.log content is:
>
>   L0351 DEBUG| Output: 'qemu-system-aarch64: host does not support in-ker=
nel GICv2 emulation\n'
>
> With this patch:
>
>  $ avocado --show=3Dapp run -t device:gicv3 tests/acceptance/
>  (1/1) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_kvm_gicv=
3: PASS (55.10 s)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/boot_linux.py | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux=
.py
> index 0055dc7cee..c743e231f4 100644
> --- a/tests/acceptance/boot_linux.py
> +++ b/tests/acceptance/boot_linux.py
> @@ -182,10 +182,11 @@ def test_virt_tcg(self):
>          self.add_common_args()
>          self.launch_and_wait()
>
> -    def test_virt_kvm(self):
> +    def test_virt_kvm_gicv2(self):
>          """
>          :avocado: tags=3Daccel:kvm
>          :avocado: tags=3Dcpu:host
> +        :avocado: tags=3Ddevice:gicv2
>          """
>          if not kvm_available(self.arch, self.qemu_bin):
>              self.cancel(KVM_NOT_AVAILABLE)
> @@ -195,6 +196,20 @@ def test_virt_kvm(self):
>          self.add_common_args()
>          self.launch_and_wait()
>
> +    def test_virt_kvm_gicv3(self):
> +        """
> +        :avocado: tags=3Daccel:kvm
> +        :avocado: tags=3Dcpu:host
> +        :avocado: tags=3Ddevice:gicv3
> +        """
> +        if not kvm_available(self.arch, self.qemu_bin):
> +            self.cancel(KVM_NOT_AVAILABLE)
> +        self.vm.add_args("-accel", "kvm")
> +        self.vm.add_args("-cpu", "host")
> +        self.vm.add_args("-machine", "virt,gic-version=3D3")
> +        self.add_common_args()
> +        self.launch_and_wait()
> +
>
>  class BootLinuxPPC64(BootLinux):
>      """
> --
> 2.26.2
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>



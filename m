Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0407EC55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406DC2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGHuWm7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406DC2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4mH-0000vf-4Q
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 06:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kY4kb-0007rB-NO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:01:48 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kY4kO-0007yB-Kr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:01:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id m13so2054838wrj.7
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NgsgEF3cxh4a2QJyJ3yz8CSoN5GhmG6ImfMK4QDU38Q=;
 b=eGHuWm7a8YHGoQQJkRVDw9QsDr2F43cQVL2euxj7XBnjYPtt7Ib7g0Fn20LpIHzM47
 AeRkPIcP3DbwaJ6NXZg2r6ecLsBsD6o91apVoD6gYryRRyOKYestNhleAmHqSuM1+qyz
 CYCR7QIFKJXHbeCTDBP3r+bQ1E3vz1F42SOctC7E1xzUbbuFAjnYA/ZXCEOi8hdrXMFo
 j9SIq0z07Vcs/z9RucelrLvYmvli/8Kkkqepvn/93566Ch38fBldRiJk3vo+rjc1jZiU
 WsVXVdM7YuZmZ4BHH+ILPVAmBYZw8oz2yEtuSmn16ftgAavQQNSm3t/moMEUu/ymqq+f
 E1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NgsgEF3cxh4a2QJyJ3yz8CSoN5GhmG6ImfMK4QDU38Q=;
 b=gtOFYDGi7DZ/dVyCUvnUjkWOcREfBDSPUvuwBJNvAbHDbuQZ8iZ8rFTwITwz8Ve8nU
 vK1tHVcslULmGU22k8kM+PfV917Ww3TTNNAypG3FWQ+u3uyq75lS3I3fN0iuVFcvqyTr
 R9NahB5XJQ3bG2dOI+IY4F7nvq6bI3T6J1T9XEwpLNG9Zdc8p93Jv+cvC9OuQoDi0fco
 ZnMO9+5QzOgCde63c2CbEVbSsmYcH8tqOGaeevba+O7PDD6xSRrNqOPttYtkp2nrA+l6
 j3oLY+W5Y13VPaPhzGeegS1kpZch7iKaAxbqXtxBYeWVp9PuWErJ+y9T8LlEq1ChozcK
 pwEQ==
X-Gm-Message-State: AOAM530awPoY7T0rehxSSX7klfI1E2ScWWs4d/7+9eN7UCH5XiOjjxzd
 FJ8gsohiUaX/CRfl6dpP0FwfHA==
X-Google-Smtp-Source: ABdhPJzWpStp+pVp+vl7p4xVCS8J5Ty0ezaMWiGhF7GJHh+IQlKU+PIE3IZJSNl53jpoBI09DxLgvA==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr4433017wrq.129.1603965689861; 
 Thu, 29 Oct 2020 03:01:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m8sm4010179wrw.17.2020.10.29.03.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 03:01:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CD4601FF7E;
 Thu, 29 Oct 2020 10:01:27 +0000 (GMT)
References: <20201028174406.23424-1-alex.bennee@linaro.org>
 <alpine.DEB.2.21.2010281406080.12247@sstabellini-ThinkPad-T480s>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] meson.build: fix building of Xen support for aarch64
In-reply-to: <alpine.DEB.2.21.2010281406080.12247@sstabellini-ThinkPad-T480s>
Date: Thu, 29 Oct 2020 10:01:27 +0000
Message-ID: <87d011mjuw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 qemu-devel@nongnu.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefano Stabellini <sstabellini@kernel.org> writes:

> On Wed, 28 Oct 2020, Alex Benn=C3=A9e wrote:
>> Xen is supported on aarch64 although weirdly using the i386-softmmu
>> model. Checking based on the host CPU meant we never enabled Xen
>> support. It would be nice to enable CONFIG_XEN for aarch64-softmmu to
>> make it not seem weird but that will require further build surgery.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> Cc: Paul Durrant <paul@xen.org>
>> Fixes: 8a19980e3f ("configure: move accelerator logic to meson")
>> ---
>>  meson.build | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/meson.build b/meson.build
>> index 835424999d..f1fcbfed4c 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -81,6 +81,8 @@ if cpu in ['x86', 'x86_64']
>>      'CONFIG_HVF': ['x86_64-softmmu'],
>>      'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
>>    }
>> +elif cpu in [ 'arm', 'aarch64' ]
>> +  accelerator_targets +=3D { 'CONFIG_XEN': ['i386-softmmu'] }
>>  endif
>
> This looks very reasonable -- the patch makes sense.
>
>
> However I have two questions, mostly for my own understanding. I tried
> to repro the aarch64 build problem but it works at my end, even without
> this patch.

Building on a x86 host or with cross compiler?

> I wonder why. I suspect it works thanks to these lines in
> meson.build:
>
>   if not get_option('xen').disabled() and 'CONFIG_XEN_BACKEND' in config_=
host
>     accelerators +=3D 'CONFIG_XEN'
>     have_xen_pci_passthrough =3D not get_option('xen_pci_passthrough').di=
sabled() and targetos =3D=3D 'linux'
>   else
>     have_xen_pci_passthrough =3D false
>   endif
>
> But I am not entirely sure who is adding CONFIG_XEN_BACKEND to
> config_host.

The is part of the top level configure check - which basically checks
for --enable-xen or autodetects the presence of the userspace libraries.
I'm not sure if we have a slight over proliferation of symbols for Xen
support (although I'm about to add more).

> The other question is: does it make sense to print the value of
> CONFIG_XEN as part of the summary? Something like:
>
> diff --git a/meson.build b/meson.build
> index 47e32e1fcb..c6e7832dc9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2070,6 +2070,7 @@ summary_info +=3D {'KVM support':       config_all.=
has_key('CONFIG_KVM')}
>  summary_info +=3D {'HAX support':       config_all.has_key('CONFIG_HAX')}
>  summary_info +=3D {'HVF support':       config_all.has_key('CONFIG_HVF')}
>  summary_info +=3D {'WHPX support':      config_all.has_key('CONFIG_WHPX'=
)}
> +summary_info +=3D {'XEN support':      config_all.has_key('CONFIG_XEN')}
>  summary_info +=3D {'TCG support':       config_all.has_key('CONFIG_TCG')}
>  if config_all.has_key('CONFIG_TCG')
>    summary_info +=3D {'TCG debug enabled': config_host.has_key('CONFIG_DE=
BUG_TCG')}
>
>
> But I realize there is already:
>
> summary_info +=3D {'xen support':       config_host.has_key('CONFIG_XEN_B=
ACKEND')}
>
> so it would be a bit of a duplicate

Hmm so what we have is:

  CONFIG_XEN_BACKEND
    - ensures that appropriate compiler flags are added
    - pegs RAM_ADDR_MAX at UINT64_MAX (instead of UINTPTR_MAX)
  CONFIG_XEN
    - which controls a bunch of build objects, some of which may be i386 on=
ly?
    ./accel/meson.build:15:specific_ss.add_all(when: ['CONFIG_XEN'], if_tru=
e: dummy_ss)
    ./accel/stubs/meson.build:2:specific_ss.add(when: 'CONFIG_XEN', if_fals=
e: files('xen-stub.c'))
    ./accel/xen/meson.build:1:specific_ss.add(when: 'CONFIG_XEN', if_true: =
files('xen-all.c'))
    ./hw/9pfs/meson.build:17:fs_ss.add(when: 'CONFIG_XEN', if_true: files('=
xen-9p-backend.c'))
    ./hw/block/dataplane/meson.build:2:specific_ss.add(when: 'CONFIG_XEN', =
if_true: files('xen-block.c'))
    ./hw/block/meson.build:14:softmmu_ss.add(when: 'CONFIG_XEN', if_true: f=
iles('xen-block.c'))
    ./hw/char/meson.build:23:softmmu_ss.add(when: 'CONFIG_XEN', if_true: fi=
les('xen_console.c'))
    ./hw/display/meson.build:18:softmmu_ss.add(when: 'CONFIG_XEN', if_true:=
 files('xenfb.c'))
    ./hw/i386/xen/meson.build:1:i386_ss.add(when: 'CONFIG_XEN', if_true: fi=
les('xen-hvm.c',
                                                                           =
    'xen-mapcache.c',
                                                                           =
    'xen_apic.c',
                                                                           =
    'xen_platform.c',
                                                                           =
    'xen_pvdevice.c')
    ./hw/net/meson.build:2:softmmu_ss.add(when: 'CONFIG_XEN', if_true: file=
s('xen_nic.c'))
    ./hw/usb/meson.build:76:softmmu_ss.add(when: ['CONFIG_USB', 'CONFIG_XEN=
', libusb], if_true: files('xen-usb.c'))
    ./hw/xen/meson.build:1:softmmu_ss.add(when: ['CONFIG_XEN', xen], if_tru=
e: files(
    ./hw/xen/meson.build:20:specific_ss.add_all(when: ['CONFIG_XEN', xen], =
if_true: xen_specific_ss)
    ./hw/xenpv/meson.build:3:xenpv_ss.add(when: 'CONFIG_XEN', if_true: file=
s('xen_machine_pv.c'))
    - there are also some stubbed inline functions controlled by it
  CONFIG_XEN_IGD_PASSTHROUGH
    - specific x86 PC only feature via Kconfig rule
  CONFIG_XEN_PCI_PASSTHROUGH
    - control Linux specific specific feature (via meson rule)


First obvious question - is everything in hw/i386/xen actually i386
only? APIC seems pretty PC orientated but what about xen_platform and
pvdevice? There seem to be some dependancies on xen-mapcache across the
code.

--=20
Alex Benn=C3=A9e


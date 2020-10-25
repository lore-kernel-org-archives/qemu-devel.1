Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8861CC388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 20:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB5522284
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 20:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI7FjKaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB5522284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWmTk-0007T4-OP
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 16:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWmS8-0006ru-0y
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 16:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWmS5-0002sl-82
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 16:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603657031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A84ciwOwF7C0A7sMoy8rUR68i3xBWzE+J5TgW7uwkxE=;
 b=EI7FjKaUWaYO5sDetX8q4BNzveCJizZqIT0g89tLYb/1t76wEaD7x9aW6OYD348sTOwQXs
 HDoM7VfcPM6mmD9hix3JXyjkE8NCGAI6Us8AYOdzXUbfNyOckstmNs9KwHNF9qYoQ4dVlU
 PIqi3TzIIjJETRMHz7xg48CA/3puH/A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-9k_wTbOfNPCmJ81uEYmO-g-1; Sun, 25 Oct 2020 16:17:08 -0400
X-MC-Unique: 9k_wTbOfNPCmJ81uEYmO-g-1
Received: by mail-wr1-f72.google.com with SMTP id j15so8089wro.4
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 13:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A84ciwOwF7C0A7sMoy8rUR68i3xBWzE+J5TgW7uwkxE=;
 b=p4vPqUMgA6Rjh69JNGKZbKx4tLr8Cf0KkJiVHCvlmDgnD/rGL7gYT72lhpe8sJBCwe
 SgrfPM1BMrxjI5xY5+QaNM4WCIZdSxOMqTz8osSHaFDnjOAN2LqFpnLTwdMQbGC7JB6z
 EQSrrWL0eR5akwrUC33KV32cLBZutNqZL4C2eZHin+XbqlNGCaJfytxVCja/UvkmyiW+
 +zbtf5tF4156iTYcreQwQoEFx8YBL4EIjgE4iwSKbg4dG37kppjkEhZR3ppyYYZxv2Be
 JP+yfWdZIUUFZEdaOIbFovBOZ4xMIEb1H+bvV4lvP6hnWttSGmpAIyVMGVuAnhvYDOx2
 8Xfg==
X-Gm-Message-State: AOAM532xLKhkkIcEBw5CjhxyLY9cSel4CQYboSx9AFsuHjfRY4VRmfTv
 ZuuyeoMDtMFWO51ionBbEFjRH3wIb9zVNTbKelnPMLBoYvidRW6zdDf0CRWsMR9SOqYbXrWXQOa
 WdSfLn0VAGgWy8X4=
X-Received: by 2002:a5d:5387:: with SMTP id d7mr14046230wrv.224.1603657027305; 
 Sun, 25 Oct 2020 13:17:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcyJ5YNYg5lzN5LkS66U7WL3ofeLbxZhAVpk795FVwSq70jOw2JSSDGybJsKoEHEEwJSEC0A==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr14046196wrv.224.1603657026915; 
 Sun, 25 Oct 2020 13:17:06 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id m14sm19346480wro.43.2020.10.25.13.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2020 13:17:06 -0700 (PDT)
Subject: Re: [RFC PATCH 4/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
To: Niek Linnenbank <nieklinnenbank@gmail.com>, Bin Meng
 <bmeng.cn@gmail.com>, avocado-devel <avocado-devel@redhat.com>
References: <20201023131808.3198005-1-f4bug@amsat.org>
 <20201023131808.3198005-5-f4bug@amsat.org>
 <CAPan3Wp3CEh0Q1pJ41+rqBqAucFULAfAj=sR4Ba10hcW+1Tc7w@mail.gmail.com>
 <CAEUhbmX8MWBL_7LgLZ5-xNJJ4iddtgQKV9q4qydhektok+zxNA@mail.gmail.com>
 <CAPan3Wo-nydxbQ=Orfi_nzgAr-uMaiGn67tF_fxfW+7OkaZ5VA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <268631c7-90d0-6f5b-6a60-f786e6a552d8@redhat.com>
Date: Sun, 25 Oct 2020 21:17:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAPan3Wo-nydxbQ=Orfi_nzgAr-uMaiGn67tF_fxfW+7OkaZ5VA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 16:17:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing avocado-devel@

On 10/26/20 12:35 AM, Niek Linnenbank wrote:
> On Sun, Oct 25, 2020 at 3:17 AM Bin Meng <bmeng.cn@gmail.com 
> <mailto:bmeng.cn@gmail.com>> wrote:
>     On Sun, Oct 25, 2020 at 5:01 AM Niek Linnenbank
>     <nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>> wrote:
...
>      > After applying that change, all Orange Pi tests run successfully:
>      >
>      > $ AVOCADO_ALLOW_LARGE_STORAGE=yes ARMBIAN_ARTIFACTS_CACHED=yes
>     avocado --show=app,console run -t machine:orangepi-pc
>     tests/acceptance/boot_linux_console.py
> 
>     This command does not work for me.
> 
>     Traceback (most recent call last):
>        File "/usr/local/bin/avocado", line 5, in <module>
>          from avocado.core.main import main
>        File "/usr/local/lib/python3.8/dist-packages/avocado/core/main.py",
>     line 22, in <module>
>          from avocado.core import data_dir
>        File
>     "/usr/local/lib/python3.8/dist-packages/avocado/core/data_dir.py",
>     line 39, in <module>
>          from .output import LOG_JOB, LOG_UI
>        File "/usr/local/lib/python3.8/dist-packages/avocado/core/output.py",
>     line 27, in <module>
>          from .settings import settings
>        File
>     "/usr/local/lib/python3.8/dist-packages/avocado/core/settings.py",
>     line 625, in <module>
>          settings = Settings()  # pylint: disable-msg=invalid-name
>        File
>     "/usr/local/lib/python3.8/dist-packages/avocado/core/settings.py",
>     line 274, in __init__
>          self._prepare_base_dirs()
>        File
>     "/usr/local/lib/python3.8/dist-packages/avocado/core/settings.py",
>     line 315, in _prepare_base_dirs
>          self._config_path_pkg = resource_filename('avocado',
>     config_pkg_base)
>        File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py",
>     line 1145, in resource_filename
>          return get_provider(package_or_requirement).get_resource_filename(
>        File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py",
>     line 365, in get_provider
>          return _find_adapter(_provider_factories, loader)(module)
>        File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py",
>     line 1393, in __init__
>          self.module_path = os.path.dirname(getattr(module, '__file__', ''))
>        File "/usr/lib/python3.8/posixpath.py", line 152, in dirname
>          p = os.fspath(p)
>     TypeError: expected str, bytes or os.PathLike object, not NoneType
> 
>     I haven't got a command to work on testing only a single target. Any
>     hint? Thanks!
> 
> 
> That error is new to me, I have not seen it before. From the stacktrace, 
> it looks like that avocado is trying to read its own configuration / 
> settings file (from settings.py).
> Later on there is a type conversion error for NoneType. Perhaps the 
> avocado files for your user have somehow got corrupted?
> You could try to remove them from your home directory and/or re-install 
> avocado as well and start out fresh.
> I assume that at least 'avocado --help'  should work without generating 
> this error.
> 
> Also it may be useful to know that it looks like you need to run avocado 
> from within the new 'build' directory that the new meson build system 
> now creates.
> If not running from the 'build' directory, I'm getting this printed on 
> my machine:
>    CANCEL: No QEMU binary defined or found in the build tree
> 
> So once your avocado is working without the type error you could try this:
> 
> 1) cd build
> 2) AVOCADO_ALLOW_LARGE_STORAGE=yes ARMBIAN_ARTIFACTS_CACHED=yes avocado 
> --show=app,console run -t machine:orangepi-pc 
> tests/acceptance/boot_linux_console.py
> 
> Alternatively, if you can't get avocado to run anything, you could also 
> just run the Armbian image (or any other image) directly via 
> qemu-system-arm:
> 
>    $ build/arm-softmmu/qemu-system-arm -M orangepi-pc -nographic -nic 
> user -sd Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img
>    U-Boot SPL 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200)
>    DRAM: 1024 MiB
>    ...
>    Autoboot in 1 seconds, press <Space> to stop
>    => setenv extraargs 'console=ttyS0,115200'
>    => boot
>    ...
>    Uncompressing Linux... done, booting the kernel.
>    Loading, please wait...
>    starting version 237
> 
> Also see the file docs/system/arm/orangepi.rst with some additional 
> information and documentation.
> 
> Hope this helps & regards,
> 
> Niek



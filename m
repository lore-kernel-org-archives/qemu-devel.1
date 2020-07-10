Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E910C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FBC2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9YcQ+DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FBC2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtwMx-0003pd-2l
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtwMK-0003PZ-SM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:58:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27219
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtwMH-0002wU-W8
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594400324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TpzwPi28Xan5vKT/YFon/l4V8ZB1eZL/orWKc7YBCiU=;
 b=f9YcQ+DP1DxGLPVRvjTfeopK4WVBWKWqUpC/VM6C4KCBGEu2AiqGnTZSEHMMo4pYS0wm85
 y2EM7i/7RbjZL7IPo5twMHiavowr58oo2Dl+aAVaXcpPa3raD1Flwtn8z69hHyijeMV6+I
 MBr3/lfXQvCpSLlbqo7RZZUhpfKAh7k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-ci-17HMaPl6GybIiD39yGg-1; Fri, 10 Jul 2020 12:58:40 -0400
X-MC-Unique: ci-17HMaPl6GybIiD39yGg-1
Received: by mail-wr1-f71.google.com with SMTP id j3so6614933wrq.9
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 09:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TpzwPi28Xan5vKT/YFon/l4V8ZB1eZL/orWKc7YBCiU=;
 b=oZwECbo7182nYDZBg0rgLkYulyjQyQuFzwTAJImdJ5GJQrRRmrO3QSVA8rguiEZuQ2
 y/gD2CFvgbAKeshoRtRpHZVPDy6PWpejHJ48x80ennrg66IEI42vMdCr/q+1HUJo8IsA
 6kL3/sdUCnYZwyKxDE5FhZliUKXzVscGqM016lU961jaJA5PZDOAyXHBFmJOXvfmXvTv
 JLsmlRkiGbH7Gxwj6JgNm3UBwMg8S6oHfkIQSBUN1ptXGAJ5LMcZVuegVu00fUP1Cwq7
 ehB5ffge5k8stcEe9MnZbmImewoctfeCz9ULyDZ4hTgzQ97rfJs2PRedZvwUzrIAOf0/
 /g/g==
X-Gm-Message-State: AOAM5338AyRnJ0QgoD8Vz88e7zUgc/iSul0wl+sHfSrwGrN12K8KtbpO
 HNEeOiyDAUuhyEfvlTVy8RF6ALB7tlzmzHbjhADo3SZ3589Ci8NADVUO09BvdUMDNZDsJBRmB3G
 lihYOY2jzkw2bAnY=
X-Received: by 2002:adf:80c2:: with SMTP id 60mr51768251wrl.388.1594400319096; 
 Fri, 10 Jul 2020 09:58:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmcYulK4nR4cZlH9F2SyX0/YjD2IE2h7Ss5inEJg9gospT5G5LQFgLreedwRgaXPhc9Kesag==
X-Received: by 2002:adf:80c2:: with SMTP id 60mr51768238wrl.388.1594400318874; 
 Fri, 10 Jul 2020 09:58:38 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v12sm10765614wrt.31.2020.07.10.09.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 09:58:38 -0700 (PDT)
Subject: Re: [PULL 00/10] Modules 20200707 patches
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200707134229.9773-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <0edadbc3-1407-4fcb-e2f0-72097ebff05a@redhat.com>
Date: Fri, 10 Jul 2020 18:58:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200707134229.9773-1-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 3:42 PM, Gerd Hoffmann wrote:
> The following changes since commit 7623b5ba017f61de5d7c2bba12c6feb3d55091b1:
> 
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-07-06 11:40:10 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kraxel.org/qemu tags/modules-20200707-pull-request
> 
> for you to fetch changes up to ef138c77249771081d8c2d09b8e729f7e92cdf28:
> 
>   chardev: enable modules, use for braille (2020-07-07 15:33:59 +0200)
> 
> ----------------------------------------------------------------
> qom: add support for qom objects in modules.
> build some devices (qxl, virtio-gpu, ccid, usb-redir) as modules.
> build braille chardev as module.
> 
> v2: more verbose comment for "build: fix device module builds" patch.
> 
> note: qemu doesn't rebuild objects on cflags changes (specifically
>       -fPIC being added when code is switched from builtin to module).
>       Workaround for resulting build errors: "make clean", rebuild.
> 
> ----------------------------------------------------------------
> 
> Gerd Hoffmann (10):
>   module: qom module support
>   object: qom module support
>   qdev: device module support
>   build: fix device module builds
>   ccid: build smartcard as module
>   usb: build usb-redir as module
>   vga: build qxl as module
>   vga: build virtio-gpu only once
>   vga: build virtio-gpu as module
>   chardev: enable modules, use for braille
> 
>  Makefile.objs            |  2 ++
>  Makefile.target          | 14 +++++++++
>  include/qemu/module.h    |  2 ++
>  include/qom/object.h     | 12 +++++++
>  chardev/char.c           |  2 +-
>  hw/core/qdev.c           |  6 ++--
>  qdev-monitor.c           |  5 +--
>  qom/object.c             | 14 +++++++++
>  qom/qom-qmp-cmds.c       |  3 +-
>  softmmu/vl.c             |  4 +--
>  util/module.c            | 67 ++++++++++++++++++++++++++++++++++++++++
>  chardev/Makefile.objs    |  5 ++-
>  hw/Makefile.objs         |  2 ++
>  hw/display/Makefile.objs | 28 ++++++++++-------
>  hw/usb/Makefile.objs     | 13 +++++---
>  15 files changed, 155 insertions(+), 24 deletions(-)
> 

This is making Travis-CI fail:

https://travis-ci.org/github/philmd/qemu/jobs/706941688

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=s390x-softmmu/qemu-system-s390x
QTEST_QEMU_IMG=qemu-img tests/qtest/device-introspect-test -m=quick -k
--tap < /dev/null | ./scripts/tap-driver.pl
--test-name="device-introspect-test"
Failed to open module:
/home/travis/build/philmd/qemu/build/s390x-softmmu/../hw-display-qxl.so:
undefined symbol: vga_ioport_read
Failed to open module:
/home/travis/build/philmd/qemu/build/s390x-softmmu/../hw-display-virtio-gpu.so:
undefined symbol: pci_std_vga_mmio_region_init
PASS 1 device-introspect-test /s390x/device/introspect/list
Failed to open module:
/home/travis/build/philmd/qemu/build/s390x-softmmu/../hw-display-qxl.so:
undefined symbol: vga_ioport_read
Failed to open module:
/home/travis/build/philmd/qemu/build/s390x-softmmu/../hw-display-virtio-gpu.so:
undefined symbol: pci_std_vga_mmio_region_init
PASS 2 device-introspect-test /s390x/device/introspect/list-fields
PASS 3 device-introspect-test /s390x/device/introspect/none
PASS 4 device-introspect-test /s390x/device/introspect/abstract
Failed to open module:
/home/travis/build/philmd/qemu/build/s390x-softmmu/../hw-display-qxl.so:
undefined symbol: vga_ioport_read
Failed to open module:
/home/travis/build/philmd/qemu/build/s390x-softmmu/../hw-display-virtio-gpu.so:
undefined symbol: pci_std_vga_mmio_region_init
PASS 5 device-introspect-test /s390x/device/introspect/abstract-interfaces
Failed to open module:
/home/travis/build/philmd/qemu/build/s390x-softmmu/../hw-display-qxl.so:
undefined symbol: vga_ioport_read
Failed to open module:
/home/travis/build/philmd/qemu/build/s390x-softmmu/../hw-display-virtio-gpu.so:
undefined symbol: pci_std_vga_mmio_region_init
missing object type 'virtio-gpu-device'
Broken pipe
/home/travis/build/philmd/qemu/tests/qtest/libqtest.c:175: kill_qemu()
detected QEMU death from signal 6 (Aborted) (core dumped)
Aborted (core dumped)
ERROR - too few tests run (expected 6, got 5)
/home/travis/build/philmd/qemu/tests/Makefile.include:648: recipe for
target 'check-qtest-s390x' failed
make: *** [check-qtest-s390x] Error 1



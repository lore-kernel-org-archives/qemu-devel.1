Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D6CC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DAA20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YD0maEE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DAA20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkLd-0000cC-Eo
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izkKb-0007BD-Fw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izkKZ-0005kb-WF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:48:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izkKZ-0005hw-Nx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581007723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRKZxQWihF2X175wvO0Nl0XhJDux6OoYVe3DIPIrFGE=;
 b=YD0maEE7VauD1WakIfP6FtlrDgZU2YgvOIfE/9+89n7kXVsY6DZhtRfE9vb3KzJbKcF5I6
 wbWtBsYdAXPkIkT3RzJBJ7tQrfrYDcZglM2UC3NRxleSljdCuLtqNw1HKWFG8IhbqrGFh7
 k73+67wYpKpUSIZMDJQctC6F4h90e0A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-s11usECSN9-VmFaDjU42dQ-1; Thu, 06 Feb 2020 11:48:40 -0500
Received: by mail-wr1-f72.google.com with SMTP id s13so3747128wrb.21
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 08:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h71KXt8ncdVnXZtJi10mW6py/Vn7daUYhvP48+54hXc=;
 b=ZPMUinVX1j9mpx86Ev1Ez50hOuwYaIy8BCFX07YA+u1Q3ESPTXqok/Et4sI9SjXwBF
 7mW4jTQDJ6CY2aRYKptfdtGmg1tu/aXBJ2Nv67Xc+M++5WkFWgHw6uBhqii+oQhAcEgJ
 EGOn3TI67WniRbP/EzPKWqqtoBtZzTa2miW8FrslZFff1oAZoVR6j3nhfMKPjliDEbS5
 u1drGwwpFpPT/nYZSEg/enHcTY2YUTKcqc17rOyYGkWSS3CAuIaVXwkAUjFRlJFjoWaQ
 k3rAgnT55BB0FjS0SNjhjXB02E2KcQwa/vEizh3GGa/veq5DdwL1RxZIsFEciAk2fEKU
 E+EA==
X-Gm-Message-State: APjAAAX/vUtuqVpVgD5wZre01J0rhoQDWyKzIyAv15k+go/Bq1NrClZO
 sbvdlxMqAgjCsUvdBihYPGsgTYslBBGycfnkg5+sOGqEeUO7kQp4Iv7pmtNDZYmAzk3DU4IMY7l
 sIkqOE6DzXeHy46s=
X-Received: by 2002:adf:8b54:: with SMTP id v20mr4926936wra.390.1581007719830; 
 Thu, 06 Feb 2020 08:48:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyFQJcG1ky94iCAfcQTsaEJQjX9IlhgXGV8w6vLzy/sHf8PnM8+wszl7yLTgoOvyqa159JVg==
X-Received: by 2002:adf:8b54:: with SMTP id v20mr4926903wra.390.1581007719498; 
 Thu, 06 Feb 2020 08:48:39 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s8sm64879wmf.45.2020.02.06.08.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 08:48:39 -0800 (PST)
Subject: Re: [PATCH v2 00/29] tests/acceptance/virtio_seg_max_adjust: Restrict
 it to Linux/X86
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4bbe9ff8-e1a8-917d-5a57-ce5185da19fa@redhat.com>
Date: Thu, 6 Feb 2020 17:48:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: s11usECSN9-VmFaDjU42dQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 10:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Currently our CI is mostly restricted to Linux/X86.
> We want to have more, but until there we have to run these tests
> manually, which is why we didn't noticed earlier this test was
> failing on OSX.
>=20
> This series contains the patches I used to debug why the
> virtio_seg_max_adjust had broken the OSX CI, but then I
> kept testing on other archs, thus added more patches...
>=20
> Currently our CI is mostly restricted to Linux/X86.
> We want to have more, but until there we have to run these tests
> manually, which is why we didn't noticed earlier some tests are
> failing (on OSX, using --without-default-devices, ...).
>=20
> Tested on Linux/FreeBSD/OSX, X86/Aarch64.
>=20
> Regards,
>=20
> Phil.
>=20
> Supersedes: <20200122223247.30419-1-philmd@redhat.com>
> "tests/acceptance/virtio_seg_max_adjust: Restrict it to Linux/X86"
>=20
> Denis Plotnikov (1):
>    tests: rename virtio_seg_max_adjust to virtio_check_params
>=20
> Philippe Mathieu-Daud=C3=A9 (28):
>    hw/core: Allow setting 'virtio-blk-device.scsi' property on OSX host
>    accel/accel: Make TYPE_ACCEL abstract
>    python/qemu: Add binutils::binary_get_version()
>    tests/acceptance: Use 'version-min' tag to verify QEMU binary version
>    tests/acceptance: Restrict X86CPUModelAliases test to QEMU >=3D 4.1
>    python/qemu: Add binutils::binary_get_arch()
>    tests/acceptance: Use the 'arch' tag to verify QEMU binary target
>    python/qemu: Add binutils::binary_get_machines()
>    tests/acceptance: Use 'machine' tag to check if available in QEMU
>      binary
>    python/qemu: Add binutils::binary_get_qom_implementations()
>    python/qemu: Add binutils::binary_get_accels()
>    python/qemu/accel: Use binutils::binary_get_accels()
>    python/qemu: Add binutils::binary_get_devices()
>    tests/acceptance: Use 'device' tags to check availability in QEMU
>      binary
>    tests/acceptance/virtio_check_params: Only remove listed machines
>    tests/acceptance/virtio_check_params: Improve exception logging
>    tests/acceptance/virtio_check_params: List machine being tested
>    tests/acceptance/virtio_check_params: Only test Xen as superuser
>    tests/acceptance/virtio_check_params: Skip test if arch is not
>      supported
>    tests/acceptance/virtio_check_params: Kludge to skip tests on MIPS
>    tests/acceptance/virtio_check_params: Support the s390x architecture
>    tests/acceptance/virtio_check_params: Support the ppc architecture
>    tests/acceptance/virtio_check_params: Default to -nodefaults
>    tests/acceptance/virtio_check_params: Require a virtio-scsi-pci device
>    tests/acceptance/boot_linux_console: Do not use VGA on Clipper machine
>    tests/acceptance/migration: Default to -nodefaults
>    tests/acceptance/version: Default to -nodefaults
>    MAINTAINERS: Add Acceptance tests reviewers

I have applied the following patches on my python-next tree [*]:
15/29 tests: rename virtio_seg_max_adjust to virtio_check_params
17/29 tests/acceptance/virtio_check_params: Improve exception logging
18/29 tests/acceptance/virtio_check_params: List machine being tested
24/29 tests/acceptance/virtio_check_params: Default to -nodefaults
26/29 tests/acceptance/boot_linux_console: Do not use VGA on Clipper machin=
e
27/29 tests/acceptance/migration: Default to -nodefaults
28/29 tests/acceptance/version: Default to -nodefaults

I plan to disable the virtio_check_params.py test for now, because it=20
broke the CI and the Virtuozzo folks didn't reply to this series=20
intending to fix it. We will restore it once it later.

[*] https://gitlab.com/philmd/qemu/commits/python-next



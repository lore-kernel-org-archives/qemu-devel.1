Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5699AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181E020658
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSHCeEhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181E020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQ2N-0002HB-7s
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGQ1c-0001R2-5L
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGQ1a-0001WP-Hy
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:34:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26783)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGQ1a-0001WC-EM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584981241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K2HFL/LAearWFT+UIOAnbAKhnvPCwB7nQ9wuU226caM=;
 b=YSHCeEhS78MU+jnI7+PCqJThji2lSCHzkHk19Ul60Om8F04kdj3vpgERFFYclwsGvL/hgO
 qhUxS+EzNGYRLSVDkrTtv55tTXutrNshH1NpzOzAJ0Cz/BVKuyJaNCgL8mQVKGGQwBTt4p
 NPBciSSI2E5c9NV2y2+3mYM7L7tg6O8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-SDX61lpGPh2NQO4t4nNDQQ-1; Mon, 23 Mar 2020 12:33:56 -0400
X-MC-Unique: SDX61lpGPh2NQO4t4nNDQQ-1
Received: by mail-wm1-f69.google.com with SMTP id g9so203865wmh.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P7OP4Cll5K5pf+M41Hm+cDHCK/8KBzWRtKdwP3rsVxQ=;
 b=YIbA6We2us+JsgqW7NUaoaCdwt1OX1kK0bYxybp396FrD8Tcmz9BpNEWfUmMq6Ffz9
 Q8dYi7z1YbUaahTNRMsR5/SWMh/whnzuT9xJe3+0YcJPq0Y/HiI4N7Szqijq2CFcF77U
 qTLxdcP0frW1nvgGHh4hh66ZmUZsOpsnqn94QIl6SVAZkqBnhRt6eSTV78OjZBFRdZLi
 HmKTcaajsTG31CguvDzzDmEBZEGJYAKOZSdaDX6smC79ub5CpqpR8HJ/F2zZeSCN2uKv
 kly2Oy3WbN6K2GX5dHJzxTkgUXScyI6qcZHKwao6M70m9rJw9D19y71S/HJuDbxm/ZhA
 TkLg==
X-Gm-Message-State: ANhLgQ2EnwsAVucKzGqz2aQpkE+0vSTkzBiiuvRCthMF+0A4CFtKo7Wo
 uAgp2YwG625a3Uz1XXwdce5MKHQfBm9HVwl2x6AWo/IUSGOp38CBOwLzNC0DbDEcBBaNdHeWW2i
 CBLpPW+baUt2ysAQ=
X-Received: by 2002:a1c:23c8:: with SMTP id j191mr64021wmj.117.1584981234894; 
 Mon, 23 Mar 2020 09:33:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvaNO3QGRiiA/WswSJzA2yryDoDNmMN4MP0ZjfsEpHRxWf1/y31rDMPupZzkZQBIecrfBn0Nw==
X-Received: by 2002:a1c:23c8:: with SMTP id j191mr64005wmj.117.1584981234681; 
 Mon, 23 Mar 2020 09:33:54 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id d124sm111783wmd.37.2020.03.23.09.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 09:33:54 -0700 (PDT)
Subject: Re: [PATCH v1 02/11] tests/vm: move vga setup
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad1b15f0-6ac9-27a6-7d85-1757d3fe8f67@redhat.com>
Date: Mon, 23 Mar 2020 17:33:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323161514.23952-3-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 5:15 PM, Alex Benn=C3=A9e wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Move '-device VGA' from basevm.py to the guests, so they have
> the chance to opt out and run without display device.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20200310083218.26355-3-kraxel@redhat.com>

Already reviewed:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg686829.html
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   tests/vm/basevm.py   | 1 -
>   tests/vm/fedora      | 1 +
>   tests/vm/freebsd     | 1 +
>   tests/vm/netbsd      | 1 +
>   tests/vm/openbsd     | 1 +
>   tests/vm/ubuntu.i386 | 5 ++++-
>   6 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index c53fd354d95..cffe7c4600e 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -179,7 +179,6 @@ class BaseVM(object):
>  =20
>       def boot(self, img, extra_args=3D[]):
>           args =3D self._args + [
> -            "-device", "VGA",
>               "-drive", "file=3D%s,if=3Dnone,id=3Ddrive0,cache=3Dwritebac=
k" % img,
>               "-device", "virtio-blk,drive=3Ddrive0,bootindex=3D0"]
>           args +=3D self._data_args + extra_args
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> index 4843b4175e0..bd9c6cf295c 100755
> --- a/tests/vm/fedora
> +++ b/tests/vm/fedora
> @@ -82,6 +82,7 @@ class FedoraVM(basevm.BaseVM):
>           self.boot(img_tmp, extra_args =3D [
>               "-bios", "pc-bios/bios-256k.bin",
>               "-machine", "graphics=3Doff",
> +            "-device", "VGA",
>               "-cdrom", iso
>           ])
>           self.console_init(300)
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 86770878b67..58166766d91 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -92,6 +92,7 @@ class FreeBSDVM(basevm.BaseVM):
>           self.boot(img_tmp, extra_args =3D [
>               "-bios", "pc-bios/bios-256k.bin",
>               "-machine", "graphics=3Doff",
> +            "-device", "VGA",
>               "-cdrom", iso
>           ])
>           self.console_init()
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 55590f46015..f3257bc245a 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -86,6 +86,7 @@ class NetBSDVM(basevm.BaseVM):
>           self.boot(img_tmp, extra_args =3D [
>               "-bios", "pc-bios/bios-256k.bin",
>               "-machine", "graphics=3Doff",
> +            "-device", "VGA",
>               "-cdrom", iso
>           ])
>           self.console_init()
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index ab6abbedab5..0b705f49452 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -82,6 +82,7 @@ class OpenBSDVM(basevm.BaseVM):
>           self.boot(img_tmp, extra_args =3D [
>               "-bios", "pc-bios/bios-256k.bin",
>               "-machine", "graphics=3Doff",
> +            "-device", "VGA",
>               "-cdrom", iso
>           ])
>           self.console_init()
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 3266038fbde..15707753353 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -36,7 +36,10 @@ class UbuntuX86VM(basevm.BaseVM):
>           img_tmp =3D img + ".tmp"
>           subprocess.check_call(["cp", "-f", cimg, img_tmp])
>           self.exec_qemu_img("resize", img_tmp, "50G")
> -        self.boot(img_tmp, extra_args =3D ["-cdrom", self.gen_cloud_init=
_iso()])
> +        self.boot(img_tmp, extra_args =3D [
> +            "-device", "VGA",
> +            "-cdrom", self.gen_cloud_init_iso()
> +        ])
>           self.wait_ssh()
>           self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
>           self.ssh_root_check("apt-get update")
>=20



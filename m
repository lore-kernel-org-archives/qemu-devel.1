Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4608C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC55214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g36Y9HVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC55214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJYv-0000Sw-R8
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixJXU-00088g-Ss
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixJXT-0004Ho-NI
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:48:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25402
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixJXT-0004FS-JA
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580428079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tngp9GPrOTBwPQ6Bzph7QX4dsHxKhUf223UHgXjuq5k=;
 b=g36Y9HVXAXcQZ1WZ85U0Stl4LJdNgTTRdrV7nicm3Qtt8VDKuGo9o/YhLDPITHX0X/Mqbp
 nXV82zXzRIZctW2YGpmi0xb9/LHblRv2wYus+NBT8Syrf3U36mTkAwL9TvJfkTVCkcLwPd
 F0OhcCyv12xj5aTzb5eeTFy+OLfZUhU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-UsG0g7VjOzqOIzRXyQ3CXQ-1; Thu, 30 Jan 2020 18:47:57 -0500
Received: by mail-wr1-f69.google.com with SMTP id z14so2469316wrs.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 15:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BqDe7Cj8FT35afwZ7Z18l1nXaF9b4b2GM42iw9a3gLY=;
 b=PY+YfSULil5lnfH/fiHbrzbpoH/aXVoYXd8ZgvPKiJimPSxkbQfNd810vFeAzHAyby
 HauosGc0NKq3I4ZCPFnPl7ULJdotKaXOBV8ZaoizUPct7C+3qmSlCzE3nsI7psxR4eZJ
 hNG8qcBXpzqorwSMwUn5cSBnfLyuO1MPW7N9s0C83uL9Id++lcHj4pZp5LAwTLiiDWH6
 wuS9FEi1XQnQ7ojiMkNUSaR3mf5LEm1SU+BnrkZfXmUbKVyOxOXEmTAI0x0g/V+c8oIA
 5lP3fGpA8HLCqcSQpdtKFD2w52NdHq0H0Unc/s0az2bhq26FN2q8C/g4HVYvtWJKi7eB
 4YKg==
X-Gm-Message-State: APjAAAV+ydP3apZ3YHzViCrEq94UdisuzK8B9DwNE4OBHIuhH0e1pSWF
 eu9+sVudOJ9mzUjhKIcgh9CFK01d5xwLkPwDkbqda3mSmwElW7w28eSLsBQn2IKYHUniax5oxI2
 WzKFaderB7CIIliM=
X-Received: by 2002:a5d:4285:: with SMTP id k5mr8017124wrq.72.1580428075261;
 Thu, 30 Jan 2020 15:47:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgxpjyuUEBwc3eUqIM0ptp5DlvPeawGxcWdCo6pV92vhECbiOddUA/blxEwAA3nvGtdKjSWg==
X-Received: by 2002:a5d:4285:: with SMTP id k5mr8017097wrq.72.1580428075086;
 Thu, 30 Jan 2020 15:47:55 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id a198sm8022382wme.12.2020.01.30.15.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 15:47:54 -0800 (PST)
Subject: Re: [PATCH v2 07/12] tests/acceptance: Remove shebang header
To: qemu-devel@nongnu.org
References: <20200130163232.10446-1-philmd@redhat.com>
 <20200130163232.10446-8-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <29489dc7-6ec0-afcd-a26f-1f8eeafe7b7a@redhat.com>
Date: Fri, 31 Jan 2020 00:47:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130163232.10446-8-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: UsG0g7VjOzqOIzRXyQ3CXQ-1
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 5:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Patch created mechanically by running:
>=20
>    $ chmod 644 $(git grep -lF '#!/usr/bin/env python' \
>        | xargs grep -L 'if __name__.*__main__')
>    $ sed -i "/^#\!\/usr\/bin\/\(env\ \)\?python.\?$/d" \
>        $(git grep -lF '#!/usr/bin/env python' \
>        | xargs grep -L 'if __name__.*__main__')
>=20
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/virtio_seg_max_adjust.py  | 1 -
>   tests/acceptance/x86_cpu_model_versions.py | 1 -
>   2 files changed, 2 deletions(-)
>   mode change 100755 =3D> 100644 tests/acceptance/virtio_seg_max_adjust.p=
y
>=20
> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance=
/virtio_seg_max_adjust.py
> old mode 100755
> new mode 100644
> index 5458573138..8d4f24da49
> --- a/tests/acceptance/virtio_seg_max_adjust.py
> +++ b/tests/acceptance/virtio_seg_max_adjust.py
> @@ -1,4 +1,3 @@
> -#!/usr/bin/env python
>   #
>   # Test virtio-scsi and virtio-blk queue settings for all machine types
>   #
> diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
> index 90558d9a71..01ff614ec2 100644
> --- a/tests/acceptance/x86_cpu_model_versions.py
> +++ b/tests/acceptance/x86_cpu_model_versions.py
> @@ -1,4 +1,3 @@
> -#!/usr/bin/env python
>   #
>   # Basic validation of x86 versioned CPU models and CPU model aliases
>   #
>=20

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next



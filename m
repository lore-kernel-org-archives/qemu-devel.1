Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A625FC433E8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FD92063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3L5GGqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FD92063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyye4-0001dr-P3
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyydK-00014j-CF
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:25:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33063
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyydI-0003bJ-2g
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595600706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HMgos3rMAozVFWK1T2nVC5fiTgRC57wF931n+nyCEK4=;
 b=d3L5GGqn5DitLApWh0UeWkZ1YesF5edPAeAsL++oUaq4+LrU50i4LriFOrIRXcwbFiOyKf
 mB6AQb8g8jCiD+7Yd/iys3dXu0aaknNy7J0u94gCWyNv94z2nEkbe7lb54Uneh4vX07Nae
 rczmxUVCVSpaRv6Fbs9FPaLztnYk3RY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-2__FVYa-OS6cIl1-Q_AX9A-1; Fri, 24 Jul 2020 10:25:02 -0400
X-MC-Unique: 2__FVYa-OS6cIl1-Q_AX9A-1
Received: by mail-wr1-f69.google.com with SMTP id d6so646468wrv.23
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 07:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HMgos3rMAozVFWK1T2nVC5fiTgRC57wF931n+nyCEK4=;
 b=FOrADWLRfXvJf+eB3Bq6CSC4EVyOi8qpv4pWg3XtelZ6fvY1x2UwncyrQcx4TX0Z39
 uGaHjiKwncjxYt6EPSv3Yc4cTuwmunkjmlTjdRFs20PoSNbvPMT8ovgbLqEFrU24Plw6
 igILo7s27JhhN2NWWx2nF0Fjd/SRYF266jC1hSNYILSPVFfIPF/XXzHtlX7EKaeriLtG
 0QgrQGiya1FbUvBkpCTvgR7/q1ZFCaMyDpFWN6ti0D6icaJ/RztKFmVB6vneusy5dJ0h
 ZuQ1oLbADGEZhb+w2y4Hk/JngNFBqAvlWp7GncYSXsJfTcVruxYAnND4Zy93R4B0+NZI
 Pwcg==
X-Gm-Message-State: AOAM533bs55W6J3Zes/qkwU+telsx92JEhz0GJZBJ+NkauBO6mmc9mPV
 HsY26Lust2izj5TWf/FIwpSpYwkVOTqtNRhGapN1Z6BNMOiXIn/0vGodeEK34ogr64QxX38Rup2
 9nTD8l1lrFCaCFsE=
X-Received: by 2002:a1c:345:: with SMTP id 66mr8718801wmd.31.1595600701513;
 Fri, 24 Jul 2020 07:25:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwI7opJ4ZhK6chB3GGEroTB0pG9rHr7WucqKMjSsB3jHcUK+ukLq3ZyuyWRz/ZhFExdLV53qQ==
X-Received: by 2002:a1c:345:: with SMTP id 66mr8718784wmd.31.1595600701318;
 Fri, 24 Jul 2020 07:25:01 -0700 (PDT)
Received: from [192.168.1.33] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id x82sm2210076wmb.30.2020.07.24.07.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 07:25:00 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] util: rename qemu_open() to qemu_open_old()
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200724132510.3250311-1-berrange@redhat.com>
 <20200724132510.3250311-2-berrange@redhat.com>
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
Message-ID: <ead14a79-8ffc-8177-a1d7-e0487723e574@redhat.com>
Date: Fri, 24 Jul 2020 16:24:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200724132510.3250311-2-berrange@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 3:25 PM, Daniel P. Berrangé wrote:
> We want to introduce a new version of qemu_open() that uses an Error
> object for reporting problems and make this it the preferred interface.
> Rename the existing method to release the namespace for the new impl.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  accel/kvm/kvm-all.c            |  2 +-
>  backends/rng-random.c          |  2 +-
>  backends/tpm/tpm_passthrough.c |  8 ++++----
>  block/file-posix.c             | 14 +++++++-------
>  block/file-win32.c             |  5 +++--
>  block/vvfat.c                  |  5 +++--
>  chardev/char-fd.c              |  2 +-
>  chardev/char-pipe.c            |  6 +++---
>  chardev/char.c                 |  2 +-
>  dump/dump.c                    |  2 +-
>  hw/s390x/s390-skeys.c          |  2 +-
>  hw/usb/host-libusb.c           |  2 +-
>  hw/vfio/common.c               |  4 ++--
>  include/qemu/osdep.h           |  2 +-
>  io/channel-file.c              |  2 +-
>  net/vhost-vdpa.c               |  2 +-
>  os-posix.c                     |  2 +-
>  qga/channel-posix.c            |  4 ++--
>  qga/commands-posix.c           |  6 +++---
>  target/arm/kvm.c               |  2 +-
>  ui/console.c                   |  2 +-
>  util/osdep.c                   |  2 +-
>  util/oslib-posix.c             |  2 +-
>  23 files changed, 42 insertions(+), 40 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>



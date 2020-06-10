Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848A1C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C932074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqvPP9bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C932074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj772-0001jn-LE
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj76O-00011j-3x
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:13:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49405
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj76N-0002YV-3R
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591820013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NHftCHQpW1KYwbKUZAnBWUcM8dR+pRrfGJRJcMtvgWA=;
 b=fqvPP9bCATF55lyEGZzsRhoS5k6rPIfn+uNESHuwqj+QDv+n47799sHwHMZ6vBloXKU6Zt
 fFTCjczXmlETGze6BpMbBgnYKaCt0qs9JmDwSKZz/3e8hvQioGIA1zB5x4R2OJqYvRih6G
 PItwmOOX5DuF1nZc3ShJmfqTvustkIg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-aO11lCQ4PW6Q2wc1WlRI-w-1; Wed, 10 Jun 2020 16:13:29 -0400
X-MC-Unique: aO11lCQ4PW6Q2wc1WlRI-w-1
Received: by mail-wr1-f72.google.com with SMTP id x15so172869wru.21
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NHftCHQpW1KYwbKUZAnBWUcM8dR+pRrfGJRJcMtvgWA=;
 b=PAT9y7QPLObEa7DTI5KRMTCLmWl9MsQu3HvbsgWZfjghUfHDC6uL/v5rgqOd2CFIJe
 mLSs1tFziuHRthofDG26Xy01Xzcuu5MPPVtDUemSuBnKJiwC8MWZxsEj51hAbHlUl7RS
 4J4ujFFj9Ki7Jgl4IuqO6La2BbHozyBKIVBGEMQizMxJNR2U1U9GAAUM7gpvCPcyHPEz
 /IpRPdGAWSnhBIFH3z2BQc7/6Aa43rhktdKoP6QYr3l8K4RqXKV82O4dC73aEPNzv0Aw
 NZnjqTcQr5gCWu8O0uLXi0UO3rAJta2dxwP89wuGmvLPDT43UmGZXwQ1kznM61zxNn8m
 CUEA==
X-Gm-Message-State: AOAM530e+3h/DtcCWd6dVOTl6glp63GB3vaFQRqjJXL6nKhADsIqJBQg
 U9mptgmSZT7Jmcg4YiJFLAjlU2YILoaU+qavwvjhgxwWUgreXV7fOVNC59YbGDh2njk0FKD8+Kx
 H0Jj+k7+kFmXwZRs=
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr4495758wmc.167.1591820008152; 
 Wed, 10 Jun 2020 13:13:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF146Glt3QFygz0HbnKCMaon1FKaqCRya+soY4WNDVy9MkI8LglL4qf598hWrtHYShQGS0eg==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr4495741wmc.167.1591820007932; 
 Wed, 10 Jun 2020 13:13:27 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o18sm1027699wme.19.2020.06.10.13.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 13:13:27 -0700 (PDT)
Subject: Re: [PATCH 0/8] tpm: Split hw/ vs backends/
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200610200247.21378-1-philmd@redhat.com>
 <CAJ+F1CLwLqTCKbUw_xrVax1zctE3Q68ZbaM_Tydn7ZqELp8vnw@mail.gmail.com>
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
Message-ID: <fbc1d5ea-4097-81b4-3e09-1820d112d78d@redhat.com>
Date: Wed, 10 Jun 2020 22:13:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLwLqTCKbUw_xrVax1zctE3Q68ZbaM_Tydn7ZqELp8vnw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 10:09 PM, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jun 11, 2020 at 12:03 AM Philippe Mathieu-Daudé
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> 
>     Hi,
> 
>     Today I started to review some vTPM patches and got very
>     confused by the files under hw/tpm/. In particular after
>     running:
> 
>       $ git grep TYPE_TPM_BACKEND
>       backends/tpm.c:188:    .name = TYPE_TPM_BACKEND,
>       hw/tpm/tpm_emulator.c:985:    .parent = TYPE_TPM_BACKEND,
>       hw/tpm/tpm_passthrough.c:393:    .parent = TYPE_TPM_BACKEND,
>       include/sysemu/tpm_backend.h:21:#define TYPE_TPM_BACKEND "tpm-backend"
> 
>     As there is no particular reason to keep this mixed, clean it up.
> 
> 
> While at it, why not start to organize backends/ ?  I would move that
> under backends/tpm/

Sure, if the overall of this series looks good, I can do that.
I'll wait for positive/negative feedback first.

> 
> 
>     Philippe Mathieu-Daudé (8):
>       hw/tpm: Do not include 'qemu/osdep.h' in header
>       hw/tpm: Include missing 'qemu/option.h' header
>       hw/tpm: Move 'hw/acpi/tpm.h' inclusion from header to sources
>       hw/tpm: Remove unnecessary 'tpm_int.h' header inclusion
>       hw/tpm: Move few declarations from 'tpm_util.h' to 'tpm_int.h'
>       hw/tpm: Move DEFINE_PROP_TPMBE() macro to 'tmp_prop.h' local header
>       hw/tpm: Make 'tpm_util.h' publicly accessible as "sysemu/tpm_util.h"
>       tpm: Move backend code under the 'backends/' directory
> 
>      Makefile                               |  2 +-
>      {hw/tpm => backends}/tpm_int.h         | 19 +++++++++++---
>      {hw/tpm => backends}/tpm_ioctl.h       |  0
>      hw/tpm/tpm_ppi.h                       |  1 -
>      hw/tpm/tpm_prop.h                      | 31 +++++++++++++++++++++++
>      hw/tpm/tpm_tis.h                       |  1 -
>      {hw/tpm => include/sysemu}/tpm_util.h  | 19 +++-----------
>      {hw/tpm => backends}/tpm_emulator.c    |  2 +-
>      {hw/tpm => backends}/tpm_passthrough.c |  2 +-
>      {hw/tpm => backends}/tpm_util.c        |  2 +-
>      hw/tpm/tpm_crb.c                       |  4 +--
>      hw/tpm/tpm_spapr.c                     |  4 +--
>      hw/tpm/tpm_tis_common.c                |  4 +--
>      hw/tpm/tpm_tis_isa.c                   |  3 ++-
>      hw/tpm/tpm_tis_sysbus.c                |  3 ++-
>      tests/qtest/tpm-emu.c                  |  2 +-
>      MAINTAINERS                            |  2 +-
>      backends/Kconfig                       | 14 +++++++++++
>      backends/Makefile.objs                 |  3 +++
>      backends/trace-events                  | 32 ++++++++++++++++++++++++
>      hw/tpm/Kconfig                         | 15 ------------
>      hw/tpm/Makefile.objs                   |  3 ---
>      hw/tpm/trace-events                    | 34 +-------------------------
>      23 files changed, 116 insertions(+), 86 deletions(-)
>      rename {hw/tpm => backends}/tpm_int.h (81%)
>      rename {hw/tpm => backends}/tpm_ioctl.h (100%)
>      create mode 100644 hw/tpm/tpm_prop.h
>      rename {hw/tpm => include/sysemu}/tpm_util.h (80%)
>      rename {hw/tpm => backends}/tpm_emulator.c (99%)
>      rename {hw/tpm => backends}/tpm_passthrough.c (99%)
>      rename {hw/tpm => backends}/tpm_util.c (99%)
>      create mode 100644 backends/Kconfig
> 
>     -- 
>     2.21.3
> 
> 
> 
> 
> -- 
> Marc-André Lureau



Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530BEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166A2206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgVM81lg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166A2206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj76M-0000rE-B9
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj752-0007kI-3i
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:12:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33599
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj751-0002SU-2k
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u7chI+EPwHFwo1xT6IV5QMeTISXGaNBDxXBxaXdBqBo=;
 b=RgVM81lg3LrkZqm2O+Dr0ESzbYxK2jjdclxvsPgBiSJudvRVNwQQerxQyyYnM4O9YpKD5e
 d4Mr2P7glStCpNXu3TmhUb+OfVGVQGr2EVfKm+KC98697q/YYoOmP6VbZ27Gtc1nlsGaLf
 o2jC7uwDhSlncEv5tEwPnUlC/94bgAc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-5UO4pLEZNbq-Se0qkXYAxQ-1; Wed, 10 Jun 2020 16:12:09 -0400
X-MC-Unique: 5UO4pLEZNbq-Se0qkXYAxQ-1
Received: by mail-wm1-f69.google.com with SMTP id u15so607202wmm.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=u7chI+EPwHFwo1xT6IV5QMeTISXGaNBDxXBxaXdBqBo=;
 b=iDwoDHZLjjo9i+A1Jkfq9EXiGb+lKhZUlvZv4iEXLw6U0SVJ1wb0Us2CpydCukSyvz
 gy7jLJX8Ggsnlu1EDV7KH+r9yVgxiWTNrxUoS0kYNCL53HWYAG9JGzdeBlCIFIbxeky3
 OZwaYbno/bJuhIlQS6619HTEubPrn6KwYcz3adJryVc1BQZ/YaJGeevCEECXKDjx/CuC
 rL+6WjWdxjyeb6+nuXZS4HOx9IXBFB/WXDJQ0wLYehzrMIkwEWoNxOmcGCpm+a0uFAPm
 B9rTIvrzjxblo90CupRLoIOYe01aY5arkQMOJky7vX05+b9OKKQlkA6tAxGqEYpCRwGp
 ye3g==
X-Gm-Message-State: AOAM5336O/AKMzpVMn75Krl7ukugaT2PwwTXVyTlW22hZgrXw9XScvId
 6cgTs9+o6r7SI1WyV1UBDc6Ew37H4+tlw80f/YrhtvrpGRHjytjzKXeehwgJ1NzRWtkezG717ab
 up1jvwuiM3dbqQsw=
X-Received: by 2002:a1c:59c7:: with SMTP id n190mr4518235wmb.61.1591819927776; 
 Wed, 10 Jun 2020 13:12:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHJtTBbpmjTEZNlNKWGsjqrz40GVFjaUqtkTtkcQHpU//DA26LNujbdBu9pdBD5KBFsDcX4Q==
X-Received: by 2002:a1c:59c7:: with SMTP id n190mr4518220wmb.61.1591819927492; 
 Wed, 10 Jun 2020 13:12:07 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id p16sm1336290wru.27.2020.06.10.13.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 13:12:06 -0700 (PDT)
Subject: Re: [PATCH 0/8] tpm: Split hw/ vs backends/
To: qemu-devel@nongnu.org
References: <20200610200247.21378-1-philmd@redhat.com>
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
Message-ID: <c7f3fb51-6bb0-6ad2-0ae9-e54ad8174d1d@redhat.com>
Date: Wed, 10 Jun 2020 22:12:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200610200247.21378-1-philmd@redhat.com>
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 10:02 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Today I started to review some vTPM patches and got very
> confused by the files under hw/tpm/. In particular after
> running:
> 
>   $ git grep TYPE_TPM_BACKEND
>   backends/tpm.c:188:    .name = TYPE_TPM_BACKEND,
>   hw/tpm/tpm_emulator.c:985:    .parent = TYPE_TPM_BACKEND,
>   hw/tpm/tpm_passthrough.c:393:    .parent = TYPE_TPM_BACKEND,
>   include/sysemu/tpm_backend.h:21:#define TYPE_TPM_BACKEND "tpm-backend"
> 
> As there is no particular reason to keep this mixed, clean it up.
> 
> Philippe Mathieu-Daudé (8):
>   hw/tpm: Do not include 'qemu/osdep.h' in header
>   hw/tpm: Include missing 'qemu/option.h' header
>   hw/tpm: Move 'hw/acpi/tpm.h' inclusion from header to sources
>   hw/tpm: Remove unnecessary 'tpm_int.h' header inclusion
>   hw/tpm: Move few declarations from 'tpm_util.h' to 'tpm_int.h'
>   hw/tpm: Move DEFINE_PROP_TPMBE() macro to 'tmp_prop.h' local header
>   hw/tpm: Make 'tpm_util.h' publicly accessible as "sysemu/tpm_util.h"
>   tpm: Move backend code under the 'backends/' directory
> 
>  Makefile                               |  2 +-
>  {hw/tpm => backends}/tpm_int.h         | 19 +++++++++++---
>  {hw/tpm => backends}/tpm_ioctl.h       |  0
>  hw/tpm/tpm_ppi.h                       |  1 -
>  hw/tpm/tpm_prop.h                      | 31 +++++++++++++++++++++++
>  hw/tpm/tpm_tis.h                       |  1 -
>  {hw/tpm => include/sysemu}/tpm_util.h  | 19 +++-----------
>  {hw/tpm => backends}/tpm_emulator.c    |  2 +-
>  {hw/tpm => backends}/tpm_passthrough.c |  2 +-
>  {hw/tpm => backends}/tpm_util.c        |  2 +-
>  hw/tpm/tpm_crb.c                       |  4 +--
>  hw/tpm/tpm_spapr.c                     |  4 +--
>  hw/tpm/tpm_tis_common.c                |  4 +--
>  hw/tpm/tpm_tis_isa.c                   |  3 ++-
>  hw/tpm/tpm_tis_sysbus.c                |  3 ++-
>  tests/qtest/tpm-emu.c                  |  2 +-
>  MAINTAINERS                            |  2 +-
>  backends/Kconfig                       | 14 +++++++++++
>  backends/Makefile.objs                 |  3 +++
>  backends/trace-events                  | 32 ++++++++++++++++++++++++
>  hw/tpm/Kconfig                         | 15 ------------
>  hw/tpm/Makefile.objs                   |  3 ---
>  hw/tpm/trace-events                    | 34 +-------------------------
>  23 files changed, 116 insertions(+), 86 deletions(-)
>  rename {hw/tpm => backends}/tpm_int.h (81%)
>  rename {hw/tpm => backends}/tpm_ioctl.h (100%)
>  create mode 100644 hw/tpm/tpm_prop.h
>  rename {hw/tpm => include/sysemu}/tpm_util.h (80%)
>  rename {hw/tpm => backends}/tpm_emulator.c (99%)
>  rename {hw/tpm => backends}/tpm_passthrough.c (99%)
>  rename {hw/tpm => backends}/tpm_util.c (99%)
>  create mode 100644 backends/Kconfig

Beh I forgot to commit the docs/ changes...

-- >8 --
diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 5e61238bc5..546109ebf7 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -199,8 +199,8 @@ to be used with the passthrough backend or the swtpm
backend.

 QEMU files related to TPM backends:
  - ``backends/tpm.c``
+ - ``include/sysemu/tpm.h``
  - ``include/sysemu/tpm_backend.h``
- - ``include/sysemu/tpm_backend_int.h``

 The QEMU TPM passthrough device
 -------------------------------
@@ -232,9 +232,9 @@ Integrity Measurement Architecture (IMA), are not
expecting to share
 PCRs.

 QEMU files related to the TPM passthrough device:
- - ``hw/tpm/tpm_passthrough.c``
- - ``hw/tpm/tpm_util.c``
- - ``hw/tpm/tpm_util.h``
+ - ``backends/tpm_passthrough.c``
+ - ``backends/tpm_util.c``
+ - ``include/sysemu/tpm_util.h``


 Command line to start QEMU with the TPM passthrough device using the host's
@@ -292,9 +292,9 @@ instrumented to initialize a TPM 1.2 or TPM 2 device
using this
 command.

 QEMU files related to the TPM emulator device:
- - ``hw/tpm/tpm_emulator.c``
- - ``hw/tpm/tpm_util.c``
- - ``hw/tpm/tpm_util.h``
+ - ``backends/tpm_emulator.c``
+ - ``backends/tpm_util.c``
+ - ``include/sysemu/tpm_util.h``

 The following commands start the swtpm with a UnixIO control channel over
 a socket interface. They do not need to be run as root.

---

I'll wait for some review before respining.



Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7702AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4031D20679
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7/UTLPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4031D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfRZ-0001oi-H4
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnfPG-00067y-V7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:39:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43001
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnfPF-0004d8-1w
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592905192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=devLSGWOsZYzYWfZieWlop+g3AQTWag//5NZrI0WjsI=;
 b=f7/UTLPqlUeAnBCyPvo6A/2DdDPHvICcElQZjL0E/nIBkQddO2pCfaHv4JR6tk5SrSWjRD
 v9SjO4RRQQBbMMWtStLebU3MWVc4cyku19LXvIrrIeumM4qtbwaJgXr7C8AjRyJgx67/zB
 owumWLOYPO+YLGYU1+ahEeLgfhiD4Vk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-vSMY9sFONfCeFAyMEM6axg-1; Tue, 23 Jun 2020 05:39:50 -0400
X-MC-Unique: vSMY9sFONfCeFAyMEM6axg-1
Received: by mail-wm1-f71.google.com with SMTP id v24so3379873wmh.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=devLSGWOsZYzYWfZieWlop+g3AQTWag//5NZrI0WjsI=;
 b=nXYB36Hri0TRYl2aQu62lzbv5cu14HPWIn9sImpt9l3c2YBKnQ0oLcVsKn4DGrZqmc
 l6TscU0QxBxQimOf0KMnnKI+1vYo9Yo8xn9+02FOSTUho0MLEKKxUGS3yNtrVxYgz+5s
 6nF56auQ/eFo9FLtQURoYVftWd9u3t1igsu3o+9Xb/9LlHMCzhMtUto4pozzAC5KwmUD
 tXIe5N8QeG7GoZ/zFB52Vtob/CGbP+kFgGV9U8LKyKVfjobmMR6OeGGYWqrGWoo25mRj
 AJKqYT8pWS+Y2A5RszppPqYm2souBu/afCNFiAUupw0AV9MqT39v9QH5E/VpkdJJYnbd
 3/BA==
X-Gm-Message-State: AOAM53220vmk26WlleOWbtBENBL3Iqmifnhmq3v99xIkm39KBZ2ixqys
 GiDAWbWwxfnPm58QYtY64REhOeEJEM/XFpeGbvdmVl1ulbHKvWP27mmJYqjYqO+KTHUVu/lztJR
 uJoYzkEJ+i2q6iTk=
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr21975597wmf.97.1592905189182; 
 Tue, 23 Jun 2020 02:39:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcz8IPvvE0DqJQZ4OE0m1m8U6YasMoSoOm1DLWdWRUDI1C47D866oDSaqIgIyg5+cz7tXymQ==
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr21975584wmf.97.1592905188956; 
 Tue, 23 Jun 2020 02:39:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fd64:dd90:5ad5:d2e1?
 ([2001:b07:6468:f312:fd64:dd90:5ad5:d2e1])
 by smtp.gmail.com with ESMTPSA id c65sm2910949wme.8.2020.06.23.02.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 02:39:48 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] tpm: Split hw/ vs backends/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200612085444.8362-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <03924193-9774-9f85-2008-05c047fe91cf@redhat.com>
Date: Tue, 23 Jun 2020 11:39:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200612085444.8362-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/06/20 10:54, Philippe Mathieu-Daudé wrote:
> Missing review: last patch
> - #12 "tpm: Move backend code under the 'backends/' directory"
> 
> Hi,
> 
> Yesterday I started to review some vTPM patches and got very
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
> Since v2:
> - Resolved the FIXME in tpm_tis_common.c by making the
>   TRACE_TPM_UTIL_SHOW_BUFFER check locally to tpm_util.c
> 
> Since v1:
> - Amended docs/ changes
> - Renamed Kconfig TPM_BACKEND variable
> - Move backend files under backends/tpm/ (Marc-André & Stefan)
> - Fix x86-64 build error (patchew)
> 
> Philippe Mathieu-Daudé (12):
>   docs/specs/tpm: Correct header path name
>   backends: Add TPM files into their own directory
>   hw/tpm: Rename TPMDEV as TPM_BACKEND in Kconfig
>   hw/tpm: Do not include 'qemu/osdep.h' in header
>   hw/tpm: Include missing 'qemu/option.h' header
>   hw/tpm: Move 'hw/acpi/tpm.h' inclusion from header to sources
>   hw/tpm: Remove unnecessary 'tpm_int.h' header inclusion
>   hw/tpm: Make TRACE_TPM_UTIL_SHOW_BUFFER check local to tpm_util.c
>   hw/tpm: Move few declarations from 'tpm_util.h' to 'tpm_int.h'
>   hw/tpm: Move DEFINE_PROP_TPMBE() macro to 'tmp_prop.h' local header
>   hw/tpm: Make 'tpm_util.h' publicly accessible as "sysemu/tpm_util.h"
>   tpm: Move backend code under the 'backends/' directory
> 
>  docs/specs/tpm.rst                     | 14 +++++------
>  Makefile                               |  2 +-
>  Makefile.objs                          |  1 +
>  {hw => backends}/tpm/tpm_int.h         | 19 +++++++++++---
>  {hw => backends}/tpm/tpm_ioctl.h       |  0
>  hw/tpm/tpm_ppi.h                       |  1 -
>  hw/tpm/tpm_prop.h                      | 31 +++++++++++++++++++++++
>  hw/tpm/tpm_tis.h                       |  1 -
>  {hw/tpm => include/sysemu}/tpm_util.h  | 19 +++-----------
>  backends/{tpm.c => tpm/tpm_backend.c}  |  0
>  {hw => backends}/tpm/tpm_emulator.c    |  2 +-
>  {hw => backends}/tpm/tpm_passthrough.c |  2 +-
>  {hw => backends}/tpm/tpm_util.c        |  5 +++-
>  hw/tpm/tpm_crb.c                       |  4 +--
>  hw/tpm/tpm_ppi.c                       |  1 +
>  hw/tpm/tpm_spapr.c                     |  4 +--
>  hw/tpm/tpm_tis_common.c                | 11 +++------
>  hw/tpm/tpm_tis_isa.c                   |  3 ++-
>  hw/tpm/tpm_tis_sysbus.c                |  3 ++-
>  tests/qtest/tpm-emu.c                  |  2 +-
>  MAINTAINERS                            |  2 +-
>  backends/Kconfig                       |  1 +
>  backends/Makefile.objs                 |  2 +-
>  backends/tpm/Kconfig                   | 14 +++++++++++
>  backends/tpm/Makefile.objs             |  4 +++
>  backends/tpm/trace-events              | 33 +++++++++++++++++++++++++
>  hw/tpm/Kconfig                         | 21 +++-------------
>  hw/tpm/Makefile.objs                   |  3 ---
>  hw/tpm/trace-events                    | 34 +-------------------------
>  29 files changed, 136 insertions(+), 103 deletions(-)
>  rename {hw => backends}/tpm/tpm_int.h (81%)
>  rename {hw => backends}/tpm/tpm_ioctl.h (100%)
>  create mode 100644 hw/tpm/tpm_prop.h
>  rename {hw/tpm => include/sysemu}/tpm_util.h (80%)
>  rename backends/{tpm.c => tpm/tpm_backend.c} (100%)
>  rename {hw => backends}/tpm/tpm_emulator.c (99%)
>  rename {hw => backends}/tpm/tpm_passthrough.c (99%)
>  rename {hw => backends}/tpm/tpm_util.c (98%)
>  create mode 100644 backends/Kconfig
>  create mode 100644 backends/tpm/Kconfig
>  create mode 100644 backends/tpm/Makefile.objs
>  create mode 100644 backends/tpm/trace-events
> 

Queued this one, actually.

Paolo



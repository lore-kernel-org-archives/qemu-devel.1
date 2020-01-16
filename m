Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83023C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0A3246BF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIeAjzmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0A3246BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is8md-0008Hm-Cj
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1is8lb-0007fV-B2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1is8lW-00073O-Jq
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:17:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22110
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1is8lW-00072j-Es
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579195025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJB+bdjusuwgJFTBM5V6hLwv2GyvQ1lKSplcsGc5q2A=;
 b=HIeAjzmEadHVAUArAQKl1LfMLBlnW5hjK+ZoLWvbL0BO+85C13I4n5gLFCA/bMUeMYsAo0
 XROvMzJNKT47OGaQo/DBi+zgoB8pF9LWLJZL8Vl4CG8WcSW8YSQN28G2wyhWyr+Zsf88RP
 VaeDI0U8Q+Op6W4nVmINoNVmXgk8RUY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-LehrB83hM0i5oLn6YI0o1A-1; Thu, 16 Jan 2020 12:17:04 -0500
Received: by mail-wr1-f70.google.com with SMTP id y7so9524506wrm.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 09:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kJB+bdjusuwgJFTBM5V6hLwv2GyvQ1lKSplcsGc5q2A=;
 b=mAQfdVgTtzBwN7avKhX6XRy1WHjN1Bru82yVHK+Qq1Z2zfTFuTnr37p3azTf3WMxgX
 u9zfx5iFayaHdYWkXy6uoAjdTA2p+kZ6kJ3zfKVnGR1qSxS6LPRQLw3Hc/MM9uVcz0zy
 L+8gmEc3Xn0WiCnbwcrE/PVLdLjx7UxDZMP2NZNDFHbBbMj356jwyi7Ol+I4IvF/dsdm
 O27toG3NrCDHzR/rNMh5JwrZKdvFIX1hg8HlMrBGnPR2X4+90ktQ1/s/CTi07EI2swgp
 N7l3HeOlUTzXAq/+wy4R1lYfzK1wS5C9AZM4FjQXuHEeZ+yESECZm6kGUnme7c5o95pL
 XXwg==
X-Gm-Message-State: APjAAAX9Xb4dSQnVCV5SDwHp2ckpuNcTBqbMQy9WurXdfAp5+/iQRa5m
 5hcuheYp0FwGqgz8k1z5S2Pr2I3FCWwXQ1+dVuuk0eHGaEHRQm3RtpZmoLleoCnRj18zDOuLcYQ
 nbdz+umUKinBLS2M=
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr4518957wrr.73.1579195022930;
 Thu, 16 Jan 2020 09:17:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhgeYGYbU7/hjdcPlbIu8YKkmUnD8+PDPqORrDP4/5H5RsosQDNiDn23K7TVbSfi7UdS7rNw==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr4518924wrr.73.1579195022667;
 Thu, 16 Jan 2020 09:17:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a?
 ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
 by smtp.gmail.com with ESMTPSA id i5sm5568768wml.31.2020.01.16.09.17.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 09:17:01 -0800 (PST)
Subject: Re: [PATCH v6 0/8] blockdev: Fix AioContext handling for various
 blockdev actions
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20200108143138.129909-1-slp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98068559-2270-d329-583b-8bf5afac086c@redhat.com>
Date: Thu, 16 Jan 2020 18:17:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108143138.129909-1-slp@redhat.com>
Content-Language: en-US
X-MC-Unique: LehrB83hM0i5oLn6YI0o1A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/01/20 15:31, Sergio Lopez wrote:
> This patch series includes fixes for various issues related to
> AioContext mismanagement for various blockdev-initiated actions.
> 
> It also adds tests for those actions when executed on drives running
> on an IOThread AioContext.

Testing the latest addition to Patchew:

Supersedes: <20191128104129.250206-1-slp@redhat.com>

:)

Paolo

> ---
> Changelog:
> 
> v6:
>  - Rename the patch series.
>  - Add "block/backup-top: Don't acquire context while dropping top"
>  - Add "blockdev: Acquire AioContext on dirty bitmap functions"
>  - Add "blockdev: Return bs to the proper context on snapshot abort"
>  - Add "iotests: Test handling of AioContexts with some blockdev
>    actions" (thanks Kevin Wolf)
>  - Fix context release on error. (thanks Kevin Wolf)
> 
> v5:
>  - Include fix for iotest 141 in patch 2. (thanks Max Reitz)
>  - Also fix iotest 185 and 219 in patch 2. (thanks Max Reitz)
>  - Move error block after context acquisition/release, to we can use
>    goto to bail out and release resources. (thanks Max Reitz)
>  - Properly release old_context in qmp_blockdev_mirror. (thanks Max
>    Reitz)
> 
> v4:
>  - Unify patches 1-4 and 5-7 to avoid producing broken interim
>    states. (thanks Max Reitz)
>  - Include a fix for iotest 141. (thanks Kevin Wolf)
> 
> v3:
>  - Rework the whole patch series to fix the issue by consolidating all
>    operations in the transaction model. (thanks Kevin Wolf)
> 
> v2:
>  - Honor bdrv_try_set_aio_context() context acquisition requirements
>    (thanks Max Reitz).
>  - Release the context at drive_backup_prepare() instead of avoiding
>    re-acquiring it at do_drive_baclup(). (thanks Max Reitz)
>  - Convert a single patch into a two-patch series.
> ---
> 
> Sergio Lopez (8):
>   blockdev: fix coding style issues in drive_backup_prepare
>   blockdev: unify qmp_drive_backup and drive-backup transaction paths
>   blockdev: unify qmp_blockdev_backup and blockdev-backup transaction
>     paths
>   blockdev: honor bdrv_try_set_aio_context() context requirements
>   block/backup-top: Don't acquire context while dropping top
>   blockdev: Acquire AioContext on dirty bitmap functions
>   blockdev: Return bs to the proper context on snapshot abort
>   iotests: Test handling of AioContexts with some blockdev actions
> 
>  block/backup-top.c         |   5 -
>  block/backup.c             |   3 +
>  blockdev.c                 | 391 ++++++++++++++++++++-----------------
>  tests/qemu-iotests/141.out |   2 +
>  tests/qemu-iotests/185.out |   2 +
>  tests/qemu-iotests/219     |   7 +-
>  tests/qemu-iotests/219.out |   8 +
>  tests/qemu-iotests/281     | 247 +++++++++++++++++++++++
>  tests/qemu-iotests/281.out |   5 +
>  tests/qemu-iotests/group   |   1 +
>  10 files changed, 484 insertions(+), 187 deletions(-)
>  create mode 100755 tests/qemu-iotests/281
>  create mode 100644 tests/qemu-iotests/281.out
> 



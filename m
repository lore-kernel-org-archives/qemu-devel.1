Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F0DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F39C2063A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlv9FBXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F39C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvfU3-0001V0-F1
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 07:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvfTA-0000dH-4e
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:21:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvfT8-0004bH-DA
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:20:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id o11so2235980wrv.9
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DPDin73FgWKKbUzWnpJXsKIub5tUydrQPHvsTDczSvs=;
 b=jlv9FBXv2V6SPhSNzgN7sY04hX1qyEthMxmIfkX2kLyrrOa4sGyG6EA0OSGY+iwIDP
 yrx3iI+YdSCnW7p4yZmzaH/q5p6A98B5bJW4PKshNC+zs2HTXGSSPmAzEnaI3cvZAjw2
 HFjnZ0OTEvai49jJZ/1Csw+LfF+ToLeX4jI1WZJjmCJGzwp+uEIFPP/8fcvpYrgxhNpx
 dab9VNa9mbmeyCM6j4EutIg2VYeW5zvEMlXc1O2fW/4PvpLHB9MlJ0UoElXRB1zqAyxB
 q1jIXnkvmAMAGgeEoWYWdNU5LxzqalvCfXJagtRicFqq0ELL0tEDtszKLptWg8+/R7FR
 XdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DPDin73FgWKKbUzWnpJXsKIub5tUydrQPHvsTDczSvs=;
 b=lJUguFSvCfl5idnnO2szFCoo6/YNQoWVc2oSe6eFEysmM4ZY0ClPjHuVF8o2joflyL
 P2BQ1NpgynU/qN369dfJUewINpfY3OeVW64ee/t2ix+OjRqKM3KShYyDDkW2iRVn18/4
 L2wQfq6CT1g8PBLkQNf0RC6yQxUTXR1HpoSHmw1R4Rc2CqkqSS2dz5/YE7mDxpWszoAr
 DBkAX3vacp2G7cyfP1Dy8CiZWxpSZXcLSysXdtCGCBwKxZX/kY+GHM72DNUYx+jJtYlP
 4qsEx59npoTHPpnDQ9kh0rgVZ0R+7I+rvTRU4Jm9F8JLPPWYGvFgbbIrmNMPndrSuEoO
 yKhw==
X-Gm-Message-State: AOAM531ln2/Z+wd6KtQVVkZ5FkQhl4XVeAUwsP9+xDqQFw4TgjQR5azP
 Digy45uzXV5y+lDCrgkGvve73g==
X-Google-Smtp-Source: ABdhPJwFbQbY4G69VA4jHin9D/v9iivSIQ9dT6sKBj5VVbhmk53KaXVWuAYKq/nr6iu9/umuztCfrw==
X-Received: by 2002:a5d:658a:: with SMTP id q10mr11733198wru.220.1594812056749; 
 Wed, 15 Jul 2020 04:20:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f15sm2937295wrx.91.2020.07.15.04.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 04:20:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7A59E1FF7E;
 Wed, 15 Jul 2020 12:20:54 +0100 (BST)
References: <159316678008.10508.6615172353109944370.stgit@pasha-ThinkPad-X280>
 <159316680859.10508.4570677924280388493.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH 05/13] qapi: introduce replay.json for
 record/replay-related stuff
In-reply-to: <159316680859.10508.4570677924280388493.stgit@pasha-ThinkPad-X280>
Date: Wed, 15 Jul 2020 12:20:54 +0100
Message-ID: <87ft9txbvt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> This patch adds replay.json file. It will be
> used for adding record/replay-related data structures and commands.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  0 files changed
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5dd86c7f94..ca5b1cf7f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2572,6 +2572,7 @@ F: docs/replay.txt
>  F: stubs/replay.c
>  F: tests/acceptance/replay_kernel.py
>  F: tests/acceptance/replay_linux.py
> +F: qapi/replay.json

This makes me wonder what is missing as MAINTAINERS doesn't have
replay_linux.py - which is why I was confused.

>=20=20
>  IOVA Tree
>  M: Peter Xu <peterx@redhat.com>
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index c9c896ae8d..e00ed2f4a5 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -14,6 +14,7 @@
>=20=20
>  #include "qapi/qapi-types-misc.h"
>  #include "qapi/qapi-types-run-state.h"
> +#include "qapi/qapi-types-replay.h"
>  #include "qapi/qapi-types-ui.h"
>  #include "block/aio.h"
>=20=20
> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index 4673ab7490..eff501a97d 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -7,8 +7,8 @@ util-obj-y +=3D qapi-util.o
>=20=20
>  QAPI_COMMON_MODULES =3D audio authz block-core block char common control=
 crypto
>  QAPI_COMMON_MODULES +=3D dump error introspect job machine migration misc
> -QAPI_COMMON_MODULES +=3D net pragma qdev qom rdma rocker run-state socke=
ts tpm
> -QAPI_COMMON_MODULES +=3D trace transaction ui
> +QAPI_COMMON_MODULES +=3D net pragma qdev qom rdma replay rocker run-stat=
e sockets
> +QAPI_COMMON_MODULES +=3D tpm trace transaction ui
>  QAPI_TARGET_MODULES =3D machine-target misc-target
>  QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
>=20=20
> diff --git a/qapi/misc.json b/qapi/misc.json
> index a5a0beb902..2a7af56887 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1493,24 +1493,6 @@
>  { 'event': 'ACPI_DEVICE_OST',
>       'data': { 'info': 'ACPIOSTInfo' } }
>=20=20
> -##
> -# @ReplayMode:
> -#
> -# Mode of the replay subsystem.
> -#
> -# @none: normal execution mode. Replay or record are not enabled.
> -#
> -# @record: record mode. All non-deterministic data is written into the
> -#          replay log.
> -#
> -# @play: replay mode. Non-deterministic data required for system executi=
on
> -#        is read from the log.
> -#
> -# Since: 2.5
> -##
> -{ 'enum': 'ReplayMode',
> -  'data': [ 'none', 'record', 'play' ] }
> -
>  ##
>  # @xen-load-devices-state:
>  #
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 43b0ba0dea..ce48897b94 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -81,6 +81,7 @@
>  { 'include': 'qdev.json' }
>  { 'include': 'machine.json' }
>  { 'include': 'machine-target.json' }
> +{ 'include': 'replay.json' }
>  { 'include': 'misc.json' }
>  { 'include': 'misc-target.json' }
>  { 'include': 'audio.json' }
> diff --git a/qapi/replay.json b/qapi/replay.json
> new file mode 100644
> index 0000000000..9e13551d20
> --- /dev/null
> +++ b/qapi/replay.json
> @@ -0,0 +1,26 @@
> +# -*- Mode: Python -*-
> +#
> +
> +##
> +# =3D Record/replay
> +##
> +
> +{ 'include': 'common.json' }
> +
> +##
> +# @ReplayMode:
> +#
> +# Mode of the replay subsystem.
> +#
> +# @none: normal execution mode. Replay or record are not enabled.
> +#
> +# @record: record mode. All non-deterministic data is written into the
> +#          replay log.
> +#
> +# @play: replay mode. Non-deterministic data required for system executi=
on
> +#        is read from the log.
> +#
> +# Since: 2.5
> +##
> +{ 'enum': 'ReplayMode',
> +  'data': [ 'none', 'record', 'play' ] }

otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e


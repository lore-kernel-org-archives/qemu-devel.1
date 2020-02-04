Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D57C3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563BD20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiOhRQcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563BD20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0ml-0000ao-ID
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz0kA-0004vB-JZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz0k8-0007KA-C5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:08:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47437
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz0k8-0007I5-7s
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580832483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mp4Gj/TzoHQZoGGJc2ktciNqWHdcRqjXeC6laX0gjl4=;
 b=NiOhRQcKCBAQGS2EW6pr2gFCOTfPLFt5cQydl96vuXmaKUlHzJNgJxv0tNEUUes/efETQ6
 UrVvHXzcnAhFBobD4NSM+/pqpqBwnsM4Srk0QuJzaxs9TJHIjeQRhX2vLQlO25vwcda6xO
 xsy1D04UBDxigGl44IH1Az6mNHehxz0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-689S_zvLPDa3znbJ7hu8cA-1; Tue, 04 Feb 2020 11:08:00 -0500
Received: by mail-wm1-f69.google.com with SMTP id y125so1149429wmg.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GolQCDLcWStaY3lluMhv6Tsrkkt5aaGfx6eFswOajXE=;
 b=A9NVCD/2IOzyktNaYLIpqZwI2ZYwsPJC+6IYjPampDOHhlD/3LqPlIaKSpIdx2cgS6
 Dx7mkYdz3+oRNCIu+KKSEKSyo2+sAevJYMRr4UlQ87RJqKfBXwxY5K0xnkQitF3SfTvO
 sdNtH3HQfgPTr0l69J6XRn87ZMTwogJfBO82xsGNlPQhLlcACgN3kgEmRS399pIXATaG
 qQOQuc7b1oy8hg+nIMETM0JavOGtznDeYnelGhoqVeRV6yMLT+QTCLjcoiqCJsQbcdmc
 LAalXm/5MGMslTfY8WA0zwxIFlqLEbmwwWQroOOXQfkZekGieDCSOODQexTy2Xa8TCeu
 J6QA==
X-Gm-Message-State: APjAAAW+hEcupppEmafJdfGIioc6rsZcappzTmyDAd65liJDYtkkN6hz
 Ljm+A3DFocN5sx0URMB5hII5BthNUyLDzheQYJGkNE3YMq6BObcI3h7UnclwGeCPd5riaHr7pmj
 eIptSL9Zq1J+2WHg=
X-Received: by 2002:a7b:c652:: with SMTP id q18mr6406824wmk.123.1580832478620; 
 Tue, 04 Feb 2020 08:07:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9S/i4Mxfg5INZI9DMeoQI7RxqdRe3AtZUqSdS+K3rX6ORXXnmZN/A8jfKg/D2qTQQ+Otlng==
X-Received: by 2002:a7b:c652:: with SMTP id q18mr6406804wmk.123.1580832478380; 
 Tue, 04 Feb 2020 08:07:58 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id y1sm18159332wrq.16.2020.02.04.08.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 08:07:57 -0800 (PST)
Subject: Re: [PATCH] drop "from __future__ import print_function"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200204160604.19883-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <86185404-c4bc-b35d-eedc-9d95d1698379@redhat.com>
Date: Tue, 4 Feb 2020 17:07:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204160604.19883-1-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: 689S_zvLPDa3znbJ7hu8cA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 5:06 PM, Paolo Bonzini wrote:
> This is only needed for Python 2, which we do not support anymore.
>=20
> Based-on: <20200204160028.16211-1-pbonzini@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   scripts/analyse-9p-simpletrace.py        | 1 -
>   scripts/analyse-locks-simpletrace.py     | 1 -
>   scripts/device-crash-test                | 1 -
>   scripts/dump-guest-memory.py             | 1 -
>   scripts/kvm/kvm_flightrecorder           | 1 -
>   scripts/kvm/vmxcap                       | 1 -
>   scripts/minikconf.py                     | 1 -
>   scripts/modules/module_block.py          | 1 -
>   scripts/qapi-gen.py                      | 1 -
>   scripts/qapi/doc.py                      | 1 -
>   scripts/qmp/qemu-ga-client               | 1 -
>   scripts/qmp/qmp                          | 1 -
>   scripts/qmp/qmp-shell                    | 1 -
>   scripts/qmp/qom-get                      | 1 -
>   scripts/qmp/qom-list                     | 1 -
>   scripts/qmp/qom-set                      | 1 -
>   scripts/qmp/qom-tree                     | 1 -
>   scripts/replay-dump.py                   | 1 -
>   scripts/signrom.py                       | 1 -
>   scripts/simpletrace.py                   | 1 -
>   scripts/vmstate-static-checker.py        | 1 -
>   tests/docker/travis.py                   | 1 -
>   tests/guest-debug/test-gdbstub.py        | 1 -
>   tests/migration/guestperf/engine.py      | 1 -
>   tests/migration/guestperf/plot.py        | 1 -
>   tests/migration/guestperf/shell.py       | 1 -
>   tests/qapi-schema/test-qapi.py           | 1 -
>   tests/qemu-iotests/149                   | 1 -
>   tests/qemu-iotests/165                   | 1 -
>   tests/qemu-iotests/iotests.py            | 1 -
>   tests/qemu-iotests/nbd-fault-injector.py | 1 -
>   tests/qemu-iotests/qcow2.py              | 1 -
>   tests/qemu-iotests/qed.py                | 1 -
>   tests/vm/basevm.py                       | 1 -
>   34 files changed, 34 deletions(-)
>=20
> diff --git a/scripts/analyse-9p-simpletrace.py b/scripts/analyse-9p-simpl=
etrace.py
> index f20050fddd..7dfcb6ba2f 100755
> --- a/scripts/analyse-9p-simpletrace.py
> +++ b/scripts/analyse-9p-simpletrace.py
> @@ -3,7 +3,6 @@
>   # Usage: ./analyse-9p-simpletrace <trace-events> <trace-pid>
>   #
>   # Author: Harsh Prateek Bora
> -from __future__ import print_function
>   import os
>   import simpletrace

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



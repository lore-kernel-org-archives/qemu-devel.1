Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF736C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC1C20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0lmFgFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC1C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9aT-0005ll-RZ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE9Uo-0005t0-4k
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE9Um-0007Kr-Oe
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:30:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20623)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE9Ul-0007Gm-Gu
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584441047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sEWNqzFaoxEa+58cO40Jpez+R+M71OVxk6iZCOTC5I=;
 b=K0lmFgFKvkGC/eZ4PAsYVCnvyjWeNWVrWBiwxhhIffb3JlfDm7/9hsnsFPOEJbbY1OzZOh
 Ncdj/feunnLe6qw3GeHsma5kJIA198E9m9VVFJ+f/7uQ8AwIWYyvycD9JhREEcJKoJerfp
 eWnvdxstgC0p2/GS5jxVlf/agaz6uYA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-XyI7J1b_PLq6ErHn3FNhhQ-1; Tue, 17 Mar 2020 06:30:43 -0400
X-MC-Unique: XyI7J1b_PLq6ErHn3FNhhQ-1
Received: by mail-wm1-f69.google.com with SMTP id g26so5552805wmk.6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=55Oo5NkKbyxcBavyE68uAV9NFs7KDyk+gF1ISZOgndM=;
 b=sfQh/gUkHfiXlHvujhkCHWD+nq91BrRD1z/JJLNHvSwGQFyZ8zh2ARqyN4ddhvHjBB
 vFwK+vecEOu2HsRsH3Q94OlfXB3F8HWrrp4GNFXZRC2yOree7fDsyYZvLxOHHfGMPB3X
 PzNi1ISQvNHQa7ROd5YrgDga2zBoe7Pe0u0D/Fs2Fioq0FpCtjipNsQfXVN/IaGS+8sO
 UZafgLrXDEMSXbZLcrsb0leppSveIyPSoJw8xa014lwkUEvD6rO596nNIptA6SBnWM+u
 vJOVviF5Oc+VDvSqTSnDQhJZv082dH65LG42PCjr3z3mUe4g9DNd9PF/4ljPgyf3KJnc
 6/Fg==
X-Gm-Message-State: ANhLgQ3jy72RMakkVWtr0eU28pg0B5Tsy+Wv+CBMYQZ4vv/hsDU2BLvl
 aE37Pq18k58LHcFtuQP2Mk3YiQEYo5MlQhgH8G2LWvad/ZdjDFNvPLjxOMne5PpJRTVtwcYkSJ4
 1TQFM6X3mUMr2Dz0=
X-Received: by 2002:a5d:6082:: with SMTP id w2mr5352142wrt.300.1584441042561; 
 Tue, 17 Mar 2020 03:30:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtIZF8AYXmY55uNahGNtqj0CtUppt3+hLyU7NJYZz84kI4Bx0BaNaZGpJcNOuOrC/6SoX4grQ==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr5352129wrt.300.1584441042386; 
 Tue, 17 Mar 2020 03:30:42 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id t9sm552105wrx.31.2020.03.17.03.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:30:41 -0700 (PDT)
Subject: Re: [PATCH v1 22/28] tests/guest-debug: add a simple test runner
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-23-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <834cdb7b-01aa-c783-843c-f58908d55304@redhat.com>
Date: Tue, 17 Mar 2020 11:30:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316172155.971-23-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 6:21 PM, Alex Benn=C3=A9e wrote:
> The test runners job is to start QEMU with guest debug enabled and
> then spawn a gdb process running a test script that exercises the
> functionality it wants to test.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   tests/guest-debug/run-test.py | 57 +++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
>   create mode 100755 tests/guest-debug/run-test.py
>=20
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.p=
y
> new file mode 100755
> index 00000000000..8c49ee2f225
> --- /dev/null
> +++ b/tests/guest-debug/run-test.py
> @@ -0,0 +1,57 @@
> +#!/usr/bin/env python3
> +#
> +# Run a gdbstub test case
> +#
> +# Copyright (c) 2019 Linaro
> +#
> +# Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
> +# See the COPYING file in the top-level directory.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import argparse
> +import subprocess
> +import shutil
> +import shlex
> +
> +def get_args():
> +    parser =3D argparse.ArgumentParser(description=3D"A gdbstub test run=
ner")
> +    parser.add_argument("--qemu", help=3D"Qemu binary for test",
> +                        required=3DTrue)
> +    parser.add_argument("--qargs", help=3D"Qemu arguments for test")
> +    parser.add_argument("--binary", help=3D"Binary to debug",
> +                        required=3DTrue)
> +    parser.add_argument("--test", help=3D"GDB test script",
> +                        required=3DTrue)
> +    parser.add_argument("--gdb", help=3D"The gdb binary to use", default=
=3DNone)
> +
> +    return parser.parse_args()
> +
> +if __name__ =3D=3D '__main__':
> +    args =3D get_args()
> +
> +    # Search for a gdb we can use
> +    if not args.gdb:
> +        args.gdb =3D shutil.which("gdb-multiarch")
> +    if not args.gdb:
> +        args.gdb =3D shutil.which("gdb")
> +    if not args.gdb:
> +        print("We need gdb to run the test")
> +        exit(-1)
> +
> +    # Launch QEMU with binary
> +    if "system" in args.qemu:
> +        cmd =3D "%s %s %s -s -S" % (args.qemu, args.qargs, args.binary)
> +    else:
> +        cmd =3D "%s %s -g 1234 %s" % (args.qemu, args.qargs, args.binary=
)
> +
> +    inferior =3D subprocess.Popen(shlex.split(cmd))
> +
> +    # Now launch gdb with our test and collect the result
> +    gdb_cmd =3D "%s %s -ex 'target remote localhost:1234' -x %s" % (args=
.gdb, args.binary, args.test)
> +
> +    result =3D subprocess.call(gdb_cmd, shell=3DTrue);
> +
> +    exit(result)
>=20



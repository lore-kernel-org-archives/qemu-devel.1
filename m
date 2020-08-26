Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AEAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3EA2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9dqKiJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3EA2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxHc-00016d-Gw
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxGk-0000eh-E6
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:23:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxGi-0005Mw-BJ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598455399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/eY+XHFIQVWWePO9nZ2oFD7CfyyAagegqaOn7z/Bi1M=;
 b=X9dqKiJfNwjRSTxTuN+nK1Zx9MrX0u9NOJRWdb0fO0VxO5slvD3eaUUvzS2y8YC8gF1a5V
 dlycCcZQKxnXWMskU3Vyax39eUscrctTS8irmgdfXugItJTgwD0HXGFYj3ySqCL7DU/Wmh
 OLvEJMyVYl1FN5auVSL9ySh6tbKJG2I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-fhmtgjTjPFy2VsSpDlNi_w-1; Wed, 26 Aug 2020 11:23:17 -0400
X-MC-Unique: fhmtgjTjPFy2VsSpDlNi_w-1
Received: by mail-ej1-f70.google.com with SMTP id g20so1141799ejd.8
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/eY+XHFIQVWWePO9nZ2oFD7CfyyAagegqaOn7z/Bi1M=;
 b=BG8+dsiovNSdXCDqq5G32bYo7to1FgbfxpNcKjiiHujyJZgazRqjGaGSCZ/okDUFjC
 z/c0LIeu5sdNK/Z9EABTs5IBUNVzdkG+duaQfu0ssySyQRn5n3LidWCU0CU2Qio+xR8U
 +cu8QleKdP6IppPtfahwOwPmCVxLc5+uRZ4H+kIbrqWw36y0Go1HA+6N+siwXSTOuVBj
 KX/qn/Iha5tk24W6nKsWwxLpBnyq+fY8JXUh8WNHtGbbeXbn5hzlBGTFBv4xAK0ZcURq
 Nfj7nRPfWfJF07q5wLJUo35veF2tWJ4i7mF4D9Tm55G4rQG0n8/5dGIOLdaqYRAV14lp
 Ne5w==
X-Gm-Message-State: AOAM530TZ/ho+sW+5Kf7mYtcmNQo2Fyiol//7RreXin526dQmVkq4Lrq
 XvzzojLAFPzi02f3jVDVuiVqpmoD1q82FRpCPVmMYkDCyyV6aO4jETxOBb7bJZy2TUTPO9a/Uga
 9gKTepvxZEGshUVOAOKQ+xHNk9s9A/dI=
X-Received: by 2002:a17:906:d9db:: with SMTP id
 qk27mr15323353ejb.230.1598455390313; 
 Wed, 26 Aug 2020 08:23:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTXTgfEQxQinbwD2709kgSBmsnJ0ZlmX+BgGMgWNr1gO8ekkulh6ugbB1IyhjnO48P0E7euyOEgMS2091M4Tw=
X-Received: by 2002:a17:906:d9db:: with SMTP id
 qk27mr15323333ejb.230.1598455390055; 
 Wed, 26 Aug 2020 08:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <20200826151006.80-6-luoyonggang@gmail.com>
In-Reply-To: <20200826151006.80-6-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 17:22:59 +0200
Message-ID: <CABgObfYK_BC0U+iXC9Y8VPSRXJT+vwZHhzT+Db+N4hTTqEVKRA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] meson: Convert undefsym.sh to undefsym.py
To: luoyonggang@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Careful, the original script:

-comm -12 \
-  <( $NM -P -g $staticlib | awk '$2!="U"{print "-Wl,-u," $1}' | sort -u) \
-  <( $NM -P -g "$@" | awk '$2=="U"{print "-Wl,-u," $1}' | sort -u)

looks for lines that *are* U in the modules. So using filter_lines_set
is correct for static libraries but wrong for modules.

Paolo

On Wed, Aug 26, 2020 at 5:13 PM <luoyonggang@gmail.com> wrote:
>
> From: Yonggang Luo <luoyonggang@gmail.com>
>
> undefsym.sh are not msys2 compatible, convert it to python script
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  meson.build         |  2 +-
>  scripts/undefsym.py | 56 +++++++++++++++++++++++++++++++++++++++++++++
>  scripts/undefsym.sh | 20 ----------------
>  3 files changed, 57 insertions(+), 21 deletions(-)
>  create mode 100644 scripts/undefsym.py
>  delete mode 100755 scripts/undefsym.sh
>
> diff --git a/meson.build b/meson.build
> index 1644bbd83c..d6e3bcea7e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -845,7 +845,7 @@ foreach d, list : modules
>  endforeach
>
>  nm = find_program('nm')
> -undefsym = find_program('scripts/undefsym.sh')
> +undefsym = find_program('scripts/undefsym.py')
>  block_syms = custom_target('block.syms', output: 'block.syms',
>                               input: [libqemuutil, block_mods],
>                               capture: true,
> diff --git a/scripts/undefsym.py b/scripts/undefsym.py
> new file mode 100644
> index 0000000000..ebc009fb24
> --- /dev/null
> +++ b/scripts/undefsym.py
> @@ -0,0 +1,56 @@
> +#!/usr/bin/env python3
> +# -*- coding: utf-8 -*-
> +
> +# Before a shared module's DSO is produced, a static library is built for it
> +# and passed to this script.  The script generates -Wl,-u options to force
> +# the inclusion of symbol from libqemuutil.a if the shared modules need them,
> +# This is necessary because the modules may use functions not needed by the
> +# executable itself, which would cause the function to not be linked in.
> +# Then the DSO loading would fail because of the missing symbol.
> +
> +
> +"""
> +Compare the static library for compute the symbol duplication
> +"""
> +
> +import sys
> +import subprocess
> +
> +def filter_lines_set(stdout):
> +    linesSet = set()
> +    for line in stdout.splitlines():
> +        tokens = line.split(b' ')
> +        if len(tokens) >= 1:
> +            if len(tokens) > 1 and tokens[1] == b'U':
> +                continue
> +            new_line = b'-Wl,-u,' + tokens[0]
> +            if not new_line in linesSet:
> +                linesSet.add(new_line)
> +    return linesSet
> +
> +def main(args):
> +    global _SCRIPT
> +    print(" ".join(args),  file=sys.stderr)
> +    if len(args) <= 3:
> +        sys.exit(0)
> +
> +    nm = args[1]
> +    staticlib = args[2]
> +    pc = subprocess.run([nm, "-P", "-g", staticlib], stdout=subprocess.PIPE)
> +    if pc.returncode != 0:
> +        sys.exit(-1)
> +    lines_set_left = filter_lines_set(pc.stdout)
> +
> +    shared_modules = args[3:]
> +    pc = subprocess.run([nm, "-P", "-g"] + shared_modules, stdout=subprocess.PIPE)
> +    if pc.returncode != 0:
> +        sys.exit(-1)
> +    lines_set_right = filter_lines_set(pc.stdout)
> +    lines = []
> +    for line in sorted(list(lines_set_right)):
> +        if line in lines_set_left:
> +            lines.append(line)
> +    sys.stdout.write(b'\n'.join(lines).decode())
> +
> +if __name__ == "__main__":
> +    main(sys.argv)
> diff --git a/scripts/undefsym.sh b/scripts/undefsym.sh
> deleted file mode 100755
> index b9ec332e95..0000000000
> --- a/scripts/undefsym.sh
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -#! /usr/bin/env bash
> -
> -# Before a shared module's DSO is produced, a static library is built for it
> -# and passed to this script.  The script generates -Wl,-u options to force
> -# the inclusion of symbol from libqemuutil.a if the shared modules need them,
> -# This is necessary because the modules may use functions not needed by the
> -# executable itself, which would cause the function to not be linked in.
> -# Then the DSO loading would fail because of the missing symbol.
> -
> -if test $# -le 2; then
> -  exit 0
> -fi
> -
> -NM=$1
> -staticlib=$2
> -shift 2
> -# Find symbols defined in static libraries and undefined in shared modules
> -comm -12 \
> -  <( $NM -P -g $staticlib | awk '$2!="U"{print "-Wl,-u," $1}' | sort -u) \
> -  <( $NM -P -g "$@" | awk '$2=="U"{print "-Wl,-u," $1}' | sort -u)
> --
> 2.27.0.windows.1
>



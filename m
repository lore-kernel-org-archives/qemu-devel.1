Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B9DC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAFC20708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjpsoZNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAFC20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Q4V-0007PH-FB
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Q3b-0006uO-Qu
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Q3a-0007ID-Gg
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:34:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Q3a-0007HN-Cj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581406445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YS7Gc5HmxrDbEbwf7CNtsg9nZZr8xk5Xt95MdKhpsoc=;
 b=ZjpsoZNQzl7E0+zf0lmpvL2gYM1xHOS7xuYR5/2vitJQuwq3gkgF20UpIU09qOiFP1kh9A
 BQJjZdfXT2NdBx8u0z5b6/j4NM/5llu6bXBcD0nVCcgTVL9dT1ZI5M9z7zQGu+FhnyQ2oe
 BLY+chH/4PdYEsJgh4xCLiVIXG9khjI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-EFJm0isON2WiaoFk5y3How-1; Tue, 11 Feb 2020 02:34:02 -0500
Received: by mail-wm1-f72.google.com with SMTP id 7so956508wmf.9
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YS7Gc5HmxrDbEbwf7CNtsg9nZZr8xk5Xt95MdKhpsoc=;
 b=J5pzufAD4pCWBunBzd30fvR2fFmbUrASJowMGPH43Age256Zq+kD/aykgSr20AtCC3
 MgkBkoWvBdr5m+DUVnSsMAqEZXqZ8mQPY+5w22maZz0IoThA3XHKSkTVHcIOafpVaHR5
 yAU55Ub59lYK//YAzGWsw5K41PMDoUfLdhwyoUskAsz2vyTqmyrTGL85NItr13fB2TzR
 /Km7q87B1GgFUXS4pk+fuCHKJcwcaPJd90zQBcf1h6cEdjXPWvDleBKiWhWAhl3fr34h
 u53iHeQR98DBjwy5jX23yqUktEYIUoHDQpMrVx/QhDLpjMglxt+qng3H4YoFlW2Qpthq
 y9sQ==
X-Gm-Message-State: APjAAAWDUai9spyVl2twPZXvWHLGB4SoGtWkv6Pwc/9hz2Pvvf0nUuLR
 o0RVSTaiaBFF5J0t3lM5gP3EbMXA4/pxochGwD0nkmZoLydjMedMn2SKFSQUyrVsU11Zi60QZPA
 DR3UVtyV3/ahldDI=
X-Received: by 2002:a1c:6189:: with SMTP id v131mr4121013wmb.185.1581406440899; 
 Mon, 10 Feb 2020 23:34:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6NLSVFK0csld8J0J9VmQ1nFDGGMS0+cr8wTSFrpq+AgeLrbNVl74ZlsmqETEnuSQnWUbcQw==
X-Received: by 2002:a1c:6189:: with SMTP id v131mr4120958wmb.185.1581406440440; 
 Mon, 10 Feb 2020 23:34:00 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c15sm4062751wrt.1.2020.02.10.23.33.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:33:59 -0800 (PST)
Subject: Re: [RFC PATCH 21/66] Hexagon generator phase 2 - qemu_def_generated.h
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-22-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9c9a89fa-fddc-c0aa-b520-044eb7379b16@redhat.com>
Date: Tue, 11 Feb 2020 08:33:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-22-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: EFJm0isON2WiaoFk5y3How-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 1:39 AM, Taylor Simpson wrote:
> For each instruction we create
>      DEF_HELPER function prototype
>      TCG code to generate call to helper
>      Helper definition
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/do_qemu.py | 773 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 773 insertions(+)
>   create mode 100755 target/hexagon/do_qemu.py
> 
> diff --git a/target/hexagon/do_qemu.py b/target/hexagon/do_qemu.py
> new file mode 100755
> index 0000000..992dbc3
> --- /dev/null
> +++ b/target/hexagon/do_qemu.py
> @@ -0,0 +1,773 @@
> +#!/usr/bin/env python

python3 ;)

> +
> +from __future__ import print_function

Not needed anymore.

> +##
> +##  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
> +##
> +##  This program is free software; you can redistribute it and/or modify
> +##  it under the terms of the GNU General Public License as published by
> +##  the Free Software Foundation; either version 2 of the License, or
> +##  (at your option) any later version.
> +##
> +##  This program is distributed in the hope that it will be useful,
> +##  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +##  GNU General Public License for more details.
> +##
> +##  You should have received a copy of the GNU General Public License
> +##  along with this program; if not, see <http://www.gnu.org/licenses/>.
> +##
> +
> +import sys
> +import re
> +import string
> +try:
> +    from StringIO import StringIO
> +except ImportError:
> +    from io import StringIO

Directly "from io import StringIO".

> +
> +
> +import operator
> +from itertools import chain
> +
> +
> +
> +behdict = {}          # tag ->behavior
> +semdict = {}          # tag -> semantics
> +extdict = {}          # tag -> What extension an instruction belongs to (or "")
> +extnames = {}         # ext name -> True
> +attribdict = {}       # tag -> attributes
> +macros = {}           # macro -> macro information...
> +attribinfo = {}       # Register information and misc
> +tags = []             # list of all tags
> +
> +def get_macro(macname,ext=""):
> +    mackey = macname + ":" + ext
> +    if ext and mackey not in macros:
> +        return get_macro(macname,"")
> +    return macros[mackey]
> +
> +# We should do this as a hash for performance,
> +# but to keep order let's keep it as a list.
> +def uniquify(seq):
> +    seen = set()
> +    seen_add = seen.add
> +    return [x for x in seq if x not in seen and not seen_add(x)]
> +
> +regre = re.compile(
> +    r"((?<!DUP)[MNORCPQXSGVZA])([stuvwxyzdefg]+)([.]?[LlHh]?)(\d+S?)")
> +immre = re.compile(r"[#]([rRsSuUm])(\d+)(?:[:](\d+))?")
> +reg_or_immre = \
> +    re.compile(r"(((?<!DUP)[MNRCOPQXSGVZA])([stuvwxyzdefg]+)" + \
> +                "([.]?[LlHh]?)(\d+S?))|([#]([rRsSuUm])(\d+)[:]?(\d+)?)")
> +relimmre = re.compile(r"[#]([rR])(\d+)(?:[:](\d+))?")
> +absimmre = re.compile(r"[#]([sSuUm])(\d+)(?:[:](\d+))?")
> +
> +finished_macros = set()
[...]



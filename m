Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92116C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B1D206F1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYVXXdz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B1D206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbwZ-0006PT-Ji
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbvu-0005t4-83
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:56:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbvs-0003Ti-HO
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590508558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ExvP0V1+INEAGK5lSUT/2b1atNKdbvLM0DMkBuSlWm4=;
 b=JYVXXdz1TjVB2ElGADYr3y8LWjOI4VEdNQmdV5TDoedCt2rgLS3A3e6kJDxb+E5QmlaNpM
 UjT3bvXBT1oUtLCBVMJw1X3XSsA1z2BWXm3I2kU+jH6zNr7ZwBkq/vIn9iKjeUQFb+CJr3
 x7DZLUsVknGRlUcBnS2PaZtUmoncmmo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-AS-FxxEbOfm8NWT7r35ZXA-1; Tue, 26 May 2020 11:55:52 -0400
X-MC-Unique: AS-FxxEbOfm8NWT7r35ZXA-1
Received: by mail-ed1-f71.google.com with SMTP id w15so8527258edi.11
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ExvP0V1+INEAGK5lSUT/2b1atNKdbvLM0DMkBuSlWm4=;
 b=CJfn4yu8/csriCcRRGBoMSSut81Mdnc0SR2k53FCsBd6dhXYKE1uMnzVYMAy6D/SE6
 sDEmIj5WuxXabP/rVLmDpqNjirpNVe5FQUFQQ0SXUcjIuRO/gOvtwpx3WxGGkK3o/Avi
 TvmBRBiE8ape75vUoozh0vqXwl1gksFtZQgCS6HmMBzG+7qNwRaz7DR/pkksMlc5OzSx
 FTVLY/OQ2MSrsXg6L6KDmxOTKkGdPqFsGnXiAAnf2LduWdk0SVMna+YALTz7kp9bXirT
 CMQIpNzgPFyruDr1Q+GQysPlBuZQO1VZBb2hRqQ7iMhoznvlSEXVlH22c/Bw2jk8DVk0
 dGEg==
X-Gm-Message-State: AOAM532RnwIbSSQ0sR6hdxX2EOasdvzt36wNxM+icXbt3axtxR8mvPDY
 SXAF//Xi5jjC4PUULQbjbRUAmp7CE4rsur/+p8HxiVnAvxUdue9p6pDSTiALV6NvCvsflZknm+P
 4BxmaclPVScU5oo8=
X-Received: by 2002:a50:d7d1:: with SMTP id m17mr7964970edj.126.1590508551222; 
 Tue, 26 May 2020 08:55:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydcFHNeRChSIoHPPWwMYXRqYzz4xHvl//AZpWRPYMGs16IW0vNvE+U/bVTbDBTWIbevdeAOA==
X-Received: by 2002:a50:d7d1:: with SMTP id m17mr7964936edj.126.1590508550957; 
 Tue, 26 May 2020 08:55:50 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id b15sm277828edj.37.2020.05.26.08.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 08:55:50 -0700 (PDT)
Subject: Re: [PATCH RFC 02/32] scripts/qmp: Fix shebang and imports
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-3-jsnow@redhat.com>
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
Message-ID: <d607ffed-9556-87f0-ff4f-169d99667957@redhat.com>
Date: Tue, 26 May 2020 17:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-3-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 7:53 AM, John Snow wrote:
> There's more wrong with these scripts; They are in various stages of
> disrepair. That's beyond the scope of this current patchset.
> 
> This just mechanically corrects the imports and the shebangs, as part of
> ensuring that the python/qemu/lib refactoring didn't break anything
> needlessly.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Whoops, I address this in a patch series I'm working on, too. I'll keep
my patch in there for now until this one makes it in, or vice-versa.

https://www.mail-archive.com/qemu-block@nongnu.org/msg66801.html

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  scripts/qmp/qmp      | 4 +++-
>  scripts/qmp/qom-fuse | 4 +++-
>  scripts/qmp/qom-get  | 6 ++++--
>  scripts/qmp/qom-list | 4 +++-
>  scripts/qmp/qom-set  | 6 ++++--
>  scripts/qmp/qom-tree | 6 ++++--
>  6 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
> index 0625fc2aba..5981f7c414 100755
> --- a/scripts/qmp/qmp
> +++ b/scripts/qmp/qmp
> @@ -11,7 +11,9 @@
>  # See the COPYING file in the top-level directory.
>  
>  import sys, os
> -from qmp import QEMUMonitorProtocol
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> +from qemu.lib import QEMUMonitorProtocol
>  
>  def print_response(rsp, prefix=[]):
>      if type(rsp) == list:
> diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
> index 6bada2c33d..6006f1d562 100755
> --- a/scripts/qmp/qom-fuse
> +++ b/scripts/qmp/qom-fuse
> @@ -15,7 +15,9 @@ import fuse, stat
>  from fuse import Fuse
>  import os, posix
>  from errno import *
> -from qmp import QEMUMonitorProtocol
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> +from qemu.lib import QEMUMonitorProtocol
>  
>  fuse.fuse_python_api = (0, 2)
>  
> diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
> index 007b4cd442..1d04d1b119 100755
> --- a/scripts/qmp/qom-get
> +++ b/scripts/qmp/qom-get
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python3
>  ##
>  # QEMU Object Model test tools
>  #
> @@ -13,7 +13,9 @@
>  
>  import sys
>  import os
> -from qmp import QEMUMonitorProtocol
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> +from qemu.lib import QEMUMonitorProtocol
>  
>  cmd, args = sys.argv[0], sys.argv[1:]
>  socket_path = None
> diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
> index 03bda3446b..94e3bc21ba 100755
> --- a/scripts/qmp/qom-list
> +++ b/scripts/qmp/qom-list
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python3
>  ##
>  # QEMU Object Model test tools
>  #
> @@ -13,6 +13,8 @@
>  
>  import sys
>  import os
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
>  from qmp import QEMUMonitorProtocol
>  
>  cmd, args = sys.argv[0], sys.argv[1:]
> diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
> index c37fe78b00..a78080a4fc 100755
> --- a/scripts/qmp/qom-set
> +++ b/scripts/qmp/qom-set
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python3
>  ##
>  # QEMU Object Model test tools
>  #
> @@ -13,7 +13,9 @@
>  
>  import sys
>  import os
> -from qmp import QEMUMonitorProtocol
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> +from qemu.lib import QEMUMonitorProtocol
>  
>  cmd, args = sys.argv[0], sys.argv[1:]
>  socket_path = None
> diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
> index 1c8acf61e7..4866c15581 100755
> --- a/scripts/qmp/qom-tree
> +++ b/scripts/qmp/qom-tree
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python3
>  ##
>  # QEMU Object Model test tools
>  #
> @@ -15,7 +15,9 @@
>  
>  import sys
>  import os
> -from qmp import QEMUMonitorProtocol
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> +from qemu.lib import QEMUMonitorProtocol
>  
>  cmd, args = sys.argv[0], sys.argv[1:]
>  socket_path = None
> 



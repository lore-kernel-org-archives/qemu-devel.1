Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E258CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF572073F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2t1GJ1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF572073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icBl5-0004TM-MO
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 12:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icAw3-0008EJ-9j
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icAvz-0002hv-In
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:21:56 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icAvy-0002cz-Gk
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:21:55 -0500
Received: by mail-wm1-x341.google.com with SMTP id u18so3555605wmc.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 08:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HXMYVlTVWGlBh4GEhEx9d/lDpyqjrN+hUgS0cGnh4h8=;
 b=p2t1GJ1FLaKzGvvgQE1Vd01Uz1XImEiw4wHo/x1hXf9mvGEVbN1qgOhHSYxc1pUXPb
 AbAH5/QKYrKdMcYbYcUzvWmlGfZ2z5NmEFida37xcqYHvvihITiMFYhVoUA1eQu3fyAI
 5p6NhynYFrdn53sJOWqig0UKQYjavwwun/W3WSbCu3uKWjIGG7vtJ5AokM9z/7xRr+0t
 6uY5ElozrPlKVggECuDbmtGZLi6es3e/TWONJrWe/2U+t+7BvHcpMZmj6X8npFc4TACB
 O3hRiP/BZAOzbeXSDI0so4cZnCheqIKL+Ua/oboy06EprUrstda+aRmeKC/ZIt5rOr45
 fApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HXMYVlTVWGlBh4GEhEx9d/lDpyqjrN+hUgS0cGnh4h8=;
 b=KTUYHx/gNbp2wgQ8wtaZXyqQ761h6s87BhJyBoEBHtNiWhJ/oaaUbYIbAWfNn/1/B/
 5yKMrn4iP7WINjeKOb/9+sI4w6BO9CfmWjqewAMxhODKwJwUXHm6IZGhGG16X1MhZLVq
 T1lHcjmdsFirAe5d9INvDIus+VDSt3bo0GaeCPRvwumSuWq3LGfFX0XuaRXvFmpyXG0E
 n1xfi9XaQT8A9bUluOP0FGB4mN4/1sHtcJ//HCCA1Itjm80LxSNvzQuRinda3GS7CxWI
 ZmhY00IGJ4ljYVatWLx+QNwR5uAv+394L84Hyv6YrOaeXsXkRyeGOdsFUJGIUB0tFISH
 2P4g==
X-Gm-Message-State: APjAAAVptxGVjsDDF2N2ONiWKVKGtfWhRvmlNvfr2XOGhdv1DvgDN5o9
 pInAFrhfJ1yQe1ZKIqWGRWi/SQ==
X-Google-Smtp-Source: APXvYqw4n/5mQOlAoRdNZrDgOkllY6PukBsavKBaDHFEGwA5H96kvAaI3fsCKZQAuoJFaw8+r80/uA==
X-Received: by 2002:a05:600c:2318:: with SMTP id
 24mr34733575wmo.21.1575390109859; 
 Tue, 03 Dec 2019 08:21:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s65sm3558992wmf.48.2019.12.03.08.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 08:21:48 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 703F01FF87;
 Tue,  3 Dec 2019 16:21:47 +0000 (GMT)
References: <20191115180829.10275-1-wainersm@redhat.com>
 <20191115180829.10275-2-wainersm@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 1/4] python/qemu: Move kvm_available() to its own module
In-reply-to: <20191115180829.10275-2-wainersm@redhat.com>
Date: Tue, 03 Dec 2019 16:21:47 +0000
Message-ID: <87zhg99y78.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, ehabkost@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, crosa@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wainer dos Santos Moschetta <wainersm@redhat.com> writes:

> This creates the 'accel' Python module to be the home for
> utilities that deal with accelerators. Also moved kvm_available()
> from __init__.py to this new module.
>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  python/qemu/__init__.py | 20 +-------------------
>  python/qemu/accel.py    | 36 ++++++++++++++++++++++++++++++++++++
>  tests/vm/basevm.py      |  2 +-
>  3 files changed, 38 insertions(+), 20 deletions(-)
>  create mode 100644 python/qemu/accel.py
>
> diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
> index 6c919a3d56..eff17a306e 100644
> --- a/python/qemu/__init__.py
> +++ b/python/qemu/__init__.py
> @@ -12,24 +12,6 @@
>  # Based on qmp.py.
>  #
>=20=20
> -import logging
> -import os
> -
>  from . import qmp
>  from . import machine
> -
> -LOG =3D logging.getLogger(__name__)
> -
> -# Mapping host architecture to any additional architectures it can
> -# support which often includes its 32 bit cousin.
> -ADDITIONAL_ARCHES =3D {
> -    "x86_64" : "i386",
> -    "aarch64" : "armhf"
> -}
> -
> -def kvm_available(target_arch=3DNone):
> -    host_arch =3D os.uname()[4]
> -    if target_arch and target_arch !=3D host_arch:
> -        if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
> -            return False
> -    return os.access("/dev/kvm", os.R_OK | os.W_OK)
> +from . import accel
> diff --git a/python/qemu/accel.py b/python/qemu/accel.py
> new file mode 100644
> index 0000000000..1b825126c5
> --- /dev/null
> +++ b/python/qemu/accel.py
> @@ -0,0 +1,36 @@
> +"""
> +QEMU accel module:
> +
> +This module provides utilities for discover and check the availability of
> +accelerators.
> +"""
> +# Copyright (C) 2015-2016 Red Hat Inc.
> +# Copyright (C) 2012 IBM Corp.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  See
> +# the COPYING file in the top-level directory.
> +#
> +# Based on qmp.py.

Don't think you need this - it's very much not based on qmp.py (also
quite small).

> +#
> +
> +import logging
> +import os
> +
> +LOG =3D logging.getLogger(__name__)

I don't think we use logging at all so you can drop the import and LOG
lines.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +
> +# Mapping host architecture to any additional architectures it can
> +# support which often includes its 32 bit cousin.
> +ADDITIONAL_ARCHES =3D {
> +    "x86_64" : "i386",
> +    "aarch64" : "armhf"
> +}
> +
> +def kvm_available(target_arch=3DNone):
> +    host_arch =3D os.uname()[4]
> +    if target_arch and target_arch !=3D host_arch:
> +        if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
> +            return False
> +    return os.access("/dev/kvm", os.R_OK | os.W_OK)
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 91a9226026..3e2b69c96c 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -21,7 +21,7 @@ import logging
>  import time
>  import datetime
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
> -from qemu import kvm_available
> +from qemu.accel import kvm_available
>  from qemu.machine import QEMUMachine
>  import subprocess
>  import hashlib


--=20
Alex Benn=C3=A9e


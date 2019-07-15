Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA994C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8817620665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHATq9eI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8817620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyqM-0007Ui-QB
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45635)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hmyq9-00070W-QD
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hmyq7-0006MZ-HI
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:08:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hmyq7-0006IH-73
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:08:15 -0400
Received: by mail-wr1-x441.google.com with SMTP id r1so16593453wrl.7
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 04:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=5pk3JRfO7hC2NdVIrw5XnpJc9vUbT01sn/ySJoxHsV4=;
 b=jHATq9eIy8eQAj20MBvG8SkU9VYwwfOd7go0rAhZ2LkoT4s6czK0IuPjUNRkKuXARx
 7Fwis9LiMrJlX0hQu5CfryXYTO8/HDVZJN8O7+OjZA33QCNcLSYE7u+/yDelDDBlg/Wj
 HMJvUr7GI46zBAr9fn+QBoJKDZs1CZdMKVvGw0TkGfXhbN88zW/NAwRW8k0ZANOxQYrB
 KJG24Iu/3hFLfr2yv9HTWolMwujgDMYGFnvWW6mRWurH0+oCXeDdBLi7+tWQMSYypSoI
 kTmAxhb7FDdzFHvhf/Q32DYu+Ft+P04P5QK2nWksvi/mCWoGdiKBYZFrdY1nkp5ERRiv
 eagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=5pk3JRfO7hC2NdVIrw5XnpJc9vUbT01sn/ySJoxHsV4=;
 b=dntCmZNWpkahqvVekk9vDWQejrzEdP0mg6TEBGV21O497aaAL1be/Af/bKOEi0Vjjy
 F6x2UqjnQoe7eEfX0eNxUsbu9cNlCKrC1HJnGSkXotDxYfHKqLBg8A4aBvx/XLcO5r5F
 zWUjOpJbUqKlts0L/0P9wvEb6OSgrrQgkqsDc+z67e2aGDtGG1afLi5Epo9PVxSiSSNT
 8GaZZbym6e5BId9z2aipb0kyjScmUjk0sQvLwy5BAv+0vLnY5tiR+pOng0WBqUdFy0o2
 cicmLkTak1aHw7aehW5wU73ziri5sNNxV6G2aj0ybLcISGXN9+IuILGzzy1oTAPNtFFH
 Tyxg==
X-Gm-Message-State: APjAAAVhsf4ElhurKWJuTaEHcpM6llZCO99b6tqr4BLu0a8Ga4r+jW0V
 52I4+S2jGTKSaeiD8kOrhFsJZw==
X-Google-Smtp-Source: APXvYqw9mq+jN36XHGCc3yIBFQmBvJTxGsZLoAZVNOf5TFJnEj3IU87NXsEKjgdzRye+06f605PJPw==
X-Received: by 2002:adf:e941:: with SMTP id m1mr19284072wrn.279.1563188892187; 
 Mon, 15 Jul 2019 04:08:12 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o7sm14162617wmc.36.2019.07.15.04.08.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 04:08:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3C9681FF87;
 Mon, 15 Jul 2019 12:08:11 +0100 (BST)
References: <20190712111849.9006-1-alex.bennee@linaro.org>
 <20190712111849.9006-2-alex.bennee@linaro.org>
 <189b17fc-fdba-5ccc-d018-6fbd27c6babd@redhat.com>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <189b17fc-fdba-5ccc-d018-6fbd27c6babd@redhat.com>
Date: Mon, 15 Jul 2019 12:08:11 +0100
Message-ID: <87o91vv9lw.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 1/7] tests/docker: add test-misc for
 building tools & docs
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
Cc: Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/12/19 1:18 PM, Alex Benn=C3=A9e wrote:
>> Add yet another test type so we cna quickly exercise the miscellaneous
>
> "cna" -> "can"
>
>> build products of the build system under various docer configurations.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/docker/test-misc | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100755 tests/docker/test-misc
>>
>> diff --git a/tests/docker/test-misc b/tests/docker/test-misc
>> new file mode 100755
>> index 00000000000..d480afedca7
>> --- /dev/null
>> +++ b/tests/docker/test-misc
>> @@ -0,0 +1,22 @@
>> +#!/bin/bash -e
>> +#
>> +# Build the miscellaneous components
>> +#
>> +# Copyright (c) 2019 Linaro Ltd.
>> +#
>> +# Authors:
>> +#  Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>> +# See the COPYING file in the top-level directory.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +. common.rc
>> +
>> +cd "$BUILD_DIR"
>> +
>> +# build everything else but QEMU
>> +configure_qemu --disable-user --disable-system --enable-docs --enable-t=
ools
>> +build_qemu
>> +install_qemu
>>
>
> I got:
>
> $ make docker-test-misc@debian-win32-cross
>   BUILD   debian9
>   GEN
> /home/phil/source/qemu/docker-src.2019-07-13-17.03.48.3829/qemu.tar
>   BUILD   debian9-mxe
> usage: git archive [<options>] <tree-ish> [<path>...]
>    or: git archive --list
>    or: git archive --remote <repo> [--exec <cmd>] [<options>] <tree-ish>
> [<path>...]
>    or: git archive --remote <repo> [--exec <cmd>] --list
>
>     --format <fmt>        archive format
>     --prefix <prefix>     prepend prefix to each pathname in the archive
>     -o, --output <file>   write the archive to this file
>     --worktree-attributes
>                           read .gitattributes in working directory
>     -v, --verbose         report archived files on stderr
>     -0                    store only
>     -1                    compress faster
>     -9                    compress better
>
>     -l, --list            list supported archive formats
>
>     --remote <repo>       retrieve the archive from remote repository <re=
po>
>     --exec <command>      path to the remote git-upload-archive command
>
> failed to archive qemu
> make[1]: *** [tests/docker/Makefile.include:31:
> qemu/docker-src.2019-07-13-17.03.48.3829] Error 1

Hmm I haven't been able to get this... does it depend on having
uncommited changes in a subproject?

>
> And remembered some script/archive patch on the list:
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg02073.html

I'll look at snarfing that.

>
> With it amended this works correctly, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


--
Alex Benn=C3=A9e


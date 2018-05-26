Received: from eggs.gnu.org ([2001:4830:134:3::10]:46438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMbt9-0003OB-8l
	for qemu-devel@nongnu.org; Sat, 26 May 2018 12:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMbt8-0001Xq-C5
	for qemu-devel@nongnu.org; Sat, 26 May 2018 12:17:51 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:40684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMbt8-0001XN-4a
	for qemu-devel@nongnu.org; Sat, 26 May 2018 12:17:50 -0400
Received: by mail-pl0-x243.google.com with SMTP id t12-v6so4829953plo.7
	for <qemu-devel@nongnu.org>; Sat, 26 May 2018 09:17:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-OfPdAY-DrM6G4xU1nh8FVSL5mO+nCppswi5U3RpUGdQ@mail.gmail.com>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<b8019eac434b2e61813a2061090d85401c6c44c4.1527310210.git.keno@alumni.harvard.edu>
	<ee73c66b-2a36-ffbc-ba2e-9b01386a54d0@amsat.org>
	<CAFEAcA-OfPdAY-DrM6G4xU1nh8FVSL5mO+nCppswi5U3RpUGdQ@mail.gmail.com>
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat, 26 May 2018 12:17:08 -0400
Message-ID: <CABV8kRxUZDgde1LO0VTG00v2Q_cD8g27VMCO+Sj3e=9n1JkFSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/13] 9p: linux: Fix a couple Linux
 assumptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>, Greg Kurz <groug@kaod.org>

>>> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
>>> index 3fa062b..a13e729 100644
>>> --- a/fsdev/file-op-9p.h
>>> +++ b/fsdev/file-op-9p.h
>>> @@ -16,7 +16,9 @@
>>>
>>>  #include <dirent.h>
>>>  #include <utime.h>
>>> +#ifdef CONFIG_LINUX
>>
>> What about a less restrictive:
>>
>> #ifndef __APPLE__
>
> In general I would recommend checking for specific
> features (usually in configure), rather than adding
> ifdef tests for particular OSes. In this case presumably
> we're including these headers because we're after
> a specific function or define or whatever, so we can
> check in configure for what header that's in (or
> if it's not available at all).
>
> thanks
> -- PMM

This header is used for struct statfs. I would be fine
with a configure check for this, though it looks like
other places in the code base that use this header
(e.g. util/mmap-alloc.c) also guard it in
CONFIG_LINUX, so that seemed like the right check
to me given the current code base.

Would you like me to submit a patch to switch these
to a configure check?

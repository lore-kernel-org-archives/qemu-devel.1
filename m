Received: from eggs.gnu.org ([2001:4830:134:3::10]:60261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN1tS-0005hm-RZ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN1tN-0000B7-V0
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:31:38 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eN1tN-0000Aq-No
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:31:33 -0500
Received: by mail-pf0-x243.google.com with SMTP id u19so5406557pfa.12
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 11:31:33 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171205044844.3597-1-richard.henderson@linaro.org>
	<CAFEAcA-i7pFPwdTvW=4VeRXfJC6hYD=PY6J-Z9XZcWmAk7hwiw@mail.gmail.com>
	<659ad21b-5c17-a194-6104-fe4f50e58009@twiddle.net>
	<803c99d5-a4bc-4888-f20d-6840e7a75254@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <14cf323d-01c4-0875-99af-842ec5110f1c@twiddle.net>
Date: Thu, 7 Dec 2017 11:31:28 -0800
MIME-Version: 1.0
In-Reply-To: <803c99d5-a4bc-4888-f20d-6840e7a75254@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Use *at functions instead
 of caching interp_prefix contents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12/07/2017 09:06 AM, Eric Blake wrote:
>> It's an IF with a /* fallthru */, so there are very few
>> less ugly ways to write it...
> 
> Maybe:
> 
> while (1) {
>     if (interp_dirfd > 0 && filename[0] == '/') {
>         fd = openat(interp_dirfd, filename + 1, O_RDONLY);
>         if (fd >= 0 || errno != ENOENT) {
>             break;
>         }
>     }
>     fd = open(filename, O_RDONLY);
>     break;
> }

Nice.  I'd been pondering

    if (interp_dirfd < 0
        || filename[0] != '/'
        || (fd = openat(interp_dirfd, filename + 1, O_RDONLY),
            fd < 0 && errno == ENOENT)) {
        fd = open(filename, O_RDONLY);
    }


r~

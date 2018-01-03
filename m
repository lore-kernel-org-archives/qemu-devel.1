Received: from eggs.gnu.org ([2001:4830:134:3::10]:33682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWsPP-00080r-TR
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWsPM-0004BC-Lv
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:25:19 -0500
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:40202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWsPM-0004AS-Er
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:25:16 -0500
Received: by mail-pl0-x230.google.com with SMTP id 62so2145824pld.7
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 15:25:16 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-6-git-send-email-mjc@sifive.com>
	<7b4c9965-d0c4-1b10-aa6d-553a3923d598@linaro.org>
	<CAHNT7NsOYOiK1gJ68GfRW+WDM5OF0JEk_YX+dMzYo25s3gno-Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <510622d0-649f-4187-90db-7222da892fc4@linaro.org>
Date: Wed, 3 Jan 2018 15:25:12 -0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7NsOYOiK1gJ68GfRW+WDM5OF0JEk_YX+dMzYo25s3gno-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/21] RISC-V CPU Helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 01/03/2018 02:59 PM, Michael Clark wrote:
> I see exit(1) called in quite a few of the other ports too. I was wondering at
> the time if there is a canonical error_abort API?

Yes, but they're wrong too.  Lots of that is old code in less maintained targets.

The only time errors should exit are when parsing options for startup.  Even
then new code should use qapi/error.h, propagating the error back to generic
code.  (This is where your canonical error_abort API is located.)

Once running, guest errors should continue as best as we can.  Either ignoring
the action or raising an exception are usually the right thing.  The guest --
and even more importantly a guest running without supervisor -- should not be
able to force the hypervisor to shutdown.

Asserting for logic errors that are fully within the hypervisor are permitted.
It should be taken as written that any such assertion actually triggering is a
bug to be fixed.

We prefer g_assert_not_reached() over assert(false) or abort() for protecting
code paths that should not be reachable.  I do not use the other g_assert*
functions myself, though other parts of qemu do.


r~

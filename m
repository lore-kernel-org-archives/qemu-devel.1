Received: from eggs.gnu.org ([2001:4830:134:3::10]:59876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f44e4-0005QD-11
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f44e3-00070N-4S
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:09:39 -0400
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:39928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f44e2-000704-VT
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:09:39 -0400
Received: by mail-yb0-x244.google.com with SMTP id g197-v6so6537162ybf.6
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 06:09:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a8f34bc8-fb07-94d2-c906-e17ee2b4595c@vivier.eu>
References: <20180405014135.3235-1-jcmvbkbc@gmail.com>
	<a8f34bc8-fb07-94d2-c906-e17ee2b4595c@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 5 Apr 2018 06:09:37 -0700
Message-ID: <CAMo8BfLL4B+mJLJfc0g9J=H52tAK4uETiJAuPnLhenRFs2sbfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

On Thu, Apr 5, 2018 at 2:03 AM, Laurent Vivier <laurent@vivier.eu> wrote:
> Did you try to use the regpairs_aligned() and target_offset64()
> functions as it is done for pread64(), pwrite64(), fadvise64(),... ?

My understanding is that if the syscalls had single parameter that took
two registers then it'd be a place to use regpairs_aligned. By the syscalls
are defined as follows:

SYSCALL_DEFINE5(preadv, unsigned long, fd, const struct iovec __user *, vec,
                unsigned long, vlen, unsigned long, pos_l, unsigned long, pos_h)

SYSCALL_DEFINE5(pwritev, unsigned long, fd, const struct iovec __user *, vec,
                unsigned long, vlen, unsigned long, pos_l, unsigned long, pos_h)

so these are normal unsigned long arguments, low part, then the high part.
target_offset64 treats arguments differently depending on the target
endianness, which is not needed for preadv/pwritev.

-- 
Thanks.
-- Max

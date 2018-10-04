Received: from eggs.gnu.org ([2001:4830:134:3::10]:43098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g8A1d-00044F-2Q
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g8A1Z-0006uQ-G1
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:15:08 -0400
Received: from mail-yw1-xc29.google.com ([2607:f8b0:4864:20::c29]:37845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1g8A1Z-0006tU-7k
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:15:05 -0400
Received: by mail-yw1-xc29.google.com with SMTP id y14-v6so4319939ywa.4
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 13:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181004010505.26184-1-jcmvbkbc@gmail.com>
In-Reply-To: <20181004010505.26184-1-jcmvbkbc@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 4 Oct 2018 13:14:45 -0700
Message-ID: <CAMo8BfJ==eV4g7L3nSuYa=o2RNw98nUg_0VJeBD6V8Q54m0wkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] target/xtensa: rework zero overhead loops
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>

On Wed, Oct 3, 2018 at 6:05 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Don't invalidate TB with the end of zero overhead loop when LBEG or LEND
> change. Instead encode the distance from the TB start to the LEND in the
> TB flags and generate loopback code when offset of the next PC from the
> TB start equals that distance. Distance not greater than the maximal
> instruction length is encoded literally, greater distances are capped at
> the target page size and encoded as the maximal instruction length plus
> the greatest power of 2 that is not bigger than the distance.
>
> Although this change adds dynamic TB search at the end of each zero
> overhead loop the resulting emulation speed is about 10% higher in
> uClibc-ng and LTP tests.

I thought about it some more and it looks like this is not going to work
in general case in the presence of TB linking: a block with a big (and thus
not precise) LEND distance may be linked to a block with a small (and
thus precise) LEND distance. Then LEND may change so that next time
it still goes to the first TB. In that case it shouldn't go from the first TB
to the second, but with this scheme it will.

-- 
Thanks.
-- Max

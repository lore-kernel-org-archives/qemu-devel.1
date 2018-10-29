Received: from eggs.gnu.org ([2001:4830:134:3::10]:34672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH6Jg-0004It-80
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH6Jf-000892-Eh
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:06:44 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:38569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH6Jf-0007ur-1b
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:06:43 -0400
Received: by mail-ot1-x32b.google.com with SMTP id f24so1520237otl.5
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 05:06:32 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 12:06:10 +0000
Message-ID: <CAFEAcA-=Wqxp1GOtBOZpck9J-LUgDhthP5u9PQuT-2fGdz9mwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] a64 simd decode in handle_vec_simd_shli()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hi; Coverity is complaining (in CID 1396476) about a problem in the
handle_vec_simd_shli() function, where we might dereference sli_op[]
with a size that's greater than 3. It thinks size might be > 3 because
we do a check
     if (size > 3 && !is_q) {
         unallocated_encoding(s);
         return;
     }
suggesting that we could have is_q and size > 3.

I'm having difficulty figuring out where this check has come from;
it doesn't seem to match up with the pseudocode and in any case
I don't think size can ever be > 3. We calculate:

    int size = 32 - clz32(immh) - 1;
where immh is a 4 bit field which we know cannot be all-zeroes.
So the clz32() return must be in {28,29,30,31} and the resulting
size is in {0,1,2,3}, so the check above can't ever fire.

Am I missing something? As far as I can see we should simply delete
the can't-happen condition, which will probably satisfy coverity.

thanks
-- PMM

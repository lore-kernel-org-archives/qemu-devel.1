Received: from eggs.gnu.org ([2001:4830:134:3::10]:46609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY5nR-0006Ne-NW
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY5nN-00038d-3T
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:22:53 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:34633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dY5nM-000386-Ua
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:22:49 -0400
Received: by mail-qt0-x232.google.com with SMTP id 32so15573093qtv.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 00:22:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-13-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7ef7e019-cbb7-1147-b5ae-56410f803bed@twiddle.net>
Date: Wed, 19 Jul 2017 21:22:41 -1000
MIME-Version: 1.0
In-Reply-To: <1500520169-23367-13-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/43] tcg: convert tb->cflags reads to
 tb_cflags(tb)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/19/2017 05:08 PM, Emilio G. Cota wrote:
> Convert all existing readers of tb->cflags to tb_cflags, so that we
> use atomic_read and therefore avoid undefined behaviour in C11.
> 
> Note that the remaining setters/getters of the field are protected
> by tb_lock, and therefore do not need conversion.
> 
> Luckily all readers access the field via 'tb->cflags' (so no foo.cflags,
> bar->cflags in the code base), which makes the conversion easily
> scriptable:
> FILES=$(git grep 'tb->cflags' target include/exec/gen-icount.h | \
> 	cut -f 1 -d':' | sort | uniq)
> perl -pi -e 's/([^>])tb->cflags/$1tb_cflags(tb)/g' $FILES
> perl -pi -e 's/([a-z]*)->tb->cflags/tb_cflags($1->tb)/g' $FILES
> 
> Then manually fixed the few errors that checkpatch reported.
> 
> Compile-tested for all targets.
> 
> Suggested-by: Richard Henderson<rth@twiddle.net>
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

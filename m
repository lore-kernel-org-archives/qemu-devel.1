Received: from eggs.gnu.org ([2001:4830:134:3::10]:52969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIYI-0005l7-1K
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIYG-00080Y-Mb
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:11:34 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:35678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUIYG-00080N-GY
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:11:32 -0400
Received: by mail-pf0-x22b.google.com with SMTP id c73so39625607pfk.2
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:11:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-10-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cb152594-248b-85fb-180a-fb83eecf4998@twiddle.net>
Date: Sun, 9 Jul 2017 10:11:21 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-10-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/22] exec-all: shrink tb->invalid to
 uint8_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> To avoid wasting a byte. I don't have any use in mind for this byte,
> but I think it's good to leave this byte explicitly free for future use.
> See this discussion for how the u16 came to be:
>    https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04564.html
> We could use a bool but in some systems that would take > 1 byte.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   include/exec/exec-all.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

What I would prefer to do is generalize tb->cflags.  Those values *do* affect 
how we compile the TB, and yet we don't take them into account.  So I think it 
would be a good idea to feed that into the TB hash.

At present we use 18 bits of the uint32_t.  That leaves plenty of room for:

* the compile-time value of parallel_cpus, so we don't have to keep flushing 
the TBs that we create for cpu_exec_step_atomic.

* invalid, which no TB within the hashtable would have set.

* other stuff which may become relevant in the future.


r~

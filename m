Received: from eggs.gnu.org ([2001:4830:134:3::10]:59519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV5uy-0001eV-IN
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV5uu-0004YK-Lw
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:54:16 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dV5uu-0004Y4-Fw
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:54:12 -0400
Received: by mail-pf0-f172.google.com with SMTP id q86so4163636pfl.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 17:54:12 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-10-git-send-email-cota@braap.org>
	<cb152594-248b-85fb-180a-fb83eecf4998@twiddle.net>
	<20170710235751.GA16131@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <57e5db60-7008-7c60-7139-7eb426078c0d@twiddle.net>
Date: Tue, 11 Jul 2017 14:53:00 -1000
MIME-Version: 1.0
In-Reply-To: <20170710235751.GA16131@flamenco>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/10/2017 01:57 PM, Emilio G. Cota wrote:
>> What I would prefer to do is generalize tb->cflags.  Those values *do*
>> affect how we compile the TB, and yet we don't take them into account.  So I
>> think it would be a good idea to feed that into the TB hash.
> 
> I'm having trouble seeing how this could work.
> Where do we get the "current" values from the current state, i.e.
> the ones we need to generate the hash and perform comparisons?
> In particular:
> - CF_COUNT_MASK: just use CF_COUNT_MASK?
> - CF_LAST_IO: ?
> - CF_NOCACHE: always 0 I guess

All of these are set by cpu_io_recompile as needed.
They are all clear for normal TBs.

> - CF_USE/IGNORE_ICOUNT: ?
CF_IGNORE_ICOUNT probably shouldn't exist.  Probably the callers of tb_gen_code 
should simply set CF_USE_ICOUNT properly if use_icount is true, rather than 
having two flags control the same feature.

At which point CF_USE_ICOUNT should be set iff use_icount is true.

Likewise CF_PARALLEL would be set iff parallel_cpus is true, except for within 
cpu_exec_step_atomic where we would always use 0 (because that's the whole 
point of that function).


r~

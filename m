Received: from eggs.gnu.org ([2001:4830:134:3::10]:51865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d87zo-000218-0N
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d87zn-0005Sw-5S
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:28:19 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d87zm-0005Sm-W5
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:28:19 -0400
Received: by mail-qt0-x242.google.com with SMTP id r58so625109qtb.2
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 09:28:18 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170508151707.5434-1-rth@twiddle.net>
	<20170508151707.5434-2-rth@twiddle.net>
	<20170509081457.zcxvzd5spv7n4stj@aurel32.net>
	<d8108b48-619f-181f-57ef-95a831608998@twiddle.net>
	<20170509151730.o3un5fkhdlka2qz3@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e88a7109-bfdf-b62b-c487-de98e7a38eaf@twiddle.net>
Date: Tue, 9 May 2017 09:28:13 -0700
MIME-Version: 1.0
In-Reply-To: <20170509151730.o3un5fkhdlka2qz3@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] target/s390x: Implement STORE
 FACILITIES LIST EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

On 05/09/2017 08:17 AM, Aurelien Jarno wrote:
> Ok, thanks for the detailed explanations. Then I guess you should fold
> the following patch to correctly set the zArch active bit as done in
> s390_fill_feat_block:
> 
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -693,6 +693,11 @@ static unsigned do_stfle(CPUS390XState *env, uint64_t words[MAX_STFL_WORDS])
>   
>       memset(words, 0, sizeof(uint64_t) * MAX_STFL_WORDS);
>   
> +    if (test_bit(S390_FEAT_ZARCH, features)) {
> +        /* z/Architecture is always active if around */
> +        words[0] |= 1ull << 61;
> +    }

Oops, yes, good catch.

>> Which means that we cannot mask *anything* from TCG, including the useless
>> stuff like hexadecimal floating point, and still have the kernel boot.  So
>> in practice a feature mask for TCG will be not only useless but actively
>> harmful.
> 
> That's true if you want to boot an optimized kernel.

Well, yes.  But the last time I was really looking at this (2 years ago?) 
Fedora was built to use z9-109.  I guess maybe Debian is the only distribution 
that doesn't force some later cpu?

> As soon as you try to
> use a newer CPU like the z990, the DAT-enhancement facility bit is set
> in STFL, and the kernel try to use the idte instruction which is not
> emulated by QEMU.

Good to know.  Thanks,


r~

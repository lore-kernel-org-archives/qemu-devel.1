Received: from eggs.gnu.org ([2001:4830:134:3::10]:50864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d86Tn-00011l-SO
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d86Tm-00010U-Sp
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:51:11 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:32815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d86Tm-00010O-Or
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:51:10 -0400
Received: by mail-qt0-x243.google.com with SMTP id a46so254656qte.0
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 07:51:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170508151707.5434-1-rth@twiddle.net>
	<20170508151707.5434-2-rth@twiddle.net>
	<20170509081457.zcxvzd5spv7n4stj@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d8108b48-619f-181f-57ef-95a831608998@twiddle.net>
Date: Tue, 9 May 2017 07:51:07 -0700
MIME-Version: 1.0
In-Reply-To: <20170509081457.zcxvzd5spv7n4stj@aurel32.net>
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

On 05/09/2017 01:14 AM, Aurelien Jarno wrote:
>> +/* The maximum bit defined at the moment is 129.  */
>> +#define MAX_STFL_WORDS  3
> 
> Could it be computed from S390_FEAT_MAX? in gen-features.c,
> S390_FEAT_MAX / 64 + 1 is used.

No, because the features list in cpu_features_def.h bears no relation to the 
facilities bit index (as seen in the third column of s390_features structure).

> Is there a reason to not use s390_fill_feat_block here?

Yes.  I used s390_fill_feat_block in the v1 patch and changed this in response 
to review from David Hildenbrand.

Using s390_fill_feat_block isn't completely trivial.  It stores into a 
big-endian uint8_t array, which means that (for a little-endian host) we have 
to be careful how we copy that data to the guest, lest we inadvertently byte 
swap again.

Here in v2 I store into a host-endian uint64_t array, which makes the ultimate 
users of this helper more straightforward.

> Otherwise it looks fine to me. It's probably a discussion for later
> patches, but should we also implement a TCG feature mask, like for
> example on PowerPC? Currently the only allowed CPU for TCG is z900,
> which makes this code almost useless. And while QEMU implements many
> features from newer CPU, some of them are missing and we don't want
> them to appear in the feature list.

This is complicated by the fact that for a long time, the kernel checked for an 
exact match of facilities present.

 From linux 3.13 arch/s390/kernel/head.S:

# List of facilities that are required. If not all facilities are present
# the kernel will crash. Format is number of facility words with bits set,
# followed by the facility words.

#if defined(CONFIG_64BIT)
#if defined(CONFIG_MARCH_ZEC12)
         .long 3, 0xc100efe3, 0xf46ce800, 0x00400000
#elif defined(CONFIG_MARCH_Z196)
         .long 2, 0xc100efe3, 0xf46c0000
#elif defined(CONFIG_MARCH_Z10)
         .long 2, 0xc100efe3, 0xf0680000
#elif defined(CONFIG_MARCH_Z9_109)
         .long 1, 0xc100efc3
#elif defined(CONFIG_MARCH_Z990)
         .long 1, 0xc0002000
#elif defined(CONFIG_MARCH_Z900)
         .long 1, 0xc0000000
#endif

I'm pleased to see this appears to have been dropped at some point; I cannot 
see it present in linux 4.11.  However, this still applies to the kernels 
supplied by the shipping distributions.

Which means that we cannot mask *anything* from TCG, including the useless 
stuff like hexadecimal floating point, and still have the kernel boot.  So in 
practice a feature mask for TCG will be not only useless but actively harmful.


r~

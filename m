Received: from eggs.gnu.org ([2001:4830:134:3::10]:39555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMVF-0005o3-5y
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMVE-00064u-8g
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:10:33 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEMVE-00064o-3v
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:10:32 -0400
Received: by mail-qk0-x241.google.com with SMTP id k74so2644449qke.2
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:10:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170524220827.21154-1-rth@twiddle.net>
	<20170524220827.21154-5-rth@twiddle.net>
	<20170525231259.nkzs2rdmscufnezw@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b72177b3-fbba-a82c-3ea2-2a3a808026f3@twiddle.net>
Date: Fri, 26 May 2017 14:10:28 -0700
MIME-Version: 1.0
In-Reply-To: <20170525231259.nkzs2rdmscufnezw@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] target/s390x: Re-implement a few
 EXECUTE target insns directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: thuth@redhat.com, qemu-devel@nongnu.org

On 05/25/2017 04:12 PM, Aurelien Jarno wrote:
> On 2017-05-24 15:08, Richard Henderson wrote:
>> While the previous patch is required for proper conformance,
>> the vast majority of target insns are MVC and XC for implementing
>> memmove and memset respectively.  The next most common are CLC,
>> TR, and SVC.
>>
>> Implementing these (and a few others for which we already have
>> an implementation) directly is faster than going through full
>> translation to a TB.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>   target/s390x/mem_helper.c | 66 ++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 51 insertions(+), 15 deletions(-)
> 
> I have mixed feelings about this patch. On one side it is correct. On
> the other side, I don't know if it really worth it. With the goto_ptr
> optimization, it can be executed quite fast once it has been translated
> once.

The thing is, I can't identify these being reused at all.  The only case for 
which that would even seem to make sense is memcpy/memset that happens to use 
the same size.  But even then doing the hashing to look up the block is more 
than the decoding required to run the helper directly.


r~

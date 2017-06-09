Received: from eggs.gnu.org ([2001:4830:134:3::10]:33282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJQ39-0004If-4W
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJQ36-0008Bh-3n
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:58:27 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:35288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJQ35-0008AO-VP
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:58:24 -0400
Received: by mail-qt0-x22d.google.com with SMTP id w1so87590705qtg.2
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 12:58:22 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170609053719.26251-1-rth@twiddle.net>
	<20170609195234.GA14509@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <18d9fd86-d190-cc2c-99dc-e304b6f71275@twiddle.net>
Date: Fri, 9 Jun 2017 12:58:17 -0700
MIME-Version: 1.0
In-Reply-To: <20170609195234.GA14509@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/7] tcg: allocate TB structs preceding
 translate
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

On 06/09/2017 12:52 PM, Emilio G. Cota wrote:
> On Thu, Jun 08, 2017 at 22:37:12 -0700, Richard Henderson wrote:
>> This is a follow-up to Emilio's patch set.
>>
>> My primary changes to Emilio's patches are to the first patch, in
>> merging the existing implementations from tcg/ppc/tcg-target.inc.c
>> into util/cacheinfo.c.
>>
>> Then I've a few follow-up patches to take advantage of the new TB
>> placement for arm platforms.  I've had a look at the asm output for
>> ppc64 and s390x, and don't see anything obvious that can be improved.
>>
>> Changes since v4:
>>    * The first patch reorganized a bit for aarch64 and ppc64.
>>      Re-tested on win32, for which there was a Werror.
>>      Incorporated feedback from Emilio re MacOS.
>>    * Fixed the short description for the tcg/arm patches.
> 
> This is shaping up quite nicely. Some minor suggestions:
> 
> Can we get these checkpatch warnings fixed ..
> 
>> === OUTPUT BEGIN ===
>> Checking PATCH 1/7: util: add cacheinfo...
>> ERROR: do not initialise globals to 0 or NULL
>> #149: FILE: util/cacheinfo.c:11:
>> +int qemu_icache_linesize = 0;
>>
>> ERROR: do not initialise globals to 0 or NULL
>> #150: FILE: util/cacheinfo.c:12:
>> +int qemu_dcache_linesize = 0;

These are bogus checkpatch warnings.  If we really want this, we should also 
use -fno-common.  But without that, there is a real difference between 
initialized and non-initialized global variables.

>>
>> ERROR: space prohibited after that '&&' (ctx:ExW)
>> #191: FILE: util/cacheinfo.c:53:
>> +            && buf[i].Cache.Level == 1) {
>>               ^

This is also bogus.  I have no idea what it's attempting to detect.

> 
> .. as well as these?
> 
>> Checking PATCH 6/7: tcg/arm: Try pc-relative addresses for movi...
>> ERROR: code indent should never use tabs
>> #54: FILE: tcg/arm/tcg-target.inc.c:446:
>> +^I}$
>>
>> ERROR: code indent should never use tabs
>> #64: FILE: tcg/arm/tcg-target.inc.c:453:
>> +^I}$

Yes, I can fix these.


r~

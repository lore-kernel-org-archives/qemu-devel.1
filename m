Received: from eggs.gnu.org ([2001:4830:134:3::10]:40428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq7qW-0007am-Ej
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq7qV-0001MN-CV
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:17:08 -0400
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-2-eblake@redhat.com>
	<222b07f8-4a41-04f5-c93c-727244e6d1e8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7ac0b1de-dada-33a9-30f1-5c5122982284@redhat.com>
Date: Wed, 15 Aug 2018 21:17:01 -0500
MIME-Version: 1.0
In-Reply-To: <222b07f8-4a41-04f5-c93c-727244e6d1e8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: Fix dd with skip= and count=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 08/15/2018 09:03 PM, Max Reitz wrote:

>> @@ -4559,19 +4559,23 @@ static int img_dd(int argc, char **argv)
>>           goto out;
>>       }
>>
>> +    /* Overflow means the specified offset is beyond input image's size */
>> +    if (dd.flags & C_SKIP && (in.offset > INT64_MAX / in.bsz ||
>> +                              size < in.bsz * in.offset)) {
>> +        size = 0;
>> +        error_report("%s: cannot skip to specified offset", in.filename);
> 
> in_pos should be initialized as well (to "size", I suppose), or my gcc
> will continue to complain. :-)
> 

Serves me right for compiling with -g instead of -O2 (gcc only does that 
warning on optimized builds, for some weird reason).  Will fix in v2.


>> +++ b/tests/qemu-iotests/160
>> @@ -44,6 +44,7 @@ _supported_os Linux
>>   TEST_SKIP_BLOCKS="1 2 30 30K"
>>
>>   for skip in $TEST_SKIP_BLOCKS; do
>> +  for count in '' 'count=1 '; do
> 
> Ah, so this is why we indent everything by four spaces!  So you can
> squeeze in three more block headers without having to re-indent
> everything.  I finally see. O:-)

I'm seriously thinking of reindenting things in this and the next patch, 
rather than my initial quick-and-dirty "squeeze it in".  'git diff -w' 
is not that hard to use, after all.

> 
> (Not sure why you put a space after the 'count=1', though, but OK)

For this line:

+    echo "== Converting the image with dd with ${count}skip=$skip =="

so that when $count is empty, the .out file doesn't end up with a double 
space.  Okay, I do have some sense of output aesthetics, even if my 
re-indentation skills are lacking ;=)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

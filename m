Received: from eggs.gnu.org ([2001:4830:134:3::10]:53916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1foYCf-0002H9-Fh
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 14:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1foYCe-0007u2-IT
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 14:01:29 -0400
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-2-lbloch@janustech.com>
	<w51600i8mqc.fsf@maestria.local.igalia.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <debbabd8-e16e-af3e-a2dc-8af6ec711b8e@janustech.com>
Date: Sat, 11 Aug 2018 21:01:06 +0300
MIME-Version: 1.0
In-Reply-To: <w51600i8mqc.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 1/9] qcow2: Options' documentation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On 8/10/18 2:50 PM, Alberto Garcia wrote:
> On Fri 10 Aug 2018 08:26:39 AM CEST, Leonid Bloch wrote:
>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>> ---
>>   docs/qcow2-cache.txt | 16 +++++++++++-----
>>   qemu-options.hx      |  9 ++++++---
>>   2 files changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
>> index 8a09a5cc5f..0f157d859a 100644
>> --- a/docs/qcow2-cache.txt
>> +++ b/docs/qcow2-cache.txt
>> @@ -97,12 +97,15 @@ need:
>>      l2_cache_size = disk_size_GB * 131072
>>      refcount_cache_size = disk_size_GB * 32768
>>   
>> -QEMU has a default L2 cache of 1MB (1048576 bytes) and a refcount
>> -cache of 256KB (262144 bytes), so using the formulas we've just seen
>> -we have
>> +With the default cluster size, to cover each 8 GB of the virtual image
>> +size, 1MB of L2 cache is needed:
>>   
>> -   1048576 / 131072 = 8 GB of virtual disk covered by that cache
>> -    262144 /  32768 = 8 GB
>> +   65536 / 8 = 8192 = 8 GB / 1 MB
> 
> Where does this 65536 / 8 come from? The line that you changed follows
> directly from the formula immediately before that paragraph:
> 
>       l2_cache_size = disk_size_GB * 131072
> 
> that is
> 
>       l2_cache_size / 131072 = disk_size_GB
>             1048576 / 131072 = 8 GB
> 
> Berto
> 

How about the following (all the relevant section reproduced below, for 
a continuous readability):

""""""""""
Choosing the right cache sizes
------------------------------
In order to choose the cache sizes we need to know how they relate to
the amount of the allocated space.

The amount of virtual disk that can be mapped by the L2 and refcount
caches (in bytes) is:

    disk_size = l2_cache_size * cluster_size / 8
    disk_size = refcount_cache_size * cluster_size * 8 / refcount_bits

With the default values for cluster_size (64KB) and refcount_bits
(16), this becomes:

    disk_size = l2_cache_size * 8192
    disk_size = refcount_cache_size * 32768

So in order to cover n GB of disk space with the default values we
need:

    l2_cache_size = disk_size_GB * 131072
    refcount_cache_size = disk_size_GB * 32768

For example, 1MB of L2 cache is needed to cover each 8 GB of the virtual
image size (given that the default cluster size is used):

    8 * 131072 = 1 MB

A default refcount cache is 4 times the cluster size, which defaults to
256 KB (262144 bytes). This is sufficient for 8 GB of image size:

    262144 / 32768 = 8 GB

""""""""""

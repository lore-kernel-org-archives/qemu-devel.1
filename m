Received: from eggs.gnu.org ([2001:4830:134:3::10]:45085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFvE-0000u3-Uk
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFvE-0000tb-1f
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:57:52 -0400
References: <20181022134807.27918-1-maozhongyi@cmss.chinamobile.com>
	<af86e5b9-6af6-0425-326f-7e1e8372883e@redhat.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <a0462394-ccd4-ce7a-9e75-ac428c5f1da1@cmss.chinamobile.com>
Date: Wed, 24 Oct 2018 17:57:40 +0800
MIME-Version: 1.0
In-Reply-To: <af86e5b9-6af6-0425-326f-7e1e8372883e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: convert `pwd` and $(pwd) to
 $PWD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com

Hi, Eric

On 10/23/18 4:21 PM, Eric Blake wrote:
> On 10/22/18 2:48 PM, Mao Zhongyi wrote:
> 
> The subject line says "what", but the commit body should say "why".  My 
> suggestion:
> 
> POSIX requires $PWD to be reliable, and we expect all shells used by 
> qemu scripts to be relatively close to POSIX.  Thus, it is smarter to 
> avoid forking the pwd executable for something that is already available 
> in the environment.
> 
> 
> 
> If it was done mechanically, it may also help to capture the command you 
> used to drive the change (sed or otherwise), to make it easier for 
> someone backporting this patch to rerun the same steps to regenerate the 
> patch for a different set of files on the backport.
> 
>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> ---
> 
>> +++ b/tests/qemu-iotests/001
>> @@ -24,7 +24,7 @@ owner=hch@lst.de
>>   seq=`basename $0`
>>   echo "QA output created by $seq"
>> -here=`pwd`
>> +here=$PWD
> 
> As this is a mechanical search-and-replace, this is fine.  However,
>   git grep '\$here' tests/qemu-iotests
> has 0 hits, which means we are setting a variable that has no use.  A 
> good followup patch would be to delete all of the 'here=...' lines as 
> dead code. Or even do that first, and then this patch second, for less 
> churn.
> 
>> +++ b/tests/qemu-iotests/check
>> @@ -80,17 +80,17 @@ _full_imgfmt_details()
>>   _full_platform_details()
>>   {
>> -    os=`uname -s`
>> -    host=`hostname -s`
>> -    kernel=`uname -r`
>> -    platform=`uname -m`
>> +    os=$(uname -s)
>> +    host=$(hostname -s)
>> +    kernel=$(uname -r)
>> +    platform=$(uname -m)
>>       echo "$os/$platform $host $kernel"
> 
> These changes are unrelated to the commit subject. Please split them 
> into a separate commit...
> 
>>   }
>>   # $1 = prog to look for
>>   set_prog_path()
>>   {
>> -    p=`command -v $1 2> /dev/null`
>> +    p=$(command -v $1 2> /dev/null)
>>       if [ -n "$p" -a -x "$p" ]; then
>>           type -p "$p"
>>       else
>> @@ -99,7 +99,7 @@ set_prog_path()
>>   }
>>   if [ -z "$TEST_DIR" ]; then
>> -        TEST_DIR=`pwd`/scratch
>> +        TEST_DIR=$PWD/scratch
>>   fi
> 
> ...This hunk is okay, but the rest of the file is not.
> 
> 
>> +++ b/tests/qemu-iotests/common.config
>> @@ -21,11 +21,11 @@ export LANG=C
>>   PATH=".:$PATH"
>> -HOSTOS=`uname -s`
>> -arch=`uname -m`
>> +HOSTOS=$(uname -s)
>> +arch=$(uname -m)
> 
> Another file with too many hunks.
> 
> Looking forward to v2.

Thank you very much for your kind reply, it's updated
in v2, please review. :)

Thanks,
mao

> 

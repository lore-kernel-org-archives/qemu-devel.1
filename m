Received: from eggs.gnu.org ([208.118.235.92]:51553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gbFlZ-0003Jx-Bm
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 21:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gbFlV-00028h-CA
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 21:14:49 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15830
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gbFlV-00021m-1L
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 21:14:45 -0500
References: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1544063533-10139-3-git-send-email-lizhijian@cn.fujitsu.com>
	<20181221111136-mutt-send-email-mst@kernel.org>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <a04239e5-8b87-6b90-f8c7-e9c893acceac@cn.fujitsu.com>
Date: Mon, 24 Dec 2018 10:14:38 +0800
MIME-Version: 1.0
In-Reply-To: <20181221111136-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 2/4] refactor load_image_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: peter.maydell@linaro.org, zhijianx.li@intel.com, philmd@redhat.com, qemu-devel@nongnu.org, philip.li@intel.com


On 12/22/18 00:12, Michael S. Tsirkin wrote:
> On Thu, Dec 06, 2018 at 10:32:11AM +0800, Li Zhijian wrote:
>> Don't expect read(2) can always read as many as it's told.
>>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> This is more a theoretical bugfix than a refactoring right?

Yes， it does.

how about change the title to : "enhance reading on load_image_size()" or such

Thanks
Zhijian


>
>> ---
>> V4: add reviewed-by tag
>> ---
>>   hw/core/loader.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index fa41842..9cbceab 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -77,21 +77,20 @@ int64_t get_image_size(const char *filename)
>>   ssize_t load_image_size(const char *filename, void *addr, size_t size)
>>   {
>>       int fd;
>> -    ssize_t actsize;
>> +    ssize_t actsize, l = 0;
>>   
>>       fd = open(filename, O_RDONLY | O_BINARY);
>>       if (fd < 0) {
>>           return -1;
>>       }
>>   
>> -    actsize = read(fd, addr, size);
>> -    if (actsize < 0) {
>> -        close(fd);
>> -        return -1;
>> +    while ((actsize = read(fd, addr + l, size - l)) > 0) {
>> +        l += actsize;
>>       }
>> +
>>       close(fd);
>>   
>> -    return actsize;
>> +    return actsize < 0 ? -1 : l;
>>   }
>>   
>>   /* read()-like version */
>> -- 
>> 2.7.4
>
>
>
-- 
Best regards.
Li Zhijian (8528)

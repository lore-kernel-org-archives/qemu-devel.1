Received: from eggs.gnu.org ([209.51.188.92]:41115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hEI5S-0008OQ-GB
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hEI5R-0001Vg-LN
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:36:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1hEI5R-0001Ul-A5
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:36:41 -0400
References: <f61645d0b3720a039423532d49dd65588d9bccd8.1554919328.git.crobinso@redhat.com>
	<4aee66fd-1cfa-a935-daa6-6f221af42095@redhat.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <4ee1fc10-b718-7100-8e38-f6afe5fdbe9a@redhat.com>
Date: Wed, 10 Apr 2019 14:36:37 -0400
MIME-Version: 1.0
In-Reply-To: <4aee66fd-1cfa-a935-daa6-6f221af42095@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0?] hmp: delvm: use hmp_handle_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, Peter Maydell <peter.maydell@linaro.org>

On 4/10/19 2:27 PM, Eric Blake wrote:
> On 4/10/19 1:03 PM, Cole Robinson wrote:
>> This gives us the consistent 'Error:' prefix added in 66363e9a43f,
>> which helps users like libvirt who still need to scrape hmp error
>> messages to detect failure.
>>
>> Signed-off-by: Cole Robinson <crobinso@redhat.com>
>> ---
>>  hmp.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Not enough to drive -rc4 on its own, but worth adding to our wishlist of
> potential easy patches if we do have a release blocker surface.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
>>
>> diff --git a/hmp.c b/hmp.c
>> index 8eec768088..74a4bfc1f9 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -1481,10 +1481,11 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
>>      const char *name = qdict_get_str(qdict, "name");
>>  
>>      if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
>> -        error_reportf_err(err,
>> -                          "Error while deleting snapshot on device '%s': ",
>> -                          bdrv_get_device_name(bs));
>> +        error_prepend(&err,
>> +                      "Error while deleting snapshot on device '%s': ",
> 
> Do we want to reword the message (maybe s/Error while //) to avoid the
> word "Error" twice in the same line?
> 

I'm fine with that, and I checked it won't affect libvirt's error
scraping in this area

Thanks,
Cole

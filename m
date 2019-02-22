Received: from eggs.gnu.org ([209.51.188.92]:42589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gwyZz-0006Qa-8m
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gwyZv-0000qU-9O
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:20:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gwyZk-0007yg-NQ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:20:27 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x1M03bfq096143
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 00:17:50 GMT
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp2130.oracle.com with ESMTP id 2qp81ekqf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 00:17:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1M0HnKc024239
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 00:17:49 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1M0HnEt028283
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 00:17:49 GMT
References: <20190220111346.13669-1-kraxel@redhat.com>
	<20190220111346.13669-9-kraxel@redhat.com> <20190220112421.GA5632@lap1>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <8fcb50bc-4266-45ce-a0aa-9bef838d27a5@oracle.com>
Date: Fri, 22 Feb 2019 00:17:39 +0000
MIME-Version: 1.0
In-Reply-To: <20190220112421.GA5632@lap1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 8/9] usb: add device checks before
 redirector calls to usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 20/02/2019 11:24, Yuval Shaia wrote:
> On Wed, Feb 20, 2019 at 12:13:45PM +0100, Gerd Hoffmann wrote:
>> From: Liam Merwick <liam.merwick@oracle.com>
>>
>> Add an assert and an explicit check before the two callers to
>> usb_ep_get() in the USB redirector code to ensure the device
>> passed in is not NULL.
>>
>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>> Message-id: 1549460216-25808-9-git-send-email-liam.merwick@oracle.com
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>   hw/usb/redirect.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
>> index 18a42d1938..7cb6b120d4 100644
>> --- a/hw/usb/redirect.c
>> +++ b/hw/usb/redirect.c
>> @@ -1728,6 +1728,7 @@ static void usbredir_ep_info(void *priv,
>>       USBRedirDevice *dev = priv;
>>       int i;
>>   
>> +    assert(dev != NULL);
> 
> Suggesting:
>      assert(dev)
> 
>>       for (i = 0; i < MAX_ENDPOINTS; i++) {
>>           dev->endpoint[i].type = ep_info->type[i];
>>           dev->endpoint[i].interval = ep_info->interval[i];
>> @@ -2125,7 +2126,7 @@ static int usbredir_post_load(void *priv, int version_id)
>>   {
>>       USBRedirDevice *dev = priv;
>>   
>> -    if (dev->parser == NULL) {
>> +    if (dev == NULL || dev->parser == NULL) {
> 
> Suggesting
>      if (!dev || !dev->parser)
> 

The rest of the file tests for '== NULL' so I used that for consistency 
(but in any case, my personal preferences is to just use that boolean 
style check with boolean variables).  As it happens, the commits have 
already been pulled.

Regards,
Liam

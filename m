Received: from eggs.gnu.org ([209.51.188.92]:59203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmNId-0006Zw-HH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmNIc-0007EK-MJ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:30:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmNIc-0007D9-G7
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:30:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so440197wmj.1
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 10:30:54 -0800 (PST)
References: <20190122173111.29821-1-dgilbert@redhat.com>
	<20190123114448.GB5771@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c3a45ef7-745c-5fc1-62a8-0e9060d5983e@redhat.com>
Date: Wed, 23 Jan 2019 19:30:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190123114448.GB5771@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: unegister fd handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, jemmy858585@gmail.com, quintela@redhat.com, peterx@redhat.com

On 1/23/19 12:44 PM, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> Unregister the fd handler before we destroy the channel,
>> otherwise we've got a race where we might land in the
>> fd handler just as we're closing the device.
>>
>> (The race is quite data dependent, you just have to have
>> the right set of devices for it to trigger).
>>
>> Corresponds to RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=1666601
>>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Queued

Did you fixed the patch subject typo? "un(r)egister"

>> ---
>>  migration/rdma.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 9b2e7e10aa..54a3c11540 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -2321,6 +2321,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
>>          rdma->connected = false;
>>      }
>>  
>> +    qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
>>      g_free(rdma->dest_blocks);
>>      rdma->dest_blocks = NULL;
>>  
>> -- 
>> 2.20.1
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

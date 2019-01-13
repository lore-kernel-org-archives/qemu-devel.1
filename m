Received: from eggs.gnu.org ([209.51.188.92]:51927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1giYSx-0005mF-JM
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 00:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1giYSw-00066K-Pd
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 00:37:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1giYSw-00065W-KF
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 00:37:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 821BFC0C49E1
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 05:37:44 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
References: <20190111082043.31412-1-bsd@redhat.com>
	<20190111082043.31412-2-bsd@redhat.com>
	<2770d0ef-fcce-e796-5038-bf92e3dfbdbf@redhat.com>
Date: Sun, 13 Jan 2019 00:37:40 -0500
In-Reply-To: <2770d0ef-fcce-e796-5038-bf92e3dfbdbf@redhat.com> (Eric Blake's
	message of "Fri, 11 Jan 2019 09:39:40 -0600")
Message-ID: <jpgbm4lglsr.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2 v2] usb-mtp: Reallocate buffer in
 multiples of MTP_WRITE_BUF_SZ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 1/11/19 2:20 AM, Bandan Das wrote:
>> This is a "pre-patch" to breaking up the write buffer for
>> MTP writes. Instead of allocating a mtp buffer equal to size
>> sent by the initiator, we start with a small size and reallocate
>> multiples (of that small size) as needed.
>> 
>> Signed-off-by: Bandan Das <bsd@redhat.com>
>> ---
>>  hw/usb/dev-mtp.c | 26 ++++++++++++--------------
>>  1 file changed, 12 insertions(+), 14 deletions(-)
>> 
>> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>> index b19b576278..a0d98c93ee 100644
>> --- a/hw/usb/dev-mtp.c
>> +++ b/hw/usb/dev-mtp.c
>> @@ -152,7 +152,6 @@ struct MTPData {
>>      bool         first;
>>      /* Used for >4G file sizes */
>>      bool         pending;
>> -    uint64_t     cached_length;
>>      int          fd;
>>  };
>>  
>> @@ -244,6 +243,7 @@ typedef struct {
>>  
>>  #define MTP_MANUFACTURER  "QEMU"
>>  #define MTP_PRODUCT       "QEMU filesharing"
>> +#define MTP_WRITE_BUF_SZ  512000
>
> Why not a power of two?  Perhaps use units.h and spell it (512 * KiB) ?

Sure, I will change it in a later patch.

Bandan

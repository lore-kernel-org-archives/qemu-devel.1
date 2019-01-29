Received: from eggs.gnu.org ([209.51.188.92]:58175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1goTJT-0004Iw-Kk
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1goTJP-0004PW-Ul
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:20:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1goTJO-0004KS-1t
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:20:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 576A03DE03
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 13:20:21 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
References: <20190128142410.11584-1-bsd@redhat.com>
	<20190128142410.11584-2-bsd@redhat.com>
	<6587b190-16d8-c7d7-af9c-f5f221ca79a5@redhat.com>
Date: Tue, 29 Jan 2019 08:20:20 -0500
In-Reply-To: <6587b190-16d8-c7d7-af9c-f5f221ca79a5@redhat.com> (Eric Blake's
	message of "Mon, 28 Jan 2019 10:47:41 -0600")
Message-ID: <jpgbm3zr46j.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/3] usb-mtp: Reallocate buffer in
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

> On 1/28/19 8:24 AM, Bandan Das wrote:
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
>> index 68c5eb8eaa..2f3536a26d 100644
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
> Why a non-power-of-2 instead of using units.h and writing (512 * KiB)?

Thank you for the reminder, Eric. I posted a v4.

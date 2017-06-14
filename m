Received: from eggs.gnu.org ([2001:4830:134:3::10]:32930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL3vv-00041W-FF
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL3vu-0000R2-FK
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:45:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dL3vu-0000QR-4z
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:45:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B67F4E4CA
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:45:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170613175147.GB2463@work-vm> (David Alan Gilbert's message of
	"Tue, 13 Jun 2017 18:51:48 +0100")
References: <20170613095432.11623-1-quintela@redhat.com>
	<20170613095432.11623-2-quintela@redhat.com>
	<20170613175147.GB2463@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 14 Jun 2017 10:45:42 +0200
Message-ID: <87k24fez49.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Test for disabled features
 on reception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Right now, if we receive a compressed page while this features are
>> disabled, Bad Things (TM) can happen.  Just add a test for them.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Yes, my R-b stands, there could be someone somewhere driving this by
> hand who might get caught out, but seems saner this way.
>
>> --
>> 
>> I had XBZRLE here also, but it don't need extra resources on
>> destination, only on source.  Additionally libvirt don't enable it on
>> destination, so don't put it here.
>> ---
>>  migration/ram.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index f35d65a..f2d1bce 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2477,7 +2477,7 @@ static int ram_load_postcopy(QEMUFile *f)
>>  
>>  static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>  {
>> -    int flags = 0, ret = 0;
>> +    int flags = 0, ret = 0, invalid_flags;
>>      static uint64_t seq_iter;
>>      int len = 0;
>>      /*
>> @@ -2494,6 +2494,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>          ret = -EINVAL;
>>      }
>>  
>> +    invalid_flags = 0;
>
> why didn't you use = 0 in the declaration like the rest of the flags?
> (Only minor)

Costume :-(

Changed to common style there.

Thanks, Juan.

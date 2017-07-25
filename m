Received: from eggs.gnu.org ([2001:4830:134:3::10]:53073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da1sr-0002HA-AJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da1sm-0000hQ-Bm
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:36:29 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1da1sm-0000gU-66
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:36:24 -0400
Received: by mail-wm0-f54.google.com with SMTP id t201so49394856wmt.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 08:36:22 -0700 (PDT)
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-7-f4bug@amsat.org>
	<35e2489f-9cd6-ae5e-39b6-297b6cf5d2ea@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f59b38db-f2a4-cb13-73a3-8167be3df217@redhat.com>
Date: Tue, 25 Jul 2017 17:36:19 +0200
MIME-Version: 1.0
In-Reply-To: <35e2489f-9cd6-ae5e-39b6-297b6cf5d2ea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 06/35] qcow2: remove inconsistent
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 24/07/2017 20:42, Eric Blake wrote:
> On 07/24/2017 01:27 PM, Philippe Mathieu-Daudé wrote:
>> This is equivalent to assert(russian roulette) so better remove it.
>>
>> block/qcow2-bitmap.c:259:29: warning: The left operand of '==' is a garbage value
>>         assert(bitmap_table == NULL);
>>                ~~~~~~~~~~~~ ^
>>
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  block/qcow2-bitmap.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 3e8735a20d..fe72df5057 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -254,7 +254,6 @@ static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
>>  
>>      ret = bitmap_table_load(bs, tb, &bitmap_table);
>>      if (ret < 0) {
>> -        assert(bitmap_table == NULL);
> 
> Rather, we should fix bitmap_table_load() to ensure that bitmap_table is
> always assigned, even on error.

I think it's even better to initialize bitmap_table to NULL in
free_bitmap_clusters, as all other callers do.

Paolo

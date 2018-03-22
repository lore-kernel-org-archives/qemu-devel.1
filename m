Received: from eggs.gnu.org ([2001:4830:134:3::10]:45749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1eyyqu-0002lr-Bj
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1eyyqt-00057F-GM
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:57:52 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:44025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1eyyqt-00056c-BF
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:57:51 -0400
Received: by mail-io0-x22a.google.com with SMTP id q84so5156209iod.10
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 04:57:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87sh8uzk2k.fsf@secure.mitica>
References: <1520692378-1835-1-git-send-email-lidongchen@tencent.com>
	<87sh8uzk2k.fsf@secure.mitica>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 22 Mar 2018 19:57:49 +0800
Message-ID: <CAOGPPbfgq1=K5zmALzr0gOTDcp9YsSR3+LunRDdYxcgNzaWopg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: Fix rate limiting issue on RDMA
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Dave Gilbert <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Wed, Mar 21, 2018 at 2:19 AM, Juan Quintela <quintela@redhat.com> wrote:
> Lidong Chen <jemmy858585@gmail.com> wrote:
>> RDMA migration implement save_page function for QEMUFile, but
>> ram_control_save_page do not increase bytes_xfer. So when doing
>> RDMA migration, it will use whole bandwidth.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> This part of the code is a mess.
>
> To answer David:
> - pos: Where we need to write that bit of stuff
> - bytex_xfer: how much have we written
>
> WHen we are doing snapshots on qcow2, we store memory in a contiguous
> piece of memory, so we can "overwrite" that "page" if a new verion
> cames. Nothing else (except the block) uses te "pos" parameter, so we
> can't not trust on it.
>
> And that  has been for a fast look at the code, that I got really
> confused (again).

Hi Juan:
     what is the problem?
     Thanks.

>
>
>
>> ---
>>  migration/qemu-file.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index 2ab2bf3..217609d 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -253,7 +253,7 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
>>      if (f->hooks && f->hooks->save_page) {
>>          int ret = f->hooks->save_page(f, f->opaque, block_offset,
>>                                        offset, size, bytes_sent);
>> -
>> +        f->bytes_xfer += size;
>>          if (ret != RAM_SAVE_CONTROL_DELAYED) {
>>              if (bytes_sent && *bytes_sent > 0) {
>>                  qemu_update_position(f, *bytes_sent);

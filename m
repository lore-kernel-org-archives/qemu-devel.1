Received: from eggs.gnu.org ([2001:4830:134:3::10]:48742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1ewLW4-0003AE-42
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 01:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1ewLW3-0003Id-56
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 01:33:28 -0400
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:40987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1ewLW2-0003IC-VP
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 01:33:27 -0400
Received: by mail-io0-x235.google.com with SMTP id m83so7076801ioi.8
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 22:33:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180314201929.GK3006@work-vm>
References: <1520692378-1835-1-git-send-email-lidongchen@tencent.com>
	<20180314201929.GK3006@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 15 Mar 2018 13:33:25 +0800
Message-ID: <CAOGPPbdGREwOYS+opLFLBkv4V+WLVb5YQoAcZZ5=UZVq1Zn0rw@mail.gmail.com>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Thu, Mar 15, 2018 at 4:19 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
>> RDMA migration implement save_page function for QEMUFile, but
>> ram_control_save_page do not increase bytes_xfer. So when doing
>> RDMA migration, it will use whole bandwidth.
>
> Hi,
>   Thanks for this,
>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
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
>
> I'm a bit confused, because I know rdma.c calls acct_update_position()
> and I'd always thought that was enough.
> That calls qemu_update_position(...) which increases f->pos but not
> f->bytes_xfer.
>
> f_pos is used to calculate the 'transferred' value in
> migration_update_counters and thus the current bandwidth and downtime -
> but as you say, not the rate_limit.
>
> So really, should this f->bytes_xfer += size   go in
> qemu_update_position ?

For tcp migration, bytes_xfer is updated before qemu_fflush(f) which
actually send data.
but qemu_update_position is invoked by qemu_rdma_write_one, which
after call ibv_post_send.
and qemu_rdma_save_page is asynchronous, it may merge the page.
I think it's more safe to limiting rate before send data

>
> Juan: I'm not sure I know why we have both bytes_xfer and pos.

Maybe the reasion is bytes_xfer is updated before send data,
and bytes_xfer will be reset by migration_update_counters.

>
> Dave
>
>>          if (ret != RAM_SAVE_CONTROL_DELAYED) {
>>              if (bytes_sent && *bytes_sent > 0) {
>>                  qemu_update_position(f, *bytes_sent);
>> --
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

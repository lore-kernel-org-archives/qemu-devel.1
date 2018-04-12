Received: from eggs.gnu.org ([2001:4830:134:3::10]:43566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f6Yii-0007LT-HP
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f6Yic-0003ys-EZ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:40:44 -0400
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:54700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1f6Yic-0003yU-9s
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:40:38 -0400
Received: by mail-it0-x22a.google.com with SMTP id h143-v6so6476381ita.4
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 02:40:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180411164357.GH2667@work-vm>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
	<1523089594-1422-5-git-send-email-lidongchen@tencent.com>
	<20180411164357.GH2667@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 12 Apr 2018 17:40:37 +0800
Message-ID: <CAOGPPbfVN2gz95Tsj4Vs1LzJcMbkda0_6=+sC_5g+WG8Hg3KNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/5] migration: fix qemu carsh when RDMA
 live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Thu, Apr 12, 2018 at 12:43 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
>> After postcopy, the destination qemu work in the dedicated
>> thread, so only invoke yield_until_fd_readable before postcopy
>> migration.
>
> The subject line needs to be more discriptive:
>    migration: Stop rdma yielding during incoming postcopy
>
> I think.
> (Also please check the subject spellings)
>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>>  migration/rdma.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 53773c7..81be482 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -1489,11 +1489,13 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
>>       * Coroutine doesn't start until migration_fd_process_incoming()
>>       * so don't yield unless we know we're running inside of a coroutine.
>>       */
>> -    if (rdma->migration_started_on_destination) {
>> +    if (rdma->migration_started_on_destination &&
>> +        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE) {
>
> OK, that's a bit delicate; watch if it ever gets called in a failure
> case or similar - and also wathc out if we make more use of the status
> on the destination, but otherwise, and with a fix for the subject;

How about use migration_incoming_get_current()->have_listen_thread?

    if (rdma->migration_started_on_destination &&
        migration_incoming_get_current()->have_listen_thread == false) {
        yield_until_fd_readable(rdma->comp_channel->fd);
    }

>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>>          yield_until_fd_readable(rdma->comp_channel->fd);
>>      } else {
>>          /* This is the source side, we're in a separate thread
>>           * or destination prior to migration_fd_process_incoming()
>> +         * after postcopy, the destination also in a seprate thread.
>>           * we can't yield; so we have to poll the fd.
>>           * But we need to be able to handle 'cancel' or an error
>>           * without hanging forever.
>> --
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

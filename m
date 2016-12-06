Received: from eggs.gnu.org ([2001:4830:134:3::10]:44090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.fangyi@huawei.com>) id 1cE5zm-0002bF-MD
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 22:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.fangyi@huawei.com>) id 1cE5zj-0008LV-J1
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 22:00:42 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:44366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <eric.fangyi@huawei.com>) id 1cE5zi-0008K0-MF
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 22:00:39 -0500
References: <1480895097-60463-1-git-send-email-eric.fangyi@huawei.com>
	<20161205110954.GF22443@stefanha-x1.localdomain>
From: "Fangyi (C)" <eric.fangyi@huawei.com>
Message-ID: <584629BE.6060306@huawei.com>
Date: Tue, 6 Dec 2016 11:00:14 +0800
MIME-Version: 1.0
In-Reply-To: <20161205110954.GF22443@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] nbd: Implement NBD_CMD_HAS_ZERO_INIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, xieyingtai@huawei.com, subo7@huawei.com, mreitz@redhat.com, sochin.jiang@huawei.com, pbonzini@redhat.com, wu.wubin@huawei.com

Yes, you are right. It's not necessary to use such a command. I will 
subscribe nbd-general mail-list and implement has_zero_init during 
connection.
Thank you!

在 2016/12/5 19:09, Stefan Hajnoczi 写道:
> On Sun, Dec 04, 2016 at 11:44:57PM +0000, Yi Fang wrote:
>> NBD client has not implemented callback for .bdrv_has_zero_init. So
>> bdrv_has_zero_init always returns 0 when doing non-shared storage
>> migration.
>> This patch implemented NBD_CMD_HAS_ZERO_INIT and will avoid unnecessary
>> set-dirty.
>
> Please link to the NBD spec where this new command is defined.  Has it
> already been accepted by the NBD community?
>
> I think this is a weird command because it's information that doesn't
> change over the lifetime of an NBD session.  Your patch sends a command
> and waits for the reply every time has_zero_init() is queried.
>
> Is there a better place to put this information in the NBD protocols,
> like some export information that is retried during connection?  (I
> haven't checked the protocol.)  It seems weird to send a command and
> wait for the response.
>
>> Signed-off-by: Yi Fang <eric.fangyi@huawei.com>
>> ---
>>   block/block-backend.c          |  5 +++++
>>   block/nbd-client.c             | 28 ++++++++++++++++++++++++++++
>>   block/nbd-client.h             |  1 +
>>   block/nbd.c                    |  8 ++++++++
>>   include/block/nbd.h            |  3 +++
>>   include/sysemu/block-backend.h |  1 +
>>   nbd/server.c                   | 10 +++++++++-
>>   7 files changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index efbf398..4369c85 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -1239,6 +1239,11 @@ void blk_drain_all(void)
>>       bdrv_drain_all();
>>   }
>>
>> +int blk_has_zero_init(BlockBackend *blk)
>> +{
>> +        return bdrv_has_zero_init(blk_bs(blk));
>
> Please run scripts/checkpatch.pl to check for coding style issues.
> Indentation should be 4 spaces.
>
>> +}
>> +
>>   void blk_set_on_error(BlockBackend *blk, BlockdevOnError on_read_error,
>>                         BlockdevOnError on_write_error)
>>   {
>> diff --git a/block/nbd-client.c b/block/nbd-client.c
>> index 3779c6c..8b1d98d 100644
>> --- a/block/nbd-client.c
>> +++ b/block/nbd-client.c
>> @@ -376,6 +376,34 @@ void nbd_client_attach_aio_context(BlockDriverState *bs,
>>                          false, nbd_reply_ready, NULL, bs);
>>   }
>>
>> +int nbd_client_co_has_zero_init(BlockDriverState *bs)
>
> Coroutine functions must be marked:
>
> int coroutine_fn nbd_client_co_has_zero_init()
>
>> +{
>> +    NBDClientSession *client = nbd_get_client_session(bs);
>> +    NBDRequest request = { .type = NBD_CMD_HAS_ZERO_INIT };
>> +    NBDReply reply;
>> +    ssize_t ret;
>> +
>> +    if (!(client->nbdflags & NBD_FLAG_HAS_ZERO_INIT)) {
>> +        return 0;
>> +    }
>> +
>> +    request.from = 0;
>> +    request.len = 0;
>> +
>> +    nbd_coroutine_start(client, &request);
>> +    ret = nbd_co_send_request(bs, &request, NULL);
>> +    if (ret < 0) {
>> +        reply.error = -ret;
>> +    } else {
>> +        nbd_co_receive_reply(client, &request, &reply, NULL);
>> +    }
>> +    nbd_coroutine_end(client, &request);
>> +    if (reply.error == 0) {
>> +        return 1;
>> +    }
>> +    return 0;
>> +}
>> +
>>   void nbd_client_close(BlockDriverState *bs)
>>   {
>>       NBDClientSession *client = nbd_get_client_session(bs);
>> diff --git a/block/nbd-client.h b/block/nbd-client.h
>> index f8d6006..ec01938 100644
>> --- a/block/nbd-client.h
>> +++ b/block/nbd-client.h
>> @@ -56,5 +56,6 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
>>   void nbd_client_detach_aio_context(BlockDriverState *bs);
>>   void nbd_client_attach_aio_context(BlockDriverState *bs,
>>                                      AioContext *new_context);
>> +int nbd_client_co_has_zero_init(BlockDriverState *bs);
>>
>>   #endif /* NBD_CLIENT_H */
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 35f24be..40dd9a2 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -552,6 +552,11 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
>>       bs->full_open_options = opts;
>>   }
>>
>> +static int nbd_co_has_zero_init(BlockDriverState *bs)
>> +{
>> +    return nbd_client_co_has_zero_init(bs);
>> +}
>> +
>>   static BlockDriver bdrv_nbd = {
>>       .format_name                = "nbd",
>>       .protocol_name              = "nbd",
>> @@ -569,6 +574,7 @@ static BlockDriver bdrv_nbd = {
>>       .bdrv_detach_aio_context    = nbd_detach_aio_context,
>>       .bdrv_attach_aio_context    = nbd_attach_aio_context,
>>       .bdrv_refresh_filename      = nbd_refresh_filename,
>> +    .bdrv_has_zero_init         = nbd_co_has_zero_init,
>
> .bdrv_has_zero_init() is not a coroutine_fn.  It is not okay to yield!
>
> It would be best to fetch the information during connection so that we
> don't have to send a command and wait for a reply every time
> .bdrv_has_zero_init() is called.
>

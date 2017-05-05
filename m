Received: from eggs.gnu.org ([2001:4830:134:3::10]:34664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d6bRV-000630-Oq
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d6bRR-00010s-Rz
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:30:37 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:18460 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1d6bRR-0000y7-Gg
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:30:33 -0400
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-4-vsementsov@virtuozzo.com>
	<e55d7819-db41-3077-3fe5-ecad88ab2c47@redhat.com>
	<9392b02d-e251-d3f7-dbf5-b2bce1aa7620@virtuozzo.com>
	<27047727-9208-d2f9-96f7-40829e869b54@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3f669272-c423-0466-b545-224964012c2a@virtuozzo.com>
Date: Fri, 5 May 2017 14:30:09 +0300
MIME-Version: 1.0
In-Reply-To: <27047727-9208-d2f9-96f7-40829e869b54@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/18] nbd: Minimal structured read for
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

04.05.2017 16:28, Eric Blake wrote:
> On 05/04/2017 05:58 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>>> @@ -70,6 +70,25 @@ struct NBDSimpleReply {
>>>>    };
>>>>    typedef struct NBDSimpleReply NBDSimpleReply;
>>>>    +typedef struct NBDStructuredReplyChunk {
>>>> +    uint32_t magic;
>>>> +    uint16_t flags;
>>>> +    uint16_t type;
>>>> +    uint64_t handle;
>>>> +    uint32_t length;
>>>> +} QEMU_PACKED NBDStructuredReplyChunk;
>>>> +
>>>> +typedef struct NBDStructuredRead {
>>>> +    NBDStructuredReplyChunk h;
>>>> +    uint64_t offset;
>>>> +} QEMU_PACKED NBDStructuredRead;
>>>> +
>>>> +typedef struct NBDStructuredError {
>>>> +    NBDStructuredReplyChunk h;
>>>> +    uint32_t error;
>>>> +    uint16_t message_length;
>>>> +} QEMU_PACKED NBDStructuredError;
>>> Definitely a subset of all types added in the NBD protocol extension,
>>> but reasonable for a minimal implementation.  Might be worth adding
>>> comments to the types...
>> Hmm, for me their names looks descriptive enough, but my sight may be
>> biased.. What kind of comments do you want?
> I guess I was thinking of existing structs in include/block/nbd.h:
>
> /* Handshake phase structs - this struct is passed on the wire */
>
> struct nbd_option {
>      uint64_t magic; /* NBD_OPTS_MAGIC */
>      uint32_t option; /* NBD_OPT_* */
>      uint32_t length;
> } QEMU_PACKED;
> typedef struct nbd_option nbd_option;
>
>
> and compared to:
>
> /* Transmission phase structs
>   *
>   * Note: these are _NOT_ the same as the network representation of an NBD
>   * request and reply!
>   */
> struct NBDRequest {
>      uint64_t handle;
>      uint64_t from;
>      uint32_t len;
>      uint16_t flags; /* NBD_CMD_FLAG_* */
>      uint16_t type; /* NBD_CMD_* */
> };
> typedef struct NBDRequest NBDRequest;
>
> where the comments make it obvious whether QEMU_PACKED matters because
> we are using the struct to directly map bytes read/written on the wire.
>

Ok, thank you, will add.


-- 
Best regards,
Vladimir

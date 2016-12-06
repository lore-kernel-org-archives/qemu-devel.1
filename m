Received: from eggs.gnu.org ([2001:4830:134:3::10]:46219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.fangyi@huawei.com>) id 1cE6AY-0004kg-Cd
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 22:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.fangyi@huawei.com>) id 1cE6AV-0003Eh-6J
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 22:11:50 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:59978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <eric.fangyi@huawei.com>) id 1cE6AU-0003CW-Do
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 22:11:47 -0500
References: <1480895097-60463-1-git-send-email-eric.fangyi@huawei.com>
	<20161205110954.GF22443@stefanha-x1.localdomain>
	<7c2e5e96-69e4-098c-2dca-22a03b823b5f@redhat.com>
From: "Fangyi (C)" <eric.fangyi@huawei.com>
Message-ID: <58462C16.3070505@huawei.com>
Date: Tue, 6 Dec 2016 11:10:14 +0800
MIME-Version: 1.0
In-Reply-To: <7c2e5e96-69e4-098c-2dca-22a03b823b5f@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
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
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: kwolf@redhat.com, xieyingtai@huawei.com, subo7@huawei.com, qemu-devel@nongnu.org, mreitz@redhat.com, wu.wubin@huawei.com, pbonzini@redhat.com, sochin.jiang@huawei.com

I have already seen your proposal mail for NBD_FLAG_INIT_ZEROES extension.
Thank you!


在 2016/12/6 0:54, Eric Blake 写道:
> On 12/05/2016 05:09 AM, Stefan Hajnoczi wrote:
>> On Sun, Dec 04, 2016 at 11:44:57PM +0000, Yi Fang wrote:
>>> NBD client has not implemented callback for .bdrv_has_zero_init. So
>>> bdrv_has_zero_init always returns 0 when doing non-shared storage
>>> migration.
>>> This patch implemented NBD_CMD_HAS_ZERO_INIT and will avoid unnecessary
>>> set-dirty.
>>
>> Please link to the NBD spec where this new command is defined.  Has it
>> already been accepted by the NBD community?
>
> No. This is the first I've seen of such a proposal.
>
>>
>> I think this is a weird command because it's information that doesn't
>> change over the lifetime of an NBD session.  Your patch sends a command
>> and waits for the reply every time has_zero_init() is queried.
>>
>> Is there a better place to put this information in the NBD protocols,
>> like some export information that is retried during connection?  (I
>> haven't checked the protocol.)  It seems weird to send a command and
>> wait for the response.
>
> Agreed - this patch is wrong. Even if you DO get the NBD community to
> buy into this, it should be done as a new NBD_FLAG_* sent once up-front
> during handshake phase in reply to NBD_OPT_EXPORT_NAME/NBD_OPT_GO, and
> NOT a new command that can be arbitrarily invoked multiple times during
> transmission phase.
>
> Is the goal of the flag for the server to be able to advertise to the
> client that upon initial connection, the server asserts that the volume
> currently reads as all zeroes (and therefore the client can optimize by
> not writing zeroes)?
>
> Do you need me to help re-write this into a proposal to the NBD
> community that might stand a chance of being accepted?
>

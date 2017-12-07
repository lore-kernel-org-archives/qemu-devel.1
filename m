Received: from eggs.gnu.org ([2001:4830:134:3::10]:57096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eMtWz-0000fT-IO
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eMtWw-0000Vf-FG
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:35:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eMtWv-0000R6-RX
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:35:50 -0500
References: <20171201055832.8392-1-fangying1@huawei.com>
	<20171201163813-mutt-send-email-mst@kernel.org>
	<0fe53172-70f2-56b5-5d25-b3c1769098d7@huawei.com>
	<20171206183124-mutt-send-email-mst@kernel.org>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <80d92a04-61cb-c16a-f0ff-d47e70cc2fcb@huawei.com>
Date: Thu, 7 Dec 2017 18:35:05 +0800
MIME-Version: 1.0
In-Reply-To: <20171206183124-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] vhost: Don't abort when vhost-user
 connection is lost during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, marcandre.lureau@redhat.com

On 2017/12/7 0:34, Michael S. Tsirkin wrote:
> On Wed, Dec 06, 2017 at 09:30:27PM +0800, Ying Fang wrote:
>>
>> On 2017/12/1 22:39, Michael S. Tsirkin wrote:
>>> On Fri, Dec 01, 2017 at 01:58:32PM +0800, fangying wrote:
>>>> QEMU will abort when vhost-user process is restarted during migration
>>>> when vhost_log_global_start/stop is called. The reason is clear that
>>>> vhost_dev_set_log returns -1 because network connection is lost.
>>>>
>>>> To handle this situation, let's cancel migration by setting migrate
>>>> state to failure and report it to user.
>>>
>>> In fact I don't see this as the right way to fix it. Backend is dead so why
>>> not just proceed with migration? We just need to make sure we re-send
>>> migration data on re-connect.
>>> This is where vhost start/stop migration dirty log. The original code aborts
>> qemu here beacuse vhost data stream may break down if we fail to start/stop
>> vhost dirty log during migration. Backend may be active after vhost_log_global_start.
>>
>>              dirty log start ----------------- dirty log stop
>>                      ^           ^
>>                      |           |
>> ----- backend dead ----- backend active
> 
> I'm sorry, I don't understand yet. Backend is active after logging started -
> why is this a problem?Sorry, I did not explain it well. IF backend is dead when dirty log start is called,
vhost_dev_set_log/vhost_dev_set_features may fail because connection is temporarily lost.
So even if migration is in progress and vhost-user backend is active again later,
vhost-user dirty memory is not logged.
> 
>> Currently we don't re-send migration data on re-connect in this situation.
>> May we should work it out.
> 
> So basically backend connects after logging started, and we
> do not tell it to start logging and where - is that the issue?
> I agree, that would be a bug then.
> 
Yes, this is just the issue.

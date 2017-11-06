Received: from eggs.gnu.org ([2001:4830:134:3::10]:58755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1eBgtz-0005sG-MY
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1eBgtv-0002qD-PH
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:53:19 -0500
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1506954812-6552-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51fuanjfop.fsf@maestria.local.igalia.com>
	<515d6e61-2e1f-0661-e04a-526844deb9ce@redhat.com>
	<20171106093528.7wwyxff5psaabc4a@postretch>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <c7f0493a-ae4c-6b09-6aaa-18168eb5194b@huawei.com>
Date: Mon, 6 Nov 2017 13:52:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171106093528.7wwyxff5psaabc4a@postretch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v13 2/6] qmp: Use ThrottleLimits structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu block <qemu-block@nongnu.org>

On 11/6/2017 10:35 AM, Manos Pitsidianakis wrote:
> On Fri, Oct 13, 2017 at 09:26:17AM -0500, Eric Blake wrote:
>> [adding Markus, and block list]
>>
>> On 10/13/2017 09:16 AM, Alberto Garcia wrote:
>>> On Mon 02 Oct 2017 04:33:28 PM CEST, Pradeep Jagadeesh wrote:
>>>> This patch factors out code to use the ThrottleLimits
>>>> structure.
>>>
>>>>  { 'struct': 'BlockIOThrottle',
>>>> -  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd':
>>>> 'int',
>>>> -            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int',
>>>> 'iops_wr': 'int',
>>>> -            '*bps_max': 'int', '*bps_rd_max': 'int',
>>>> -            '*bps_wr_max': 'int', '*iops_max': 'int',
>>>> -            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
>>>> -            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
>>>> -            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>>>> -            '*iops_rd_max_length': 'int', '*iops_wr_max_length':
>>>> 'int',
>>>> -            '*iops_size': 'int', '*group': 'str' } }
>>>> +  'base': 'ThrottleLimits',
>>>> +  'data': { '*device': 'str', '*id': 'str', '*group': 'str' } }
>>>
>>> So BlockIOThrottle used to have parameters named bps_rd and iops_wr, and
>>> after this patch they become bps-read and iops-write. This breaks the
>>> API completely, as you can see if you run e.g. iotest 129:
>>>
>>> AssertionError: failed path traversal for "return" in "{u'error':
>>> {u'class': u'GenericError', u'desc': u"Parameter 'iops_rd' is
>>> unexpected"}}"
>>>
>>> I just checked previous versions of the series and I see that Manos
>>> already warned you of this in v11:
>>>
>>>    https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04698.html
>>
>> On the bright side, ThrottleLimits is marked 'since 2.11' (added in
>> commit 432d889e), meaning it has not yet been released, so we CAN fix
>> the naming in ThrottleLimits to be compatible with BlockIOThrottle if we
>> want to share the type, as long as we get it done before the 2.11
>> release.
>
> We decided to keep BlockIOThrottle separate from ThrottleLimits because
> that would break the old I/O throttling API, just like is done in this
> patch series.  BlockIOThrottle is the one using old naming conventions
> so I think it should be the one to go, if that has to be done.
>
> But this all boils down to whether the legacy throttling API has to
> break in 2.11 or not, which probably is the maintainer's decision.
>
>
>> It does mean tweaking Manos' code to use compatible names
>> everywhere, but that may be a wise course of action (we tend to favor
>> '-' in new API names unless there is a strong reason to use '_'; but
>> sharing code for maximum back-compat would be a reason to use '_').
>>
Thanks for your reply Manos.

@Eric, So shall I go ahead and revert my patches to as before. I mean 
using iothrottle structure?.
What is your suggestion?

-Pradeep
>> --
>> Eric Blake, Principal Software Engineer
>> Red Hat, Inc.           +1-919-301-3266
>> Virtualization:  qemu.org | libvirt.org
>>
>
>
>

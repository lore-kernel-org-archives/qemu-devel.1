Received: from eggs.gnu.org ([2001:4830:134:3::10]:58773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiLeA-0001MT-48
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiLe7-00023W-42
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:24:14 -0400
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-4-lbloch@janustech.com>
	<20180725082611.GA4879@localhost.localdomain>
	<32a32b18-0c7c-63cd-3b1d-429717b23a85@redhat.com>
	<499d5d12-cdba-76e4-3b2e-122675ef9eec@janustech.com>
	<20180725133243.GC4879@localhost.localdomain>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <dd4a32bc-845c-f529-51a8-71c978f93861@janustech.com>
Date: Wed, 25 Jul 2018 18:23:45 +0300
MIME-Version: 1.0
In-Reply-To: <20180725133243.GC4879@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] qcow2: Introduce an option for
 sufficient L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/25/2018 04:32 PM, Kevin Wolf wrote:
> Am 25.07.2018 um 14:32 hat Leonid Bloch geschrieben:
>> On 07/25/2018 03:22 PM, Eric Blake wrote:
>>
>>      On 07/25/2018 03:26 AM, Kevin Wolf wrote:
>>
>>          Only looking at the external interface for now, I wonder whether it
>>          would be nicer not to have two mutually exclusive options, but to make
>>          l2-cache-size an alternate that can take either an int like before
>>          (meaning the number of bytes) or a string/enum (with the only accepted
>>          value "full" for now).
>>
>>      That does sound interesting.
>>
>> This does, but currently QEMU supports QEMU_OPT_STRING, QEMU_OPT_BOOL,
>> QEMU_OPT_NUMBER, and QEMU_OPT_SIZE. Looks like it will require a more
>> fundamental change to accept an option that can be either a string or a size.
> 
> Hm, yes, good point. We wouldn't be able to parse the options purely
> with QemuOpts any more. So we would have to manually check for 'full' in
> the QDict before calling qemu_opts_absorb_qdict(). If it's there, we
> would have to process it and then delete it from the QDict before we
> feed the QDict to qemu_opts_absorb_qdict(), which would only accept a
> number there. A bit ugly, but should be workable.
> 
> Maybe this is really the time that we should convert qcow2 to use the
> QAPI types anyway, like some of the protocol drivers do internally now.
> Obviously, this is out of scope for this series, but it gives a
> perspective for how to get rid of the ugliness again.

I need to look into that. Thanks for the idea. But indeed looks like out 
of scope for this series.

> 
>>          Another interesting question is whether 'full' shouldn't keep meaning
>>          full throughout the lifetime of the BlockDriverState, i.e. should it
>>          keep adapting to the new size when the image size changes?
>>
>>
>>      Do we even resize the cache now for image size changes? If we use an enum,
>>      we could have two different values depending on whether the chosen cache
>>      size remains fixed or also tries to resize when the image grows.
> 
> We don't because we only support absolute cache sizes today. 'full'
> would be the first one that is relative to the image size.
> 
>> Is it even possible to change the virtual disk image size online?
> 
> Yes, this is what qcow2_co_truncate() does (can be invoked, amongst
> others, with the QMP command 'block_resize').

Cool! This does look like a good idea to resize the L2 cache 
accordingly, but maybe this is out of scope for now as well? The purpose 
of the current series is just to provide an option to automatically 
calculate the needed L2 cache size for covering the entire image, 
instead of using an external script to do that and feed the output to 
l2-cache-size.

> 
>> Found a problem with my previous patch: the property was not actually set as a
>> proper boolean option. Also, fixing the error output in iotest 103 (thanks
>> Kevin for the catch!). V5 is on the way.
> 
> Maybe give the alternate thing a try with v5, as everyone seems to agree
> that it's a nicer interface if we can make it work.

You mean with QDict? I'll look into that now. But already sent v5 before 
reading this email.

> 
> Also, a meta-comment: Leonid, would you mind sending plain text emails
> instead of HTML-only?

Sure, Kevin! Sorry, I thought Thunderbird as configured here is sending 
plain text. I was wrong. Now it should be fine. Thanks for the remark.

Leonid.

> 
> Kevin
> 

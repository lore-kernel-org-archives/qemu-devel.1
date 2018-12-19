Received: from eggs.gnu.org ([2001:4830:134:3::10]:39391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZgvR-0000cS-Uc
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:50:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZgvQ-0005ZW-M5
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:50:33 -0500
References: <20181219015230.18652-1-jsnow@redhat.com>
	<20181219015230.18652-2-jsnow@redhat.com>
	<fe80addc-0e37-a453-b9e1-5e78b559a093@virtuozzo.com>
	<a1b2fca0-2bd1-01f6-6ff0-dfde78d4dfec@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd3979c0-2fd6-83a2-8b6f-7e3a2b828583@redhat.com>
Date: Wed, 19 Dec 2018 12:50:14 -0600
MIME-Version: 1.0
In-Reply-To: <a1b2fca0-2bd1-01f6-6ff0-dfde78d4dfec@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/5] iotests: add qmp recursive sorting
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 12/19/18 11:55 AM, John Snow wrote:

>>> +def ordered_kwargs(kwargs):
>>> +    # kwargs prior to 3.6 are not ordered, so:
>>> +    od = OrderedDict()
>>> +    for k in sorted(kwargs.keys()):
>>
>> you can use for k, v in sorted(kwargs.items()):
>> and use then v instead of kwargs[k]
>>
> 
> I don't need to sort the tuples, though, Only the keys -- which are not
> duplicated. Is it really worth changing? ...

If I'm reading this correctly:
https://www.pythoncentral.io/how-to-sort-python-dictionaries-by-key-or-value/

sorting tuples with unique keys is the same as sorting by the keys, but 
gives you the value (as part of the tuple) for free.  So the benefit is 
that:

> 
>>> +        if isinstance(kwargs[k], dict):
>>> +            od[k] = ordered_kwargs(kwargs[k])

here, you'd write:

if isinstance(v, dict):
   od[k] = ordered_kwargs(v)

instead of having to repeat the value lookup.

> 
> The motivation is that log() will log whatever you give it and apply
> filters that work on that kind of object. Some callers need to filter
> rich QMP objects and some callers need to filter text -- this is the way
> log() behaves right now and I simply didn't change it.
> 
> What qmp_log currently does is convert both the outgoing and incoming
> QMP objects to text, and then filters them as text. However, only
> precisely one test (206) uses this functionality.
> 
> So... I need some way for test 206 to do what it does. One way is to
> make a rich QMP filter, which is what I do later in this series under
> the pretense that other tests will likely want to filter QMP output, too.
> 
> The other approach involves teaching qmp_log to accept two kinds of
> filters (qmp and text) and then passing both along to log(), which will
> then filter the object before pretty-printing and then apply the text
> filters after pretty-printing, and then logging the result.
> 
> As it stands now, though, log() just applies all filters to the first
> argument without the caller needing to disambiguate. If I teach log() to
> use two types of filters, I need to go back through all of the iotests
> and teach all callers to specify e.g. qfilters= or tfilters=.
> 
> I opted for an approach that let me just edit test 206 instead -- and
> one that added a recursive QMP filter that might be useful in the future
> for other purposes.

The reasoning here makes sense to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

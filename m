Received: from eggs.gnu.org ([2001:4830:134:3::10]:44809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fioB1-0002LL-Lq
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 17:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fioB0-00080w-ON
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 17:52:03 -0400
References: <499d5d12-cdba-76e4-3b2e-122675ef9eec@janustech.com>
	<20180725133243.GC4879@localhost.localdomain>
	<dd4a32bc-845c-f529-51a8-71c978f93861@janustech.com>
	<20180725155323.GD4879@localhost.localdomain>
	<0638cd7c-23f7-0f99-735b-c3fb3102e254@janustech.com>
	<20180726144232.GE4215@localhost.localdomain>
	<c1a93a3b-1207-99c9-fcf4-a23db8f45dcc@janustech.com>
	<05696f3c-369e-22a7-a556-d6fae22ec623@janustech.com>
	<20180726201903.GL4215@localhost.localdomain>
	<80F33942-D745-468B-AFAA-0438B3D5B0B9@janustech.com>
	<20180726212812.GM4215@localhost.localdomain>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <afaaed91-8037-2bf1-b895-4707e86662d1@janustech.com>
Date: Fri, 27 Jul 2018 00:51:35 +0300
MIME-Version: 1.0
In-Reply-To: <20180726212812.GM4215@localhost.localdomain>
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

On 07/27/2018 12:28 AM, Kevin Wolf wrote>
> That makes sense. You probably need to clone the QDict before passing
> it to qcow2_update_options(), with qdict_clone_shallow().

Sounds like a solution! Great, thanks!

>>>> Can QAPI be the solution? I've seen some examples, and it looks like
>>> the
>>>> qcow2 driver already uses QAPI to some extent - I mean all the qdict
>>> stuff
>>>> is from QAPI, no? Can you please point me to an example of how QAPI
>>> can
>>>> solve the issue of an option that can accept both a size and a
>>> string?
>>>
>>> By using QAPI I mean using types like BlockdevOptionsQcow2. These types
>>> are directly generated from the JSON schema, where it's possible to
>>> specify an alternate of a string and an integer.
>>>
>>> One example for an alternate in the JSON schema is BlockdevRef, where
>>> you can give a string (to reference a node-name) or an inline
>>> declaration of a block device. In JSON, it looks like this:
>>>
>>>     { 'alternate': 'BlockdevRef',
>>>       'data': { 'definition': 'BlockdevOptions',
>>>                 'reference': 'str' } }
>>>
>>> And the generated C type for it is:
>>>
>>>     struct BlockdevRef {
>>>         QType type;
>>>         union { /* union tag is @type */
>>>             BlockdevOptions definition;
>>>             char *reference;
>>>         } u;
>>>     };
>>>
>>> In our case, we would get a union of int64_t and char* instead, and
>>> still the QType type as a discriminator.
>>
>> Thanks for the explanation!
>> But qcow2 already has the options in the JSON file, they're just not
>> used for some reason?
> 
> The block layer configuration is a bit of a mess because of backwards
> compatibility. The JSON schema is in fact used for -blockdev and for the
> blockdev-add QMP command, but not for the old option -drive and
> drive_add.
> 
> In the case of -blockdev/blockdev-add, after validating the input
> against the schema, the QAPI objects are converted to QDicts so they can
> use the same code path as the old code. Eventually, we want to use QAPI
> objects all the way, but that requires either expressing all -drive
> options in terms of QAPI object or getting rid of -driver altogether.
> This is still going to take some time.

Thanks for the details! It's clear now!

Leonid.

> 
> Kevin
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ez3LM-0004uq-PU
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ez3LL-0002r4-M7
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:45:36 -0400
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-5-vsementsov@virtuozzo.com>
	<8b6eccd8-90ee-3475-5005-df9f59f59709@redhat.com>
	<f3f02fac-35d9-2a4d-0fef-ba66f75aa929@virtuozzo.com>
	<eb213846-5a39-fcae-4a1b-ca10fced25b8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3ad3aa0c-963f-8df7-92dd-c922a7864d5f@virtuozzo.com>
Date: Thu, 22 Mar 2018 19:45:21 +0300
MIME-Version: 1.0
In-Reply-To: <eb213846-5a39-fcae-4a1b-ca10fced25b8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/4] qapi: new qmp command
 nbd-server-add-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

22.03.2018 19:19, Eric Blake wrote:
> On 03/22/2018 10:43 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>>> +# Returns: error on one of the following conditions:
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - the s=
erver is not running
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - expor=
t is not found
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - bitma=
p is not found
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - bitma=
p is disabled
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - bitma=
p is locked
>>>
>>> Do we really need to list all the error conditions?=C2=A0 My worry is=20
>>> that a list this specific might go stale, compared to the obvious=20
>>> default that the command succeeds only if it was able to expose the=20
>>> bitmap and that the error message is specific enough for a human to=20
>>> figure out what to fix if it failed.
>>
>>
>> Hmm, I've just doing it similar with other commands in the file. Is=20
>> there any requirements on this part of qapi documentation? I can=20
>> write only "# Returns: nothing on success" line, is it appropriate?=20
>> blockdev-mirror do so, but other commands tries to describe errors.=20
>> Looks like we lack some specified format for return code description=20
>> like we have for parameters..
>
> Yeah, for returns, it's been very ad hoc.=C2=A0 My personal feel (althoug=
h=20
> it's not very well documented and certainly not enforced): all=20
> commands can reasonably return errors, presumably for a good reason;=20
> but exhaustively auditing WHICH errors is a huge task with little=20
> benefits. A few commands return non-generic errors, but if all error=20
> paths used error_setg(), there's nothing that a machine can do to tell=20
> the difference between the errors, so documenting different error=20
> reasons doesn't add much.
>
> Thus, if a command returns nothing on success, I'm fine with omitting=20
> 'Returns:' entirely, and the doc generator permits that. But if you=20
> have bothered to list Returns: for certain errors, I'm not going to=20
> blindly throw away the documentation work, even though the list may=20
> become incomplete over time.
>

So, only something interesting worth documenting.

Hmm, interesting: consider for example bloc-dirty-bitmap-remove. It says:
# Returns: nothing on success
#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If @node is not a v=
alid block device or node, DeviceNotFound

But the code uses bdrv_lookup_bs, which uses simple error_setg, so it=20
will return GenericError, isn't it? And, it's not the only place..

--=20
Best regards,
Vladimir

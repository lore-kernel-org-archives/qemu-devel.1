Received: from eggs.gnu.org ([2001:4830:134:3::10]:45933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZwQB-0004jI-IY
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZwQA-0001tq-Gt
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:18:47 -0500
References: <20180110230825.18321-1-eblake@redhat.com>
	<20180110230825.18321-3-eblake@redhat.com>
	<b95cd0c3-0581-b763-07f2-8f90ef5e2e25@virtuozzo.com>
	<b711b9dc-559a-9381-4fd4-f3c5b0907c18@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e8c317c0-9650-e0fb-d30d-ea0490698ce6@virtuozzo.com>
Date: Fri, 12 Jan 2018 13:18:32 +0300
MIME-Version: 1.0
In-Reply-To: <b711b9dc-559a-9381-4fd4-f3c5b0907c18@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/6] nbd/server: refactor negotiation
 functions parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

11.01.2018 22:54, Eric Blake wrote:
> On 01/11/2018 11:55 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 11.01.2018 02:08, Eric Blake wrote:
>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>> Instead of passing currently negotiating option and its length to
>>> many of negotiation functions let's just store them on NBDClient
>>> struct to be state-variables of negotiation phase.
>>>
>>> This unifies semantics of negotiation functions and allows
>>> tracking changes of remaining option length in future patches.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> Message-Id: <20171122101958.17065-2-vsementsov@virtuozzo.com>
>>> [eblake: rebase, commit message tweak, assert !optlen after
>>> negotiation completes]
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>  =C2=A0 nbd/server.c | 168
>>> +++++++++++++++++++++++++++++------------------------------
>>>  =C2=A0 1 file changed, 84 insertions(+), 84 deletions(-)
>>> @@ -1707,6 +1706,7 @@ static coroutine_fn void
>>> nbd_co_client_start(void *opaque)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +=C2=A0=C2=A0=C2=A0 assert(!client->optlen);
>>
>> hmm, should not it be at the end of nbd_negotiate() ? Looks OK anyway.
> Sure, I'll squash this in, for no real change in behavior:
>
> diff --git i/nbd/server.c w/nbd/server.c
> index c22d5e6ecf..3fd145592e 100644
> --- i/nbd/server.c
> +++ w/nbd/server.c
> @@ -902,6 +902,7 @@ static coroutine_fn int nbd_negotiate(NBDClient
> *client, Error **errp)
>           }
>       }
>
> +    assert(!client->optlen);
>       trace_nbd_negotiate_success();
>
>       return 0;
> @@ -1726,7 +1727,6 @@ static coroutine_fn void nbd_co_client_start(void
> *opaque)
>           return;
>       }
>
> -    assert(!client->optlen);
>       nbd_client_receive_next_request(client);
>   }
>
>
>


or, even better, in nbd_negotiate_options. and you actually do it in 5/6.


--=20
Best regards,
Vladimir

Received: from eggs.gnu.org ([209.51.188.92]:33570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gt83F-0003Vr-1l
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gt83E-0007DX-5a
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:38:56 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 09:38:37 +0000
Message-ID: <c861c023-c783-57f6-85ae-52ecba971636@virtuozzo.com>
References: <20190208141122.53046-1-vsementsov@virtuozzo.com>
	<20190211034231.GD18083@stefanha-x1.localdomain>
In-Reply-To: <20190211034231.GD18083@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <B56D4D26371FFD46A366B37CB62EED11@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] coroutines: generate
 wrapper code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>

11.02.2019 6:42, Stefan Hajnoczi wrote:
> On Fri, Feb 08, 2019 at 05:11:22PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all!
>>
>> We have a very frequent pattern of wrapping a coroutine_fn function
>> to be called from non-coroutine context:
>>
>>    - create structure to pack parameters
>>    - create function to call original function taking parameters from
>>      struct
>>    - create wrapper, which in case of non-coroutine context will
>>      create a coroutine, enter it and start poll-loop.
>>
>> Here is a draft of template code + example how it can be used to drop a
>> lot of similar code.
>>
>> Hope someone like it except me)
>=20
> My 2 cents.  Cons:
>=20
>   * Synchronous poll loops are an anti-pattern.  They block all of QEMU
>     with the big mutex held.  Making them easier to write is
>     questionable because we should aim to have as few of these as
>     possible.

Understand. Do we have a concept or a kind of target for a future to get ri=
d of
these a lot of poll-loops? What is the right way? At least for block-layer?

>=20
>   * Code generation makes the code easier to write but harder to read.
>     Code is read more than written.  In this case I think open coding
>     isn't too bad and I prefer it to reading a code generation script to
>     understand how it works.

But you can read generated code in same way. You only need to read generato=
r
script if it generates something wrong, but should be rare.

>=20
> If we were planning to add lots more of these then I agree code
> generation would help.  But in this case I'd rather not.
>=20

What do you think at least of generating code to create a coroutine from a =
function
with multiple arguments?

--=20
Best regards,
Vladimir

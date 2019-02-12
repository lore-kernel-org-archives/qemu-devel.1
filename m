Received: from eggs.gnu.org ([209.51.188.92]:53572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtUyq-0002Ki-06
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtUub-0002ty-I9
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:03:35 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 12 Feb 2019 10:03:19 +0000
Message-ID: <ba74c0e8-e5d0-fe43-278c-6ed1cd7bb195@virtuozzo.com>
References: <20190208141122.53046-1-vsementsov@virtuozzo.com>
	<20190211034231.GD18083@stefanha-x1.localdomain>
	<c861c023-c783-57f6-85ae-52ecba971636@virtuozzo.com>
	<20190212032242.GC28401@stefanha-x1.localdomain>
In-Reply-To: <20190212032242.GC28401@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0FEA900691574D4280C506AB47FB0689@eurprd08.prod.outlook.com>
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

12.02.2019 6:22, Stefan Hajnoczi wrote:
> On Mon, Feb 11, 2019 at 09:38:37AM +0000, Vladimir Sementsov-Ogievskiy wr=
ote:
>> 11.02.2019 6:42, Stefan Hajnoczi wrote:
>>> On Fri, Feb 08, 2019 at 05:11:22PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
>>>> Hi all!
>>>>
>>>> We have a very frequent pattern of wrapping a coroutine_fn function
>>>> to be called from non-coroutine context:
>>>>
>>>>     - create structure to pack parameters
>>>>     - create function to call original function taking parameters from
>>>>       struct
>>>>     - create wrapper, which in case of non-coroutine context will
>>>>       create a coroutine, enter it and start poll-loop.
>>>>
>>>> Here is a draft of template code + example how it can be used to drop =
a
>>>> lot of similar code.
>>>>
>>>> Hope someone like it except me)
>>>
>>> My 2 cents.  Cons:
>>>
>>>    * Synchronous poll loops are an anti-pattern.  They block all of QEM=
U
>>>      with the big mutex held.  Making them easier to write is
>>>      questionable because we should aim to have as few of these as
>>>      possible.
>>
>> Understand. Do we have a concept or a kind of target for a future to get=
 rid of
>> these a lot of poll-loops? What is the right way? At least for block-lay=
er?
>=20
> It's non-trivial.  The nested event loop could be flattened if there was
> a mechanism to stop further activity on a specific object only (e.g.
> BlockDriverState).  That way the event loop can continue processing
> events for other objects and device emulation could continue for other
> objects.
>=20
> Unfortunately there are interactions between objects like in block jobs
> that act on multiple BDSes, so it becomes even tricky.
>=20
> A simple way of imagining this is to make each object an "actor"
> coroutine.  The coroutine processes a single message (request) at a time
> and yields when it needs to wait.  Callers send messages and expect
> asynchronous responses.  This model is bad for efficiency (parallelism

hmm, and with all these loops, where is parallelism?

> is necessary) but at least it offers a sane way of thinking about
> multiple asynchronous components coordinating together.  (It's another
> way of saying, let's put everything into coroutines.)
>=20
> The advantage of a flat event loop is that a hang in one object (e.g.
> I/O getting stuck in one file) doesn't freeze the entire event loop.
>  >>>
>>>    * Code generation makes the code easier to write but harder to read.
>>>      Code is read more than written.  In this case I think open coding
>>>      isn't too bad and I prefer it to reading a code generation script =
to
>>>      understand how it works.
>>
>> But you can read generated code in same way. You only need to read gener=
ator
>> script if it generates something wrong, but should be rare.
>=20
> Generated code isn't visible unless the code has been built and indexed
> (if you're using ctags).  This makes it harder for people to navigate
> the code.
>=20
>>>
>>> If we were planning to add lots more of these then I agree code
>>> generation would help.  But in this case I'd rather not.
>>>
>>
>> What do you think at least of generating code to create a coroutine from=
 a function
>> with multiple arguments?
>=20
> If it's easy to read without requiring one to figure out how the magic
> works, then I like it.
>=20

Ok, I'll think about it.


--=20
Best regards,
Vladimir

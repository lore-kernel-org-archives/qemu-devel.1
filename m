Received: from eggs.gnu.org ([208.118.235.92]:60916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gcZZt-0002Ql-TV
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gcZZo-0005Tn-Sj
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:36:13 -0500
Received: from mail-eopbgr00103.outbound.protection.outlook.com
	([40.107.0.103]:52581
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1gcZZo-0005Q9-Dw
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:36:08 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 27 Dec 2018 17:36:04 +0000
Message-ID: <0ebf0044-d45c-74b4-d323-2391daa12a0c@virtuozzo.com>
References: <20180404103440.19546-1-stefanha@redhat.com>
	<008ac6e8-1e68-b0f6-7e75-77453721d031@virtuozzo.com>
	<20180410020823.GB11203@stefanha-x1.localdomain>
	<fefd54c0-d5f2-dc31-ff3c-24eb29fd2101@simark.ca>
	<788e662d-0fb6-8db8-a049-3714eaa32869@redhat.com>
In-Reply-To: <788e662d-0fb6-8db8-a049-3714eaa32869@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1B18244572BFC34F85B3525F6CAC1307@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] scripts/qemugdb: support coroutine
 backtrace in coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pedro Alves <palves@redhat.com>, Simon Marchi <simark@simark.ca>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "gdb@sourceware.org" <gdb@sourceware.org>

23.04.2018 16:28, Pedro Alves wrote:
> On 04/23/2018 02:37 AM, Simon Marchi wrote:
>> On 2018-04-09 10:08 PM, Stefan Hajnoczi wrote:
>>> I wonder what the point of select-frame is then...
>>>
>>> I have CCed the GDB mailing list.  Maybe someone can help us.  Context:
>>>
>>> QEMU implements coroutines using jmpbuf.  We'd like to print coroutine
>>> call stacks in GDB and have a script that works when a process is being
>>> debugged (it sets the registers).
>>>
>>> Now we'd like to extend the script to work on core dumps where it's not
>>> possible to set registers (since there is no process being debugged).
>>>
>>> Is there a way to backtrace an arbitrary call stack in a core dump?
>>
>> Not that I know of.  The "frame <stack-addr> <pc-addr>" form of the fram=
e
>> command sounds like it should be usable to achieve that, but it doesn't
>> seem to work in that way.  I really wonder if it's working as it was
>> intended initially.  I guess using that form of the frame command should
>> override/mask the real current values of $sp and $pc?
>=20
> Yeah, "frame <args>" has a lot of problems.
>=20
> This series was working toward sorting out the "frame" command:
>=20
>    https://sourceware.org/ml/gdb-patches/2015-09/msg00248.html
>=20
> Follow the urls there for more background.
>=20
> To me, the important questions to answer are here:
>   https://sourceware.org/ml/gdb-patches/2015-09/msg00658.html
>=20
> Unfortunately, I don't think the series moved past that point.
>=20
> Thanks,
> Pedro Alves
>=20


Hi Pedro!

Hmm, returned to this topic. I've spent this day digging in gdb code, and f=
ound it much
more difficult than qemu)..

I've failed to find something like

create_frame_with_registers, or create_thread_with_registers.. Looks like r=
egisters comes
from some register caches, backed by different sources of registers or some=
thing like this.

So, I'd like to ask several questions:

1. Any news on the topic since April?

2. Can you propose a simple (maybe hacky) way (with or without patching gdb=
) to achieve the behavior like

set $rsp =3D ...
set $rbp =3D ...
set $rip =3D ...

bt #prints bt, starting from the frame corresponding to register values set
fr 5 #goes to frame in this bt, and allow to examine local variables

for debugging core-dumps?

***

May be, we can allow set registers while debugging core-dump? Why we can't =
set them? We have
same register caches, and anyway we can move between threads and frames and=
 registers are changed...

May be, we can somehow add separate thread with given registers from user, =
like they are created from
coredump file..

Anything else?

***

For me, still, the simplest way is to add additional note segments to cored=
ump file, to specify needed frames..
But it is not very comfortable, to recreate and reopen core file, when foun=
d new coroutine.

--=20
Best regards,
Vladimir

Received: from eggs.gnu.org ([209.51.188.92]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gmKtG-0005eI-2g
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gmKt6-00045M-Qs
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:56:28 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <b2915d9a-90f1-a114-5d18-f2d69cc491b8@virtuozzo.com>
References: <cover.1547739122.git.berto@igalia.com>
	<23150df9-1a9d-d1ef-c624-64eb2425a8d5@redhat.com>
	<b2915d9a-90f1-a114-5d18-f2d69cc491b8@virtuozzo.com>
Date: Wed, 23 Jan 2019 16:56:13 +0100
Message-ID: <w515zufmkpu.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/13] Add a 'x-blockdev-reopen' QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Tue 22 Jan 2019 09:15:25 AM CET, Vladimir Sementsov-Ogievskiy wrote:

>>>    a) Some options cannot be changed (most drivers don't allow that, in
>>>       fact).
>>>    b) If an option is missing, it should be reset to its default value
>>>       (rather than keeping its previous value).
>> 
>> Could we use QAPI alternate types where we could state that:
>> 
>> "option":"new" - set the option
>> "option":null - reset the option to its default
>> omit option - leave the option unchanged
>> 
>> basically, making each of the options an Alternate with JSON null, so
>> that a request to reset to the default becomes an explicit action?
>
> +1
>
> Sorry, I missed the previous discussion. What is the reason to reset
> option to default if it missed? It looks more common to not touch
> things which are not asked to.

The idea is to have a command that works like blockdev-add. If you pass
a set of options to x-blockdev-reopen then the end result should be
similar to what you would get if you had used blockdev-add.

> Also, should we consider an option which may be changed during
> life-cycle of a device not by user request to change it? If yes, it
> should be safer to not reset it.

Do you have any example in mind?

> And here: if we are going to reset to default for not listed options,
> than just not listing "backing" should remove it (as default is null,
> obviously), and we don't need this special "null" parameter.

This is a bit trickier: the default for 'backing' is not to omit the
backing file, but to open the one that is specified in the image
metadata.

$ qemu-img create -f qcow2 base.qcow2 1M
$ qemu-img create -f qcow2 -b base.qcow2 active.qcow2

If you open active.qcow2 with blockdev-add then base.qcow2 is opened as
its backing file, and the only way to prevent that is to specify a
different backing file or null if you don't want to open any.

For x-blockdev-reopen we want to keep the same behavior as much as
possible, but instead of opening base.qcow2 if 'backing' is missing we
force the user to specify that option.

> Moreover, backing is an example of an option I mentioned, it
> definitely may change after block-stream for example, so resetting to
> default is unsafe, and user will have to carefully set backing on
> reopen (not tha backing, that was used with first blockdev-add, but
> backing which we have after block-stream)

Exactly. Since opening the default backing file is not something that we
want to do during a reopen operation we don't allow leaving that option
out.

Berto

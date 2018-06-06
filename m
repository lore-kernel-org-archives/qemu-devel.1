Received: from eggs.gnu.org ([2001:4830:134:3::10]:56516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQYD9-0004Nm-NA
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQYD3-00046M-Tr
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:10:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-7-mreitz@redhat.com>
	<105c40ee-d81a-2ebb-cd3a-63aa9e518d80@redhat.com>
	<9ad8a3f2-d56f-5eaf-3136-ed5264ec9eb4@redhat.com>
Date: Wed, 06 Jun 2018 15:10:33 +0200
In-Reply-To: <9ad8a3f2-d56f-5eaf-3136-ed5264ec9eb4@redhat.com> (Max Reitz's
	message of "Fri, 11 May 2018 20:11:24 +0200")
Message-ID: <87y3fs83hy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/13] block: Add block-specific QDict
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> On 2018-05-10 16:54, Eric Blake wrote:
>> On 05/09/2018 11:55 AM, Max Reitz wrote:
>>> There are numerous QDict functions that have been introduced for and are
>>> used only by the block layer.=C2=A0 Move their declarations into an own
>>=20
>> s/an own/their own/
>>=20
>>> header file to reflect that.
>>>
>>> While qdict_extract_subqdict() is in fact used outside of the block
>>> layer (in util/qemu-config.c), it is still a function related very
>>> closely to how the block layer works with nested QDicts, namely by
>>> sometimes flattening them.=C2=A0 Therefore, its declaration is put into=
 this
>>> header as well and util/qemu-config.c includes it with a comment stating
>>> exactly which function it needs.
>>>
>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>=20
>>> +++ b/include/block/qdict.h
>>> @@ -0,0 +1,35 @@
>>> +/*
>>> + * Special QDict functions used by the block layer
>>> + *
>>> + * Copyright (c) 2018 Red Hat, Inc.
>>=20
>> You are extracting this from qdict.h which has:
>> =C2=A0* Copyright (C) 2009 Red Hat Inc.
>>=20
>> Is it worth listing 2009-2018, instead of just this year?
>
> I don't know, is it?  I don't know whether it makes a real difference.

Where's your taste for pedantry?  Here's mine: please make it 2013-2018,
because the oldest code moved is from 2013.

>>> + *
>>> + * This work is licensed under the terms of the GNU LGPL, version 2.1 =
or later.
>>> + * See the COPYING.LIB file in the top-level directory.
>>> + */
>>> +
>>> +#ifndef BLOCK_QDICT_H
>>> +#define BLOCK_QDICT_H
>>> +
>>> +#include "qapi/qmp/qdict.h"
>>> +#include "qapi/qmp/qobject.h"
>>> +#include "qapi/error.h"

Only the first #include is necessary, due to qemu/typedefs.h.  Please
drop the other two.

>>> +
>>> +
>>> +void qdict_copy_default(QDict *dst, QDict *src, const char *key);
>>> +void qdict_set_default_str(QDict *dst, const char *key, const char
>>> *val);
>>=20
>> These two might be useful outside of the block layer; we can move them
>> back in a later patch if so.=C2=A0 But for now, I agree with your choice=
 of
>> moving them.
>>=20
>>> +
>>> +void qdict_join(QDict *dest, QDict *src, bool overwrite);
>>=20
>> This is borderline whether it would be useful outside of the block layer.
>
> I decided I wanted to move the *_default* functions, and if I did that,
> I would have to move this one as well.  I decided I can't be biased just
> because I wrote this one. :-)
>
> But in general I'd say if anyone wants to use any of these functions
> outside of the block layer, they are welcome to move them back to the
> main header, provided they have a good reason to do so.  I suppose a
> good reason for using qdict_join() may indeed turn up sooner or later.

I like it this way.

With the trivial changes I asked for:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

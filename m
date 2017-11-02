Received: from eggs.gnu.org ([2001:4830:134:3::10]:48877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA6vq-0004sE-2C
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 00:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA6vm-0004BZ-RJ
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 00:16:42 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-2-f4bug@amsat.org>
	<871smcss0v.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5ef711ad-506b-e331-e6f9-9287d6500742@amsat.org>
Date: Thu, 2 Nov 2017 01:16:32 -0300
MIME-Version: 1.0
In-Reply-To: <871smcss0v.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/88] cocci: script to use g_new() &
 friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org

Hi Markus,

On 10/09/2017 04:24 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Imported from Markus Armbruster commit b45c03f
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>?
>>
>>  scripts/coccinelle/g_new.cocci | 101 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 101 insertions(+)
>>  create mode 100644 scripts/coccinelle/g_new.cocci
>>
>> diff --git a/scripts/coccinelle/g_new.cocci b/scripts/coccinelle/g_new.cocci
>> new file mode 100644
>> index 0000000000..1e57685a6b
>> --- /dev/null
>> +++ b/scripts/coccinelle/g_new.cocci
>> @@ -0,0 +1,101 @@
>> +/* transform g_new*() alloc with size arguments of the form sizeof(T) [* N]
> 
> Confusing.  Sounds like we transform g_new() into something else.  Also,
> wing both ends of the comment, and start with a capital letter.

Ok

> 
>> + *
>> + *   g_new(T, n) is neater than g_malloc(sizeof(T) * n).  It's also safer,
>> + *   for two reasons.  One, it catches multiplication overflowing size_t.
>> + *   two, it returns T * rather than void *, which lets the compiler catch
> 
> Start your sentences with a capital letter.  Or rather, keep my commit
> message's capital letters intact ;)

Yes :|

> 
>> + *   more type errors.
>> + *
>> + *    Copyright: (C) 2017 Markus Armbruster <armbru@redhat.com>. GPLv2+.
> 
> If you want to put a copyright note into this file, you should stick to
> the common format:
> 
> /*
>  * Rewrite memory allocations to use g_new() & friends
>  *
>  * Copyright (C) 2014-2017 Red Hat, Inc.
>  *
>  * Authors:
>  *  Markus Armbruster <armbru@redhat.com>,
>  *
>  * This work is licensed under the terms of the GNU GPL, version 2 or later.
>  * See the COPYING file in the top-level directory.
>  */

Ok

>> + *    (Imported from b45c03f585ea9bb1af76c73e82195418c294919d)
> 
> Scratch this line.  It's in the commit message, and that suffices.

Ok

>> + *
>> + * See http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg00908.html:
>> + *
>> + *   g_new() advantages (from glib doc):
>> + *   - the returned pointer is cast to a pointer to the given type.
>> + *   - care is taken to avoid overflow when calculating the size of the
>> + *   allocated block.
> 
> Repeats what you just said in the text pasted from my commit message.

Ok

>> + *
>> + *   p = g_malloc(sizeof(*p)) is idiomatic, and not obviously inferior to
>> + *   p = g_new(T, 1), where T is the type of *p.
>> + *   But once you add multiplication, g_new() adds something useful: overflow
>> + *   protection.  Conversion to g_new() might make sense then.
>> + */
> 
> This part doesn't really apply, yet: the semantic patch doesn't deal
> with sizeof(*p).
> 
> Please write a coherent introduction instead of a series of quotations.

Sorry :S I'll try :)

>> +
>> +@@
>> +type T;
>> +@@
>> +-g_malloc(sizeof(T))
>> ++g_new(T, 1)
>> +@@
>> +type T;
>> +@@
>> +-g_try_malloc(sizeof(T))
>> ++g_try_new(T, 1)
>> +@@
>> +type T;
>> +@@
>> +-g_malloc0(sizeof(T))
>> ++g_new0(T, 1)
>> +@@
>> +type T;
>> +@@
>> +-g_try_malloc0(sizeof(T))
>> ++g_try_new0(T, 1)
>> +
> 
> Any particular reason for adding this blank line?
> 
> You add more below, and a comment.  Okay, but I'd commit the script
> exactly as given in commit b45c03f, then add improvements on top.

Yes.

>> +@@
>> +type T;
>> +expression n;
>> +@@
>> +-g_malloc(sizeof(T) * (n))
>> ++g_new(T, n)
>> +@@
>> +type T;
>> +expression n;
>> +@@
>> +-g_try_malloc(sizeof(T) * (n))
>> ++g_try_new(T, n)
>> +@@
>> +type T;
>> +expression n;
>> +@@
>> +-g_malloc0(sizeof(T) * (n))
>> ++g_new0(T, n)
>> +@@
>> +type T;
>> +expression n;
>> +@@
>> +-g_try_malloc0(sizeof(T) * (n))
>> ++g_try_new0(T, n)
>> +
>> +@@
>> +type T;
>> +expression p, n;
>> +@@
>> +-g_realloc(p, sizeof(T) * (n))
>> ++g_renew(T, p, n)
>> +@@
>> +type T;
>> +expression p, n;
>> +@@
>> +-g_try_realloc(p, sizeof(T) * (n))
>> ++g_try_renew(T, p, n)
>> +
>> +// drop superfluous cast
>> +@@
>> +type T;
>> +expression n;
>> +@@
>> +-(T *)g_new(T, n)
>> ++g_new(T, n)
>> +@@
>> +type T;
>> +expression n;
>> +@@
>> +-(T *)g_new0(T, n)
>> ++g_new0(T, n)
>> +@@
>> +type T;
>> +expression p, n;
>> +@@
>> +-(T *)g_renew(T, p, n)
>> ++g_renew(T, p, n)

Thanks for your review :)

Phil.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPVEi-0003Yq-AX
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPVEf-0005BJ-7Y
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:20:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181120203628.2367003-1-eblake@redhat.com>
	<cb5fbd50-0629-8afb-e1d4-cc3d1a94e057@redhat.com>
	<1671d82c-da21-de1e-58c4-dd22696f9a62@redhat.com>
	<8987fde5-a0f3-ea00-e19b-ab512a81ae39@redhat.com>
Date: Wed, 21 Nov 2018 17:20:03 +0100
In-Reply-To: <8987fde5-a0f3-ea00-e19b-ab512a81ae39@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed,
	21 Nov 2018 12:39:38 +0100")
Message-ID: <87efbe1jyk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] misc: Avoid UTF-8 in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 20/11/18 23:01, Eric Blake wrote:
>> [adding Markus in CC, since git didn't do it automatically from the
>> 'Reported-by']
>>
>> On 11/20/18 3:28 PM, John Snow wrote:
>>>
>>>
>>> On 11/20/18 3:36 PM, Eric Blake wrote:
>>>> While most developers are now using UTF-8 environments, it's
>>>> harder to guarantee that error messages will be output to
>>>> a multibyte locale. Rather than risking error messages that
>>>> get corrupted into mojibake when the user runs qemu in a
>>>> non-multibyte locale, let's stick to straight ASCII error
>>>> messages, rather than assuming that our use of UTF-8 in source
>>>> code string constants will work unchanged in other locales.
>>>>
>>>> Reported-by: Markus Armbruster <armbru@redhat.com>
>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>> ---
>>>> =C2=A0 hw/misc/tmp105.c | 2 +-
>>>> =C2=A0 hw/misc/tmp421.c | 2 +-
>>>> =C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
>>
>>>
>>> Do we have any policy in place to prohibit this in the future?
>>> (Presumably a policy that is automatic and won't interfere with QEMU
>>> localization efforts which may rightly attempt to use UTF-8 for those
>>> locales.)
>>
>> Not that I know of.

We already outlaw newline and trailing punctuation, we could amend that
to outlaw non-ASCII.

$ git-grep 'no newline'
include/qapi/error.h: * The resulting message should be a single phrase, wi=
th no newline or
util/qemu-error.c: * a single phrase, with no newline or trailing punctuati=
on.
util/qemu-error.c: * a single phrase, with no newline or trailing punctuati=
on.
util/qemu-error.c: * a single phrase, with no newline or trailing punctuati=
on.
util/qemu-error.c: * a single phrase, with no newline or trailing punctuati=
on.
util/qemu-error.c: * a single phrase, with no newline or trailing punctuati=
on.
util/qemu-error.c: * single phrase, with no newline or trailing punctuation.
util/qemu-error.c: * single phrase, with no newline or trailing punctuation.

[...]
>> Maybe checkpatch.pl could be taught to do a similar check?
>
> It looks easier in shell than perl...
>
> We could add a checkpatch.sh which finally call 'exec -l checkpatch.pl
> $@' or similar?

Congratulations, you found yet another way to make our checkpatch
program less readable.

Back to serious.  checkpatch.pl already flags error messages containing
newlines (search for "should not contain newlines").  Extending that to
flag non-ASCII characters shouldn't be hard.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

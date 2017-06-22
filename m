Received: from eggs.gnu.org ([2001:4830:134:3::10]:53376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dO3Xv-0003SW-FM
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dO3Xu-0000Wh-Ec
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:57:23 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170621134744.8047-1-mreitz@redhat.com>
	<20170621134744.8047-4-mreitz@redhat.com>
	<87h8z9wcjy.fsf@dusky.pond.sub.org>
	<84e9b47f-ce63-f2cd-09f6-4819b186cfe9@redhat.com>
Date: Thu, 22 Jun 2017 16:57:13 +0200
In-Reply-To: <84e9b47f-ce63-f2cd-09f6-4819b186cfe9@redhat.com> (Max Reitz's
	message of "Wed, 21 Jun 2017 23:34:55 +0200")
Message-ID: <87fuesgjee.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/4] block: qobject_is_equal() in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> On 2017-06-21 18:06, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>> 
>>> Currently, bdrv_reopen_prepare() assumes that all BDS options are
>>> strings. However, this is not the case if the BDS has been created
>>> through the json: pseudo-protocol or blockdev-add.
>>>
>>> Note that the user-invokable reopen command is an HMP command, so you
>>> can only specify strings there. Therefore, specifying a non-string
>>> option with the "same" value as it was when originally created will now
>>> return an error because the values are supposedly similar (and there is
>>> no way for the user to circumvent this but to just not specify the
>>> option again -- however, this is still strictly better than just
>>> crashing).
>>>
>>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  block.c | 15 +++------------
>>>  1 file changed, 3 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/block.c b/block.c
>>> index fa1d06d..23424d5 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -2950,19 +2950,10 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
>>>          const QDictEntry *entry = qdict_first(reopen_state->options);
>>>  
>>>          do {
>>> -            QString *new_obj = qobject_to_qstring(entry->value);
>>> -            const char *new = qstring_get_str(new_obj);
>>> -            /*
>>> -             * Caution: while qdict_get_try_str() is fine, getting
>>> -             * non-string types would require more care.  When
>>> -             * bs->options come from -blockdev or blockdev_add, its
>>> -             * members are typed according to the QAPI schema, but
>>> -             * when they come from -drive, they're all QString.
>>> -             */
>> 
>> Your commit message makes me suspect this comment still applies in some
>> form.  Does it?
>
> The only thing that I can think of that may be applicable is what I
> wrote in the commit message; this fails now:
>
> $ qemu-io -c 'reopen -o size=65536' \
>     "json:{'driver':'null-co','size':65536}"
> Cannot change the option 'size'
>
> As I wrote in the commit message, though, I don't think this is too bad.
> First, before, it just crashed, so this definitely is better behavior.
>
> Secondly, I think this is just good for convenience; it allows the user
> to specify an option (to "change" it) even if the block driver doesn't
> support changing it. If it actually has not change, this is supposed to
> be handled gracefully. But sometimes we cannot easily handle it, so...
> We just give an error.
>
> I suspect that at some point we want to fix this by having everything
> correctly typed internally...? Until then, in my opinion, we can just
> not provide this feature.

Correcting the types in a QDict to match the schema is no easier than
converting it to a QAPI generated C type.  In my opinion we should work
towards the latter (QAPIfy stuff) instead of the former (dig us ever
deeper into the QObject hole).

> However, I should have probably not just deleted the comment and hoped
> everyone can find the necessary information through git-blame. I should
> leave a comment about this here.

Yes, please!

> Or we do make an effort to provide this test-unchanged functionality for
> every case, in which case we would have to convert either string options
> to the correct type (according to the schema) here (but if that were so
> simple, we could do that centrally in bdrv_open() already, right?) or

The one way we already have to check QObject types against the schema is
the QObject input visitor.  So, to get a QObject with correct types, you
can convert to the QAPI-generated C type with the appropriate variant of
the QObject input visitor, then right back with the QObject output
visitor.

But once we have the QAPI-generated C type, we should simply use *that*
instead of dicking around with QDict.  In other words: QAPIfy.

"Appropriate variant" means you need to choose between the variant that
expects correct scalar types (appropriate when the QObject comes from
JSON) and the keyval variant, which expects strings (appropriate when
the QObject comes from keyval_parse()).

> convert typed options to strings and compare them -- but since there are
> probably multiple different strings that can mean the same value for
> whatever type the option has, this won't work in every case either.

Converting to string throws away information.  Not sure that works.

> So I'm for leaving a comment and leaving this not quite as it should be
> until we have fixed all of the block layer (O:-)). Maybe you have a
> better idea though, which would be great.

Let's go with a comment.

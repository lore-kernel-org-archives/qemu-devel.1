Received: from eggs.gnu.org ([2001:4830:134:3::10]:48176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cinFm-0001P9-RT
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cinFl-0001xE-SR
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:16:06 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-4-git-send-email-armbru@redhat.com>
	<20170228154836.GF4090@noname.redhat.com>
	<a7bf9848-a8a1-718c-9dd7-4f2d1659cbe1@redhat.com>
	<87d1e2p4zw.fsf@dusky.pond.sub.org>
	<880a5146-13ef-bd7e-7fb8-02fb7fb663b2@redhat.com>
Date: Tue, 28 Feb 2017 20:15:56 +0100
In-Reply-To: <880a5146-13ef-bd7e-7fb8-02fb7fb663b2@redhat.com> (Eric Blake's
	message of "Tue, 28 Feb 2017 12:51:49 -0600")
Message-ID: <87poi2f7o3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 03/24] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/28/2017 12:03 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 02/28/2017 09:48 AM, Kevin Wolf wrote:
>>>> Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
>>>>> keyval_parse() parses KEY=VALUE,... into a QDict.  Works like
>>>>> qemu_opts_parse(), except:
>>>>>
>>>
>>>>> +
>>>>> +/*
>>>>> + * KEY=VALUE,... syntax:
>>>>> + *
>>>>> + *   key-vals     = [ key-val { ',' key-vals } ]
>>>
>>> Just refreshing my memory: in this grammar, [] means optional (0 or 1),
>>> and {} means repeating (0 or more).
>> 
>> Yes.
>> 
>>> That means an empty string satisfies key-vals (as in "-option ''"),
>>> intentional?
>> 
>> Yes.  Creates an empty root object.  If we don't want that, or don't
>> want it now, I can make this case an error.
>
> Making it an error now, with the ability to relax it later, would be in
> line with the fact that dotted notation cannot create an empty
> sub-element.  Supporting it now means we're stuck with it even if we
> decide the empty string could have usefully meant something else
> (although what else is useful besides an empty root object is beyond me).

We can outlaw "" during the freeze.

>>> I don't see how this permits a trailing comma, but isn't that one of
>>> your goals to allow "-option key=val," the same as "-option key=val"?
>> 
>> Mistake.  Possible fix:
>> 
>>           key-vals     = [ key-val { ',' key-val } [ ',' ]
>
> Unbalanced [].  I think you meant:
>
> key-vals = [ key-val { ',' key-val } [ ',' ] ]
>
> which properly rejects "-option ," while allowing "-option key=val,".

Fixed.

>>>>> + *   key-val      = key '=' val
>>>>> + *   key          = key-fragment { '.' key-fragment }
>>>
>>> Ambiguous.
>> 
>> I'm dense.  Can you give me an example string with two derivations?
>
> Sorry, poor editing on my part. (I wrote that before I figured out that
> {} meant 0 or more, then forgot to clean it up).  Looks like this one is
> well-formed after all.
>
>> 
>>>>> + *   key-fragment = / [^=,.]* /
>>>
>>> Do you want + instead of * in the regex, so as to require a non-empty
>>> string for key-fragment?  After all, you want to reject "-option a..b=val".
>> 
>> I like to keep syntactic and semantic analysis conceptually separate.
>> keyval_parse() looks for the next '.' to extract a key-fragment
>> (syntactic analysis).  It then rejects key-fragments it doesn't like
>> (semantic analysis).  Right now, it only dislikes lengths outside
>> [1,127].  Later on, it'll additionally dislike key-fragments that are
>> neither valid QAPI names nor digit strings.
>> 
>> Perhaps my comment could explain this better.
>
> Yes, a comment would help (then keeping the grammar accepting a 0-length
> string doesn't hurt, because the semantic analysis kicks in).

I'll try to address that when I clarify the comment on top.

>>>>> + *
>>>>> + * Semantics defined by reduction to JSON:
>>>>> + *
>>>>> + *   key-vals defines a tree of objects rooted at R
>>>>> + *   where for each key-val = key-fragment . ... = val in key-vals
>>>>> + *       R op key-fragment op ... = val'
>>>>> + *       where (left-associative) op is member reference L.key-fragment
>>>>
>>>> Maybe it's just me, but I can't say that I fully understand what these
>>>> last two lines are supposed to tell me.
>>>
>>> I think it's trying to portray dictionary member lookup semantics (each
>>> key-fragment represents another member lookup one dictionary deeper,
>>> before reaching the final lookup to the scalar value) - but yeah, it was
>>> a confusing read to me as well.
>> 
>> We're in a bit of a time squeeze right now.  I'd like to clarify the
>> comment on top.
>
> That's fair.  A poor comment isn't code, so fixing it in soft freeze is
> fine.  Maybe a FIXME is still appropriate, if we don't want to forget
> it, but I trust your judgment on this one.

Thanks!

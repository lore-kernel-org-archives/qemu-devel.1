Received: from eggs.gnu.org ([2001:4830:134:3::10]:56588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cim7h-0007wr-Ei
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cim7g-0000I0-Ca
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:03:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-4-git-send-email-armbru@redhat.com>
	<20170228154836.GF4090@noname.redhat.com>
	<a7bf9848-a8a1-718c-9dd7-4f2d1659cbe1@redhat.com>
Date: Tue, 28 Feb 2017 19:03:31 +0100
In-Reply-To: <a7bf9848-a8a1-718c-9dd7-4f2d1659cbe1@redhat.com> (Eric Blake's
	message of "Tue, 28 Feb 2017 10:57:10 -0600")
Message-ID: <87d1e2p4zw.fsf@dusky.pond.sub.org>
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

> On 02/28/2017 09:48 AM, Kevin Wolf wrote:
>> Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
>>> keyval_parse() parses KEY=VALUE,... into a QDict.  Works like
>>> qemu_opts_parse(), except:
>>>
>
>>> +
>>> +/*
>>> + * KEY=VALUE,... syntax:
>>> + *
>>> + *   key-vals     = [ key-val { ',' key-vals } ]
>
> Just refreshing my memory: in this grammar, [] means optional (0 or 1),
> and {} means repeating (0 or more).

Yes.

> That means an empty string satisfies key-vals (as in "-option ''"),
> intentional?

Yes.  Creates an empty root object.  If we don't want that, or don't
want it now, I can make this case an error.

> I don't see how this permits a trailing comma, but isn't that one of
> your goals to allow "-option key=val," the same as "-option key=val"?

Mistake.  Possible fix:

          key-vals     = [ key-val { ',' key-val } [ ',' ]

>>> + *   key-val      = key '=' val
>>> + *   key          = key-fragment { '.' key-fragment }
>
> Ambiguous.

I'm dense.  Can you give me an example string with two derivations?

>>> + *   key-fragment = / [^=,.]* /
>
> Do you want + instead of * in the regex, so as to require a non-empty
> string for key-fragment?  After all, you want to reject "-option a..b=val".

I like to keep syntactic and semantic analysis conceptually separate.
keyval_parse() looks for the next '.' to extract a key-fragment
(syntactic analysis).  It then rejects key-fragments it doesn't like
(semantic analysis).  Right now, it only dislikes lengths outside
[1,127].  Later on, it'll additionally dislike key-fragments that are
neither valid QAPI names nor digit strings.

Perhaps my comment could explain this better.

>>> + *   val          = { / [^,]* / | ',,' }
>
> Here, * makes sense, since an empty value is permitted in '-option key=".
>
>>> + *
>>> + * Semantics defined by reduction to JSON:
>>> + *
>>> + *   key-vals defines a tree of objects rooted at R
>>> + *   where for each key-val = key-fragment . ... = val in key-vals
>>> + *       R op key-fragment op ... = val'
>>> + *       where (left-associative) op is member reference L.key-fragment
>> 
>> Maybe it's just me, but I can't say that I fully understand what these
>> last two lines are supposed to tell me.
>
> I think it's trying to portray dictionary member lookup semantics (each
> key-fragment represents another member lookup one dictionary deeper,
> before reaching the final lookup to the scalar value) - but yeah, it was
> a confusing read to me as well.

We're in a bit of a time squeeze right now.  I'd like to clarify the
comment on top.

>>> + *             val' is val with ',,' replaced by ','
>>> + *   and only R may be empty.
>>> + *
>>> + *   Duplicate keys are permitted; all but the last one are ignored.
>>> + *
>>> + *   The equations must have a solution.  Counter-example: a.b=1,a=2
>>> + *   doesn't have one, because R.a must be an object to satisfy a.b=1
>>> + *   and a string to satisfy a=2.
>>> + *
>>> + * The length of any key-fragment must be between 1 and 127.
>>> + *
>>> + * Design flaw: there is no way to denote an empty non-root object.
>>> + * While interpreting "key absent" as empty object seems natural
>>> + * (removing a key-val from the input string removes the member when
>>> + * there are more, so why not when it's the last), it doesn't work:
>>> + * "key absent" already means "optional object absent", which isn't
>>> + * the same as "empty object present".
>>> + *
>>> + * Additional syntax for use with an implied key:
>>> + *
>>> + *   key-vals-ik  = val-no-key [ ',' key-vals ]
>>> + *   val-no-key   = / [^,]* /
>
> I think this needs to be [^,=]*, since the presence of an = means you've
> supplied a key, and are not using the implied-key sugar.

You're right.

>>> + *
>>> + * where no-key is syntactic sugar for implied-key=val-no-key.
>> 
>> s/no-key/val-no-key/ ?
>> 
>>> + *
>>> + * TODO support lists
>>> + * TODO support key-fragment with __RFQDN_ prefix (downstream extensions)
>> 
>> Worth another TODO comment for implied values that contain a comma? The
>> current restriction feels a bit artificial.
>
> It may be a bit artificial, but at least we can document it: implied
> keys are sugar that can only be used for certain values, but you can
> always avoid the sugar and explicitly provide the key=value for
> problematic values that can't be done with the implied key.

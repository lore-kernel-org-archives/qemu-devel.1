Received: from eggs.gnu.org ([2001:4830:134:3::10]:33849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chAlv-0008UK-GI
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chAlu-000163-F3
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:58:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-3-git-send-email-armbru@redhat.com>
	<5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
	<878toxmeol.fsf@dusky.pond.sub.org>
Date: Fri, 24 Feb 2017 08:58:25 +0100
In-Reply-To: <878toxmeol.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 23 Feb 2017 10:36:42 +0100")
Message-ID: <877f4g2f6m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 02/21/2017 03:01 PM, Markus Armbruster wrote:
[...]
>>> +    /* Implied value */
>>> +    qdict = keyval_parse("an,noaus,noaus=", NULL, &error_abort);
>>> +    g_assert_cmpuint(qdict_size(qdict), ==, 3);
>>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "an"), ==, "on");
>>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), ==, "off");
>>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "noaus"), ==, "");
>>> +    QDECREF(qdict);
>>
>> Oh, so '$key' implies the same as '$key=true'; 'no$key' implies the same
>> as '$key=false', and the presence of = is what changes an implicit bool
>> (with magic 'no' prefix handling) into a full keyname.  Looks a bit
>> weird, but it matches what QemuOpts does so we do need to keep that
>> magic around.
>
> I hate the 'no$key' sugar, and would love to get rid of it.  It makes
> things ambiguous (thus confusing) for precious little gain: 'novocaine'
> can mean 'novocaine=on' or 'vocaine=off'.  QemuOpts picks the latter,
> even when a QemuOpt named 'novocaine' has been declared.
>
> keyval_parse() is meant to behave like QemuOpts, so I'm reproducing this
> bit of bad sugar, reluctantly.

Implied value alternatives / variations:

(1) Don't implement the "no" sugar

    I think we'd have to deprecate it in QemuOpts now, to give users
    some time to adapt before keyval_parse() replaces QemuOpts.

(2) Restrict to boolean

    Have keyval_parse() store omitted value as QBool true/false instead
    of QString "on"/"off".  Make visit_type_bool() accept both.  Reject
    QBool everywhere else.

    This breaks abuse like nofilename=.

    It also breaks more legitimate use of implied values with
    enumeration types that happen to have values "on" or "off".
    Fixable: make visit_type_enum() do the right thing.  Requires
    bringing Visitor method type_enum() back.

(3) More magic

    The basic idea is to let the visitor figure out the implied value.

    First try: store "KEY" with value none.  When visit_type_bool() sees
    its key mapping to none, it picks true.  If it sees its key
    unmapped, it prepends "no", and if that's mapped to none, it picks
    false.  Add the obvious type errors.

    Sadly, this doesn't work, because it breaks wait,nowait:
    visit_type_bool() sees "wait" mapped to none and picks true, even
    though the later nowait should override it to false.  Also checking
    "no" doesn't help, because it can't distinguish nowait,wait from
    wait,nowait.

    Second try, keyval_parse() part:
    - If we have "noKEY": if "KEY" is already mapped to a boolean, set
      it to false, else set "noKEY" to true.
    - Else we have "KEY": if "noKEY" is already mapped to a boolean,
      delete it.  Then set "KEY" to true.
    This ensures that "noKEY" can map to boolean only when "KEY" does
    not.

    Visitor part: try "KEY" (accept both boolean and string), and if it
    doesn't exist, fall back to "noKEY" (accept only boolean, reverse
    sense).

    I'm not sure this magic is airtight as is.  Needs a good think.

If we're happy with bad sugar like "can't abbreviate novocaine=on to
novocaine" (confusing), "filename without a value gets you the file
'on'", we reimplement the bad sugar and move on.

If not, we have the choice between less magic or more magic.

Less magic: (1) and/or (2).

More magic: (3) or something like it.

If we don't want to decide right now, we can do

(4) Don't implement any implied value sugar for now

    You have to spell out =on and =off.  Big fat comment to remind us
    about the QemuOpts incompatibility.

I think this would be acceptable for -blockdev in 2.9.

Opinions?

[...]

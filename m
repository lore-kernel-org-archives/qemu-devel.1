Received: from eggs.gnu.org ([2001:4830:134:3::10]:35161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZwtf-0002Ma-Th
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 04:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZwte-0005D8-QI
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 04:44:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170202202739.GA15804@work-vm> <87shnvhfwc.fsf@dusky.pond.sub.org>
	<20170203165722.GC4674@work-vm>
Date: Sat, 04 Feb 2017 10:44:34 +0100
In-Reply-To: <20170203165722.GC4674@work-vm> (David Alan Gilbert's message of
	"Fri, 3 Feb 2017 16:57:23 +0000")
Message-ID: <8760kq8f3x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>> 
>> > * Markus Armbruster (armbru@redhat.com) wrote:
[...]
>> >> === Structured values ===
>> >> 
>> >> The dotted key convention messes with KEY syntax to permit structured
>> >> values.  Works, but the more conventional way to support structured
>> >> values is a syntax for structured values.  
>> >> 
>> >> An obvious one is to use { KEY=VALUE, ...} for objects, and [ VALUE,
>> >> ... ] for arrays.  Looks like this:
>> >> 
>> >>     -drive 'driver=quorum,
>> >>             child=[{ driver=file, filename=disk1.img },
>> >>                    { driver=host_device, filename=/dev/sdb },
>> >>                    { driver=nbd, host=localhost } ]'
>> >> 
>> >> Again, lines broken and indented for legibility; you need to join them
>> >> for actual use.
>> >> 
>> >> There's a syntactic catch, though: a value of the form [ ... ] can
>> >> either be an array or a string.  Which one it is depends on the type of
>> >> the key.  To parse this syntax, you need to know the types, unlike JSON
>> >> or traditional QemuOpts.  Unless we outlaw strings starting with '{' or
>> >> '[', which feels impractical.
>> >
>> > I don't understand why [ could imply a string.
>> 
>> Consider
>> 
>>     -drive 'driver=quorum,
>>             child=[{ driver=file, filename={"foolish":"name"} },
>>                    { driver=host_device, filename=/dev/sdb },
>>                    { driver=nbd, host=[::1] } ]'
>> 
>> Three KEY=VALUE have their VALUE start with '[' or '{':
>> 
>> * child=[{ driver=file, ...
>> 
>>   This is an array, not a string, because child is an array.
>> 
>> * host=[::1]
>> 
>>   This is a string, not an array containing the string "::1", because
>>   host is a string.
>
> Why is that accepted as valid input? Can't that just spit a
> 'I wanted a string not an array' ?

Because "[::1]" is a perfectly valid string.

It's also a valid array.  Unless the parser knows what type to expect
here, it cannot decide how to parse it.  That's why I wrote "to parse
this syntax, you need to know the types".

>> * filename={"foolish":"name"}
>> 
>>   This is a string, not an object, because filename is a string.
>> 
>> Clearer now?
>> 
>> >> But wait, there's another syntactic catch: in traditional QemuOpts, a
>> >> value ends at the next unescaped ',' or '\0'.  Inside an object, it now
>> >> also ends at the next unescaped '}', and inside an array, at the next
>> >> unescaped ']'.  Or perhaps at the next space (the example above assumes
>> >> it does).  That means we either have to provide a way to escape '}', ']'
>> >> and space, or find another way to delimit string values, say require '"'
>> >> around strings whenever the string contains "funny" characters.
>> >
>> > How about a tighter rule that if you've got a structured value -
>> > i.e. you're inside either of [ or {, then you must " all strings
>> > (except keys that we keep clean).
>> 
>> Matter of taste.
>> 
>> Regardless, we need a way to escape '"'.  Doubling it would be
>> consistent with the existing escape of ','.
>
> Doubling for escape feels hideous, especially for ".

No argument, but it beats counting backslashes.

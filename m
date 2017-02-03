Received: from eggs.gnu.org ([2001:4830:134:3::10]:58109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZhB2-00070I-AP
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZhB0-0006RB-PQ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:57:36 -0500
Date: Fri, 3 Feb 2017 16:57:23 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170203165722.GC4674@work-vm>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170202202739.GA15804@work-vm>
	<87shnvhfwc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87shnvhfwc.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> = Introduction =
> >> 
> >
> > <snip>
> >
> >> = Structured option argument syntax =
> >> 
> >> == JSON ==
> >> 
> >> The obvious way to provide the expressiveness of JSON on the command
> >> line is JSON.  Easy enough[2].  However, besides not being compatible,
> >> it's rather heavy on syntax, at least for simple cases.  Compare:
> >> 
> >>     -machine q35,accel=kvm
> >>     -machine '{ "type": "q35", "accel": "kvm"}'
> >> 
> >> It compares a bit more favourably in cases that use our non-flat hacks.
> >> Here's a flat list as KEY=VALUE,... with repeated keys, and as JSON:
> >> 
> >>     -semihosting-config enable,arg=eins,arg=zwei,arg=drei
> >>     -semihosting-config '{ "enable": true, "arg": [ "eins", "zwei", "drei" ] }'
> >> 
> >> Arbitrary nesting with dotted key convention:
> >> 
> >>     -drive driver=qcow2,file.driver=gluster,
> >>            file.volume=testvol,file.path=/path/a.qcow2,file.debug=9,
> >>            file.server.0.type=tcp,
> >>            file.server.0.host=1.2.3.4,
> >>            file.server.0.port=24007,
> >>            file.server.1.type=unix,
> >>            file.server.1.socket=/var/run/glusterd.socket
> >>     -drive '{ "driver": "qcow2",
> >>               "file": {
> >>                   "driver": "gluster", "volume": "testvol",
> >>                   "path": "/path/a.qcow2", "debug": 9,
> >>                   "server": [ { "type": "tcp",
> >>                                 "host": "1.2.3.4", "port": "24007"},
> >>                               { "type": "unix",
> >>                                 "socket": "/var/run/glusterd.socket" } ] } }'
> >
> > So while I generally hate JSON, the -drive dotted key syntax makes
> > me mad when it gets like this;  have a look
> > at the block replication and quorum setups especially, that can end up
> > with (from docs/COLO-FT.txt):
> >
> >   -drive if=virtio,id=primary-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,\
> >          children.0.file.filename=1.raw,\
> >          children.0.driver=raw -S
> >
> >    that's just way too many .'s to ever properly understand.
> > (I'm sure it used to be more complex).
> 
> Here's an idea to cut down on the dottery that drives you mad (and me
> too): if KEY starts with '.', combine it with a prefix of the previous
> one so that the result has the same number of name components.
> 
> Your example becomes
> 
>     -drive if=virtio,id=primary-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,\
>            children.0.file.filename=1.raw,.driver=raw -S
> 
> My example
> 
>      -drive driver=qcow2,file.driver=gluster,
>             file.volume=testvol,file.path=/path/a.qcow2,file.debug=9,
>             file.server.0.type=tcp,
>             file.server.0.host=1.2.3.4,
>             file.server.0.port=24007,
>             file.server.1.type=unix,
>             file.server.1.socket=/var/run/glusterd.socket
> 
> becomes
> 
>      -drive driver=qcow2,
>             file.driver=gluster,
>                 .volume=testvol,
>                 .path=/path/a.qcow2,
>                 .debug=9,
>             file.server.0.type=tcp,
>                          .host=1.2.3.4,
>                          .port=24007,
>             file.server.1.type=unix,
>                          .socket=/var/run/glusterd.socket
> 
> Mind, I'm not at all sure this is a *good* idea.  I suspect it's more
> magic than it's worth.

That is actually quite a nice compaction; it still feels pretty easy to read,
and doesn't use any more magic characters.

> >> Lines broken and indented for legibility; you need to join them for
> >> actual use.
> >
> > Why? What's a \n between friends for JSON?
> 
> You're right, the JSON works as is.  Only the KEY=VALUE example doesn't.
> 
> >> Once you do, both variants are basically illegible.  This
> >> is simply something that belongs into a config file rather than the
> >> command line.  In a config file, JSON would be a better choice.
> >> 
> >> There's also the -drive file=json:... syntax.  It's a bad fit for
> >> QemuOpts, because QemuOpts and JSON fight for the comma.  I'd show you
> >> if I could get it to work.
> >> 
> >> We obviously can't replace QemuOpts with JSON.  But accepting JSON in
> >> addition to QemuOpts is a debatable feature: it lets management
> >> applications reuse the code to build QMP arguments for option arguments.
> >> 
> >> Since structured option arguments are always dictionaries, a JSON option
> >> argument always starts with '{'.  If no QemuOpts argument can ever start
> >> with '{', accepting either QemuOpts or a JSON object is unambiguous.
> >> For a more detailed discussion of the following argument, see [3].
> >> 
> >> A QemuOpts argument normally starts with KEY.  We need to outlaw KEYs
> >> starting with '{'.  QAPI outlaws such names, see docs/qapi-code-gen.txt.
> >> QOM doesn't, but no such keys exist as far as I know.
> >> 
> >> QemuOpts permit abbreviating KEY=VALUE to just VALUE for one specific
> >> KEY (the "implied" key).  We need to limit this to KEYs whose VALUE
> >> can't start with '{'.  Most implied keys can't have such values.
> >> Troublemakers include qemu-img's use of implied "file" keys.  You'd have
> >> to say "file={my-tastelessly-named-file}" instead of just
> >> "{my-tastelessly-named-file}".
> >
> > What worries me a bit is building shell scripts which include ['s and {'s
> > tends to be painful.
> 
> No more than it already is if your builder copes with arbitrary
> filenames and such.  But point well taken.
> 
> > <snip>
> >
> >> === Structured values ===
> >> 
> >> The dotted key convention messes with KEY syntax to permit structured
> >> values.  Works, but the more conventional way to support structured
> >> values is a syntax for structured values.  
> >> 
> >> An obvious one is to use { KEY=VALUE, ...} for objects, and [ VALUE,
> >> ... ] for arrays.  Looks like this:
> >> 
> >>     -drive 'driver=quorum,
> >>             child=[{ driver=file, filename=disk1.img },
> >>                    { driver=host_device, filename=/dev/sdb },
> >>                    { driver=nbd, host=localhost } ]'
> >> 
> >> Again, lines broken and indented for legibility; you need to join them
> >> for actual use.
> >> 
> >> There's a syntactic catch, though: a value of the form [ ... ] can
> >> either be an array or a string.  Which one it is depends on the type of
> >> the key.  To parse this syntax, you need to know the types, unlike JSON
> >> or traditional QemuOpts.  Unless we outlaw strings starting with '{' or
> >> '[', which feels impractical.
> >
> > I don't understand why [ could imply a string.
> 
> Consider
> 
>     -drive 'driver=quorum,
>             child=[{ driver=file, filename={"foolish":"name"} },
>                    { driver=host_device, filename=/dev/sdb },
>                    { driver=nbd, host=[::1] } ]'
> 
> Three KEY=VALUE have their VALUE start with '[' or '{':
> 
> * child=[{ driver=file, ...
> 
>   This is an array, not a string, because child is an array.
> 
> * host=[::1]
> 
>   This is a string, not an array containing the string "::1", because
>   host is a string.

Why is that accepted as valid input? Can't that just spit a
'I wanted a string not an array' ?

> * filename={"foolish":"name"}
> 
>   This is a string, not an object, because filename is a string.
> 
> Clearer now?
> 
> >> But wait, there's another syntactic catch: in traditional QemuOpts, a
> >> value ends at the next unescaped ',' or '\0'.  Inside an object, it now
> >> also ends at the next unescaped '}', and inside an array, at the next
> >> unescaped ']'.  Or perhaps at the next space (the example above assumes
> >> it does).  That means we either have to provide a way to escape '}', ']'
> >> and space, or find another way to delimit string values, say require '"'
> >> around strings whenever the string contains "funny" characters.
> >
> > How about a tighter rule that if you've got a structured value -
> > i.e. you're inside either of [ or {, then you must " all strings
> > (except keys that we keep clean).
> 
> Matter of taste.
> 
> Regardless, we need a way to escape '"'.  Doubling it would be
> consistent with the existing escape of ','.

Doubling for escape feels hideous, especially for ".

Dave

> >> So, if escaped ',' wasn't ugly and confusing enough for you...
> >> 
> >> === Comparison ===
> >> 
> >> In my opinion, dotted keys are weird and ugly, but at least they don't
> >> add to the quoting mess.  Structured values look better, except when
> >> they do add to the quoting mess.
> >> 
> >> I'm having a hard time deciding which one I like less :)
> >> 
> >> Opinions?  Other ideas?
> >
> > Dave
> >
> >> 
> >> 
> >> 
> >> 
> >> [1] [PATCH v14 00/21] QAPI/QOM work for non-scalar object properties
> >> (actually v15)
> >> Message-Id: <1475246744-29302-1-git-send-email-berrange@redhat.com>
> >> http://lists.gnu.org/archive/html/qemu-devel/2016-09/msg08238.html
> >> 
> >> [2] [RFC PATCH] block: Crude initial implementation of -blockdev
> >> Message-Id: <1485968933-9162-1-git-send-email-armbru@redhat.com>
> >> http://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00182.html
> >> 
> >> [3] Message-ID: <87h989ncse.fsf@dusky.pond.sub.org>
> >> http://lists.gnu.org/archive/html/qemu-devel/2016-10/msg04046.html
> >> 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

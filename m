Received: from eggs.gnu.org ([2001:4830:134:3::10]:53276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cagPM-0008Rr-8v
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cagPL-0005Gl-BP
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:20:28 -0500
Date: Mon, 6 Feb 2017 10:20:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170206102017.GA2524@work-vm>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170202202739.GA15804@work-vm>
	<87shnvhfwc.fsf@dusky.pond.sub.org> <20170203165722.GC4674@work-vm>
	<8760kq8f3x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8760kq8f3x.fsf@dusky.pond.sub.org>
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
> >> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> >> 
> >> > * Markus Armbruster (armbru@redhat.com) wrote:
> [...]
> >> >> === Structured values ===
> >> >> 
> >> >> The dotted key convention messes with KEY syntax to permit structured
> >> >> values.  Works, but the more conventional way to support structured
> >> >> values is a syntax for structured values.  
> >> >> 
> >> >> An obvious one is to use { KEY=VALUE, ...} for objects, and [ VALUE,
> >> >> ... ] for arrays.  Looks like this:
> >> >> 
> >> >>     -drive 'driver=quorum,
> >> >>             child=[{ driver=file, filename=disk1.img },
> >> >>                    { driver=host_device, filename=/dev/sdb },
> >> >>                    { driver=nbd, host=localhost } ]'
> >> >> 
> >> >> Again, lines broken and indented for legibility; you need to join them
> >> >> for actual use.
> >> >> 
> >> >> There's a syntactic catch, though: a value of the form [ ... ] can
> >> >> either be an array or a string.  Which one it is depends on the type of
> >> >> the key.  To parse this syntax, you need to know the types, unlike JSON
> >> >> or traditional QemuOpts.  Unless we outlaw strings starting with '{' or
> >> >> '[', which feels impractical.
> >> >
> >> > I don't understand why [ could imply a string.
> >> 
> >> Consider
> >> 
> >>     -drive 'driver=quorum,
> >>             child=[{ driver=file, filename={"foolish":"name"} },
> >>                    { driver=host_device, filename=/dev/sdb },
> >>                    { driver=nbd, host=[::1] } ]'
> >> 
> >> Three KEY=VALUE have their VALUE start with '[' or '{':
> >> 
> >> * child=[{ driver=file, ...
> >> 
> >>   This is an array, not a string, because child is an array.
> >> 
> >> * host=[::1]
> >> 
> >>   This is a string, not an array containing the string "::1", because
> >>   host is a string.
> >
> > Why is that accepted as valid input? Can't that just spit a
> > 'I wanted a string not an array' ?
> 
> Because "[::1]" is a perfectly valid string.
> 
> It's also a valid array.  Unless the parser knows what type to expect
> here, it cannot decide how to parse it.  That's why I wrote "to parse
> this syntax, you need to know the types".

I think that's fine; the parser would just parse something starting with
a [ as an array, always.  You just define that and then everyone knows
that you'd better " it if you've got a [ in your string.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

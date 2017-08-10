Received: from eggs.gnu.org ([2001:4830:134:3::10]:35390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfif2-0002Lm-Tc
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfif1-00029h-4Y
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:17:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-18-eblake@redhat.com>
	<87shh0n38c.fsf@dusky.pond.sub.org>
	<fb135fb9-8c99-912e-ffe7-9d06800e8f5e@redhat.com>
Date: Thu, 10 Aug 2017 10:17:27 +0200
In-Reply-To: <fb135fb9-8c99-912e-ffe7-9d06800e8f5e@redhat.com> (Eric Blake's
	message of "Wed, 9 Aug 2017 16:57:19 -0500")
Message-ID: <874ltfj0q0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 17/22] libqtest: Add qmp_args() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "open list:IDE" <qemu-block@nongnu.org>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Eric Blake <eblake@redhat.com> writes:

> On 08/09/2017 10:57 AM, Markus Armbruster wrote:
>
>> I don't like the qmp_args name.  It's not about arguments, it's about
>> sending a command with arguments.
>> 
>> I'm afraid I'm getting pretty thorougly confused by the evolving
>> interface.  So I stop and think how it should look like when done.
>
> At a bare minimum, I like your idea that we want:
>
> FOO_send()     # sends a message, does not wait for a reply
> FOO_receive()  # reads one JSON object, returns QObject counterpart
> FOO() # combo of FOO_send() and FOO_receive()
>
> Then FOO_discard() is a convenient shorthand for QDECREF(FOO_receive()).

Yes.

Obvious names for the variations of FOO_send():

FOO_send()    send a string exactly as is
FOO_sendf()   build a string from a template, interpolating from ...
FOO_vsendf()  ditto, interpolating from va_list

Since "send string exactly as is" is uncommon, using a longer name for
it would be okay.  Say FOO_send_string() or FOO_send_raw().

> Which FOO do we need? Right now, we have 'qmp' for anything using the
> global_qtest, 'qtest_qmp' for anything using an explicit QTestState (but
> we're arguing that is overkill), and 'qmp_fd' for anything using a raw
> fd (test-qga.c - and where I added 'qga' in 11/22, although that
> addition was local rather than in libqtest.h).

'qmp', 'qtest_qmp' and 'qmp_fd' sounds good.  I hope we can get rid of
'qtest_qmp'.

> I also just had an insight: it is possible to write a macro
> qmp_send(...) that will expand to qmp_send_cmd(name) if there is only
> one argument, but to qmp_send_cmdf(name, fmt, ...) if there is more than
> one argument (and later expose a public qmp_send_cmdv(name, fmt,
> va_list) as pair if it is needed, although right now it is not).
> Perhaps we can even make the one-arg form expand to qmp_send_cmdf(name,
> " "), if that's enough to silence gcc's -Wformat-zero-length, and if our
> underlying routines are smart enough to recognize a single-space
> argument as not being worthy of calling qobject_from_jsonf() (since
> qobject_from_jsonf() aborts rather than returning NULL when presented
> just whitespace).
>
> In fact, having a macro qmp_send(cmd, ...) expand to
> qmp_send_internal(cmd, " " __VA_ARGS__) might even do the trick without
> preprocessor magic of checking whether __VA_ARGS__ contains a comma
> (although it has the subtle limitation that if present, a format
> argument MUST be a string literal because we now rely on string
> concatenation with " " - although given gcc's -Wformat-nonliteral, we
> are probably okay with that limitation).
>
> So, with a nice macro, the bulk of the testsuite would just write in
> this style:
>
> qmp_send("foo");
> qmp_send("foo", "{literal_args...}");
> qmp_send("foo", "{'name':%s}", value);
>
> for send without waiting, or:
>
> obj = qmp("foo");
> obj = qmp(foo", "{literal_args...}");
> obj = qmp("foo", "{'name':%s}", value);
>
> where the result matters.  And the names we choose for internal
> implementation are no longer quite as important (although still helpful
> to get right).

Play with it, and we'll see how it turns out.

>> We need send and receive.  Convenience functions to do both, and to
>> receive and throw away are nice to have.
>
> Do we want both a convenience function to throw away a single read, AND
> a function to send a command + throw away a read? Prior to this series,
> we have qmp_discard_response() which is send + discard, but nothing that
> does plain discard; although plain discard is a better building block
> (precisely because then we don't have to duplicate all the different
> send forms) - the convenience of send+receive in one call should be
> limited to the most common case.

The interface should provide the basic building blocks.

Convenience functions are welcome when they help the interface' users
write clearer code.  Less code is often clearer code.

> Also, the qmp_eventwait() is a nice convenience function for wait in a
> loop until the received object matches a given name; whether we also
> need the convenience of qmp_eventwait_ref() is a bit more debatable
> (perhaps we could just as easily have qmp_event_wait() always return an
> object, and require the caller to QDECREF() it, for one less function to
> maintain).

See previous paragraph :)

>> We need qmp_raw().  We haven't found a need for a raw receive function.
>
> Yes, qmp_raw() (or maybe it should be named qmp_send_raw(), depending on
> whether the receive is coupled with it?) is our backdoor for sending
> JSON that does not match the normal {'execute':'name','arguments':{}}
> paradigm (and pretty much qmp-test.c, or maybe also test-qga.c, would be
> the only clients).

A "send raw and receive cooked" function feels slightly weird.  Since
it's used only rarely, we might want to avoid the weirdness and use a
pair of calls there.

Apropos raw vs. cooked: the "send cooked" functions convert single
quotes in the template to double quotes.  The "send raw" functions
don't.  Doesn't matter when we send *to* QEMU.  Would be wrong for the
other direction, though.

> [Side node - why can't we pick a consistent naming of our tests?  The
> name 'FOO-test' is a bit nicer than 'test-FOO' when it comes to writing
> .gitignore entries. Should we do a bulk cleanup rename to get all the
> tests into one consistent naming style?]

If you look closely, you'll find that unit tests are generally named
test-FOO.c or (less commonly) check-FOO.c, and libqtest tests
FOO-test.c.  There are exceptions, probably because people don't get
this implicit (and arbitrary!) convention.

>> Convenience functions to build commands and send are nice to have.  They
>> come in pairs, without arguments, to avoid -Wno-format-zero-length
>> (aside: that's one of the sillier warnings).
>
> It's possible to alter CFLAGS to shut gcc up on that one while still
> getting the rest of -Wformat, if we don't think it adds value to qemu.
> My idea above is that you can use a macro to hide the worst of the
> paired nature, so that the bulk of the testsuite can supply or omit an
> arguments format string as desired.
>
>> 
>> We used to have almost everything with and without QTestState, but we're
>> refusing to continue that self-flagellation.
>
> And for v5, I think I'll reorder my series to get rid of QTestState
> sooner, rather than later.

Makes sense.

>> For every function taking ..., we want one taking va_list.
>
> Under the hood, probably.  Whether the va_list form has to be exported
> is a different question (we might be able to get by with just the ... form).

We can omit functions that aren't actually used.  However, when we omit
a va_list buddy, we should keep its name available, in case we need it
later.

>> Makes sense?
>> 
>> Can we derive a sensible set of function names from this?
>> 
>
> I gave it a shot.

Thanks!

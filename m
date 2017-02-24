Received: from eggs.gnu.org ([2001:4830:134:3::10]:43858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chMK1-0003vd-0B
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chMJz-0000SC-OS
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:18:33 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-3-git-send-email-armbru@redhat.com>
	<5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
	<878toxmeol.fsf@dusky.pond.sub.org>
	<877f4g2f6m.fsf@dusky.pond.sub.org>
	<c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com>
	<87h93j2ytj.fsf@dusky.pond.sub.org>
	<86ea8b80-f2ae-088f-ae2d-cf529d2db02b@redhat.com>
Date: Fri, 24 Feb 2017 21:18:21 +0100
In-Reply-To: <86ea8b80-f2ae-088f-ae2d-cf529d2db02b@redhat.com> (Eric Blake's
	message of "Fri, 24 Feb 2017 13:25:53 -0600")
Message-ID: <87r32nxrzm.fsf@dusky.pond.sub.org>
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/24/2017 01:06 PM, Markus Armbruster wrote:
>
>> 
>> The value of an implied key is not subject to key desugaring.
>
> And that's a good thing.
>
>> 
>> Without an implied key, the "node" would desugar to "de=off".
>> 
>>> How about:
>>>
>>> for 2.9: -blockdev has no magic at all (you HAVE to spell 'foo=off'
>>> rather than 'foo' for any boolean parameters that you want disabled in
>>> -blockdev);
>> 
>> You mean "rather than 'nofoo'".
>
> Yes.  Thanks for catching the intent.
>
>> 
>> "No magic at all" implies you also have to spell "foo=on" rather than
>> "foo".
>
> I'm a little more lenient for allowing 'foo' meaning 'foo=on' as a
> shortcut (although making it force a QBool rather than a string "on" may
> be nicer).

No objection.

>             I'm also okay if -blockdev has no sugar at all in 2.9 (we
> can add "foo" => "foo=on" sugar later if it makes QemuOpts conversion
> easier in 2.10; that's much more palatable than adding "nofoo" =>
> "foo=off" sugar).
>
>> I believe we need to have both or none in 2.9.  If we have only the "on"
>> sugar, "no-flush" works, and we can't add the "off" sugar without
>> breaking it.
>
> I think the "off" sugar should die, if we can convince ourselves that no
> one is using it that can't catch up to modern usage.

Yes, but we should be careful not to create problems now in case we
can't.

>>> -blockdev); and in QemuOpts, we issue deprecation warnings but keep
>>> existing behavior any time someone uses 'noFOO' that we turn into
>>> 'FOO=no'.  Then, for 2.10, we can decide to remove the deprecation
>>> warnings if they pointed out real (ab)use of the sugar in the wild, or
>>> (hopefully) to kill the sugar entirely (as part of converting QemuOpts
>>> over to keyval_parse).
>>>
>>> In short, getting rid of the 'no' prefix magic, after suitable
>>> deprecation warnings, seems like a good plan to me; and having -blockdev
>>> be slightly tighter than the rest of command line options for 2.9 only
>>> is no real loss (no one uses -blockdev yet, so they can be written to
>>> avoid the use of 'no' magic to begin with).
>> 
>> Okay, I'll post QemuOpts patch to deprecate noKEY sugar.  Let's see
>> whether anyone screams.
>
> Summarizing to make sure we're on the same track:
>
> 2.9:
> QemuOpts:
>   "noFOO" => "FOO=off" sugar - deprecation warning
>   "FOO" => "FOO=on" sugar - silently stays the same

Yes, if we can get consensus.

> -blockdev option 1:
>   "FOO" => error, no '=' present (we haven't decided on sugaring this yet)
>   "noFOO" => error, no '=' present (no off sugar, but also avoids
> "noFOO" => "noFOO=on" sugar)

Yes.

> -blockdev option 2:
>   "FOO" => "FOO=on" - enabled boolean sugar remains compact, if it is
> not ambiguous, but anything we can do to limit it to just boolean values
> rather than the string "on" might be nice
>   "noFOO" => "noFOO=on" - different behavior than QemuOpts, but less magic

No, because that would create problems if we can't get rid of noFOO
sugar elsewhere.

> 2.10:
> QemuOpts will be implemented on keyval_parse(), behaving the same as
> -blockdev.

Not sure I can complete the job in 2.10, but the text works just as well
for a later version.

>            If we took option 1 in 2.9, we have:
>   "noFOO" => "noFOO=on" (which probably triggers an error that "noFOO"
> is not an option when strict parsing is in effect) (the deprecation
> period is over, so we changed command-line behavior, but only for people
> that didn't pay attention to the warnings in 2.9)

Yes.

>   "FOO" => "FOO=on" - keep this one to minimize back-compat breakage

Yes.

> If we took option 2 in 2.9, we can still turn on "FOO" => "FOO=on" sugar
> to get back to option 1 in 2.10
>
> or we can stick to option 2 forevermore:
>   "FOO" => error, no '=' present. No longer possible to specify booleans
> without the more verbose "FOO=on"

Now I'm getting confused.  Isn't that "-blockdev option 1"?

> I have a preference for option 1 in the long run, but as it seems to be
> upwards compatible from option 2 for -blockdev in 2.9, I'm leaning
> towards option 2 for this release.

Let me rename the options:

* "no sugar -blockdev": both "FOO" and "noFOO" are rejected.

* "positive sugar blockdev": "FOO" is desugared to "FOO=on", "noFOO" to
  "noFOO=on".

Which one do you prefer for 2.9?

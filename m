Received: from eggs.gnu.org ([2001:4830:134:3::10]:40387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chLCT-0000WA-Rt
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chLCS-0000Ty-ON
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:06:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-3-git-send-email-armbru@redhat.com>
	<5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
	<878toxmeol.fsf@dusky.pond.sub.org>
	<877f4g2f6m.fsf@dusky.pond.sub.org>
	<c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com>
Date: Fri, 24 Feb 2017 20:06:32 +0100
In-Reply-To: <c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com> (Eric Blake's
	message of "Fri, 24 Feb 2017 10:24:21 -0600")
Message-ID: <87h93j2ytj.fsf@dusky.pond.sub.org>
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

> On 02/24/2017 01:58 AM, Markus Armbruster wrote:
>
>>> I hate the 'no$key' sugar, and would love to get rid of it.  It makes
>>> things ambiguous (thus confusing) for precious little gain: 'novocaine'
>>> can mean 'novocaine=on' or 'vocaine=off'.  QemuOpts picks the latter,
>>> even when a QemuOpt named 'novocaine' has been declared.
>>>
>>> keyval_parse() is meant to behave like QemuOpts, so I'm reproducing this
>>> bit of bad sugar, reluctantly.
>> 
>> Implied value alternatives / variations:
>> 
>> (1) Don't implement the "no" sugar
>> 
>>     I think we'd have to deprecate it in QemuOpts now, to give users
>>     some time to adapt before keyval_parse() replaces QemuOpts.
>> 
>
>> 
>> If we're happy with bad sugar like "can't abbreviate novocaine=on to
>> novocaine" (confusing), "filename without a value gets you the file
>> 'on'", we reimplement the bad sugar and move on.
>> 
>> If not, we have the choice between less magic or more magic.
>> 
>> Less magic: (1) and/or (2).
>> 
>> More magic: (3) or something like it.
>> 
>> If we don't want to decide right now, we can do
>> 
>> (4) Don't implement any implied value sugar for now
>> 
>>     You have to spell out =on and =off.  Big fat comment to remind us
>>     about the QemuOpts incompatibility.
>> 
>> I think this would be acceptable for -blockdev in 2.9.
>> 
>> Opinions?
>
> Do any existing blockdev sub-parameters begin with 'no'?  Ouch:
> BlockdevOptions has '*cache':'BlockdevCacheOptions' which in turn has
> '*no-flush':'bool'.

I hate negative flags.

>                      Even worse, I think you could abuse 'nono-flush' to
> enable flushing - my head hurts.

"no-flush" gets desugared to "-flush=off", which doesn't work.

"nono-flush" gets desugared to "no-flush=off", which works.

> And of course, there's the obvious BlockDevOptions '*node-name':'str'.
> No one in their right mind would expect 'node-name' without parameters
> to result in 'de-name=no'.

This is something I'd be even willing to break for existing options.

> Also, I found that at least libvirt has existing command line usage
> -numa node,nodeid=0, where qemu_numa_opts uses .implied_opt_name="type",
> .desc = {{0}} to be visited by OptsVisitor.  Because of the implied opt,
> we get the desired "type=node" rather than the accidental "de=no", but
> the magic of implied keys can certainly make it weird to think about.

Correct.

The value of an implied key is not subject to key desugaring.

Without an implied key, the "node" would desugar to "de=off".

> How about:
>
> for 2.9: -blockdev has no magic at all (you HAVE to spell 'foo=off'
> rather than 'foo' for any boolean parameters that you want disabled in
> -blockdev);

You mean "rather than 'nofoo'".

"No magic at all" implies you also have to spell "foo=on" rather than
"foo".

I believe we need to have both or none in 2.9.  If we have only the "on"
sugar, "no-flush" works, and we can't add the "off" sugar without
breaking it.

> -blockdev); and in QemuOpts, we issue deprecation warnings but keep
> existing behavior any time someone uses 'noFOO' that we turn into
> 'FOO=no'.  Then, for 2.10, we can decide to remove the deprecation
> warnings if they pointed out real (ab)use of the sugar in the wild, or
> (hopefully) to kill the sugar entirely (as part of converting QemuOpts
> over to keyval_parse).
>
> In short, getting rid of the 'no' prefix magic, after suitable
> deprecation warnings, seems like a good plan to me; and having -blockdev
> be slightly tighter than the rest of command line options for 2.9 only
> is no real loss (no one uses -blockdev yet, so they can be written to
> avoid the use of 'no' magic to begin with).

Okay, I'll post QemuOpts patch to deprecate noKEY sugar.  Let's see
whether anyone screams.

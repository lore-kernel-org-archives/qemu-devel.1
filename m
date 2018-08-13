Received: from eggs.gnu.org ([2001:4830:134:3::10]:50218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpES1-0002OS-Hw
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpES0-0004AS-H0
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:08:09 -0400
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<c134bab4-43ab-91c3-c7d9-cc8306fb4e3c@redhat.com>
	<20180813090819.GC4323@localhost.localdomain>
	<877eku8v7z.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fae82477-d0fb-8c42-9d66-f0aa51020144@redhat.com>
Date: Mon, 13 Aug 2018 10:08:01 -0500
MIME-Version: 1.0
In-Reply-To: <877eku8v7z.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 08/13/2018 04:35 AM, Markus Armbruster wrote:

>>> Or, here's an idea:
>>>
>>> Keep the name @base and @top, but add a new '*by-node':'bool' parameter,
>>> defaulting to false for now, but perhaps with a deprecation warning that
>>> we'll switch the default to true in one release and delete the parameter
>>> altogether in an even later release. When false, @base and @top are
>>> filenames, as before; when true, @base and @top are node names instead.
>>> Introspectible, nicer names in the long run, and avoids having to detect a
>>> user providing two mutually-exclusive options at once.
>>
>> I don't like options that completely change the semantics of other
>> options, but maybe that's just personal preference.
> 
> I happen to share it.

Okay, we'll ditch that idea as a non-starter.

> 
>> Anyway, thinking about the long term for block-commit is useless, the
>> command is just broken (for example, the @device option doesn't make any
>> sense) and will have to be replaced. But libvirt needs something _now_
>> for the -blockdev support, so I decided to add this as a quick hack
>> before we get the proper replacement.
>>
>> I think it makes more sense to create a new blockdev-commit (which
>> would be a name more in line with the other block job commands) and
>> deprecate the old block-commit command as a whole.

Okay, looks like a good plan for the long term, and thus a good 
rationale for the short-term choices. The commit message could call that 
out.


>> Has any progress been made on the plan to support defaults in QAPI, so
>> that we could get rid of the has_* parameters?
> 
> No.  It's one of those things that keep getting pushed out by more
> important or urgent stuff.
> 
> I expect it to be straightforward, if tedious.

In part, Marc-Andre's work to get conditional compilation in has gotten 
us closer, in that we can have 'name':{'type':'foo','if':'...'} instead 
of 'name':'type', since that dict for conditional compilation is also 
where we would stick in default values.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

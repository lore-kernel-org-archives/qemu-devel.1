Received: from eggs.gnu.org ([209.51.188.92]:55336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1W0s-000502-V5
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1W0s-0003Wz-4s
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:51:10 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190301160929.19892-1-stefanha@redhat.com>
	<bd5824cb-7adb-1e96-fbd2-eb666288c253@redhat.com>
	<20190306101811.GJ22159@stefanha-x1.localdomain>
Date: Wed, 06 Mar 2019 13:50:59 +0100
In-Reply-To: <20190306101811.GJ22159@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Wed, 6 Mar 2019 10:18:11 +0000")
Message-ID: <87sgw0yxn0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: add drop-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Neil Skrypuch <neil@tembosocial.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Fri, Mar 01, 2019 at 10:30:07AM -0600, Eric Blake wrote:
>> On 3/1/19 10:09 AM, Stefan Hajnoczi wrote:
>> > Commit dd577a26ff03b6829721b1ffbbf9e7c411b72378 ("block/file-posix:
>> > implement bdrv_co_invalidate_cache() on Linux") introduced page cache
>> > invalidation so that cache.direct=off live migration is safe on Linux.
>> > 
>> > The invalidation takes a significant amount of time when the file is
>> > large and present in the page cache.  Normally this is not the case for
>> > cross-host live migration but it can happen when migrating between QEMU
>> > processes on the same host.
>> > 
>> > On same-host migration we don't need to invalidate pages for correctness
>> > anyway, so an option to skip page cache invalidation is useful.  I
>> > investigated optimizing invalidation and detecting same-host migration,
>> > but both are hard to achieve so a user-visible option will suffice.
>> > 
>> > Suggested-by: Neil Skrypuch <neil@tembosocial.com>
>> > Tested-by: Neil Skrypuch <neil@tembosocial.com>
>> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> > Reviewed-by: Eric Blake <eblake@redhat.com>
>> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > ---
>> > v2:
>> >  * Remove outdated comment about libvirt feature detection [danpb]
>> 
>> Question - if we used qapi's 'if':COND to only declare the field on
>> platforms where we know at compile time that we can support it, would
>> that be enough for libvirt to introspect that if the field exists then
>> migration is safe, without having to rely on an query-qemu-features command?
>
> Yes, although this raises another question:
>
> The drop-cache implementation is not #ifdefed in file-posix.c.  If we
> make the QMP schema conditional, should we also #ifdef the command-line
> option in raw_runtime_opts[] to prevent QEMU from silently ignoring this
> option?

Silently ignoring user directives is generally a bad idea.  Possible
exceptions include directives of a "$frobnicate if you can" kind.

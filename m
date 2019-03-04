Received: from eggs.gnu.org ([209.51.188.92]:35520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0jK9-0008Sp-W1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0jK8-0000t0-MR
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:51:49 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190301160929.19892-1-stefanha@redhat.com>
	<bd5824cb-7adb-1e96-fbd2-eb666288c253@redhat.com>
Date: Mon, 04 Mar 2019 09:51:33 +0100
In-Reply-To: <bd5824cb-7adb-1e96-fbd2-eb666288c253@redhat.com> (Eric Blake's
	message of "Fri, 1 Mar 2019 10:30:07 -0600")
Message-ID: <87lg1vaup6.fsf@dusky.pond.sub.org>
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
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Neil Skrypuch <neil@tembosocial.com>, Max Reitz <mreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 3/1/19 10:09 AM, Stefan Hajnoczi wrote:
>> Commit dd577a26ff03b6829721b1ffbbf9e7c411b72378 ("block/file-posix:
>> implement bdrv_co_invalidate_cache() on Linux") introduced page cache
>> invalidation so that cache.direct=off live migration is safe on Linux.
>> 
>> The invalidation takes a significant amount of time when the file is
>> large and present in the page cache.  Normally this is not the case for
>> cross-host live migration but it can happen when migrating between QEMU
>> processes on the same host.
>> 
>> On same-host migration we don't need to invalidate pages for correctness
>> anyway, so an option to skip page cache invalidation is useful.  I
>> investigated optimizing invalidation and detecting same-host migration,
>> but both are hard to achieve so a user-visible option will suffice.
>> 
>> Suggested-by: Neil Skrypuch <neil@tembosocial.com>
>> Tested-by: Neil Skrypuch <neil@tembosocial.com>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>> v2:
>>  * Remove outdated comment about libvirt feature detection [danpb]
>
> Question - if we used qapi's 'if':COND to only declare the field on
> platforms where we know at compile time that we can support it, would
> that be enough for libvirt to introspect that if the field exists then
> migration is safe, without having to rely on an query-qemu-features command?
>
>> +++ b/qapi/block-core.json
>> @@ -2807,6 +2807,10 @@
>>  # @locking:     whether to enable file locking. If set to 'auto', only enable
>>  #               when Open File Descriptor (OFD) locking API is available
>>  #               (default: auto, since 2.10)
>> +# @drop-cache:  invalidate page cache during live migration.  This prevents
>> +#               stale data on the migration destination with cache.direct=off.
>> +#               Currently only supported on Linux hosts.
>> +#               (default: on, since: 4.0)
>>  # @x-check-cache-dropped: whether to check that page cache was dropped on live
>>  #                         migration.  May cause noticeable delays if the image
>>  #                         file is large, do not use in production.
>> @@ -2819,6 +2823,7 @@
>>              '*pr-manager': 'str',
>>              '*locking': 'OnOffAuto',
>>              '*aio': 'BlockdevAioOptions',
>> +            '*drop-cache': 'bool',
>>              '*x-check-cache-dropped': 'bool' } }
>
> In other words, now that we can use 'if' to hide features that aren't
> supported based on compile-time knowledge, shouldn't we use that to make
> the doc comment "only supported on Linux hosts" introspectible?

When the code behind some QAPI entity is under #if conditional, we
should consider putting the QAPI entity under the same conditional.

On introspection strategy, my general advice is to make query-qmp-schema
do whenever it can be done easily and "naturally".  Adding stuff to the
schema nobody needs except to detect it in query-qmp-schema wouldn't be
"natural".

However, consider these three cases:

1. Feature is not compiled into this build

   E.g. @drop-cache is not implemented in this build configuration.

2. Compiled into this build, always works

   E.g. @drop-cache is implemented in this build configuration, and will
   work on any supported host capable of running this build.

3. Compiled into this build, but whether it works is known only at
   run-time

   E.g. @drop-cache is implemented in this build configuration, but
   drop-cache: true might be rejected on some hosts.

As far as I understand, case 3. doesn't exist right now for @drop-cache.

As long as that's the case, query-qmp-schema suffices.

If it's not the case, we may want to use other means for it, such as
query-qmp-features.  If we anticipate it not being the case, we might
want to use other means even sooner.

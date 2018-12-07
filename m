Received: from eggs.gnu.org ([2001:4830:134:3::10]:58167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVIBR-0003is-Ha
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVIBP-00041R-8R
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:36:53 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-14-eblake@redhat.com>
	<1827042e-ddf6-47cd-52b3-403e37c7fa1f@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce5520fd-11bf-e927-49c9-1e8422d053f3@redhat.com>
Date: Fri, 7 Dec 2018 09:36:35 -0600
MIME-Version: 1.0
In-Reply-To: <1827042e-ddf6-47cd-52b3-403e37c7fa1f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/14] qemu-nbd: Add --list option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 12/7/18 6:48 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.12.2018 1:03, Eric Blake wrote:
>> We want to be able to detect whether a given qemu NBD server is
>> exposing the right export(s) and dirty bitmaps, at least for
>> regression testing.  We could use 'nbd-client -l' from the upstream
>> NBD project to list exports, but it's annoying to rely on
>> out-of-tree binaries; furthermore, nbd-client doesn't necessarily
>> know about all of the qemu NBD extensions.  Thus, we plan on adding
> 
> ha, in this patch, not plan but add:)

Yep, copy-and-paste of a common prefix across multiple patches. I'll 
probably let the text diverge in v2 to be a bit more accurate per-patch, 
at the loss of the nice copy-and-paste.

>> I debated about adding this functionality to something akin to
>> 'qemu-img info' - but that tool does not readily lend itself
>> to connecting to an arbitrary NBD server without also tying to
>> a specific export (I may, however, still add ImageInfoSpecificNBD
>> for reporting the bitmaps available when connecting to a single
>> export).  And, while it may feel a bit odd that normally
>> qemu-nbd is a server but 'qemu-nbd -L' is a client, we are not
>> really making the qemu-nbd binary that much larger, because
>> 'qemu-nbd -c' has to operate as both server and client
>> simultaneously across two threads when feeding the kernel module
>> for /dev/nbdN access.
>>
>> Sample output:
>> $ qemu-nbd -L
>> exports available: 1
>>    export: ''
>>     size:  65536
>>     flags: 0x4ed ( flush fua trim zeroes df cache )
>>     min block: 512
>>     opt block: 4096
>>     max block: 33554432
>>     available meta contexts: 1
>>      base:allocation
> 
> don't you plan to bind this all to QAPI and expose in json?

No. As explained above, QAPI is very much centered on per-BDS actions, 
while this action is a per-server action (where many servers have only 
one export, but it is also possible to have a server with 0 exports or a 
plurality of exports).  I _can't_ fit this into query-block's ImageInfo 
details about a block device, because we don't have a way of stating 
'connect to this arbitrary server, create an unspecified number of block 
devices, tell me about each of them, and then throw them all away 
because we only wanted the info about what the server made available'. 
The same is true for gluster or other remote access block devices - the 
QMP commands pre-suppose you already know WHICH specific resource you 
are accessing, rather than providing a way for you to query the remote 
server about ALL resources available but without actually selecting 
those resources.

I'm open to ideas about a new QMP command to do such a query, but who 
would be the client?  A management app that wants to hotplug a new NBD 
device to a running guest can run 'qemu-nbd --list' just as easily as 
they could run a new QMP command to learn what the server is offering. 
Without a strong reason of a client that would need this in QMP, I don't 
see the point in adding it to the qemu binary.


>> +++ b/qemu-nbd.c
>> @@ -76,6 +76,7 @@ static void usage(const char *name)
>>    {
>>        (printf) (
>>    "Usage: %s [OPTIONS] FILE\n"
>> +"  or:  %s -L [OPTIONS]\n"
>>    "QEMU Disk Network Block Device Server\n"
> 
> Do anyone know, why thunderbird add additional space to the lines started from space when quoting,
> which breaks indentation in quoted patches? How to fix it? I use plain text.

It's a known thunderbird display bug (or more specifically, something 
that thunderbird does to avoid even worse whitespace corruption later in 
its pipeline). It shows up in your reply window, but NOT in the 
recipients' view.  I've been dealing with bad formatting in thunderbird 
for years now, and this latest bug of displaying too many spaces on 
quoted reply lines that begin with whitespace (which in turn makes lines 
starting with - or + appear indented wrong) is certainly less annoying 
than their previous bug of converting all leading whitespace in the 
quoted reply to a single space.

> 
>>    "\n"
>>    "  -h, --help                display this help and exit\n"
>> @@ -97,6 +98,7 @@ static void usage(const char *name)
>>    "  -P, --partition=NUM       only expose partition NUM\n"
>>    "\n"
>>    "General purpose options:\n"
>> +"  -L, --list                list NBD exports visible to client\n"
> 
> hm. I think, user who things that qemu-nbd is only a server, can understand this as
> "dry run, don't actually start the server, but only list exports, which will be
> available to clients, keeping in mind all other specified options".
> 
> so, may be, "list remote NBD server exports and options" or something like this?

There's line lengths to worry about, but yes, I agree that adding 
something to make it a bit more obvious that this option is special is 
worth the word-smithing attempts.

>> +    printf("exports available: %d\n", rc);
>> +    for (i = 0; i < rc; i++) {
>> +        printf(" export: '%s'\n", list[i].name);
>> +        if (list[i].description && *list[i].description) {
>> +            printf("  description: %s\n", list[i].description);
>> +        }
>> +        if (list[i].flags & NBD_FLAG_HAS_FLAGS) {
>> +            printf("  size:  %" PRIu64 "\n", list[i].size);
> 
> size is available only if NBD_FLAG_HAS_FLAGS? at least, accordingly to code,
> in case 0: size is unrelated to flags.

case 0: code is for oldstyle servers. There are fewer and fewer of those 
even worth worrying about (I used nbdkit -o to test that part of my 
code, and we recently ripped oldstyle out of the qemu server); the ones 
that remain happen to set NBD_FLAG_HAS_FLAGS even for oldstyle.  I'm not 
too worried if our --list output fails to list size for an oldstyle 
server that did not set NBD_FLAG_HAS_FLAGS.

For all other servers, NBD_FLAG_HAS_FLAGS is a good witness of whether 
NBD_OPT_INFO was recognized, and there, size is indeed not present 
unless NBD_OPT_INFO worked.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZwum-0003A6-Rr
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 04:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZwuh-0005hH-Qq
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 04:45:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170202202739.GA15804@work-vm> <87shnvhfwc.fsf@dusky.pond.sub.org>
	<6e65ad3c-db00-0ce5-a9c6-0e8ba84ad3c6@redhat.com>
Date: Sat, 04 Feb 2017 10:45:41 +0100
In-Reply-To: <6e65ad3c-db00-0ce5-a9c6-0e8ba84ad3c6@redhat.com> (Max Reitz's
	message of "Fri, 3 Feb 2017 21:02:42 +0100")
Message-ID: <87zii270hm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] Non-flat command line option argument
 syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> On 03.02.2017 08:50, Markus Armbruster wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>> 
>>> * Markus Armbruster (armbru@redhat.com) wrote:
>>>> = Introduction =
>>>>
>>>
>>> <snip>
>>>
>>>> = Structured option argument syntax =
>>>>
>>>> == JSON ==
>>>>
>>>> The obvious way to provide the expressiveness of JSON on the command
>>>> line is JSON.  Easy enough[2].  However, besides not being compatible,
>>>> it's rather heavy on syntax, at least for simple cases.  Compare:
>>>>
>>>>     -machine q35,accel=kvm
>>>>     -machine '{ "type": "q35", "accel": "kvm"}'
>>>>
>>>> It compares a bit more favourably in cases that use our non-flat hacks.
>>>> Here's a flat list as KEY=VALUE,... with repeated keys, and as JSON:
>>>>
>>>>     -semihosting-config enable,arg=eins,arg=zwei,arg=drei
>>>>     -semihosting-config '{ "enable": true, "arg": [ "eins", "zwei", "drei" ] }'
>>>>
>>>> Arbitrary nesting with dotted key convention:
>>>>
>>>>     -drive driver=qcow2,file.driver=gluster,
>>>>            file.volume=testvol,file.path=/path/a.qcow2,file.debug=9,
>>>>            file.server.0.type=tcp,
>>>>            file.server.0.host=1.2.3.4,
>>>>            file.server.0.port=24007,
>>>>            file.server.1.type=unix,
>>>>            file.server.1.socket=/var/run/glusterd.socket
>>>>     -drive '{ "driver": "qcow2",
>>>>               "file": {
>>>>                   "driver": "gluster", "volume": "testvol",
>>>>                   "path": "/path/a.qcow2", "debug": 9,
>>>>                   "server": [ { "type": "tcp",
>>>>                                 "host": "1.2.3.4", "port": "24007"},
>>>>                               { "type": "unix",
>>>>                                 "socket": "/var/run/glusterd.socket" } ] } }'
>>>
>>> So while I generally hate JSON, the -drive dotted key syntax makes
>>> me mad when it gets like this;  have a look
>>> at the block replication and quorum setups especially, that can end up
>>> with (from docs/COLO-FT.txt):
>>>
>>>   -drive if=virtio,id=primary-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,\
>>>          children.0.file.filename=1.raw,\
>>>          children.0.driver=raw -S
>>>
>>>    that's just way too many .'s to ever properly understand.
>>> (I'm sure it used to be more complex).
>> 
>> Here's an idea to cut down on the dottery that drives you mad (and me
>> too): if KEY starts with '.', combine it with a prefix of the previous
>> one so that the result has the same number of name components.
>> 
>> Your example becomes
>> 
>>     -drive if=virtio,id=primary-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,\
>>            children.0.file.filename=1.raw,.driver=raw -S
>
> No, the last option would be children.0.file.driver=raw when expanded
> (which is wrong, it should be children.0.driver).

You're right.

>> My example
>> 
>>      -drive driver=qcow2,file.driver=gluster,
>>             file.volume=testvol,file.path=/path/a.qcow2,file.debug=9,
>>             file.server.0.type=tcp,
>>             file.server.0.host=1.2.3.4,
>>             file.server.0.port=24007,
>>             file.server.1.type=unix,
>>             file.server.1.socket=/var/run/glusterd.socket
>> 
>> becomes
>> 
>>      -drive driver=qcow2,
>>             file.driver=gluster,
>>                 .volume=testvol,
>>                 .path=/path/a.qcow2,
>>                 .debug=9,
>>             file.server.0.type=tcp,
>>                          .host=1.2.3.4,
>>                          .port=24007,
>>             file.server.1.type=unix,
>>                          .socket=/var/run/glusterd.socket
>> 
>> Mind, I'm not at all sure this is a *good* idea.  I suspect it's more
>> magic than it's worth.
>
> As someone who likes dot syntax very much, I don't like it. If you
> structure it like this, it's OK, but then you can just write the full
> prefix (which gets the point across just as well because I can quickly
> tell from a glance that it's the same prefix).
>
> OTOH, when joined into a single line it doesn't change much in terms of
> legibility, in my opinion.

Thanks!

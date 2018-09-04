Received: from eggs.gnu.org ([2001:4830:134:3::10]:59820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxCXl-0007YS-5U
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 10:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxCXk-0002UK-9u
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 10:43:01 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180904141730.GC3803@andariel.pipo.sk>
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<20180828142626.GM122225@angien.pipo.sk>
	<20180903150311.GC14463@dhcp-200-186.str.redhat.com>
	<w51bm9dl81j.fsf@maestria.local.igalia.com>
	<20180904141730.GC3803@andariel.pipo.sk>
Date: Tue, 04 Sep 2018 16:42:17 +0200
Message-ID: <w515zzll3xy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

On Tue 04 Sep 2018 04:17:30 PM CEST, Peter Krempa wrote:
>> >> libvirt-3-format is read-write and all other node names are
>> >> readonly in the above example.
>> >> 
>> >> The same also happens when using filenames:
>> >> 
>> >> {"execute":"block-commit",
>> >>  "arguments" : {"device":"libvirt-3-format",
>> >>                 "job-id":"libvirt-3-format",
>> >>                 "top":"/var/lib/libvirt/images/rhel7.3.1483615252",
>> >>                 "base":"/var/lib/libvirt/images/rhel7.3.1483605924",
>> >>                 "auto-finalize":true,
>> >>                 "auto-dismiss":false},
>> >>  "id":"libvirt-13"}
>> >> 
>> >> {"id":"libvirt-13","error":{"class":"GenericError","desc":"Block node is read-only"}}
>> >
>> > I see what's happening here. So we have a graph like this:
>> >
>> >      guest device
>> >           |
>> >           v
>> >     overlay-format -------> backing-format
>> >     [read-only=off]         [read-only=on]
>> >           |                        |
>> >           v                        v
>> >     overlay-proto           backing-proto
>> >     [read-only=off]         [read-only=on]
>> >
>> > The difference between your -blockdev use and -drive is that you
>> > explicitly specify the read-only option for backing-proto (and you use
>> > a separate -blockdev option anyway), so it doesn't just inherit it
>> > from backing-format.
>> 
>> Are these format and protocol block devices opened with four separate
>> -blockdev parameters? Is that how libvirt does it?
>
> Yes. This goes along with the fact that for 'blockdev-create' you need
> to blockdev-add the file which you want to format, but the formatted
> file is not automatically added.
>
> If we'd use the approach where the protocol layer is opened as part of
> the format layer it would complicate the snapshot code where we need
> to add a file and then format it to qcow2. It would mean that we'd
> have to blockdev-add a file, format it via blockdev-create, then
> blockdev-del it and open it together with the format layer. Otherwise
> the disk hot-unplug code would be plain crazy.

Do you need to add the protocol layer in order to format it, though? :-?

(I'm just trying to understand how this works, I'm not too familiar with
blockdev-create)

{'execute': 'blockdev-create',
 'arguments': {'job-id': 'job0',
               'options': {'driver': 'file',
                           'filename': 'test.qcow2',
                           'size': 0}}}
{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}

{'execute': 'blockdev-create',
 'arguments': {'job-id': 'job1',
               'options': { 'driver': 'qcow2',
                            'size': 1048576,
                            'file': {'driver': 'file',
                                     'filename': 'test.qcow2'}}}}
{'execute': 'job-dismiss', 'arguments': {'id': 'job1'}}

Berto

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxB9a-0007wE-EX
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 09:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxB9Y-0008KI-Oo
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 09:13:58 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180903150311.GC14463@dhcp-200-186.str.redhat.com>
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<20180828142626.GM122225@angien.pipo.sk>
	<20180903150311.GC14463@dhcp-200-186.str.redhat.com>
Date: Tue, 04 Sep 2018 15:13:44 +0200
Message-ID: <w51bm9dl81j.fsf@maestria.local.igalia.com>
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
To: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

On Mon 03 Sep 2018 05:03:11 PM CEST, Kevin Wolf wrote:
>> libvirt-3-format is read-write and all other node names are readonly in
>> the above example.
>> 
>> The same also happens when using filenames:
>> 
>> {"execute":"block-commit",
>>  "arguments" : {"device":"libvirt-3-format",
>>                 "job-id":"libvirt-3-format",
>>                 "top":"/var/lib/libvirt/images/rhel7.3.1483615252",
>>                 "base":"/var/lib/libvirt/images/rhel7.3.1483605924",
>>                 "auto-finalize":true,
>>                 "auto-dismiss":false},
>>  "id":"libvirt-13"}
>> 
>> {"id":"libvirt-13","error":{"class":"GenericError","desc":"Block node is read-only"}}
>
> I see what's happening here. So we have a graph like this:
>
>      guest device
>           |
>           v
>     overlay-format -------> backing-format
>     [read-only=off]         [read-only=on]
>           |                        |
>           v                        v
>     overlay-proto           backing-proto
>     [read-only=off]         [read-only=on]
>
> The difference between your -blockdev use and -drive is that you
> explicitly specify the read-only option for backing-proto (and you use
> a separate -blockdev option anyway), so it doesn't just inherit it
> from backing-format.

Are these format and protocol block devices opened with four separate
-blockdev parameters? Is that how libvirt does it?

Berto

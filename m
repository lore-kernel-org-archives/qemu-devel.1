Received: from eggs.gnu.org ([2001:4830:134:3::10]:58491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7RGe-0002ql-A0
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 16:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7R9Y-0002Ag-ST
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 16:20:22 -0400
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5771011-3a69-65c1-bcaf-83cddfb24edf@redhat.com>
Date: Tue, 2 Oct 2018 15:19:57 -0500
MIME-Version: 1.0
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/18] fleecing-hook driver for backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.orgJohn Snow <jsnow@redhat.com>

On 10/1/18 5:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> v2 was "[RFC v2] new, node-graph-based fleecing and backup"
> 
> Hi all!
> 
> These series introduce fleecing-hook driver. It's a filter-node, which
> do copy-before-write operation. Mirror uses filter-node for handling
> guest writes, let's move to filter-node (from write-notifiers) for
> backup too (patch 18)
> 
> Proposed filter driver is complete and separate: it can be used
> standalone, as fleecing provider (instead of backup(sync=none)).
> (old-style fleecing based on backup(sync=none) is supported too),
> look at patch 16.

I haven't had time to look at this series in any sort of depth yet, but 
it reminds me of a question I just ran into with my libvirt code:

What happens if we want to have two parallel clients both reading off 
different backup/fleece nodes at once?  Right now, 'nbd-server-start' is 
hard-coded to at most one NBD server, and 'nbd-server-add' is hardcoded 
to adding an export to the one-and-only NBD server.  But it would be a 
lot nicer if you could pick different ports for different clients (or 
even mix TCP and Unix sockets), so that independent backup jobs can both 
operate in parallel via different NBD servers both under control of the 
same qemu process, instead of the second client having to wait for the 
first client to disconnect so that the first NBD server can stop.  In 
the meantime, you can be somewhat careful by controlling which export 
names are exposed over NBD, but even with nbd-server-start using 
"tls-creds", all clients can see one another's exports via NBD_OPT_LIST, 
and you are relying on the clients being well-behaved, vs. the nicer 
ability to spawn multiple NBD servers, then control which exports are 
exposed over which servers, and where distinct servers could even have 
different tls-creds.

To get to that point, we'd need to enhance nbd-server-start to return a 
server id, and allow nbd-server-add and friends to take an optional 
parameter of a server id (for back-compat, if the server id is not 
provided, it operates on the first one).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:32960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZhLq-0005lz-UX
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZhLm-0003Ls-Tu
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:08:46 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cZhLm-0003LW-N4
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:08:42 -0500
Received: by mail-wm0-x242.google.com with SMTP id u63so5633693wmu.2
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 09:08:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170202150530.1025-1-pbonzini@redhat.com>
	<20170203150050.GF642@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55b46fa3-c861-9ba4-da65-25bc392d8900@redhat.com>
Date: Fri, 3 Feb 2017 09:08:36 -0800
MIME-Version: 1.0
In-Reply-To: <20170203150050.GF642@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] configure: remove
 --enable-replication/--disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com



On 03/02/2017 07:00, Stefan Hajnoczi wrote:
> On Thu, Feb 02, 2017 at 07:05:30AM -0800, Paolo Bonzini wrote:
>> The replication feature is a small amount of code, does not
>> require any external library and unless used does not add
>> anything to the guest's attack surface.  Since any extra
>> configure option affects maintainability on the other hand
>> and is subject to bit rot, I think there is no need to
>> make it configurable.
> 
> I think the current state is good: replication is enabled by default but
> can be compiled out if desired.
> 
> Downstreams may not be comfortable supporting this feature yet since
> it's incomplete.  It's fair to offer an option to disable it, otherwise
> downstreams will have to patch this themselves.

I understand---I just am not sure where to draw the line because there's
plenty of other incomplete features, hence the RFC.  For example,
record/replay cannot be enabled or disabled on the configure command
line.  That was the case even in the beginning, where it didn't support
either block or character device replay.

--enable-coroutine-pool is a relic of when Windows builds needed it, but
all other --enable-* options require an external library or at least a
specific operating system.  See for example this patch:

    commit 52b53c04faab9f7a9879c8dc014930649a3e698d
    Author: Fam Zheng <famz@redhat.com>
    Date:   Wed Sep 10 14:17:51 2014 +0800

    block: Always compile virtio-blk dataplane

    Dataplane doesn't depend on linux-aio any more, so we don't need the
    compiling condition now.

    Configure options are kept but just print a message.

    Signed-off-by: Fam Zheng <famz@redhat.com>
    Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
    Message-id: 1410329871-28885-4-git-send-email-famz@redhat.com
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


I would actually prefer to remove many of the latter
(--enable-vhost-net, --enable-vhost-scsi, --enable-vhost-socket) and
just use default-configs.  We are already doing it for ivshmem for example:

    CONFIG_IVSHMEM=$(CONFIG_EVENTFD)

Paolo

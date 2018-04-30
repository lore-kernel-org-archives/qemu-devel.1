Received: from eggs.gnu.org ([2001:4830:134:3::10]:45436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fD9Yq-0004VR-PW
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fD9Ym-0003On-Pw
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:13:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fD9Ym-0003OQ-Jr
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:13:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8648784257
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 14:13:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180416170930.35504-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 16 Apr 2018 18:09:30 +0100")
References: <20180416170930.35504-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 30 Apr 2018 16:15:38 +0200
Message-ID: <87zi1k3hmd.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 for 2.13] migration: Don't activate
 block devices if using -S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Activating the block devices causes the locks to be taken on
> the backing file.  If we're running with -S and the destination libvirt
> hasn't started the destination with 'cont', it's expecting the locks are
> still untaken.

I will try to change the naming, because we have:
- don't activate block device
- and we stop calling bdrv_invalidate_cache_all
  i.e. behind the scenes bdrv_invalidate_cache activates a block device,
  not bad O:-)

> Don't activate the block devices if we're not going to autostart the VM;
> 'cont' already will do that anyway.   This change is tied to the new
> migration capability 'late-block-activate' that defaults to off, keeping
> the old behaviour by default.

I have read the old discussion, and we have:

- current patch (not call bdrv_invalidate_cache() at bottom_handler)
- kevin approach: create two commands
  activate_devices/deactivate_devices and make libvirt use them correctly

I am not really sure which one is better, but as the patch author is
Dave ....

> bz: https://bugzilla.redhat.com/show_bug.cgi?id=1560854
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/migration.c | 34 +++++++++++++++++++++++++++-------
>  qapi/migration.json   |  6 +++++-
>  2 files changed, 32 insertions(+), 8 deletions(-)

Reviewed-by: Juan Quintela <quintela@redhat.com>


> +# @late-block-activate: If enabled, the destination will not activate block
> +#           devices (and thus take locks) immediately at the end of migration.
> +#           (since 2.13)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>             'block', 'return-path', 'pause-before-switchover', 'x-multifd',
> -           'dirty-bitmaps' ] }
> +           'dirty-bitmaps', 'late-block-activate' ] }
>  
>  ##
>  # @MigrationCapabilityStatus:

Just wondering, is there a way to enable a capability for 2.13 and
newer, and not activate it for older versions?  I *think* that this
feature should be on in new releases, and off by default with old
machine types.  But I haven't through long enough to know what needs to
be changed.

Later, Juan.

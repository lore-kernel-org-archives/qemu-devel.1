Received: from eggs.gnu.org ([2001:4830:134:3::10]:52816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f2FjW-0002ht-1K
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 08:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f2FjS-0001NF-5T
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 08:35:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f2FjR-0001MB-VW
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 08:35:42 -0400
References: <20180331084500.33313-1-jiangshanlai@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46d69a4b-83b4-2d32-4bb3-44c174533778@redhat.com>
Date: Sat, 31 Mar 2018 07:35:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180331084500.33313-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, "James O . D . Hunt" <james.o.hunt@intel.com>, Xu Wang <gnawux@gmail.com>, Peng Tao <bergwolf@gmail.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 03/31/2018 03:45 AM, Lai Jiangshan wrote:
> 1) What's this
> 
> When the migration capability 'bypass-shared-memory'
> is set, the shared memory will be bypassed when migration.
> 
> It is the key feature to enable several excellent features for
> the qemu, such as qemu-local-migration, qemu-live-update,
> extremely-fast-save-restore, vm-template, vm-fast-live-clone,
> yet-another-post-copy-migration, etc..
> 

> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Cc: James O. D. Hunt <james.o.hunt@intel.com>
> Cc: Xu Wang <gnawux@gmail.com>
> Cc: Peng Tao <bergwolf@gmail.com>
> Cc: Xiao Guangrong <xiaoguangrong@tencent.com>
> Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> ---
>   migration/migration.c | 13 +++++++++++++
>   migration/migration.h |  1 +
>   migration/ram.c       | 26 +++++++++++++++++---------
>   qapi/migration.json   |  8 +++++++-
>   4 files changed, 38 insertions(+), 10 deletions(-)
> 

> +++ b/qapi/migration.json
> @@ -352,12 +352,17 @@
>   #
>   # @x-multifd: Use more than one fd for migration (since 2.11)
>   #
> +# @bypass-shared-memory: the shared memory region will be bypassed on migration.
> +#          This feature allows the memory region to be reused by new qemu(s)
> +#          or be migrated separately. (since 2.12)

This is a new feature and you've missed the freeze for 2.12; this will 
need to be updated to '(since 2.13)' if the patch itself receives 
favorable review.

> +#
>   # Since: 1.2
>   ##
>   { 'enum': 'MigrationCapability',
>     'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>              'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
> -           'block', 'return-path', 'pause-before-switchover', 'x-multifd' ] }
> +           'block', 'return-path', 'pause-before-switchover', 'x-multifd',
> +           'bypass-shared-memory'] }
>   
>   ##
>   # @MigrationCapabilityStatus:
> @@ -412,6 +417,7 @@
>   #       {"state": true, "capability": "events"},
>   #       {"state": false, "capability": "postcopy-ram"},
>   #       {"state": false, "capability": "x-colo"}
> +#       {"state": false, "capability": "bypass-shared-memory"}

Invalid JSON - you forgot to add the comma on the previous line.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

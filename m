Received: from eggs.gnu.org ([2001:4830:134:3::10]:35246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGeh0-00055o-Go
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGegz-0006k3-LL
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:00:10 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGegz-0006hj-Ea
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:00:09 -0400
Received: by mail-oi0-x244.google.com with SMTP id f206so257615oig.2
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 22:00:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170601212921.30241-1-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <885f2f36-8ffe-ad42-91c0-d2588fc9281e@amsat.org>
Date: Fri, 2 Jun 2017 02:00:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170601212921.30241-1-quintela@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/11] Misc migration cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

for patches 1 to 10:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

On 06/01/2017 06:29 PM, Juan Quintela wrote:
> Hi
>
> This are a bit of everything:
> - Remove unneeded argumets for migration_channel_incomming
> - Lots of changes to make migration.h local to only migration
>   * Move self_annonce_delay() to misc.h
>     I know this conflicts for announce changes from Vlad, but
>     I want to remove migration.h from being exported.
>   * split registrantion functions to register.h
>   * Almost everything uses vmsd's for registration
>   * Move constants to the places that use it
>     And they are not used outside of migration/*
>   * create global_state.c, as they don't belong anywhere else
>
> ToSend:
>   * RAMState is a dynamic variable on my tree
>   * save_{setup,cleanup} and load_{setup,cleanup}
>     Yes Kevin, that is for block layer
>   * move all ram.c to use load_setup/cleanup
>
> ToDo easy: (probably post 2.10)
>   * split qapi functions from migration.c
>     They don't belong there, and it would be clearer about what is configuratio and what is code
>   * block.c and page_cache.c still use DPRINTF, they should move to use tracing
>     this is easy, volunteers, please.
>   * Now that it is clear what functions are exported and which not, writting documentation could
>     be a good idea for them.
>
> ToDo, difficult:
>   * rdma.c -> this needs some love, it uses a completely different set of hooks that everything
>     else, should have to integrate somehow everything together.
>   * abstract compression, xbzrle, postcopy and rdma into something that
>     is easier to understand.
>
> Please, review.
>
> Thanks, Juan.
>
>
> Juan Quintela (11):
>   migration: Remove MigrationState from migration_channel_incomming()
>   migration: Move self_announce_delay() to misc.h
>   migration: Split registration functions from vmstate.h
>   migration: Move dump_vmsate_json_to_file() to misc.h
>   migration: Move constants to savevm.h
>   migration: Commands are only used inside migration.c
>   migration: ram_control_* are implemented in qemu_file
>   migration: create global_state.c
>   migration: Move remaining exported functions to migration/misc.h
>   migration: Move migration.h to migration/
>   migration: Remove unneeded includes
>
>  hw/i386/pc_piix.c                            |   3 +-
>  hw/net/virtio-net.c                          |   1 +
>  hw/net/vmxnet3.c                             |   1 +
>  hw/ppc/spapr.c                               |   4 +-
>  hw/s390x/s390-skeys.c                        |   1 +
>  hw/s390x/s390-virtio-ccw.c                   |   1 +
>  hw/xen/xen-common.c                          |   3 +-
>  include/migration/colo.h                     |   3 -
>  include/migration/global_state.h             |  25 ++++
>  include/migration/misc.h                     |  28 +++++
>  include/migration/register.h                 |  64 ++++++++++
>  include/migration/vmstate.h                  |  57 ---------
>  migration/Makefile.objs                      |   2 +-
>  migration/block.c                            |   9 +-
>  migration/channel.c                          |   7 +-
>  migration/channel.h                          |   3 +-
>  migration/colo-comm.c                        |   2 +-
>  migration/colo-failover.c                    |   2 +
>  migration/colo.c                             |   4 +-
>  migration/exec.c                             |   4 +-
>  migration/fd.c                               |   4 +-
>  migration/global_state.c                     | 139 +++++++++++++++++++++
>  migration/migration.c                        | 176 +++++----------------------
>  {include/migration => migration}/migration.h |  67 ----------
>  migration/postcopy-ram.c                     |   6 +-
>  migration/qemu-file.c                        |   4 +-
>  migration/qemu-file.h                        |  17 +++
>  migration/ram.c                              |   7 +-
>  migration/rdma.c                             |   2 +-
>  migration/savevm.c                           |  11 +-
>  migration/savevm.h                           |  15 +++
>  migration/socket.c                           |   5 +-
>  migration/tls.c                              |   4 +-
>  migration/vmstate-types.c                    |   2 +-
>  migration/vmstate.c                          |   3 +-
>  qdev-monitor.c                               |   2 +-
>  slirp/slirp.c                                |   1 +
>  tests/test-vmstate.c                         |   3 +-
>  ui/spice-core.c                              |   2 +-
>  vl.c                                         |   2 +-
>  40 files changed, 368 insertions(+), 328 deletions(-)
>  create mode 100644 include/migration/global_state.h
>  create mode 100644 include/migration/register.h
>  create mode 100644 migration/global_state.c
>  rename {include/migration => migration}/migration.h (62%)
>

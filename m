Received: from eggs.gnu.org ([2001:4830:134:3::10]:60499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZbHM-00047l-SG
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZbHJ-00021a-NV
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:48:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZbHJ-000215-EH
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:48:45 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
	<20181218112142.11727.24919.stgit@pasha-VirtualBox>
Date: Wed, 19 Dec 2018 13:48:07 +0100
In-Reply-To: <20181218112142.11727.24919.stgit@pasha-VirtualBox> (Pavel
	Dovgalyuk's message of "Tue, 18 Dec 2018 14:21:42 +0300")
Message-ID: <87tvj9isxk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 08/20] migration: introduce icount field
 for snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> Saving icount as a parameters of the snapshot allows navigation between
> them in the execution replay scenario.
> This information can be used for finding a specific snapshot for rewinding
> the recorded execution to the specific moment of the time.
> E.g., 'reverse step' action needs to load the nearest snapshot which is
> prior to the current moment of time .
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
[...]
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 9e45fb4..a031e5b 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2509,6 +2509,11 @@ int save_snapshot(const char *name, Error **errp)
>      sn->date_sec = tv.tv_sec;
>      sn->date_nsec = tv.tv_usec * 1000;
>      sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    if (replay_mode != REPLAY_MODE_NONE) {
> +        sn->icount = replay_get_current_step();
> +    } else {
> +        sn->icount = -1ULL;
> +    }
>  
>      if (name) {
>          ret = bdrv_snapshot_find(bs, old_sn, name);
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 762000f..7bb1727 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -26,13 +26,18 @@
>  #
>  # @vm-clock-nsec: fractional part in nano seconds to be used with vm-clock-sec
>  #
> +# @icount: Current instruction count. Appears when execution record/replay
> +#          is enabled. Used for "time-traveling" to match the moment
> +#          in the recorded execution with the snapshots (since 4.0)
> +#
>  # Since: 1.3
>  #
>  ##
>  { 'struct': 'SnapshotInfo',
>    'data': { 'id': 'str', 'name': 'str', 'vm-state-size': 'int',
>              'date-sec': 'int', 'date-nsec': 'int',
> -            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int' } }
> +            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int',
> +            '*icount': 'int' } }
>  
>  ##
>  # @ImageInfoSpecificQCow2EncryptionBase:

As far as I can tell, @icount is the same as ReplayInfo's @step.  But I
had to look at the code to tell.  Please name the two consistently.
Also consider having the documentation refer to ReplayInfo.

> diff --git a/qapi/block.json b/qapi/block.json
> index 11f01f2..a6396a9 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -176,7 +176,8 @@
>  #                    "date-sec": 1000012,
>  #                    "date-nsec": 10,
>  #                    "vm-clock-sec": 100,
> -#                    "vm-clock-nsec": 20
> +#                    "vm-clock-nsec": 20,
> +#                    "icount": 220414
>  #      }
>  #    }
>  #

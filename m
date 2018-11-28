Received: from eggs.gnu.org ([2001:4830:134:3::10]:49667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gS2A1-0006wl-9N
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gS29w-0001iw-A1
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:53:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gS29w-0001ha-12
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:53:52 -0500
Date: Wed, 28 Nov 2018 16:53:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181128155345.GC4222@dhcp-200-186.str.redhat.com>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
	<20181010133414.24538.21966.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010133414.24538.21966.stgit@pasha-VirtualBox>
Subject: Re: [Qemu-devel] [PATCH v7 07/19] migration: introduce icount field
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.com, dovgaluk@ispras.ru, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

Am 10.10.2018 um 15:34 hat Pavel Dovgalyuk geschrieben:
> Saving icount as a parameters of the snapshot allows navigation between
> them in the execution replay scenario.
> This information can be used for finding a specific snapshot for rewinding
> the recorded execution to the specific moment of the time.
> E.g., 'reverse step' action needs to load the nearest snapshot which is
> prior to the current moment of time .
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

> diff --git a/block/qapi.c b/block/qapi.c
> index c66f949..9f2ccfa 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -210,6 +210,7 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
>          info->date_nsec     = sn_tab[i].date_nsec;
>          info->vm_clock_sec  = sn_tab[i].vm_clock_nsec / 1000000000;
>          info->vm_clock_nsec = sn_tab[i].vm_clock_nsec % 1000000000;
> +        info->icount        = sn_tab[i].icount;

Now that it's optional, info->has_icount needs to be set, too.

>          info_list = g_new0(SnapshotInfoList, 1);
>          info_list->value = info;

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index cfb37f8..34dc9f1 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -26,13 +26,18 @@
>  #
>  # @vm-clock-nsec: fractional part in nano seconds to be used with vm-clock-sec
>  #
> +# @icount: Current instruction count. Appears when execution record/replay
> +#          is enabled. Used for "time-traveling" to match the moment
> +#          in the recorded execution with the snapshots (since 3.1)

"(since 4.0)" now.

Kevin

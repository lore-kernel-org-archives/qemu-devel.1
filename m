Received: from eggs.gnu.org ([209.51.188.92]:44472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghrkk-00009J-Dr
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghrkj-0001g9-Fx
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:01:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghrkj-0001d2-7C
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:01:17 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
	<154703592583.13472.9297189413941172861.stgit@pasha-VirtualBox>
Date: Fri, 11 Jan 2019 09:01:11 +0100
In-Reply-To: <154703592583.13472.9297189413941172861.stgit@pasha-VirtualBox>
	(Pavel Dovgalyuk's message of "Wed, 09 Jan 2019 15:12:05 +0300")
Message-ID: <87a7k7aaig.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 08/21] migration: introduce icount field
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> Saving icount as a parameters of the snapshot allows navigation between
> them in the execution replay scenario.
> This information can be used for finding a specific snapshot for rewinding
> the recorded execution to the specific moment of the time.
> E.g., 'reverse step' action needs to load the nearest snapshot which is
> prior to the current moment of time .
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> --
>
> v2:
>  - made icount in SnapshotInfo optional (suggested by Eric Blake)
> v7:
>  - added more comments for icount member (suggested by Markus Armbruster)
> v9:
>  - updated icount comment
> ---
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 762000f..a197e5f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -26,13 +26,19 @@
>  #
>  # @vm-clock-nsec: fractional part in nano seconds to be used with vm-clock-sec
>  #
> +# @icount: Current instruction count. Appears when execution record/replay
> +#          is enabled. Used for "time-traveling" to match the moment
> +#          in the recorded execution with the snapshots. This counter may
> +#          be obtained through @query-replay command (since 4.0)

query-replay appears only in PATCH 11.  Please delay the last sentence
until then.

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

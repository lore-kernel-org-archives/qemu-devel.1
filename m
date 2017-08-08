Received: from eggs.gnu.org ([2001:4830:134:3::10]:34895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df6X1-0006ZA-3f
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df6X0-00010l-1q
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:34:55 -0400
Date: Tue, 8 Aug 2017 16:34:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170808153429.GN2081@work-vm>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-33-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502117160-24655-33-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 32/56] hmp: Make
 block_set_io_throttle's arguments unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> The previous commit made them unsigned in QMP.  Switch HMP's args_type
> from 'l' to 'o'.  Loses support for expressions (QEMU pocket
> calculator), gains support for unit suffixes.  Negative values are no
> longer accepted and interpreted modulo 2^64.  Instead, values between
> 2^63 and 2^64-1 are now accepted.

But that also means all these values are assumed to be in MB by default?

Dave

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp-commands.hx | 2 +-
>  hmp.c           | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 46ce79c..bc3c066 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1668,7 +1668,7 @@ ETEXI
>  
>      {
>          .name       = "block_set_io_throttle",
> -        .args_type  = "device:B,bps:l,bps_rd:l,bps_wr:l,iops:l,iops_rd:l,iops_wr:l",
> +        .args_type  = "device:B,bps:o,bps_rd:o,bps_wr:o,iops:l,iops_rd:l,iops_wr:l",
>          .params     = "device bps bps_rd bps_wr iops iops_rd iops_wr",
>          .help       = "change I/O throttle limits for a block drive",
>          .cmd        = hmp_block_set_io_throttle,
> diff --git a/hmp.c b/hmp.c
> index 3253674..599e816 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1764,9 +1764,9 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
>      BlockIOThrottle throttle = {
>          .has_device = true,
>          .device = (char *) qdict_get_str(qdict, "device"),
> -        .bps = qdict_get_int(qdict, "bps"),
> -        .bps_rd = qdict_get_int(qdict, "bps_rd"),
> -        .bps_wr = qdict_get_int(qdict, "bps_wr"),
> +        .bps = qdict_get_uint(qdict, "bps"),
> +        .bps_rd = qdict_get_uint(qdict, "bps_rd"),
> +        .bps_wr = qdict_get_uint(qdict, "bps_wr"),
>          .iops = qdict_get_int(qdict, "iops"),
>          .iops_rd = qdict_get_int(qdict, "iops_rd"),
>          .iops_wr = qdict_get_int(qdict, "iops_wr"),
> -- 
> 2.7.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

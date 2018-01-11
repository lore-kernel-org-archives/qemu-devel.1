Received: from eggs.gnu.org ([2001:4830:134:3::10]:35095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZh8n-0007MO-CB
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZh8k-0006M8-49
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:59:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZh8j-0006Ll-T6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:59:46 -0500
Date: Thu, 11 Jan 2018 17:59:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180111175934.GB13384@work-vm>
References: <20171208173321.GR2403@work-vm>
	<20180109192802.17167-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109192802.17167-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2.5/6] hmp: Add name parameter to
 nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com

* Eric Blake (eblake@redhat.com) wrote:
> Extend the flexibility of the previous QMP patch to also work
> in HMP.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, that looks good to me from the HMP side; let me
know which way you want to take it; I can take it via
HMP once the code that uses it is in; whichever is easiest.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> 
> In response to Dave's request.
> I could also squash this into Vladimir's 2/6 if desired.
> 
>  hmp.c           | 3 ++-
>  hmp-commands.hx | 9 +++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 80c5b01540..c9fcdc8593 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2221,10 +2221,11 @@ exit:
>  void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
>  {
>      const char *device = qdict_get_str(qdict, "device");
> +    const char *name = qdict_get_try_str(qdict, "name");
>      bool writable = qdict_get_try_bool(qdict, "writable", false);
>      Error *local_err = NULL;
> 
> -    qmp_nbd_server_add(device, false, NULL, true, writable, &local_err);
> +    qmp_nbd_server_add(device, !!name, name, true, writable, &local_err);
> 
>      if (local_err != NULL) {
>          hmp_handle_error(mon, &local_err);
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 6d5ebdf6ab..b8b6fb9184 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1553,17 +1553,18 @@ ETEXI
> 
>      {
>          .name       = "nbd_server_add",
> -        .args_type  = "writable:-w,device:B",
> -        .params     = "nbd_server_add [-w] device",
> +        .args_type  = "writable:-w,device:B,name:s?",
> +        .params     = "nbd_server_add [-w] device [name]",
>          .help       = "export a block device via NBD",
>          .cmd        = hmp_nbd_server_add,
>      },
>  STEXI
> -@item nbd_server_add @var{device}
> +@item nbd_server_add @var{device} [ @var{name} ]
>  @findex nbd_server_add
>  Export a block device through QEMU's NBD server, which must be started
>  beforehand with @command{nbd_server_start}.  The @option{-w} option makes the
> -exported device writable too.
> +exported device writable too.  The export name is controlled by @var{name},
> +defaulting to @var{device}.
>  ETEXI
> 
>      {
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

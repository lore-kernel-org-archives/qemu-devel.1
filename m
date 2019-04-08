Received: from eggs.gnu.org ([209.51.188.92]:45860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDWIz-0002rw-2g
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDWIy-0006hC-4F
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:35:29 -0400
Date: Mon, 8 Apr 2019 16:35:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190408153520.GG2687@work-vm>
References: <20190408153003.20596-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408153003.20596-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: Fix drive_add ... format=help crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> drive_new() returns null without setting an error when it provided
> help.  add_init_drive() assumes null means failure, and crashes trying
> to report a null error.
> 
> Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> v2: Make tests/test-hmp.c cover the bug
> 
>  device-hotplug.c | 2 +-
>  tests/test-hmp.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/device-hotplug.c b/device-hotplug.c
> index 6090d5f1e9..6153259d71 100644
> --- a/device-hotplug.c
> +++ b/device-hotplug.c
> @@ -48,7 +48,7 @@ static DriveInfo *add_init_drive(const char *optstr)
>  
>      mc = MACHINE_GET_CLASS(current_machine);
>      dinfo = drive_new(opts, mc->block_default_type, &err);
> -    if (!dinfo) {
> +    if (err) {
>          error_report_err(err);
>          qemu_opts_del(opts);
>          return NULL;
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 8c49d2fdf1..54a01824dc 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -31,6 +31,7 @@ static const char *hmp_cmds[] = {
>      "cpu 0",
>      "device_add ?",
>      "device_add usb-mouse,id=mouse1",
> +    "drive_add ignored format=help",

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      "mouse_button 7",
>      "mouse_move 10 10",
>      "mouse_button 0",
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

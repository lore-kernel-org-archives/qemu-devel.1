Received: from eggs.gnu.org ([209.51.188.92]:55733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDWqL-0005FB-7y
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDWqJ-0003ZW-3P
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:09:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDWqH-0003WU-4B
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:09:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so17044904wra.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 09:09:49 -0700 (PDT)
References: <20190408153003.20596-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f4a9a69c-e952-3252-578c-ec729c57886f@redhat.com>
Date: Mon, 8 Apr 2019 18:09:46 +0200
MIME-Version: 1.0
In-Reply-To: <20190408153003.20596-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] hmp: Fix drive_add ... format=help crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 4/8/19 5:30 PM, Markus Armbruster wrote:
> drive_new() returns null without setting an error when it provided
> help.  add_init_drive() assumes null means failure, and crashes trying
> to report a null error.
> 
> Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
>      "mouse_button 7",
>      "mouse_move 10 10",
>      "mouse_button 0",
> 

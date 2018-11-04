Received: from eggs.gnu.org ([2001:4830:134:3::10]:39957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJQv8-0008JO-Dk
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJQv5-0005PA-A6
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:31:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gJQv5-0005MI-3o
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:30:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id v24-v6so6484614wmh.3
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 14:30:58 -0800 (PST)
References: <20181103130143.7179-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d00e5a0e-a30e-69a6-d8fd-c748977c9191@redhat.com>
Date: Sun, 4 Nov 2018 23:30:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181103130143.7179-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qga-win: fix leaks of
 build_guest_disk_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: tgolembi@redhat.com, mdroth@linux.vnet.ibm.com

On 3/11/18 14:01, Marc-André Lureau wrote:
> Introduced in commit b1ba8890e63ce9432c41c5c3fc229f54c87c9c99, vol_h
> handle should be closed, and "out" cleanup should be done after
> DeviceIoControl() fails.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   qga/commands-win32.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index ef1d7d48d2..62e1b51dfe 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -797,7 +797,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
>                       0, extents, size, NULL, NULL)) {
>                   error_setg_win32(errp, GetLastError(),
>                       "failed to get disk extents");
> -                return NULL;
> +                goto out;
>               }
>           } else if (last_err == ERROR_INVALID_FUNCTION) {
>               /* Possibly CD-ROM or a shared drive. Try to pass the volume */
> @@ -855,6 +855,9 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
>   
>   
>   out:
> +    if (vol_h != INVALID_HANDLE_VALUE) {
> +        CloseHandle(vol_h);
> +    }
>       qapi_free_GuestDiskAddress(disk);
>       g_free(extents);
>       g_free(name);
> 

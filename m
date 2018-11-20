Received: from eggs.gnu.org ([2001:4830:134:3::10]:36754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPBoa-0007pE-5z
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPBoV-0003c8-2I
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:36:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPBoU-0003as-Qv
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:35:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so1679487wmd.1
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 11:35:58 -0800 (PST)
References: <20181120152753.10463-1-marcandre.lureau@redhat.com>
	<20181120152753.10463-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3e048f60-a589-9ddc-2bbf-2cbbdcf01939@redhat.com>
Date: Tue, 20 Nov 2018 20:35:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181120152753.10463-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1? 1/3] sheepdog: fix
 stringop-truncation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On 20/11/18 16:27, Marc-André Lureau wrote:
> It seems adding an assert is enough to silence GCC.
> (sd_parse_snapid_or_tag() g_strlcpy() ensures that we don't get in
> that situation)
> 
> ~/src/qemu/block/sheepdog.c: In function 'find_vdi_name':
> ~/src/qemu/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
>       strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 

Fixes: https://bugs.launchpad.net/bugs/1803872

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/sheepdog.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 0125df9d49..f8877b611d 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -1236,6 +1236,7 @@ static int find_vdi_name(BDRVSheepdogState *s, const char *filename,
>        * don't want the send_req to read uninitialized data.
>        */
>       strncpy(buf, filename, SD_MAX_VDI_LEN);
> +    assert(strlen(tag) < SD_MAX_VDI_TAG_LEN);
>       strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>   
>       memset(&hdr, 0, sizeof(hdr));
> 

I tried to fix this warning this way:

-    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
+    struct {
+        char vdi[SD_MAX_VDI_LEN];
+        char vdi_tag[SD_MAX_VDI_TAG_LEN];
+    } buf;

...

-    strncpy(buf, filename, SD_MAX_VDI_LEN);
-    strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
+    strncpy(buf.vdi, filename, SD_MAX_VDI_LEN);
+    strncpy(buf.vdi_tag, tag, SD_MAX_VDI_TAG_LEN);

but your patch is simpler.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks,

Phil.

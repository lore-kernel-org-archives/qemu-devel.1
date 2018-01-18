Received: from eggs.gnu.org ([2001:4830:134:3::10]:44114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec1uZ-0002B3-Gs
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 23:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec1uW-0006WV-D8
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 23:34:47 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:39821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec1uW-0006Vn-9n
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 23:34:44 -0500
Received: by mail-qt0-x242.google.com with SMTP id f4so6381143qtj.6
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 20:34:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180118025245.13042-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bbb71ebd-cd85-b80a-455b-e28641439bb9@amsat.org>
Date: Thu, 18 Jan 2018 01:34:40 -0300
MIME-Version: 1.0
In-Reply-To: <20180118025245.13042-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Simplify error handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 01/17/2018 11:52 PM, Fam Zheng wrote:
> Coverity doesn't like the ignored return value introduced in
> 9d3b155186c278 (hw/block: Fix the return type), and other callers are
> converted already in ceff3e1f01.
> 
> This one was added lately in d9bcd6f7f23a and missed the train. Do it
> now.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/scsi/scsi-generic.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index ba70c0dc19..7414fe2d67 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -482,7 +482,6 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
>      int rc;
>      int sg_version;
>      struct sg_scsi_id scsiid;
> -    Error *local_err = NULL;
>  
>      if (!s->conf.blk) {
>          error_setg(errp, "drive property not set");
> @@ -516,11 +515,9 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
>          error_setg(errp, "SG_GET_SCSI_ID ioctl failed");
>          return;
>      }
> -    blkconf_apply_backend_options(&s->conf,
> -                                  blk_is_read_only(s->conf.blk),
> -                                  true, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (!blkconf_apply_backend_options(&s->conf,
> +                                       blk_is_read_only(s->conf.blk),
> +                                       true, errp)) {
>          return;
>      }
>  
> 

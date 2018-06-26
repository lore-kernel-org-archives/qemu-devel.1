Received: from eggs.gnu.org ([2001:4830:134:3::10]:41791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqeL-000820-8R
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqeI-00052z-3G
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:17:01 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqeH-00052t-UR
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:16:58 -0400
Received: by mail-qt0-x243.google.com with SMTP id o9-v6so15653096qtp.3
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:16:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5be32be9-63e9-d7c7-6fc6-3bc126a6a9fd@amsat.org>
Date: Tue, 26 Jun 2018 13:16:53 -0300
MIME-Version: 1.0
In-Reply-To: <20180626154028.11133-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/5] pr-helper: fix assertion failure on
 failed multipath PERSISTENT RESERVE IN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mprivozn@redhat.com

On 06/26/2018 12:40 PM, Paolo Bonzini wrote:
> The response size is expected to be zero if the SCSI status is not
> "GOOD", but nothing was resetting it.
> 
> This can be reproduced simply by "sg_persist -s /dev/sdb" where /dev/sdb
> in the guest is a scsi-block device corresponding to a multipath device
> on the host.
> 
> Before:
> 
>   PR in (Read full status): Aborted command
> 
> and on the host:
> 
>   prh_write_response: Assertion `resp->sz == 0' failed.
> 
> After:
> 
>   PR in (Read full status): bad field in cdb or parameter list
>   (perhaps unsupported service action)
> 
> Reported-by: Jiri Belka <jbelka@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scsi/qemu-pr-helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index 4057cf355c..0218d65bbf 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -558,7 +558,11 @@ static int do_pr_in(int fd, const uint8_t *cdb, uint8_t *sense,
>  #ifdef CONFIG_MPATH
>      if (is_mpath(fd)) {
>          /* multipath_pr_in fills the whole input buffer.  */
> -        return multipath_pr_in(fd, cdb, sense, data, *resp_sz);
> +        int r = multipath_pr_in(fd, cdb, sense, data, *resp_sz);
> +        if (r != GOOD) {
> +            *resp_sz = 0;
> +        }
> +        return r;
>      }
>  #endif
>  
> 

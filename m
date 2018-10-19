Received: from eggs.gnu.org ([2001:4830:134:3::10]:38502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDROT-0001uR-JF
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDROP-0006oz-Tm
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gDROK-0006eP-82
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:48:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43A2388319
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 09:48:18 +0000 (UTC)
References: <20180720214020.22897-1-bsd@redhat.com>
	<20180720214020.22897-4-bsd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d05f2c28-c24b-f2ca-206a-2addfc913851@redhat.com>
Date: Fri, 19 Oct 2018 11:48:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180720214020.22897-4-bsd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] dev-mtp: retry write for incomplete
 transfers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 2018-07-20 23:40, Bandan Das wrote:
> For large buffers, write may not copy the full buffer. For example,
> on Linux, write imposes a limit of 0x7ffff000. Note that this does
> not fix >4G transfers but ~>2G files will transfer successfully.
> 
> Signed-off-by: Bandan Das <bsd@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 1b72603dc5..c8f6eb4e9e 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1602,6 +1602,24 @@ static void utf16_to_str(uint8_t len, uint16_t *arr, char *name)
>      g_free(wstr);
>  }
>  
> +/* Wrapper around write, returns 0 on failure */
> +static uint64_t write_retry(int fd, void *buf, uint64_t size)
> +{
> +        uint64_t bytes_left = size, ret;
> +
> +        while (bytes_left > 0) {
> +                ret = write(fd, buf, bytes_left);
> +                if ((ret == -1) && (errno != EINTR || errno != EAGAIN ||
> +                                    errno != EWOULDBLOCK)) {

Someone opened a bug ticket about this here:

 https://bugs.launchpad.net/qemu/+bug/1798780

The check looks wrong, indeed - either "!=" should be "==" or "||"
should be "&&" here ?

 Thomas

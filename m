Received: from eggs.gnu.org ([2001:4830:134:3::10]:35704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb15J-0006aB-Nn
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb15F-0002dI-Qu
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:29:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eb15F-0002cy-Js
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:29:37 -0500
References: <20180115041648.33740-1-linzhecheng@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a6ca84f-4df2-523c-d3aa-75cd73b1d739@redhat.com>
Date: Mon, 15 Jan 2018 10:29:32 +0100
MIME-Version: 1.0
In-Reply-To: <20180115041648.33740-1-linzhecheng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi: handle the special parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, wangxinxin.wang@huawei.com

On 15/01/2018 05:16, linzhecheng wrote:
> scsi_disk_emulate_command calls
> scsi_build_sense(NULL, 0, outbuf, r->buflen,
>                                   (req->cmd.buf[1] & 1) == 0);
> But scsi_convert_sense doesn't handle the case when in_buf is NULL
> or in_len is 0, which will lead to segfault.
> 

This is already fixed in my last pull request.

Paolo

> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> ---
>  scsi/utils.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scsi/utils.c b/scsi/utils.c
> index ddae650a99..b769e80c12 100644
> --- a/scsi/utils.c
> +++ b/scsi/utils.c
> @@ -322,6 +322,10 @@ int scsi_convert_sense(uint8_t *in_buf, int in_len,
>      SCSISense sense;
>      bool fixed_in;
>  
> +    if (!in_buf || !in_len) {
> +        return 0;
> +    }
> +
>      fixed_in = (in_buf[0] & 2) == 0;
>      if (in_len && fixed == fixed_in) {
>          memcpy(buf, in_buf, MIN(len, in_len));
> 

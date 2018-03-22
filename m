Received: from eggs.gnu.org ([2001:4830:134:3::10]:60325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyzl1-0005zZ-5s
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyzkx-00054u-6K
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:55:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyzkx-00054f-1i
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:55:47 -0400
References: <20180322024056.29599-1-yuchenlin@synology.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cede55a3-a5e0-c98a-5d03-ff68a0305ecd@redhat.com>
Date: Thu, 22 Mar 2018 07:55:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180322024056.29599-1-yuchenlin@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vmdk: return ENOTSUP before offset overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin@synology.com, qemu-devel@nongnu.org
Cc: famz@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 03/21/2018 09:40 PM, yuchenlin--- via Qemu-devel wrote:
> From: yuchenlin <yuchenlin@synology.com>
> 
> VMDK has a hard limitation of extent size, which is due to the size of grain
> table entry is 32 bits. It means it can only point to a grain located at
> offset = 2^32. To prevent offset overflow and record a useless offset
> in grain table. We should return un-support here.
> 
> Signed-off-by: yuchenlin <yuchenlin@synology.com>
> ---
>   block/vmdk.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index f94c49a9c0..d8fc961940 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -47,6 +47,9 @@
>   #define VMDK4_FLAG_MARKER (1 << 17)
>   #define VMDK4_GD_AT_END 0xffffffffffffffffULL
>   
> +/* 2TB */
> +#define VMDK_EXTENT_SIZE_LIMIT (2199023255552)

Please spell this '(2ULL * 1024 * 1024 * 1024 * 1024)', or even rebase 
it on top of Phillipe's BYTE-based definitions as '2 * T_BYTE' (v2 
proposed a cunits.h, although v3 is still pending posting and may rename 
the header units.h)

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01077.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

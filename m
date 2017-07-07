Received: from eggs.gnu.org ([2001:4830:134:3::10]:43828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dTTta-0005IE-96
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dTTtX-0004SO-4R
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:06:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dTTtW-0004S0-Qw
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:06:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v67E3kjx146539
	for <qemu-devel@nongnu.org>; Fri, 7 Jul 2017 10:06:05 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bjbk88fcj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 10:06:04 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 7 Jul 2017 08:06:01 -0600
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
	<1499423224-23060-3-git-send-email-thuth@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 7 Jul 2017 10:05:57 -0400
MIME-Version: 1.0
In-Reply-To: <1499423224-23060-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <4d8bbe89-389c-fb52-1387-da56c3fc3848@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/8] pc-bios/s390-ccw: Move ebc2asc
 to sclp.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>



On 07/07/2017 06:26 AM, Thomas Huth wrote:
> We will later need this array in a file that we will link to the
> netboot code, too. Since there is some ebcdic convertion done
> in sclp_get_loadparm_ascii(), the sclp.c file seems to be a good
> candidate.

s/convertion/conversion
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/main.c | 11 -----------
>  pc-bios/s390-ccw/sclp.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 40cba8d..0580eac 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -17,17 +17,6 @@ static SubChannelId blk_schid = { .one = 1 };
>  IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>  static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
>
> -const unsigned char ebc2asc[256] =
> -      /* 0123456789abcdef0123456789abcdef */
> -        "................................" /* 1F */
> -        "................................" /* 3F */
> -        " ...........<(+|&.........!$*);." /* 5F first.chr.here.is.real.space */
> -        "-/.........,%_>?.........`:#@'=\""/* 7F */
> -        ".abcdefghi.......jklmnopqr......" /* 9F */
> -        "..stuvwxyz......................" /* BF */
> -        ".ABCDEFGHI.......JKLMNOPQR......" /* DF */
> -        "..STUVWXYZ......0123456789......";/* FF */
> -
>  /*
>   * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
>   * a subsystem-identification is at 184-187 and bytes 188-191 are zero
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index aa1c862..2ee204a 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -14,6 +14,17 @@
>
>  static char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
>
> +const unsigned char ebc2asc[256] =
> +      /* 0123456789abcdef0123456789abcdef */
> +        "................................" /* 1F */
> +        "................................" /* 3F */
> +        " ...........<(+|&.........!$*);." /* 5F first.chr.here.is.real.space */
> +        "-/.........,%_>?.........`:#@'=\""/* 7F */
> +        ".abcdefghi.......jklmnopqr......" /* 9F */
> +        "..stuvwxyz......................" /* BF */
> +        ".ABCDEFGHI.......JKLMNOPQR......" /* DF */
> +        "..STUVWXYZ......0123456789......";/* FF */
> +
>  /* Perform service call. Return 0 on success, non-zero otherwise. */
>  static int sclp_service_call(unsigned int command, void *sccb)
>  {
>

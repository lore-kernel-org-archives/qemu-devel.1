Received: from eggs.gnu.org ([2001:4830:134:3::10]:43953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwOXc-0002Mb-M1
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwOXa-0001ym-0o
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:15:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwOXZ-0001yB-OR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:14:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8P8ErXv123161
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 04:14:53 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d6p5xwepq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 04:14:52 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 25 Sep 2017 09:14:17 +0100
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-3-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 25 Sep 2017 10:14:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0ca38937-6b03-1929-9157-91cb043a9236@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 02/27] s390x/cpumodel: fix max STFL(E)
 bit number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Makes sense. I asked myself if there is code outside that does not zero out 2048-16k so
I looked into the kernel source and it looks like we always did the right thing
(and zeroed out the response buffer), so this should not uncover any bugs.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

On 09/18/2017 05:59 PM, David Hildenbrand wrote:
> Not that it would matter in the near future, but it is actually 2048
> bytes, therefore 16384 possible bits.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu_features.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 1d3a036393..31a4676f05 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -381,7 +381,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
> 
>      switch (type) {
>      case S390_FEAT_TYPE_STFL:
> -       nr_bits = 2048;
> +       nr_bits = 16384;
>         break;
>      case S390_FEAT_TYPE_PLO:
>         nr_bits = 256;
> 

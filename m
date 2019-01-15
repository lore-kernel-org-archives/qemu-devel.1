Received: from eggs.gnu.org ([209.51.188.92]:37255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gjNJE-0002Bn-6a
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gjNJB-0004D7-9f
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:55:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57320
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gjNJ9-00045c-9w
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:55:03 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0FBn2Ri019095
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 06:54:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q1dmec6et-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 06:54:50 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 15 Jan 2019 11:54:48 -0000
References: <1547470346-18416-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 15 Jan 2019 12:54:44 +0100
MIME-Version: 1.0
In-Reply-To: <1547470346-18416-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Message-Id: <9f0e2e04-4dec-c958-740f-e27268f1b462@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2] configure: Only build the
 s390-ccw bios if the compiler supports -march=z900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org



On 14.01.2019 13:52, Thomas Huth wrote:
> We want to build our s390-ccw bios with -march=z900 so that it also
> works with the oldest s390x CPU that we support with TCG. However,
> Clang on s390x does not support -march=z900 anymore, so we can not
> use this compiler to build the s390-ccw bios. Thus add a proper test
> to the configure script to see whether the compiler is usable.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  v2: Use compile_prog as suggested by Peter
> 
>  configure | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 05b7e85..2b9ba7d 100755
> --- a/configure
> +++ b/configure
> @@ -5905,8 +5905,12 @@ if test "$cpu" = "ppc64" -a "$targetos" != "Darwin" ; then
>    roms="$roms spapr-rtas"
>  fi
>  
> +# Only build s390-ccw bios if we're on s390x and the compiler has -march=z900
>  if test "$cpu" = "s390x" ; then
> -  roms="$roms s390-ccw"
> +  write_c_skeleton
> +  if compile_prog "-march=z900" ""; then
> +    roms="$roms s390-ccw"
> +  fi
>  fi
>  
>  # Probe for the need for relocating the user-only binary.
> 

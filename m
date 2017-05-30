Received: from eggs.gnu.org ([2001:4830:134:3::10]:35826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dFk6n-00057w-0A
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dFk6i-0001HD-8o
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:35:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dFk6h-0001Gi-VQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:34:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4UGYRBM097279
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 12:34:54 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2asc6j8gsf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 12:34:54 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 30 May 2017 12:34:52 -0400
References: <149615665491.28067.17765793725374594694.stgit@bahia.lan>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 30 May 2017 18:34:46 +0200
MIME-Version: 1.0
In-Reply-To: <149615665491.28067.17765793725374594694.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <e8fdae1c-9d3c-1059-509a-6b85000e83a9@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: use STRIP variable in
 Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-trivial@nongnu.org, Fam Zheng <famz@redhat.com>, Alexander Graf <agraf@suse.de>

On 05/30/2017 05:04 PM, Greg Kurz wrote:
> The docker-run-test-build@debian-s390x-cross target fails with:
> 
> strip --strip-unneeded s390-ccw.elf -o s390-ccw.img
> strip: Unable to recognise the format of the input file `s390-ccw.elf'
> 
> The configure script defines a STRIP makefile variable whose default
> value is ${cross_prefix}strip. Let's use it.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  pc-bios/s390-ccw/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 79a46b67356f..7af57dad109c 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -22,7 +22,7 @@ s390-ccw.elf: $(OBJECTS)
>  	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TARGET_DIR)$@")
> 
>  s390-ccw.img: s390-ccw.elf
> -	$(call quiet-command,strip --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
> +	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
> 
>  $(OBJECTS): Makefile
> 
> 

I was going to apply this, but it fails with --disable-strip like

    /bin/sh: --strip-unneeded: command not found
    Makefile:25: recipe for target 's390-ccw.img' failed
    make[1]: *** [s390-ccw.img] Error 127
    Makefile:354: recipe for target 'romsubdir-s390-ccw' failed
    make: *** [romsubdir-s390-ccw] Error 2

Not yet sure whats going on.

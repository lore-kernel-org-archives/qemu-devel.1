Received: from eggs.gnu.org ([2001:4830:134:3::10]:49945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dG41Z-0008Ft-6q
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dG41W-0001gc-Bi
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:50:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dG41W-0001gH-1H
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:50:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4VDmfti032537
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:50:52 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2asun6hw6d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:50:51 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 31 May 2017 07:50:51 -0600
References: <149623617700.4947.12490877660892961664.stgit@bahia.lan>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 31 May 2017 15:50:44 +0200
MIME-Version: 1.0
In-Reply-To: <149623617700.4947.12490877660892961664.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <c7e20195-8fa4-c081-b63d-02e380e8b909@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] pc-bios/s390-ccw: use STRIP variable in
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
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Fam Zheng <famz@redhat.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 05/31/2017 03:09 PM, Greg Kurz wrote:
> The docker-run-test-build@debian-s390x-cross target fails with:
> 
> strip --strip-unneeded s390-ccw.elf -o s390-ccw.img
> strip: Unable to recognise the format of the input file `s390-ccw.elf'
> 
> The configure script defines a STRIP makefile variable whose default
> value is ${cross_prefix}strip. Let's use it.
> 
> We default to using the non-prefixed strip command in case --enable-debug
> or --disable-strip was passed to configure during a regular build.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - added default value
>     - no longer Cc: qemu-trivial as it turned out to be not that trivial
> 
> Philippe,
> 
> Please give your Reviewed-by again if you're okay with this change.
> ---
>  pc-bios/s390-ccw/Makefile |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 79a46b67356f..fb88c13bc742 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -21,8 +21,10 @@ build-all: s390-ccw.img
>  s390-ccw.elf: $(OBJECTS)
>  	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TARGET_DIR)$@")
> 
> +STRIP ?= strip
> +
>  s390-ccw.img: s390-ccw.elf
> -	$(call quiet-command,strip --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
> +	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
> 
>  $(OBJECTS): Makefile
> 
> 
applied, thanks.

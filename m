Received: from eggs.gnu.org ([2001:4830:134:3::10]:48926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fBJO8-0005oY-Lg
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fBJO4-00057Q-Ji
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:19:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44730
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fBJO4-000574-D0
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:19:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3PC9VhM065883
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:19:03 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hjrs3t3us-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:19:03 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 25 Apr 2018 13:19:01 +0100
References: <1524647323-6449-1-git-send-email-thuth@redhat.com>
	<1524647323-6449-3-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Apr 2018 14:18:59 +0200
MIME-Version: 1.0
In-Reply-To: <1524647323-6449-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <60dc9968-58fd-46e3-b471-7a0b7093ba15@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] pc-bios/s390-ccw/net: Use diag308
 to reset machine before jumping to the OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>



On 04/25/2018 11:08 AM, Thomas Huth wrote:

> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -283,6 +283,15 @@ void panic(const char *string)
>      }
>  }
>  
> +void write_subsystem_identification(void)
> +{
> +    uint32_t *schid = (uint32_t *) 184;
> +    uint32_t *zeroes = (uint32_t *) 188;
> +
> +    *schid = 0;         /* We must not set this for virtio-net */
> +    *zeroes = 0;
> +}
> +


I think we actually want to have the CCW devno of that network device
stored. It has some value to know which CCW device we bootet from, no?

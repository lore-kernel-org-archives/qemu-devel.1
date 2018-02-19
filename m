Received: from eggs.gnu.org ([208.118.235.92]:36245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1enh9j-00030b-KW
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 03:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1enh9g-0003OV-JS
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 03:50:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42684
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1enh9g-0003NZ-Ds
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 03:50:36 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1J8mnmb016981
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 03:50:34 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g7qkug4ps-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 03:50:33 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 08:50:32 -0000
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-6-git-send-email-walling@linux.vnet.ibm.com>
	<331dee18-2eb2-9189-852b-bf8723c03d27@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 09:50:28 +0100
MIME-Version: 1.0
In-Reply-To: <331dee18-2eb2-9189-852b-bf8723c03d27@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <eab38e32-4a4b-1cee-e034-d7e425f3ca44@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v7 05/12] s390-ccw: move
 auxiliary IPL data to separate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 17.02.2018 09:11, Thomas Huth wrote:
[...]
> 
> I still think that the information should *not* be stored within the
> IplParameterBlock to avoid that we pass it via DIAG 0x308, too.
> If we do it like this, I'm pretty sure that we will look at this code in
> a couple of years and wonder whether we can change it again or whether
> this is an established interface between the host and the guest. So
> please, let's avoid establishing such "hidden" interfaces just out of
> current convenience. There must be a better location for this.
> Christian, do you have an idea?
> 
>  Thomas
> 
In principle I do agree, although I think we can manage the host/guest
boundary. If we believe we can't, we have a much bigger problem (looking
at the position of the iplb smack in the middle of the s390-ipl state).

The main reason why I didn't bother to introduce a new private field in
s390-ipl was that I expect more changes to the IPL area in the future
(earlier than in a couple of years) and am not really sure whether this
QEMU <-> BIOS interface will remain the same and how much effort to
spend on it.

The major point of this change is to move non-standard data out of the
guest-visible IPLB to avoid compatibility problems in the future, while
still catering for features like network boot and boot menus. I have no
bias against other solutions achieving this objective. If you and
Christian think we need a new field, it's all right with me.

-- 
Regards,
 Viktor Mihajlovski

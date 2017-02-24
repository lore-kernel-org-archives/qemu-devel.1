Received: from eggs.gnu.org ([2001:4830:134:3::10]:42794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1chDl5-00052U-7f
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1chDl0-0002tJ-7M
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:09:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1chDkz-0002Wq-Tj
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:09:50 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1OB9UGM009583
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:09:31 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28td8c75sj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:09:31 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 24 Feb 2017 04:09:30 -0700
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
	<20170220141943.8426-2-cornelia.huck@de.ibm.com>
	<967f7397-9995-0d24-bf35-682da2c732ff@redhat.com>
	<48b23a4f-ebd3-2306-ea0f-75b713817440@de.ibm.com>
	<aade1638-9dd8-98e7-bf40-f12ab9322da6@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 Feb 2017 12:09:25 +0100
MIME-Version: 1.0
In-Reply-To: <aade1638-9dd8-98e7-bf40-f12ab9322da6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <3c9ae0ce-c4b8-6061-c68d-4aa72a56bccd@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] elf-loader: Allow late loading of elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>

On 02/24/2017 11:44 AM, Thomas Huth wrote:
> On 21.02.2017 11:23, Christian Borntraeger wrote:
>> On 02/20/2017 04:33 PM, Thomas Huth wrote:
>>> On 20.02.2017 15:19, Cornelia Huck wrote:
>>>> From: Farhan Ali <alifm@linux.vnet.ibm.com>
>>>>
>>>> The current QEMU ROM infrastructure rejects late loading of ROMs.
>>>> And ELFs are currently loaded as ROM, this prevents delayed loading
>>>> of ELFs. So when loading ELF, allow the user to specify if ELF should
>>>> be loaded as ROM or not.
>>>>
>>>> If an ELF is not loaded as ROM, then they are not restored on a
>>>> guest reboot/reset and so its upto the user to handle the reloading.
>>>
>>> Could you maybe also explain here why you need such a delayed ELF
>>> loading? Why can't you load the s390-netboot.img at the same time as
>>> s390-ccw.img?
>>
>> Please read the cover letter for some details how to build such a netrom.
> 
> Sure, understood, but I still did not see an explanation why this can't
> be loaded as "ROM", too / why it needs to be loaded "delayed"? Does the
> image data need to be writable in memory? Or is the information not
> available yet at that point in time, whether the user wants to do a
> network boot or not? Don't get me wrong, I'm basically fine with this
> patch, I'm just missing some explanation *why* you have to do it this way.

As I already wrote, the rom will be big. kernel + ramdisk will take easily
10-30Mbytes. This is loaded twice (in the rom as data and into the guest)
So this will waste lets say 60Mbyte per guest for nothing.

You know yourself that on s390 we do have >100 guests in production environment.

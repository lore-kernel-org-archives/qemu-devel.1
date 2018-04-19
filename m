Received: from eggs.gnu.org ([2001:4830:134:3::10]:54297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f98rt-0006BF-El
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f98rp-0005SW-AQ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:40:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59194
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1f98rp-0005SB-4f
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:40:49 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3JCaQOa034500
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 08:40:48 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hetqwt05q-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 08:40:48 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 19 Apr 2018 13:40:46 +0100
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<1524054707-20663-4-git-send-email-thuth@redhat.com>
	<bc5533dc-9471-7dac-6aba-9014e9961376@linux.vnet.ibm.com>
	<b0bb6918-0047-9a53-b03f-bff5669daaaa@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 19 Apr 2018 14:40:42 +0200
MIME-Version: 1.0
In-Reply-To: <b0bb6918-0047-9a53-b03f-bff5669daaaa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <2d59a139-3bdd-4b4e-882c-5cf845488eda@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2.13 3/4] pc-bios/s390-ccw/net: Add
 support for pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

On 19.04.2018 10:17, Thomas Huth wrote:
> On 19.04.2018 09:41, Viktor VM Mihajlovski wrote:
>> On 18.04.2018 14:31, Thomas Huth wrote:
>>> Since it is quite cumbersome to manually create a combined kernel with
>>> initrd image for network booting, we now support loading via pxelinux
>>> configuration files, too. In these files, the kernel, initrd and command
>>> line parameters can be specified seperately, and the firmware then takes
>>> care of glueing everything together in memory after the files have been
>>> downloaded.
[...]
>>> +static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
>>> +{
>>> +    int rc;
>>> +    void *baseaddr = (void *)0x2000;  /* Load right after the low-core */
>>> +
>>> +    rc = tftp_load(fn_ip, baseaddr, KERNEL_MAX_SIZE - (long)baseaddr);
>>> +
>>> +    if (rc > 0 && rc < sizeof(cfgbuf) - 1) {
>>> +        /* Check whether it is a configuration file instead of a kernel */
>> That's interesting because treating the bootfile as pxe-ish config is
>> what DPM does. Which means that with this change the processor
>> architecture type 0x1f (Basic) will turn into a superset of 0x20
>> (Extended).
> 
> Is there any reference available what "basic" and "extended" exactly
> mean? I just know that there are these two values registered by you at
> the IANA:
> 
> https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xhtml#processor-architecture
> 
> ... but I haven't seen a description of the differences of these two
> values yet.
> 
Yep, the IANA stuff is pretty terse for all architectures. In a
nutshell: 0x1f is standard DHCP-based boot (bootfile is a single
executable binary) and 0x20 serves a pxe-style config file instead.
In fact, "processor architecture identifier" is a misnomer, as it
describes a pair of processor architecture and firmware.
Since the QEMU firmware has two significant extensions now (insfile and
direct config file loading), it might be worthwhile to add a new
identifier value (say s390 QEMU PC-BIOS or similar) announcing the new
capabilities, so that a boot server admin can setup her system accordingly.
>> I guess this should be documented somewhere(TM) to avoid
>> confusion.
> 
> I plan to update https://wiki.qemu.org/Features/S390xNetworkBoot once
> the patches have been merged upstream.
> 
sounds good.
[...]

-- 
Regards,
  Viktor Mihajlovski

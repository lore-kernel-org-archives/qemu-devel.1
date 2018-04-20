Received: from eggs.gnu.org ([2001:4830:134:3::10]:37663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f9Pvi-00069L-Bh
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f9Pvd-0004E9-BN
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:53:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1f9Pvd-0004Ck-0f
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:53:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3K6qgDs054479
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 02:53:51 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hfasc1ecg-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 02:53:51 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Fri, 20 Apr 2018 07:53:48 +0100
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<1524054707-20663-4-git-send-email-thuth@redhat.com>
	<bc5533dc-9471-7dac-6aba-9014e9961376@linux.vnet.ibm.com>
	<b0bb6918-0047-9a53-b03f-bff5669daaaa@redhat.com>
	<2d59a139-3bdd-4b4e-882c-5cf845488eda@linux.vnet.ibm.com>
	<475ea222-cc03-16e4-0f50-f89cf2bfae6f@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 20 Apr 2018 08:53:45 +0200
MIME-Version: 1.0
In-Reply-To: <475ea222-cc03-16e4-0f50-f89cf2bfae6f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <0b6af02e-6e5b-76bb-a0d0-30038ad5a265@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.13 3/4]
 pc-bios/s390-ccw/net: Add support for pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 19.04.2018 18:55, Thomas Huth wrote:
> On 19.04.2018 14:40, Viktor VM Mihajlovski wrote:
>> On 19.04.2018 10:17, Thomas Huth wrote:
>>> On 19.04.2018 09:41, Viktor VM Mihajlovski wrote:
>>>> On 18.04.2018 14:31, Thomas Huth wrote:
>>>>> Since it is quite cumbersome to manually create a combined kernel with
>>>>> initrd image for network booting, we now support loading via pxelinux
>>>>> configuration files, too. In these files, the kernel, initrd and command
>>>>> line parameters can be specified seperately, and the firmware then takes
>>>>> care of glueing everything together in memory after the files have been
>>>>> downloaded.
>> [...]
>>>>> +static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
>>>>> +{
>>>>> +    int rc;
>>>>> +    void *baseaddr = (void *)0x2000;  /* Load right after the low-core */
>>>>> +
>>>>> +    rc = tftp_load(fn_ip, baseaddr, KERNEL_MAX_SIZE - (long)baseaddr);
>>>>> +
>>>>> +    if (rc > 0 && rc < sizeof(cfgbuf) - 1) {
>>>>> +        /* Check whether it is a configuration file instead of a kernel */
>>>> That's interesting because treating the bootfile as pxe-ish config is
>>>> what DPM does. Which means that with this change the processor
>>>> architecture type 0x1f (Basic) will turn into a superset of 0x20
>>>> (Extended).
>>>
>>> Is there any reference available what "basic" and "extended" exactly
>>> mean? I just know that there are these two values registered by you at
>>> the IANA:
>>>
>>> https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xhtml#processor-architecture
>>>
>>> ... but I haven't seen a description of the differences of these two
>>> values yet.
>>>
>> Yep, the IANA stuff is pretty terse for all architectures. In a
>> nutshell: 0x1f is standard DHCP-based boot (bootfile is a single
>> executable binary) and 0x20 serves a pxe-style config file instead.
> 
> Can 0x20 also still handle binary files, or only pxe-style config files?
> 
Unfortunately, DPM has no support for binaries which was the reason we
ended up with two different identifiers
>> In fact, "processor architecture identifier" is a misnomer, as it
>> describes a pair of processor architecture and firmware.
> 
> Yeah, I know ... it's even worse nowadays, it's processor + firmware +
> TCP/IP protocol (HTTP vs. TFTP) ... we should have properly untangled
> that when doing RFC 5970, but it was already hard enough to get that
> accepted in the current shape, so we missed to clean up the mess from
> RFC 4578 / PXE :-(
> 
>> Since the QEMU firmware has two significant extensions now (insfile and
>> direct config file loading), it might be worthwhile to add a new
>> identifier value (say s390 QEMU PC-BIOS or similar) announcing the new
>> capabilities, so that a boot server admin can setup her system accordingly.
> 
> Not sure ... too many processory-architecture-type entries might also
> rather be too confusing for the users? ... so if 0x20 can also handle
> binary files like 0x1f, I'd maybe simply go with 0x20 and mainly promote
> pxelinux config files in the documentation?
> 
Well, if we don't add another identifier, and I feel reluctant about it
as well for the reasons you wrote, we may stick with 0x1f and consider
the additional capabilities as being optional (for special needs only).
Remember that a client-specific pxe-style config or insfile have to be
tied to a client identifier that can be referenced in the DHCP server
configuration (usually the MAC address). I.e., if MAC equals so-and-so
send back bootfile name xyz.
But this is exactly what the pxelinux config file probing offers: having
client (or client-group) specific configs without the need to
reconfigure the DHCP server for every new (virtual) machine. My
assumption is that server admins will go with the pxelinux config
approach they're used from other architectures (which becomes now even
easier with your changes).
>  Thomas
> 


-- 
Regards,
  Viktor Mihajlovski

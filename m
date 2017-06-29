Received: from eggs.gnu.org ([2001:4830:134:3::10]:33488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <javierm@redhat.com>) id 1dQYjE-0005Lv-8i
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <javierm@redhat.com>) id 1dQYjB-0006Do-HS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:39:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <javierm@redhat.com>) id 1dQYjB-0006CX-5t
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:39:21 -0400
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
	<e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <8c6ec7dd-aaa5-272f-6f75-9440acb10f61@redhat.com>
Date: Thu, 29 Jun 2017 14:39:14 +0200
MIME-Version: 1.0
In-Reply-To: <e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] TPM status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Jones <pjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Hello Stefan,

Thanks a lot for the summary, it's very informative. I've a question below.

On 06/27/2017 06:12 PM, Stefan Berger wrote:

> 
> QEMU TPM Device
> ===============
> 
> = Guest-side Hardware Interface =
> 
> The QEMU TPM emulation implements a TPM TIS hardware interface following
> the Trusted Computing Group's specification "TCG PC Client Specific TPM
> Interface Specification (TIS)", Specifcation Version 1.3, 21 March 2013.
> This specification, or a later version of it, can be accessed from the
> following URL:
> 
> https://trustedcomputinggroup.org/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
> 
> The TIS interface makes a memory mapped IO region in the area 0xfed40000 -
> 0xfed44fff available to the guest operating system.
>

Besides the TIS interface, the TPM2.0 spec defines a CRB (Command Response
Buffer Interface) as described in the "TCG PC Client Platform TPM Profile
(PTP) Specification Family 2.0, Level 00 Revision 00.43, January 26, 2015"

https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2-0-v43-150126.pdf

> 
> = TPM backend devices =
> 
> The TPM implementation is split into two parts. The one part is the hardware
> interface, such as the TPM TIS interface described earlier, and the TPM backend
> interface. The backend interfaces implement the interaction with a TPM device,
> which may be a physical or an emulated device. The split between the front-
> and backend devices allows a frontend to be connected with any available
> backend. This enables the TIS interface to be used with the passthrough backend
> or the (future) swtpm backend.

So we will need another TPM interface that implements the CRB interface? I
have a machine with the Intel PTT TPM2.0 (firmware-based implemented in ME)
that uses this CRB interface instead of TIS1.2 + cancel, so libvirt fails:

Error starting domain: internal error: No usable sysfs TPM cancel file could be found

Traceback (most recent call last):
  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 88, in cb_wrapper
    callback(asyncjob, *args, **kwargs)
  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 124, in tmpcb
    callback(*args, **kwargs)
  File "/usr/share/virt-manager/virtManager/libvirtobject.py", line 83, in newfn
    ret = fn(self, *args, **kwargs)
  File "/usr/share/virt-manager/virtManager/domain.py", line 1479, in startup
    self._backend.create()
  File "/usr/lib64/python2.7/site-packages/libvirt.py", line 1039, in create
    if ret == -1: raise libvirtError ('virDomainCreate() failed', dom=self)
libvirtError: internal error: No usable sysfs TPM cancel file could be found

The Linux kernel exposes either a TIS or CRB interface depending on what is
filled in the TPM2 ACPI table "Start Method" field as specified in "TCG ACPI
Specification Family 1.2 and 2.0 Version 1.2, Revision 8 February 27, 2017"

https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification-Family-1.2-and-2.0-Ver1.2-Rev8_public-revie....pdf

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat

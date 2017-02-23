Received: from eggs.gnu.org ([2001:4830:134:3::10]:37353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgw3J-0005eB-Pn
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgw3G-0005BD-M2
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:15:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgw3G-0005Ax-G3
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:15:30 -0500
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
	<fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
	<CAFEAcA--bSo7PJH0Px9ytQspaYuS55CSsM_EN6zt0djhkqKNPw@mail.gmail.com>
	<5a0773de-6bc7-474a-82ab-2edd37ce8a93@redhat.com>
	<CAFEAcA99xi4k57h2XGw2deGO24E95AS5jyGL+4GzjqNgMb9wcg@mail.gmail.com>
	<92580ca9-47fe-a943-7720-d3cb1fc6d2eb@redhat.com>
	<CAFEAcA8769a_8xwk57FS6Ko+Lioud20+70JRSafeEic6GB_RAw@mail.gmail.com>
	<3d5e7b5e-4501-86b7-093d-47fb09af585e@redhat.com>
	<CAFEAcA9gcArSqhbRi6-YdR=5eE9dtq66C7N0qTbCuBiY_Zr+tA@mail.gmail.com>
	<41630a89-e645-7d7e-b7c2-356fd6dcadee@redhat.com>
	<CAFEAcA_Mh9ZrJeu4f==ko1k2yLkfPe2AwNbUHcxkmS6Lzuvk0Q@mail.gmail.com>
	<2565ef99-9c16-e836-08c6-0915f5d4b0f8@redhat.com>
	<CAFEAcA_BgiXrjW9aRNFkXEEjS+kjibJ_UisJtiLgrPh=0re5qA@mail.gmail.com>
	<c76578aa-ec76-f904-b0fc-72676e4ce515@redhat.com>
	<CAFEAcA_waGB88XyzGxFbE_OyLAPnY70aEVQYzbS0k3KR+FF9DA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dac5dcb6-7beb-1c33-0a4e-b7977fce69b6@redhat.com>
Date: Thu, 23 Feb 2017 17:15:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_waGB88XyzGxFbE_OyLAPnY70aEVQYzbS0k3KR+FF9DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, zhong@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>



On 23/02/2017 17:08, Peter Maydell wrote:
> On 23 February 2017 at 15:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> However, DEVICE_NATIVE_ENDIAN would have to be paired with tswap, which
>> the current code does not do, hence the bug.  To have no swap at all,
>> you'd need DEVICE_HOST_ENDIAN.
> 
> Yes, I agree that the current ramdevice code has this bug (and
> that we can fix it by any of the various options).

Good. :)

>>> AIUI what we want for this VFIO case is "when the guest does
>>> a 32-bit write of 0x12345678 then the bytes are 0x12 0x34 0x56 0x78
>>> regardless of whether TARGET_BIG_ENDIAN or not".
>>
>> No, I don't think so.  This is not specific to VFIO.  You can do it with
>> any device, albeit VFIO is currently the only one using ramd regions.
> 
> The commit message in the patch that started this thread off
> says specifically that "VFIO PCI device is little endian".
> Is that wrong?

Yes, I think it's a red herring.  Hence my initial confusion, when I
asked "would Yongji's patch just work if it used DEVICE_BIG_ENDIAN and
beNN_to_cpu/cpu_to_beNN".

Paolo

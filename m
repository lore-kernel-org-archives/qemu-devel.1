Received: from eggs.gnu.org ([2001:4830:134:3::10]:42708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgosi-0007yP-Cg
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgosf-0001Jg-A2
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:36:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgosf-0001JV-4K
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:36:05 -0500
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
Date: Thu, 23 Feb 2017 09:35:59 +0100
MIME-Version: 1.0
In-Reply-To: <5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, zhong@linux.vnet.ibm.com, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>



On 23/02/2017 05:20, Alexey Kardashevskiy wrote:
> First, Paolo is right and ram_device_mem_ops::endianness should be
> host-endian which happens to be little in our test case (ppc64le)

So you tested a ppc64 BE guest and it works?

> Keep things where they are in the VFIO department and just fix
> ram_device_mem_ops::endianness?

I would fix the ram_device_mem_ops.  Either by introducing
DEVICE_HOST_ENDIAN(*) or with Yongji's patch.

(*) DEVICE_NATIVE_ENDIAN is special cased all over the place
    because the same device (in a file that's compiled just once)
    can be either little- or big-endian.  DEVICE_HOST_ENDIAN can
    be a simple #define to either DEVICE_LITTLE_ENDIAN or
    DEVICE_BIG_ENDIAN, because host endianness is the same for
    all QEMU binaries.  It's literally half a dozen lines of code.

Paolo

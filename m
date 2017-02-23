Received: from eggs.gnu.org ([2001:4830:134:3::10]:36708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgqEx-0000dD-4L
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgqEw-0001Sz-CB
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:03:11 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgqEw-0001Su-61
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:03:10 -0500
Received: by mail-wr0-x231.google.com with SMTP id 97so18476766wrb.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 02:03:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
	<fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 10:02:48 +0000
Message-ID: <CAFEAcA--bSo7PJH0Px9ytQspaYuS55CSsM_EN6zt0djhkqKNPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, zhong@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>

On 23 February 2017 at 08:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 23/02/2017 05:20, Alexey Kardashevskiy wrote:
>> First, Paolo is right and ram_device_mem_ops::endianness should be
>> host-endian which happens to be little in our test case (ppc64le)
>
> So you tested a ppc64 BE guest and it works?
>
>> Keep things where they are in the VFIO department and just fix
>> ram_device_mem_ops::endianness?
>
> I would fix the ram_device_mem_ops.  Either by introducing
> DEVICE_HOST_ENDIAN(*) or with Yongji's patch.
>
> (*) DEVICE_NATIVE_ENDIAN is special cased all over the place
>     because the same device (in a file that's compiled just once)
>     can be either little- or big-endian.  DEVICE_HOST_ENDIAN can
>     be a simple #define to either DEVICE_LITTLE_ENDIAN or
>     DEVICE_BIG_ENDIAN, because host endianness is the same for
>     all QEMU binaries.  It's literally half a dozen lines of code.

I'm really not convinced we need DEVICE_HOST_ENDIAN. RAM
areas should be target-endian (you can probably define
"target endianness" as "the endianness that RAM areas have".)

-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDAJ8-0003sA-A2
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDAJ2-0000d8-Kg
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:01:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fDAJ2-0000cx-FD
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:01:32 -0400
References: <20180430122404.10741-1-peter.maydell@linaro.org>
	<CAFEAcA_XLm34+7z3L6jPFMcffxPoKNvmKwrKVrrR6rT_E6wwvw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b40350d8-7654-f0d2-b695-df353015e96d@redhat.com>
Date: Mon, 30 Apr 2018 17:01:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_XLm34+7z3L6jPFMcffxPoKNvmKwrKVrrR6rT_E6wwvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory.h: Improve IOMMU related
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 30/04/2018 15:34, Peter Maydell wrote:
>>       */
>>      IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
>>                                 IOMMUAccessFlags flag);
> A question I just thought of -- how long is the IOMMUTLBEntry I get
> back guaranteed to be valid for? For instance if I'm in an RCU
> critical section can I assume it won't become invalid before I
> leave the critical section? Or must I always register an IOMMU
> notifier before I call translate? I'm guessing not the latter
> because flatview_do_translate() does not, but is the guarantee
> only RCU-critical section or while-holding-big-QEMU-lock or
> something else?

The only pointer inside is to the target AddressSpace, which (see
address_space_destroy) is safe to access inside either of those
condition.  In practice we use the former.

Paolo

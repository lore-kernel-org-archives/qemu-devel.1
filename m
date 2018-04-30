Received: from eggs.gnu.org ([2001:4830:134:3::10]:56146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD6Kj-0008Mt-HH
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD6Kg-0003Wn-Ec
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:47:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fD6Kg-0003WZ-9K
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:46:58 -0400
References: <20180426150901.30278-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb113306-8c1c-e414-18d1-3337f1521f5e@redhat.com>
Date: Mon, 30 Apr 2018 12:46:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180426150901.30278-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] mmio-exec: Make device return
 MemoryRegion rather than host pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Francisco Iglesias <frasse.iglesias@gmail.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, KONRAD Frederic <frederic.konrad@adacore.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "Emilio G. Cota" <cota@braap.org>

On 26/04/2018 17:09, Peter Maydell wrote:
> 
> QUESTIONS:
>  * do we really need to postpone things from
>    memory_region_invalidate_mmio_ptr() to
>    memory_region_do_invalidate_mmio_ptr(), given that the deletion of
>    the memory region and ramblock is RCU-deferred anyway?
>  * should we add the subregion at elevated prio so it definitely hits
>    first?  I've left it the way the existing code does for the
>    moment...
>  * is there any way to avoid the weird self-owning MemoryRegion
>    and corresponding need to pass a NULL name pointer?

There would be, but the comment here says why it'd be an issue:

    /* Memory regions without an owner are supposed to never go away;
     * we do not ref/unref them because it slows down DMA sensibly.
     */
    if (mr && mr->owner) {
        object_ref(mr->owner);
    }

though perhaps we can remove that other hack in 2.13, which will have
MemoryRegionCache again.

Paolo

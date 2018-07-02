Received: from eggs.gnu.org ([2001:4830:134:3::10]:40857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fa2PP-0003r6-7m
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fa2PM-0007VJ-1Z
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:14:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fa2PL-0007Un-TH
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:14:35 -0400
References: <20180702163125.28729-1-pbonzini@redhat.com>
	<CAFEAcA8=zvwfr=6pF+HuNkmD2HWwtSuLuepQwRR1+x8FyNNS=g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9872d42d-378d-123b-4b14-4698c8a68a84@redhat.com>
Date: Mon, 2 Jul 2018 19:14:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8=zvwfr=6pF+HuNkmD2HWwtSuLuepQwRR1+x8FyNNS=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fsdev: fix compilation with VIRTIO but not
 VIRTIO_9P
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>

On 02/07/2018 18:56, Peter Maydell wrote:
> On 2 July 2018 at 17:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> hw/9pfs/Makefile.objs uses CONFIG_VIRTIO_9P to guard the definition for
>> FileOperations structs, while fsdev/Makefile.objs uses CONFIG_VIRTIO
>> to guard the use.  Mismatch causes linking to fail when CONFIG_VIRTIO
>> is set but CONFIG_VIRTIO_9P is not.
>>
>> Fix it and use if/else to clarify that the two lines are for opposite
>> conditions.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Fixes: b5dfdb082fc350f3e68dfa61dc988d97cad28cfe
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  fsdev/Makefile.objs | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> I've also just noticed that hw/Makefile.objs guards the use
> of the hw/9pfs directory with
> devices-dirs-$(call land,$(CONFIG_VIRTFS),$(call
> lor,$(CONFIG_VIRTIO),$(CONFIG_XEN))) += 9pfs/
> 
> so after b5dfdb082fc we're now somewhat redundantly guarding
> the object files with both this check and with the new one
> inside hw/9pfs/Makefile.objs. Maybe we should make the
> hw/Makefile.objs guard use CONFIG_VIRTIO_9P where it
> currently has CONFIG_VIRTIO and then drop the ifeq in
> hw/9pfs/Makefile.objs ?

Yes, that makes sense.

Paolo

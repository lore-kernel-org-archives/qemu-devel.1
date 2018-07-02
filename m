Received: from eggs.gnu.org ([2001:4830:134:3::10]:58076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa28D-0005yS-GN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa28C-0002hQ-Kr
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:56:53 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fa28C-0002gV-7k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:56:52 -0400
Received: by mail-oi0-x242.google.com with SMTP id m2-v6so9703153oim.12
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:56:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702163125.28729-1-pbonzini@redhat.com>
References: <20180702163125.28729-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 17:56:30 +0100
Message-ID: <CAFEAcA8=zvwfr=6pF+HuNkmD2HWwtSuLuepQwRR1+x8FyNNS=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>

On 2 July 2018 at 17:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
> hw/9pfs/Makefile.objs uses CONFIG_VIRTIO_9P to guard the definition for
> FileOperations structs, while fsdev/Makefile.objs uses CONFIG_VIRTIO
> to guard the use.  Mismatch causes linking to fail when CONFIG_VIRTIO
> is set but CONFIG_VIRTIO_9P is not.
>
> Fix it and use if/else to clarify that the two lines are for opposite
> conditions.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: b5dfdb082fc350f3e68dfa61dc988d97cad28cfe
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  fsdev/Makefile.objs | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I've also just noticed that hw/Makefile.objs guards the use
of the hw/9pfs directory with
devices-dirs-$(call land,$(CONFIG_VIRTFS),$(call
lor,$(CONFIG_VIRTIO),$(CONFIG_XEN))) += 9pfs/

so after b5dfdb082fc we're now somewhat redundantly guarding
the object files with both this check and with the new one
inside hw/9pfs/Makefile.objs. Maybe we should make the
hw/Makefile.objs guard use CONFIG_VIRTIO_9P where it
currently has CONFIG_VIRTIO and then drop the ifeq in
hw/9pfs/Makefile.objs ?

thanks
-- PMM

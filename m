Received: from eggs.gnu.org ([209.51.188.92]:55227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gj4ur-0007qz-1H
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gj4uq-00077s-4w
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:16:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gj4up-00076Z-T2
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:16:44 -0500
Date: Mon, 14 Jan 2019 09:07:57 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190114090757.68bfa839@x1.home>
In-Reply-To: <648fabd1-b598-02a9-14f6-02ed2c767b2a@huawei.com>
References: <648fabd1-b598-02a9-14f6-02ed2c767b2a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Questions about VFIO enabling MSIX vector
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heyi Guo <guoheyi@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, wanghaibin 00208455 <wanghaibin.wang@huawei.com>

On Sat, 12 Jan 2019 10:30:40 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> Hi folks,
> 
> I have some questions about vfio_msix_vector_do_use() in
> hw/vfio/pci.c, could you help to explain?
> 
> We can see that when guest tries to enable one specific MSIX vector
> by unmasking MSIX Vector Control, the access will be trapped and then
> into function vfio_msix_vector_do_use(). And we may go to the below
> branch in line 525:
> 
> 
> 520 /*
> 521  * We don't want to have the host allocate all possible MSI vectors
> 522  * for a device if they're not in use, so we shutdown and incrementally
> 523  * increase them as needed.
> 524  */
> 525  if (vdev->nr_vectors < nr + 1) {
> 526      vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
> 527      vdev->nr_vectors = nr + 1;
> 528      ret = vfio_enable_vectors(vdev, true);
> 529      if (ret) {
> 530          error_report("vfio: failed to enable vectors, %d", ret);
> 531      }
> 
> Here all MSIX vectors will be disabled first and then enabled, with
> one more MSIX. The comment is there but I still don't quite
> understand. It makes sense for not allocating all possible MSI
> vectors, but why shall we shutdown the whole MSI when being requested
> to enable one specific vector? Can't we just enable the user
> specified vector indexed by "nr"?

What internal kernel API would vfio-pci make use of to achieve that?
We can't know the intentions of the guest and we have a limited set of
tools to manage the MSI-X state in the host kernel.  It's generally the
case that MSI-X vectors are only manipulated during driver setup and
shutdown, so while the current behavior isn't necessarily efficient, it
works within the constraints and generally doesn't have a runtime impact
on performance.  We also recognize that this behavior may change in the
future depending on more dynamic internal host kernel interfaces, thus
we export the VFIO_IRQ_INFO_NORESIZE flag to indicate to userspace
whether this procedure is required.

> What's more, on ARM64 systems with GIC ITS, the kernel will issue an
> ITS discard command when disabling a MSI vector, which will drop
> currently pending MSI interrupt. If device driver in guest system
> enables some MSIs first and interrupts may come at any time, and then
> it tries to enable other MSIs, is it possible for the above code to
> cause interrupts missing?

Interrupt reconfiguration is generally during driver setup or teardown
when the device is considered idle or lost interrupts are not a
concern.  If you have a device which manipulates interrupt
configuration runtime, you can expect that lost interrupts won't be the
only problem, it's also likely to experience much more overhead in the
interrupt manipulation path under assignment than on bare metal.  This
is another reason that well behaved drivers generally use relatively
static interrupt configurations initialized at driver setup time.
Thanks,

Alex

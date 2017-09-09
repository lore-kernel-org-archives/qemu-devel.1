Received: from eggs.gnu.org ([2001:4830:134:3::10]:54021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dqgAZ-00061i-5F
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 09:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dqgAQ-0003ER-Sy
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 09:51:35 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dqgAQ-0003CO-Mn
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 09:51:26 -0400
Received: by mail-wm0-x244.google.com with SMTP id x17so3492674wmd.5
	for <qemu-devel@nongnu.org>; Sat, 09 Sep 2017 06:51:25 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170907202637.23121.65136.stgit@gimli.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6fa3058b-6c6a-18f4-4433-cd1f53dd19be@redhat.com>
Date: Sat, 9 Sep 2017 15:51:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170907202637.23121.65136.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost: Release memory references on cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com

On 07/09/2017 22:27, Alex Williamson wrote:
> vhost registers a MemoryListener where it adds and removes references
> to MemoryRegions as the MemoryRegionSections pass through.  The
> region_add callback is invoked for each existing section when the
> MemoryListener is registered, but unregistering the MemoryListener
> performs no reciprocal region_del callback.  It's therefore the
> owner of the MemoryListener's responsibility to cleanup any persistent
> changes, such as these memory references, after unregistering.
> 
> The consequence of this bug is that if we have both a vhost device
> and a vfio device, the vhost device will reference any mmap'd MMIO of
> the vfio device via this MemoryListener.  If the vhost device is then
> removed, those references remain outstanding.  If we then attempt to
> remove the vfio device, it never gets finalized and the only way to
> release the kernel file descriptors is to terminate the QEMU process.
> 
> Fixes: dfde4e6e1a86 ("memory: add ref/unref calls")
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-stable@nongnu.org # v1.6.0+
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

This fix is correct.  It's surprising that it was only found now!

Thanks,

Paolo

> ---
>  hw/virtio/vhost.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6eddb099b02f..b737ca915b06 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1356,6 +1356,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>      if (hdev->mem) {
>          /* those are only safe after successful init */
>          memory_listener_unregister(&hdev->memory_listener);
> +        for (i = 0; i < hdev->n_mem_sections; ++i) {
> +            MemoryRegionSection *section = &hdev->mem_sections[i];
> +            memory_region_unref(section->mr);
> +        }
>          QLIST_REMOVE(hdev, entry);
>      }
>      if (hdev->migration_blocker) {
> 

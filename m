Received: from eggs.gnu.org ([2001:4830:134:3::10]:43088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cfoPY-0003Un-U9
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cfoPV-0008VP-Kd
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:53:52 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cfoPV-0008VJ-EK
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:53:49 -0500
Received: by mail-wm0-x242.google.com with SMTP id v77so14511468wmv.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:53:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170220093304.20515-1-stefanha@redhat.com>
	<CAFEAcA_5dyLsiGwns9LgBf92Ffv57VEPo3SYmfz6wGeFU7YeLg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75895472-5968-ffcd-a410-e0df320461a2@redhat.com>
Date: Mon, 20 Feb 2017 14:53:44 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_5dyLsiGwns9LgBf92Ffv57VEPo3SYmfz6wGeFU7YeLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/24] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 20/02/2017 14:37, Peter Maydell wrote:
> 
>  -void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
>  +bool virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
>   {
> +     virtio_scsi_acquire(s);
>       if (s->events_dropped) {
>           virtio_scsi_push_event(s, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
>  +        return true;
>       }
> ++<<<<<<< HEAD
>  +    return false;
> ++=======
> +     virtio_scsi_release(s);
> ++>>>>>>> remotes/stefanha/tags/block-pull-request
>   }
> 
>   static void virtio_scsi_handle_event(VirtIODevice *vdev, VirtQueue *vq)
> 
> since one half of this merge is adding extra return paths
> which won't have release() calls in them in the other half.

Indeed, it needs to add the release call on both paths.

Paolo

> Can you rebase and fix, please?

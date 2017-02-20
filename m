Received: from eggs.gnu.org ([2001:4830:134:3::10]:39578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfoAX-0002pv-Nk
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfoAW-00048l-QM
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:38:21 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfoAW-00048Z-JI
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:38:20 -0500
Received: by mail-wr0-x232.google.com with SMTP id 89so59693714wrr.3
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:38:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170220093304.20515-1-stefanha@redhat.com>
References: <20170220093304.20515-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 13:37:58 +0000
Message-ID: <CAFEAcA_5dyLsiGwns9LgBf92Ffv57VEPo3SYmfz6wGeFU7YeLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/24] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 February 2017 at 09:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 5dae13cd71f0755a1395b5a4cde635b8a6ee3f58:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-or-20170214' into staging (2017-02-14 09:55:48 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to decc18f33adecb1316437a47fff0cf0a7665906a:
>
>   coroutine-lock: make CoRwlock thread-safe and fair (2017-02-16 17:17:34 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Hi; this has merge conflicts in hw/scsi/virtio-scsi.c and
hw/block/virtio-blk.c which I could maybe resolve by hand
but at least one of them makes me suspicious that perhaps
the automatic merging will have semantically mismerged:

@@@ -758,13 -756,13 +768,18 @@@ out
      virtio_scsi_release(s);
  }

 -void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
 +bool virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
  {
+     virtio_scsi_acquire(s);
      if (s->events_dropped) {
          virtio_scsi_push_event(s, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
 +        return true;
      }
++<<<<<<< HEAD
 +    return false;
++=======
+     virtio_scsi_release(s);
++>>>>>>> remotes/stefanha/tags/block-pull-request
  }

  static void virtio_scsi_handle_event(VirtIODevice *vdev, VirtQueue *vq)

since one half of this merge is adding extra return paths
which won't have release() calls in them in the other half.

Can you rebase and fix, please?

thanks
-- PMM

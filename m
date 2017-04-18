Received: from eggs.gnu.org ([2001:4830:134:3::10]:44516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0Vmh-0001wr-Pb
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 12:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0Vmd-00034B-Ov
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 12:15:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d0Vmd-00033M-Fy
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 12:15:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3IGDwVi116296
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 12:15:14 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29w4jajg9m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 12:15:13 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 18 Apr 2017 17:15:11 +0100
Date: Tue, 18 Apr 2017 18:15:04 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1492345561-10267-1-git-send-email-tgnyang@gmail.com>
References: <1492345561-10267-1-git-send-email-tgnyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170418181504.66fb3a11.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw: make *_exit functions return void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <tgnyang@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

On Sun, 16 Apr 2017 20:26:01 +0800
Zihan Yang <tgnyang@gmail.com> wrote:

>     According to the second suggestion listed on Dead code Removal
>     of BiteSizedTasks, I modify some *_exit functions to make them
>     return void. Some *_exit and *_exitfn functions that already
>     return void remain unchanged. Also, the checks for the callers
>     are deleted.
> 
> Signed-off-by: Zihan Yang <tgnyang@gmail.com>
> ---
>  hw/audio/hda-codec.c              | 3 +--
>  hw/audio/intel-hda.c              | 3 +--
>  hw/audio/intel-hda.h              | 2 +-
>  hw/char/sclpconsole-lm.c          | 3 +--
>  hw/char/sclpconsole.c             | 3 +--
>  hw/core/qdev.c                    | 6 +-----
>  hw/s390x/event-facility.c         | 6 +-----
>  hw/s390x/virtio-ccw.c             | 7 +++----
>  hw/s390x/virtio-ccw.h             | 2 +-
>  hw/usb/dev-smartcard-reader.c     | 3 +--
>  include/hw/qdev-core.h            | 2 +-
>  include/hw/s390x/event-facility.h | 2 +-
>  12 files changed, 14 insertions(+), 28 deletions(-)

Hm, I wondered why I had a deja vu... ah, here:
https://marc.info/?t=149003291200008&r=1&w=2

The author of that patch did not follow up AFAICS, but some of the
suggestions made in that thread apply to your patch as well.

In particular:


> diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> index 07d6ebd..6fa8922 100644
> --- a/hw/char/sclpconsole-lm.c
> +++ b/hw/char/sclpconsole-lm.c
> @@ -318,9 +318,8 @@ static int console_init(SCLPEvent *event)
>      return 0;
>  }
> 
> -static int console_exit(SCLPEvent *event)
> +static void console_exit(SCLPEvent *event)
>  {
> -    return 0;
>  }
> 
>  static void console_reset(DeviceState *dev)
> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> index b78f240..d9bbc5e 100644
> --- a/hw/char/sclpconsole.c
> +++ b/hw/char/sclpconsole.c
> @@ -246,9 +246,8 @@ static void console_reset(DeviceState *dev)
>     scon->notify = false;
>  }
> 
> -static int console_exit(SCLPEvent *event)
> +static void console_exit(SCLPEvent *event)
>  {
> -    return 0;
>  }

These two now empty functions are not very useful; it is better to
simply remove them.

With that change, I'd take a split-out patch for sclp and virtio-ccw
through my tree, or I'd ack a not-split-out version.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdr@ashroe.eu>) id 1ebTuz-0000aP-Rn
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdr@ashroe.eu>) id 1ebTuw-0001cE-JJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:16:57 -0500
Received: from mail.ashroe.eu ([94.176.239.133]:59722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdr@ashroe.eu>) id 1ebTuw-0001bM-Cb
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:16:54 -0500
References: <1515924416-9266-1-git-send-email-ghammer@redhat.com>
From: "Kinsella, Ray" <mdr@ashroe.eu>
Message-ID: <4a649398-c643-33d2-f4ec-cd031b963e2f@ashroe.eu>
Date: Tue, 16 Jan 2018 15:40:21 +0000
MIME-Version: 1.0
In-Reply-To: <1515924416-9266-1-git-send-email-ghammer@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/3 v2] virtio: improve virtio devices
 initialization time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gal Hammer <ghammer@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com

Hi Gal,

Brilliant - will test this in the next day or two.
Hopefully this will help resolve the issues I reported last summer.

http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg05268.html

Ray K

On 14/01/2018 10:06, Gal Hammer wrote:
> A bug was reported about a very slow boot time and a 100% CPU usage of
> both Windows and Linux guests when running a VM with multiple
> virtio-serial devices (https://bugzilla.redhat.com/1528588).
>
> For example, running a VM with 25 virtio-serial devices, each one with
> max_ports=511, could have a boot time of around 30 minutes. With this
> patch (and another patch to kvm) the boot time is reduced to
> approximately 3 minutes.
>
> The patch wraps all the changes made to the Memory Regions during the
> eventfd registrations in a memory regions transaction. I had to add a
> cleanup callback function to the EventNotifier struct, so it will be
> possible to use a transaction in the shutdown code path as well.
>
> Gal Hammer (3):
>    qemu: add a cleanup callback function to EventNotifier
>    virtio: postpone the execution of event_notifier_cleanup function
>    virtio: improve virtio devices initialization time
>
>   accel/kvm/kvm-all.c           |  4 ++++
>   hw/virtio/virtio-bus.c        | 19 +++++++++++--------
>   hw/virtio/virtio.c            |  5 +++++
>   include/qemu/event_notifier.h |  1 +
>   util/event_notifier-posix.c   |  5 ++++-
>   util/event_notifier-win32.c   |  2 ++
>   6 files changed, 27 insertions(+), 9 deletions(-)
>

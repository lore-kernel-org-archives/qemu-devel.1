Received: from eggs.gnu.org ([2001:4830:134:3::10]:35834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1egRMb-0006cq-Vd
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 03:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1egRMY-0007ZY-Qr
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 03:33:58 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ghammer@redhat.com>) id 1egRMY-0007ZH-Lz
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 03:33:54 -0500
Received: by mail-oi0-f66.google.com with SMTP id 4so7182045ois.10
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 00:33:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129184717.68df3b33@bahia.lan>
References: <1517235657-22547-1-git-send-email-ghammer@redhat.com>
	<20180129184717.68df3b33@bahia.lan>
From: Gal Hammer <ghammer@redhat.com>
Date: Tue, 30 Jan 2018 10:33:53 +0200
Message-ID: <CAA2ifQxgTnAohjkmP3ji7KDqbTyo9g5sjbMtHh55iGiXoZyKNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/2] virtio: improve virtio devices
 initialization time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

Hi Greg,

On Mon, Jan 29, 2018 at 7:47 PM, Greg Kurz <groug@kaod.org> wrote:
> On Mon, 29 Jan 2018 16:20:55 +0200
> Gal Hammer <ghammer@redhat.com> wrote:
>
>> Using a cleanup callback function (Version 2 of this patches) in order to
>> support transactions fails when the same event notifier fd was used by more
>> than one Memory Region.
>>
>> This time I ask the caller to do the event notifier cleanup by himself.
>>
>
> Much better ! QEMU no longer aborts. Also I could observe a speed-up when
> booting a fedora27 guest with 5 virtio-serial devices (max_ports=511), from
> 1m40s down to 1m10s. Impressive. :)

Thanks for the quick review, testing, and the kudos ;-).

After spending some time trying to understand why the previous patch
fails I was able to figure it out. I was using
"disable-legacy=on,disable-modern=off", so I missed the fact that a
"transition" device registers two different memory regions with the
same event fd.

> For all the patches in this series:
>
> Reviewed-by: Greg Kurz <groug@kaod.org>
>
> and
>
> Tested-by: Greg Kurz <groug@kaod.org>
>
>> Gal Hammer (2):
>>   virtio: remove event notifier cleanup call on de-assign
>>   virtio: improve virtio devices initialization time
>>
>>  hw/block/dataplane/virtio-blk.c |  2 ++
>>  hw/scsi/virtio-scsi-dataplane.c |  2 ++
>>  hw/virtio/vhost.c               |  2 ++
>>  hw/virtio/virtio-bus.c          | 14 ++++++++++----
>>  hw/virtio/virtio.c              | 22 +++++++++++++++++++++-
>>  include/hw/virtio/virtio-bus.h  |  2 ++
>>  6 files changed, 39 insertions(+), 5 deletions(-)
>>
>

BTW: There is a pending patch for kvm that will trim few more seconds
from the boot time...

    Gal.

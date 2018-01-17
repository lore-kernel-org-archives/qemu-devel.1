Received: from eggs.gnu.org ([2001:4830:134:3::10]:42289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1ebk16-0005fj-Jl
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1ebk13-0005SL-CP
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:28:20 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ghammer@redhat.com>) id 1ebk13-0005Pj-3Q
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:28:17 -0500
Received: by mail-lf0-f65.google.com with SMTP id o89so16899033lfg.10
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 01:28:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4a649398-c643-33d2-f4ec-cd031b963e2f@ashroe.eu>
References: <1515924416-9266-1-git-send-email-ghammer@redhat.com>
	<4a649398-c643-33d2-f4ec-cd031b963e2f@ashroe.eu>
From: Gal Hammer <ghammer@redhat.com>
Date: Wed, 17 Jan 2018 11:28:14 +0200
Message-ID: <CAA2ifQy8pxOcxb_VbU-k+_6nDQ+pyMxB_j=pQGp_emUz7PK3cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Kinsella, Ray" <mdr@ashroe.eu>
Cc: qemu-devel@nongnu.org

Hi Ray,

On Tue, Jan 16, 2018 at 5:40 PM, Kinsella, Ray <mdr@ashroe.eu> wrote:
> Hi Gal,
>
> Brilliant - will test this in the next day or two.
> Hopefully this will help resolve the issues I reported last summer.
>
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg05268.html

Thanks for the compliment although a little over-tuned. ;-)

I'm not sure my patch will help with your problem of multiple PCI
devices (lots of devices). My patch improves the eventfd registration
path while it seems that the source of your problem is either
limitation enforced by the PCI specifications or by the QEMU's PCI
emulation code.

> Ray K

    Gal.

>
> On 14/01/2018 10:06, Gal Hammer wrote:
>>
>> A bug was reported about a very slow boot time and a 100% CPU usage of
>> both Windows and Linux guests when running a VM with multiple
>> virtio-serial devices (https://bugzilla.redhat.com/1528588).
>>
>> For example, running a VM with 25 virtio-serial devices, each one with
>> max_ports=511, could have a boot time of around 30 minutes. With this
>> patch (and another patch to kvm) the boot time is reduced to
>> approximately 3 minutes.
>>
>> The patch wraps all the changes made to the Memory Regions during the
>> eventfd registrations in a memory regions transaction. I had to add a
>> cleanup callback function to the EventNotifier struct, so it will be
>> possible to use a transaction in the shutdown code path as well.
>>
>> Gal Hammer (3):
>>    qemu: add a cleanup callback function to EventNotifier
>>    virtio: postpone the execution of event_notifier_cleanup function
>>    virtio: improve virtio devices initialization time
>>
>>   accel/kvm/kvm-all.c           |  4 ++++
>>   hw/virtio/virtio-bus.c        | 19 +++++++++++--------
>>   hw/virtio/virtio.c            |  5 +++++
>>   include/qemu/event_notifier.h |  1 +
>>   util/event_notifier-posix.c   |  5 ++++-
>>   util/event_notifier-win32.c   |  2 ++
>>   6 files changed, 27 insertions(+), 9 deletions(-)
>>
>

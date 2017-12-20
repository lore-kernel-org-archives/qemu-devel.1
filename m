Received: from eggs.gnu.org ([2001:4830:134:3::10]:56070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eRXpe-0002St-2M
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eRXpd-000883-13
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:26:22 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:32983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eRXpc-00087M-PX
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:26:20 -0500
Received: by mail-wr0-x242.google.com with SMTP id v21so10615370wrc.0
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 22:26:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171220060449-mutt-send-email-mst@kernel.org>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171219113505.GA8499@stefanha-x1.localdomain>
	<20171219161754-mutt-send-email-mst@kernel.org>
	<CAJSP0QV80YLwDfKJaXkjepwttsrX1wuH0c_69KTq_mGimYMf1g@mail.gmail.com>
	<20171220060449-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 20 Dec 2017 06:26:18 +0000
Message-ID: <CAJSP0QUug3R0BB15pKi6Rj+nRsarmttVnuQVpGe7YYL26+4dgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Avi Cohen (A)" <avi.cohen@huawei.com>, "Yang,
	Zhiyong" <zhiyong.yang@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Wei Wang <wei.w.wang@intel.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Dec 20, 2017 at 4:06 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Dec 19, 2017 at 05:05:59PM +0000, Stefan Hajnoczi wrote:
>> On Tue, Dec 19, 2017 at 2:56 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >>  * Please handle short reads/writes and EAGAIN with the UNIX domain socket.  Do
>> >>    not use read/write_all() functions because they hang QEMU until I/O
>> >>    completes.
>> >
>> > I'm not sure I agree with this one. vhost-user uses this extensively
>> > right now. It might be a worth-while goal to drop this limitation
>> > but I don't see why we should start with vhost-pci.
>> >
>> > And in particular, VCPU can't make progress unless a slave is present.
>>
>> Hang on, we're talking about different things:
>>
>> The QEMU vhost-user master blocks because vhost_*() functions are
>> synchronous (they don't use callbacks or yield).  Fixing that is
>> beyond the scope of this patch series and I'm not asking for it.
>>
>> This patch series adds a from-scratch vhost-user slave implementation
>> which has no good reason to be blocking.  A single malicious or broken
>> guest must not be able to hang a vhost-pci network switch.
>
> Hmm that's not an easy change. But I agree, it's more important for
> the switch.

It's easy,  See "[PATCH v3 4/7] vhost-pci-slave: add vhost-pci slave
implementation".  There is only one qemu_chr_fe_read_all() call and
one qemu_chr_fe_write_all() call!

The read is the first thing that happens when the socket becomes
readable.  The write is the last thing that happens when a vhost-user
protocol message has been handled.

Moreover, the socket is only used in half-duplex with 1
request/response at any given time.

This means most of the code will be unchanged.  Only the beginning of
vp_slave_read() and vp_slave_write() need to be adapted.  I'm not
asking for a lot.

Stefan

Received: from eggs.gnu.org ([209.51.188.92]:41876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hJ8Ms-00020W-5G
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 23:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hJ8Mo-0004wc-1p
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 23:14:41 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e]:45411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fengyd81@gmail.com>) id 1hJ8Ml-0004Tq-DH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 23:14:35 -0400
Received: by mail-io1-xd2e.google.com with SMTP id e8so2248124ioe.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 20:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACnvu8YKqaZA7XSD41=SQrUL7h9YafJMgKPe5cJZd3XZ3zrSNw@mail.gmail.com>
	<20190415145358.GA2893@work-vm>
	<CACnvu8a5DjAUhfAGmi6GtpD1V2hfoNLTkKEgbsFuL_6GrRc+pg@mail.gmail.com>
	<CACnvu8Y9Ub5PAOt18ukzvOoDxmfzwvygWWwOZaT5Q2Eig6YFTw@mail.gmail.com>
	<20190416084738.GA3123@work-vm>
	<CACnvu8Y7OQSYgGUXm5+bdB0owwmm+gSDpuaGQn=5QNhB5wcjvQ@mail.gmail.com>
In-Reply-To: <CACnvu8Y7OQSYgGUXm5+bdB0owwmm+gSDpuaGQn=5QNhB5wcjvQ@mail.gmail.com>
From: fengyd <fengyd81@gmail.com>
Date: Wed, 24 Apr 2019 11:14:15 +0800
Message-ID: <CACnvu8aWowPEo=0fE+CXbdp+g9LFvxSNjRsAHdQiQzvJfoYjsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Fwd: How live migration work for vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

Hi,

For vhost,  *last_avail_idx*  is maintained in vhost_virtqueue
but during live migration, *last_avail_idx*  is fetched from VirtQueue.
Do you know how these two *last_avail_idx *are synchronized?

virtio_load related code which is called during live migration:

* vdev->vq[i].inuse = (uint16_t)(vdev->vq[i].last_avail_idx -*

*                                vdev->vq[i].used_idx);*

*            if (vdev->vq[i].inuse > vdev->vq[i].vring.num) {*

*                error_report("VQ %d size 0x%x < last_avail_idx 0x%x - "*

*                             "used_idx 0x%x",*

*                             i, vdev->vq[i].vring.num,*

*                             vdev->vq[i].last_avail_idx,*


Thanks

On Tue, 23 Apr 2019 at 14:20, fengyd <fengyd81@gmail.com> wrote:

> Hi,
>
> I want to add some log to qemu-kvm-ev.
> Do you know how to compile qemu-kvm-ev from source code?
>
> Thanks
>
> Yafeng
>
> On Tue, 16 Apr 2019 at 16:47, Dr. David Alan Gilbert <dgilbert@redhat.com>
> wrote:
>
>> * fengyd (fengyd81@gmail.com) wrote:
>> > ---------- Forwarded message ---------
>> > From: fengyd <fengyd81@gmail.com>
>> > Date: Tue, 16 Apr 2019 at 09:17
>> > Subject: Re: [Qemu-devel] How live migration work for vhost-user
>> > To: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> >
>> >
>> > Hi,
>> >
>> > Any special feature needs to be supported on guest driver?
>> > Because it's OK for standard Linux VM, but not OK for our VM where
>> virtio
>> > is  implemented by ourself.
>>
>> I'm not sure; you do have to support that 'log' mechanism but I don't
>> know what else is needed.
>>
>> > And with qemu-kvm-ev-2.6, live migration can work with our VM where
>> virtio
>> > is  implemented by ourself.
>>
>> 2.6 is pretty old, so there's a lot of changes - not sure what's
>> relevant.
>>
>> Dave
>>
>> > Thanks
>> > Yafeng
>> >
>> > On Mon, 15 Apr 2019 at 22:54, Dr. David Alan Gilbert <
>> dgilbert@redhat.com>
>> > wrote:
>> >
>> > > * fengyd (fengyd81@gmail.com) wrote:
>> > > > Hi,
>> > > >
>> > > > During live migration,  the folloing log can see in
>> nova-compute.log in
>> > > my
>> > > > environment:
>> > > >  ERROR nova.virt.libvirt.driver
>> [req-039a85e1-e7a1-4a63-bc6d-c4b9a044aab6
>> > > > 0cdab20dc79f4bc6ae5790e7b4a898ac 3363c319773549178acc67f32c78310e -
>> > > default
>> > > > default] [instance: 5ec719f4-1865-4afe-a207-3d9fae22c410] Live
>> Migration
>> > > > failure: internal error: qemu unexpectedly closed the monitor:
>> > > > 2019-04-15T02:58:22.213897Z qemu-kvm: VQ 0
>> > > > size 0x100 < last_avail_idx 0x1e - used_idx 0x23
>> > > >
>> > > > It's OK for standard Linux VM, but not OK for our VM where virtio is
>> > > > implemented by ourself.
>> > > > KVM version as follow:
>> > > > qemu-kvm-common-ev-2.12.0-18.el7_6.3.1.x86_64
>> > > > qemu-kvm-ev-2.12.0-18.el7_6.3.1.x86_64
>> > > > libvirt-daemon-kvm-3.9.0-14.2.el7.centos.ncir.8.x86_64
>> > > >
>> > > > Do you know what's the difference between virtio and vhost-user
>> during
>> > > > migration?
>> > > > The function virtio_load in Qemu is called for virtio and vhost-user
>> > > during
>> > > > migration.
>> > > > For virtio,  last_avail_idx  and used_idx are stored in Qemu, Qemu
>> is
>> > > > responsible for updating their values accordingly
>> > > > For vhost-user, last_avail_idx  and used_idx are stored in
>> vhost-user
>> > > app,
>> > > > eg. DPDK, not in Qemu?
>> > > > How does migration work for vhost-user?
>> > >
>> > > I don't know the details, but my understanding is that vhost-user
>> > > tells the vhost-user client about an area of 'log' memory, where the
>> > > vhost-user client must mark pages as dirty.
>> > >
>> > > In the qemu source, see docs/interop/vhost-user.txt and see
>> > > the VHOST_SET_LOG_BASE and VHOST_USER_SET_LOG_FD calls.
>> > >
>> > > If the client correctly marks the areas as dirty, then qemu
>> > > should resend those pages across.
>> > >
>> > >
>> > > Dave
>> > >
>> > > > Thanks in advance
>> > > > Yafeng
>> > > --
>> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>> > >
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
>

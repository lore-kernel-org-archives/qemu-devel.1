Received: from eggs.gnu.org ([2001:4830:134:3::10]:39829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1chMAH-0005aE-HK
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1chMAG-0002pj-6D
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:08:29 -0500
Received: from mail-lf0-x236.google.com ([2a00:1450:4010:c07::236]:35109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1chMAF-0002oa-Qw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:08:28 -0500
Received: by mail-lf0-x236.google.com with SMTP id z127so13281697lfa.2
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 12:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20170224195117.GR8830@work-vm>
In-Reply-To: <20170224195117.GR8830@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Feb 2017 20:08:14 +0000
Message-ID: <CAJ+F1CKCY8hki2huXObFGqzEaPcava60GnonmbVUZAwSNp=hjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] make check: crash in vhost-user chardev cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, mst@redhat.com

Hi

On Fri, Feb 24, 2017 at 11:54 PM Dr. David Alan Gilbert <dgilbert@redhat.co=
m>
wrote:

> Hi,
>   I'm seeing a hang+crash doing a make check that
> looks like it's coming from vhost-user's chardev cleanup,
> so I'm suspecting your e0b283e7c.
> The synptom is that the make check hangs in the qtest
> part, and a dmesg shows that a qemu crashed.
>

See that thread:
https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg06015.html


> I got a backtrace that shows:
>
> (gdb) where
> #0  0x0000560d3344f03e in qemu_chr_fe_read_all (be=3Dbe@entry=3D0x0,
> buf=3Dbuf@entry=3D0x7ffea7a2f520 "\v", len=3Dlen@entry=3D12) at
> /home/dgilbert/git/qemu/chardev/char.c:209
> #1  0x0000560d33199d64 in vhost_user_read (msg=3Dmsg@entry=3D0x7ffea7a2f5=
20,
> dev=3D<optimized out>)
>     at /home/dgilbert/git/qemu/hw/virtio/vhost-user.c:125
> #2  0x0000560d3319a11f in vhost_user_get_vring_base (dev=3D0x560d35a614a0=
,
> ring=3D0x7ffea7a2f670)
>     at /home/dgilbert/git/qemu/hw/virtio/vhost-user.c:417
> #3  0x0000560d33196abb in vhost_virtqueue_stop (dev=3Ddev@entry=3D0x560d3=
5a614a0,
> vdev=3Dvdev@entry=3D0x560d3729cc00, vq=3D0x560d35a61678, idx=3D1) at
> /home/dgilbert/git/qemu/hw/virtio/vhost.c:1070
> #4  0x0000560d33198cd4 in vhost_dev_stop (hdev=3Dhdev@entry=3D0x560d35a61=
4a0,
> vdev=3Dvdev@entry=3D0x560d3729cc00)
>     at /home/dgilbert/git/qemu/hw/virtio/vhost.c:1533
> #5  0x0000560d3317bfd8 in vhost_net_stop_one (net=3D0x560d35a614a0,
> dev=3D0x560d3729cc00)
>     at /home/dgilbert/git/qemu/hw/net/vhost_net.c:288
> #6  0x0000560d3317c4aa in vhost_net_stop (dev=3Ddev@entry=3D0x560d3729cc0=
0,
> ncs=3D<optimized out>, total_queues=3Dtotal_queues@entry=3D1) at
> /home/dgilbert/git/qemu/hw/net/vhost_net.c:367
> #7  0x0000560d33179201 in virtio_net_vhost_status (status=3D<optimized ou=
t>,
> n=3D0x560d3729cc00)
>     at /home/dgilbert/git/qemu/hw/net/virtio-net.c:176
> #8  0x0000560d33179201 in virtio_net_set_status (vdev=3D0x560d3729cc00,
> status=3D7 '\a')
>     at /home/dgilbert/git/qemu/hw/net/virtio-net.c:250
> #9  0x0000560d3339ce99 in qemu_del_net_client (nc=3D0x560d35a61250) at
> /home/dgilbert/git/qemu/net/net.c:390
> #10 0x0000560d3339e30d in net_cleanup () at
> /home/dgilbert/git/qemu/net/net.c:1454
> #11 0x0000560d330ee940 in main (argc=3D<optimized out>, argv=3D<optimized
> out>, envp=3D<optimized out>)
>     at /home/dgilbert/git/qemu/vl.c:4637
> (gdb)
>
> #0  qemu_chr_fe_read_all (be=3Dbe@entry=3D0x0, buf=3Dbuf@entry=3D0x7ffea7=
a2f520
> "\v", len=3Dlen@entry=3D12)
>     at /home/dgilbert/git/qemu/chardev/char.c:209
> 209         Chardev *s =3D be->chr;
>
> Dave
>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
> --
Marc-Andr=C3=A9 Lureau

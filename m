Received: from eggs.gnu.org ([2001:4830:134:3::10]:59911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gH7hm-0008QE-Jb
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gH7hk-0003KF-4k
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:35:42 -0400
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:35945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gH7hf-0003DY-7P
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:35:37 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <CAJ+F1CK0PKp1+RYf-x=uy7B6cDYWGjY+0eb76hStNKxmQoe5eg@mail.gmail.com>
References: <155951540214563@sas1-fc7737ec834f.qloud-c.yandex.net>
	<CAJ+F1CK0PKp1+RYf-x=uy7B6cDYWGjY+0eb76hStNKxmQoe5eg@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 29 Oct 2018 16:35:24 +0300
Message-Id: <191141540820124@myt4-a988562a11ab.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vhost-user devices work with chardev from
 different threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>



29.10.2018, 09:46, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@gmail.com>:
> Hi
>
> On Mon, Oct 22, 2018 at 5:24 PM Yury Kotov <yury-kotov@yandex-team.ru> =
wrote:
>
>> =C2=A0Hi,
>>
>> =C2=A0I examined vhost-user devices and found some chardev using stran=
geness.
>>
>> =C2=A0Is it ok, that vhost-user's set_status do sync chardev io ops fr=
om KVM thread?
>> =C2=A0It seems that chardev doesn't support working with different thr=
eads.
>>
>> =C2=A0For example, I think such race is possible (two simultaneous eve=
nts):
>> =C2=A01) Vhost-user server was killed (main thread will handle G_IO_HU=
P),
>> =C2=A02) Virtio-pci bus handles guest driver's set_status command.
>> =C2=A0=C2=A0=C2=A0=C2=A0Some io op from vhost-user backend will fail b=
ecause of 1).
>>
>> =C2=A0So, it is possible to enter tcp_chr_disconnect twice from the ma=
in thread and
>> =C2=A0from KVM thread.
>>
>> =C2=A0Backtrace examples:
>>
>> =C2=A0KVM thread (handle set_status of guest):
>> =C2=A0tcp_chr_disconnect
>> =C2=A0tcp_chr_write (cc->chr_write)
>> =C2=A0qemu_chr_write_buffer
>> =C2=A0qemu_chr_write
>> =C2=A0qemu_chr_fe_write_all
>> =C2=A0vhost_user_write
>> =C2=A0vhost_user_set_mem_table (hdev->vhost_ops->vhost_set_mem_table)
>> =C2=A0vhost_dev_start
>> =C2=A0vhost_user_blk_start (or another vhost-user device)
>> =C2=A0vhost_user_blk_set_status (vdc->set_status)
>>
>> =C2=A0Main thread (handle vhost server disconnect):
>> =C2=A0tcp_chr_disconnect
>> =C2=A0tcp_chr_hup
>> =C2=A0g_main_context_dispatch
>> =C2=A0glib_pollfds_poll
>> =C2=A0os_host_main_loop_wait
>> =C2=A0main_loop_wait
>> =C2=A0main_loop
>> =C2=A0main
>>
>> =C2=A0Is it really a problem or do I misunderstand?
>
> I think you are correct, it's a problem. Are you working on a
> solution? (either using the chardev lock, or perhaps relying on main
> thread HUP handler only, or a combination of both approaches)

So, chardev is thread safe by design? I thought it is vhost's problem...
Anyway I plan to fix that.

>
> thanks
>
> --
> Marc-Andr=C3=A9 Lureau

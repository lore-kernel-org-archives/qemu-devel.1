Received: from eggs.gnu.org ([2001:4830:134:3::10]:37627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gKREy-00073r-Pd
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gKREv-0001TR-Ns
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:03:40 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:42718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gKREv-0001O0-1w
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:03:37 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <CAJ+F1CKqmNp90AHZZ5cS_ctJGB9QPMYzOtovRjx7Nmnpook21w@mail.gmail.com>
References: <155951540214563@sas1-fc7737ec834f.qloud-c.yandex.net>
	<CAJ+F1CK0PKp1+RYf-x=uy7B6cDYWGjY+0eb76hStNKxmQoe5eg@mail.gmail.com>
	<191141540820124@myt4-a988562a11ab.qloud-c.yandex.net>
	<CAJ+F1CKqmNp90AHZZ5cS_ctJGB9QPMYzOtovRjx7Nmnpook21w@mail.gmail.com>
MIME-Version: 1.0
Date: Wed, 07 Nov 2018 20:03:28 +0300
Message-Id: <2154781541610208@myt4-a988562a11ab.qloud-c.yandex.net>
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

Hi,

I was wrong... Described problem with vhost-user is not possible.
It cannot enter tcp_chr_disconnect twice because of qemu global mutex (BQ=
L).
Thus chardev event handler (main loop) and vhost_user_blk_set_status (VCP=
U) are
working under BQL.

30.10.2018, 20:12, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@gmail.com>:
> Hi
>
> On Mon, Oct 29, 2018 at 5:35 PM Yury Kotov <yury-kotov@yandex-team.ru> =
wrote:
>> =C2=A029.10.2018, 09:46, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@gm=
ail.com>:
>> =C2=A0> Hi
>> =C2=A0>
>> =C2=A0> On Mon, Oct 22, 2018 at 5:24 PM Yury Kotov <yury-kotov@yandex-=
team.ru> wrote:
>> =C2=A0>
>> =C2=A0>> Hi,
>> =C2=A0>>
>> =C2=A0>> I examined vhost-user devices and found some chardev using st=
rangeness.
>> =C2=A0>>
>> =C2=A0>> Is it ok, that vhost-user's set_status do sync chardev io ops=
 from KVM thread?
>> =C2=A0>> It seems that chardev doesn't support working with different =
threads.
>> =C2=A0>>
>> =C2=A0>> For example, I think such race is possible (two simultaneous =
events):
>> =C2=A0>> 1) Vhost-user server was killed (main thread will handle G_IO=
_HUP),
>> =C2=A0>> 2) Virtio-pci bus handles guest driver's set_status command.
>> =C2=A0>> Some io op from vhost-user backend will fail because of 1).
>> =C2=A0>>
>> =C2=A0>> So, it is possible to enter tcp_chr_disconnect twice from the=
 main thread and
>> =C2=A0>> from KVM thread.
>> =C2=A0>>
>> =C2=A0>> Backtrace examples:
>> =C2=A0>>
>> =C2=A0>> KVM thread (handle set_status of guest):
>> =C2=A0>> tcp_chr_disconnect
>> =C2=A0>> tcp_chr_write (cc->chr_write)
>> =C2=A0>> qemu_chr_write_buffer
>> =C2=A0>> qemu_chr_write
>> =C2=A0>> qemu_chr_fe_write_all
>> =C2=A0>> vhost_user_write
>> =C2=A0>> vhost_user_set_mem_table (hdev->vhost_ops->vhost_set_mem_tabl=
e)
>> =C2=A0>> vhost_dev_start
>> =C2=A0>> vhost_user_blk_start (or another vhost-user device)
>> =C2=A0>> vhost_user_blk_set_status (vdc->set_status)
>> =C2=A0>>
>> =C2=A0>> Main thread (handle vhost server disconnect):
>> =C2=A0>> tcp_chr_disconnect
>> =C2=A0>> tcp_chr_hup
>> =C2=A0>> g_main_context_dispatch
>> =C2=A0>> glib_pollfds_poll
>> =C2=A0>> os_host_main_loop_wait
>> =C2=A0>> main_loop_wait
>> =C2=A0>> main_loop
>> =C2=A0>> main
>> =C2=A0>>
>> =C2=A0>> Is it really a problem or do I misunderstand?
>> =C2=A0>
>> =C2=A0> I think you are correct, it's a problem. Are you working on a
>> =C2=A0> solution? (either using the chardev lock, or perhaps relying o=
n main
>> =C2=A0> thread HUP handler only, or a combination of both approaches)
>>
>> =C2=A0So, chardev is thread safe by design? I thought it is vhost's pr=
oblem...
>> =C2=A0Anyway I plan to fix that.
>
> chardev is not thread-safe in general, only the write path (assuming
> everything else, like lifecycle, is done safely by the user).
>
>> =C2=A0>
>> =C2=A0> thanks
>> =C2=A0>
>> =C2=A0> --
>> =C2=A0> Marc-Andr=C3=A9 Lureau
>
> --
> Marc-Andr=C3=A9 Lureau

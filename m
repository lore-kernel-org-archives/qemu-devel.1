Received: from eggs.gnu.org ([2001:4830:134:3::10]:38462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gHXZL-0006C2-QM
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gHXZJ-0008GP-NL
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:12:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gHXZG-0008Bu-43
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:12:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2-v6so6575693wmh.3
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 10:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <155951540214563@sas1-fc7737ec834f.qloud-c.yandex.net>
	<CAJ+F1CK0PKp1+RYf-x=uy7B6cDYWGjY+0eb76hStNKxmQoe5eg@mail.gmail.com>
	<191141540820124@myt4-a988562a11ab.qloud-c.yandex.net>
In-Reply-To: <191141540820124@myt4-a988562a11ab.qloud-c.yandex.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Oct 2018 21:12:18 +0400
Message-ID: <CAJ+F1CKqmNp90AHZZ5cS_ctJGB9QPMYzOtovRjx7Nmnpook21w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: yury-kotov@yandex-team.ru
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, wrfsh@yandex-team.ru

Hi

On Mon, Oct 29, 2018 at 5:35 PM Yury Kotov <yury-kotov@yandex-team.ru> wrot=
e:
>
>
>
> 29.10.2018, 09:46, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@gmail.com>:
> > Hi
> >
> > On Mon, Oct 22, 2018 at 5:24 PM Yury Kotov <yury-kotov@yandex-team.ru> =
wrote:
> >
> >>  Hi,
> >>
> >>  I examined vhost-user devices and found some chardev using strangenes=
s.
> >>
> >>  Is it ok, that vhost-user's set_status do sync chardev io ops from KV=
M thread?
> >>  It seems that chardev doesn't support working with different threads.
> >>
> >>  For example, I think such race is possible (two simultaneous events):
> >>  1) Vhost-user server was killed (main thread will handle G_IO_HUP),
> >>  2) Virtio-pci bus handles guest driver's set_status command.
> >>     Some io op from vhost-user backend will fail because of 1).
> >>
> >>  So, it is possible to enter tcp_chr_disconnect twice from the main th=
read and
> >>  from KVM thread.
> >>
> >>  Backtrace examples:
> >>
> >>  KVM thread (handle set_status of guest):
> >>  tcp_chr_disconnect
> >>  tcp_chr_write (cc->chr_write)
> >>  qemu_chr_write_buffer
> >>  qemu_chr_write
> >>  qemu_chr_fe_write_all
> >>  vhost_user_write
> >>  vhost_user_set_mem_table (hdev->vhost_ops->vhost_set_mem_table)
> >>  vhost_dev_start
> >>  vhost_user_blk_start (or another vhost-user device)
> >>  vhost_user_blk_set_status (vdc->set_status)
> >>
> >>  Main thread (handle vhost server disconnect):
> >>  tcp_chr_disconnect
> >>  tcp_chr_hup
> >>  g_main_context_dispatch
> >>  glib_pollfds_poll
> >>  os_host_main_loop_wait
> >>  main_loop_wait
> >>  main_loop
> >>  main
> >>
> >>  Is it really a problem or do I misunderstand?
> >
> > I think you are correct, it's a problem. Are you working on a
> > solution? (either using the chardev lock, or perhaps relying on main
> > thread HUP handler only, or a combination of both approaches)
>
> So, chardev is thread safe by design? I thought it is vhost's problem...
> Anyway I plan to fix that.

chardev is not thread-safe in general, only the write path (assuming
everything else, like lifecycle, is done safely by the user).

>
> >
> > thanks
> >
> > --
> > Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau

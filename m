Received: from eggs.gnu.org ([208.118.235.92]:34747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gbEjc-000166-V4
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 20:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gbEjc-0000B1-2T
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 20:08:44 -0500
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:53819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gbEjb-0000An-Tg
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 20:08:44 -0500
Received: by mail-it1-x142.google.com with SMTP id g85so14254050ita.3
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 17:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20181215120353.82786-1-liq3ea@163.com>
In-Reply-To: <20181215120353.82786-1-liq3ea@163.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 24 Dec 2018 09:08:08 +0800
Message-ID: <CAKXe6S+TfxVKq_YToc6mpJe3ozO4j5oXAd261G7O5ruSZGwPHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vhost-user-test fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: Thomas Huth <thuth@redhat.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Peter Maydell <peter.maydell@linaro.org>, marcandre lureau <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Ping..

Li Qiang <liq3ea@163.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=8815=E6=97=A5=E5=
=91=A8=E5=85=AD =E4=B8=8B=E5=8D=888:06=E5=86=99=E9=81=93=EF=BC=9A

> Currently, the vhost-user-test is not correct.
> When in qtest mode, the accel is qtest, not kvm.
> So when the client side of vhost-user-test send
> 'VHOST_USER_SET_VRING_CALL' msg, the 'fd' will
> no be added in 'fds' in 'vhost_set_vring_file'.
> In 'chr_read' of the server side in the
> vhost-user-test, it calls 'qemu_chr_fe_get_msgfds'
> to get the fd in 'VHOST_USER_SET_VRING_CALL'. Though
> there is no fd returned, but as the 'fd' is not initialized
> so 'fd' maybe valid, and 'qemu_set_nonblock' will be success.
> Even worse, 'qemu_set_nonblock' doesn't check the return value
> of fcntl.
>
> So this cause the interesting bug here: there are three issues,
> but they combined and will bypass the qtest.
>
> This patchset tries to address these issue.
>
> v2: Change the second patch per Paolo's review
>
> Li Qiang (3):
>   tests: vhost-user-test: initialize 'fd' in chr_read
>   vhost-user: fix ioeventfd_enabled
>   util: check the return value of fcntl in qemu_set_{block,nonblock}
>
>  hw/virtio/vhost-user.c  | 2 +-
>  tests/vhost-user-test.c | 2 +-
>  util/oslib-posix.c      | 8 ++++++--
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> --
> 2.17.1
>
>
>

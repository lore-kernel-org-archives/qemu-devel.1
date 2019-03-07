Received: from eggs.gnu.org ([209.51.188.92]:60583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1rBo-0001wC-2j
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1rBn-0006sV-2o
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:27:52 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:41779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1rBm-0006s6-Qi
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:27:51 -0500
Received: by mail-ot1-x32b.google.com with SMTP id t7so13735491otk.8
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 03:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 11:27:38 +0000
Message-ID: <CAFEAcA92uBmran70VSGvgd2dj034O5mxELSBfNSjzDg1Q=Ecyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On Wed, 6 Mar 2019 at 23:59, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to dd9eff6c839db3996c157f0a6a4e18f95683e58c:
>
>   slirp: remove QEMU Makefile.objs (2019-03-07 00:12:34 +0100)
>
> ----------------------------------------------------------------

Hi; this fails to build on FreeBSD, I'm afraid:

In file included from /var/tmp/qemu-test.Sn5gQz/slirp/src/stream.c:24:
In file included from /var/tmp/qemu-test.Sn5gQz/slirp/src/stream.h:4:
/var/tmp/qemu-test.Sn5gQz/slirp/src/libslirp.h:29:19: warning: type
specifier missing, defaults to 'int' [-Wimplicit-int]
typedef ssize_t (*SlirpReadCb)(void *buf, size_t len, void *opaque);
                  ^
/var/tmp/qemu-test.Sn5gQz/slirp/src/libslirp.h:29:9: warning: type
specifier missing, defaults to 'int' [-Wimplicit-int]
typedef ssize_t (*SlirpReadCb)(void *buf, size_t len, void *opaque);
~~~~~~~ ^
/var/tmp/qemu-test.Sn5gQz/slirp/src/libslirp.h:29:17: error: function
cannot return function type 'int (void *, size_t, void *)' (aka 'int
(void *, unsigned
long, void *)')
typedef ssize_t (*SlirpReadCb)(void *buf, size_t len, void *opaque);
                ^
/var/tmp/qemu-test.Sn5gQz/slirp/src/libslirp.h:30:32: error: function
cannot return function type 'ssize_t' (aka 'int (int *)')
typedef ssize_t (*SlirpWriteCb)(const void *buf, size_t len, void *opaque);
                               ^
/var/tmp/qemu-test.Sn5gQz/slirp/src/libslirp.h:108:22: error: unknown
type name 'SlirpReadCb'
                     SlirpReadCb read_cb, void *opaque);
                     ^
In file included from /var/tmp/qemu-test.Sn5gQz/slirp/src/stream.c:24:
/var/tmp/qemu-test.Sn5gQz/slirp/src/stream.h:7:5: error: unknown type
name 'SlirpReadCb'
    SlirpReadCb read_cb;
    ^
2 warnings and 4 errors generated.

I think this is a missing #include of <sys/types.h> which is where
ssize_t comes from -- on the other OSes it likely gets dragged in
by default.

thanks
-- PMM

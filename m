Received: from eggs.gnu.org ([2001:4830:134:3::10]:39535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC61t-000290-Bq
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC61r-0002lP-WA
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:15:25 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:33818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC61r-0002lC-Jf
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:15:23 -0400
Received: by mail-ot0-x236.google.com with SMTP id i5-v6so2640642oth.1
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 09:15:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1519922735-29054-11-git-send-email-mst@redhat.com>
References: <1519922735-29054-1-git-send-email-mst@redhat.com>
	<1519922735-29054-11-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 17:15:02 +0100
Message-ID: <CAFEAcA8=4nyvq4949e171pScH86HbFdKxArHxC-gBcvm6Kytww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 10/13] cryptodev: add vhost-user as a new
 cryptodev backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gonglei <arei.gonglei@huawei.com>, Longpeng <longpeng2@huawei.com>, Jay Zhou <jianjay.zhou@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

On 1 March 2018 at 16:46, Michael S. Tsirkin <mst@redhat.com> wrote:
> From: Gonglei <arei.gonglei@huawei.com>
>
> Usage:
>  -chardev socket,id=charcrypto0,path=/path/to/your/socket
>  -object cryptodev-vhost-user,id=cryptodev0,chardev=charcrypto0
>  -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0
>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi; Coverity (CID 1390600) points out that there's dead code
in this function:

> +static void cryptodev_vhost_user_event(void *opaque, int event)
> +{
> +    CryptoDevBackendVhostUser *s = opaque;
> +    CryptoDevBackend *b = CRYPTODEV_BACKEND(s);
> +    Error *err = NULL;

We set err to NULL here...

> +    int queues = b->conf.peers.queues;
> +
> +    assert(queues < MAX_CRYPTO_QUEUE_NUM);
> +
> +    switch (event) {
> +    case CHR_EVENT_OPENED:
> +        if (cryptodev_vhost_user_start(queues, s) < 0) {
> +            exit(1);
> +        }
> +        b->ready = true;
> +        break;
> +    case CHR_EVENT_CLOSED:
> +        b->ready = false;
> +        cryptodev_vhost_user_stop(queues, s);
> +        break;
> +    }

...and nothing here does anything with err...

> +
> +    if (err) {
> +        error_report_err(err);
> +    }

...so this if() is all dead code and we could remove err entirely.

> +}

thanks
-- PMM

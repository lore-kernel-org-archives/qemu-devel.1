Received: from eggs.gnu.org ([2001:4830:134:3::10]:53682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVaqt-0002ad-5y
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVaqp-000810-Fd
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:56:07 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:32955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1dVaqp-00080L-9X
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:56:03 -0400
Received: by mail-oi0-f53.google.com with SMTP id p188so41641292oia.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 02:56:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711122958.GM7116@redhat.com>
References: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
	<1499158630-75260-14-git-send-email-longpeng2@huawei.com>
	<20170711122958.GM7116@redhat.com>
From: long mike <longpeng.mike@gmail.com>
Date: Thu, 13 Jul 2017 17:55:00 +0800
Message-ID: <CACnE9px5A5_q4acVHYf=y0s7Qaie=18fEh3Q4ed5kyWMXAveQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 13/18] crypto: cipher: add afalg-backend
 cipher support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, arei.gonglei@huawei.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org

2017-07-11 20:29 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:
> On Tue, Jul 04, 2017 at 04:57:05PM +0800, Longpeng(Mike) wrote:
>> Adds afalg-backend cipher support: introduces some private APIs
>> firstly, and then intergrates them into qcrypto_cipher_afalg_driver.
>>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
>>  crypto/Makefile.objs  |   1 +
>>  crypto/afalgpriv.h    |   9 ++
>>  crypto/cipher-afalg.c | 223 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  crypto/cipher.c       |  23 +++++-
>>  crypto/cipherpriv.h   |  16 ++++
>>  5 files changed, 268 insertions(+), 4 deletions(-)
>>  create mode 100644 crypto/cipher-afalg.c
>>
[...]

>> +
>> +static int
>> +qcrypto_afalg_cipher_op(QCryptoAFAlg *afalg,
>> +                        const void *in, void *out,
>> +                        size_t len, bool do_encrypt,
>> +                        Error **errp)
>> +{
>> +    uint32_t *type = NULL;
>> +    struct iovec iov;
>> +    size_t ret, done = 0;
>> +    uint32_t origin_controllen;
>> +
>> +    origin_controllen = afalg->msg->msg_controllen;
>> +    /* movev ->cmsg to first header, for crypto-info */
>> +    afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
>> +
>> +    /* build encrypt msg */
>> +    afalg->cmsg->cmsg_level = SOL_ALG;
>> +    afalg->msg->msg_iov = &iov;
>> +    afalg->msg->msg_iovlen = 1;
>> +    type = (uint32_t *)CMSG_DATA(afalg->cmsg);
>> +    if (do_encrypt) {
>> +        *type = ALG_OP_ENCRYPT;
>> +    } else {
>> +        *type = ALG_OP_DECRYPT;
>> +    }
>> +
>> +    do {
>> +        iov.iov_base = (void *)in + done;
>> +        iov.iov_len = len - done;
>> +
>> +        /* send info to AF_ALG core */
>> +        ret = sendmsg(afalg->opfd, afalg->msg, 0);
>> +        if (ret == -1) {
>> +            error_setg_errno(errp, errno, "Send data to AF_ALG core failed");
>> +            return -1;
>> +        }
>> +
>> +        /* encrypto && get result */
>> +        if (ret != read(afalg->opfd, out, ret)) {
>> +            error_setg_errno(errp, errno, "Get result from AF_ALG core failed");
>> +            return -1;
>> +        }
>> +
>> +        /* do not update IV for following chunks */
>> +        afalg->msg->msg_controllen = 0;
>> +        done += ret;
>> +    } while (done < len);
>
> In the next patch you use iov_send_recv() which provides the
> while()  loop automatically upon short write. Lets just use
> that method here too.
>

Hi Daniel,

I'm afraid we couldn't use  iov_send_recv() here.

For the AF_ALG API of cipher, it needs some additional control info
in 'struct msghdr', while iov_send_recv-->do_send_recv would set a
local msghdr object and there's no opportunity for caller to pass any
control info.

For hash/hmac, it doesn't need any control info when send/recv, so
we can use iov_send_recv there.

Currently the 'struct QCryptoAFAlg' is:
struct QCryptoAFAlg {
    int tfmfd;
    int opfd;
    char *name;  [ will be removed in V5 ]
    struct msghdr *msg;
    struct cmsghdr *cmsg;
};

So I think we don't need alloc msg/cmsg when new hash/hmac
context, maybe I should remove g_new0(struct msghdr, 1) in
qcrypto_afalg_hash_ctx_new().

Do you have any suggestion?

Regards,
Longpeng

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



-- 
Reards,
Longpeng

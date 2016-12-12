Received: from eggs.gnu.org ([2001:4830:134:3::10]:33509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNtJ-0002jS-Go
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNtD-0001a7-8f
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:31:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGNtC-0001Yl-Sk
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:31:23 -0500
Date: Mon, 12 Dec 2016 10:31:17 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161212103117.GG15611@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
	<1481530092-20240-8-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481530092-20240-8-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2 7/7] crypto: add HMAC algorithms
 testcases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: eblake@redhat.com, armbru@redhat.com, stefanha@redhat.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Mon, Dec 12, 2016 at 04:08:12PM +0800, Longpeng(Mike) wrote:
> This patch add HMAC algorithms testcases
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  tests/Makefile.include   |   2 +
>  tests/test-crypto-hmac.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 168 insertions(+)
>  create mode 100644 tests/test-crypto-hmac.c
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index e98d3b6..4841d58 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -91,6 +91,7 @@ gcov-files-test-qemu-opts-y = qom/test-qemu-opts.c
>  check-unit-y += tests/test-write-threshold$(EXESUF)
>  gcov-files-test-write-threshold-y = block/write-threshold.c
>  check-unit-y += tests/test-crypto-hash$(EXESUF)
> +check-unit-y += tests/test-crypto-hmac$(EXESUF)
>  check-unit-y += tests/test-crypto-cipher$(EXESUF)
>  check-unit-y += tests/test-crypto-secret$(EXESUF)
>  check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlscredsx509$(EXESUF)
> @@ -571,6 +572,7 @@ tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
>  tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
>  tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
>  tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-obj-y)
> +tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o $(test-crypto-obj-y)
>  tests/test-crypto-cipher$(EXESUF): tests/test-crypto-cipher.o $(test-crypto-obj-y)
>  tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypto-obj-y)
>  tests/test-crypto-xts$(EXESUF): tests/test-crypto-xts.o $(test-crypto-obj-y)
> diff --git a/tests/test-crypto-hmac.c b/tests/test-crypto-hmac.c
> new file mode 100644
> index 0000000..678df52
> --- /dev/null
> +++ b/tests/test-crypto-hmac.c
> @@ -0,0 +1,166 @@
> +/*
> + * QEMU Crypto hmac algorithms tests
> + *
> + * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * Authors:
> + *    Longpeng(Mike) <longpeng2@huawei.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "crypto/init.h"
> +#include "crypto/hmac.h"
> +
> +typedef struct QCryptoHmacTestData QCryptoHmacTestData;
> +struct QCryptoHmacTestData {
> +    const char *path;
> +    QCryptoHmacAlgorithm alg;
> +    const char *key;
> +    const char *message;
> +    const char *digest;
> +};
> +
> +static QCryptoHmacTestData test_data[] = {
> +    {
> +        .path = "/crypto/hmac/hmac-md5",
> +        .alg = QCRYPTO_HMAC_ALG_MD5,
> +        .key =
> +            "0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b",
> +        .message =
> +            "4869205468657265",
> +        .digest =
> +            "9294727a3638bb1c13f48ef8158bfc9d",
> +    },
> +    {
> +        .path = "/crypto/hmac/hmac-sha1",
> +        .alg = QCRYPTO_HMAC_ALG_SHA1,
> +        .key =
> +            "0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b"
> +            "0b0b0b0b",
> +        .message =
> +            "4869205468657265",
> +        .digest =
> +            "b617318655057264e28bc0b6fb378c8e"
> +            "f146be00",
> +    },
> +};

This is quite weak test coverage  - it needs to cover all 7 hash algorithms


> +
> +static inline int unhex(char c)
> +{
> +    if (c >= 'a' && c <= 'f') {
> +        return 10 + (c - 'a');
> +    }
> +    if (c >= 'A' && c <= 'F') {
> +        return 10 + (c - 'A');
> +    }
> +    return c - '0';
> +}
> +
> +static inline char hex(int i)
> +{
> +    if (i < 10) {
> +        return '0' + i;
> +    }
> +    return 'a' + (i - 10);
> +}
> +
> +static size_t unhex_string(const char *hexstr,
> +                           uint8_t **data)
> +{
> +    size_t len;
> +    size_t i;
> +
> +    if (!hexstr) {
> +        *data = NULL;
> +        return 0;
> +    }
> +
> +    len = strlen(hexstr);
> +    *data = g_new0(uint8_t, len / 2);
> +
> +    for (i = 0; i < len; i += 2) {
> +        (*data)[i / 2] = (unhex(hexstr[i]) << 4) | unhex(hexstr[i + 1]);
> +    }
> +    return len / 2;
> +}
> +
> +static char *hex_string(const uint8_t *bytes,
> +                        size_t len)
> +{
> +    char *hexstr = g_new0(char, len * 2 + 1);
> +    size_t i;
> +
> +    for (i = 0; i < len; i++) {
> +        hexstr[i * 2] = hex((bytes[i] >> 4) & 0xf);
> +        hexstr[i * 2 + 1] = hex(bytes[i] & 0xf);
> +    }
> +    hexstr[len * 2] = '\0';
> +
> +    return hexstr;
> +}
> +
> +static void test_hmac(const void *opaque)
> +{
> +    const QCryptoHmacTestData *data = opaque;
> +    size_t nkey, digest_len, msg_len;
> +    uint8_t *key = NULL;
> +    uint8_t *message = NULL;
> +    uint8_t *digest = NULL;
> +    uint8_t *output = NULL;
> +    char *outputhex = NULL;
> +    QCryptoHmac *hmac = NULL;
> +    Error *err = NULL;
> +    int ret;
> +
> +    if (!qcrypto_hmac_supports(data->alg)) {
> +        return;
> +    }
> +
> +    nkey = unhex_string(data->key, &key);
> +    digest_len = unhex_string(data->digest, &digest);
> +    msg_len = unhex_string(data->message, &message);
> +
> +    output = g_new0(uint8_t, digest_len);
> +
> +    hmac = qcrypto_hmac_new(data->alg, key, nkey, &err);
> +    g_assert(err == NULL);
> +    g_assert(hmac != NULL);
> +
> +    ret = qcrypto_hmac_bytes(hmac, (const char *)message,
> +                        msg_len, &output, &digest_len, &err);
> +
> +    g_assert(ret == 0);
> +
> +    outputhex = hex_string(output, digest_len);
> +
> +    g_assert_cmpstr(outputhex, ==, data->digest);
> +
> +    qcrypto_hmac_free(hmac);
> +
> +    g_free(outputhex);
> +    g_free(output);
> +    g_free(message);
> +    g_free(digest);
> +    g_free(key);
> +}


We need to cover qcrypto_hmac_bytesv and qcrypto_hmac_digest
methods too.

IOW, can you simply copy the test-crypto-hash.c test suite entirely
but remove the base64 part of it.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

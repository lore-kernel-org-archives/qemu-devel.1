Received: from eggs.gnu.org ([2001:4830:134:3::10]:47181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1Mvs-0000hl-6g
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 21:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1Mvp-0000wQ-4Z
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 21:00:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3446
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1Mvo-0000oF-9q
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 21:00:17 -0400
Message-ID: <58F958A9.4050106@huawei.com>
Date: Fri, 21 Apr 2017 08:56:09 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 00/18] crypto: add
 afalg-backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, arei.gonglei@huawei.com, weidong.huang@huawei.com, armbru@redhat.com, eblake@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

Hi Daniel,

2.9 was released, so...ping

Thanks.

On 2017/4/17 9:33, Longpeng(Mike) wrote:

> The AF_ALG socket family is the userspace interface for linux
> crypto API, users can use it to access hardware accelerators.
> 
> This patchset adds a afalg-backend for qemu crypto subsystem. Currently
> when performs encrypt/decrypt, we'll try afalg-backend first and will
> back to libiary-backend if it failed.
> 
> In the next step, It would support a command parameter to specifies
> which backends prefer to and some other improvements.
> 
> I measured the performance about the afalg-backend impls, I tested
> how many data could be encrypted in 5 seconds.
> 
> NOTE: If we use specific hardware crypto cards, I think afalg-backend
>       would even faster.
> 
> test-environment: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
> 
> *sha256*
> chunk_size(bytes)   MB/sec(afalg:sha256-ssse3)  MB/sec(nettle)
> 512                 93.03                       185.87
> 1024                146.32                      201.78
> 2048                213.32                      210.93
> 4096                275.48                      215.26
> 8192                321.77                      217.49
> 16384               349.60                      219.26
> 32768               363.59                      219.73
> 65536               375.79                      219.99
> 
> *hmac(sha256)*
> chunk_size(bytes)   MB/sec(afalg:sha256-ssse3)  MB/sec(nettle)
> 512                 71.26                       165.55
> 1024                117.43                      189.15
> 2048                180.96                      203.24
> 4096                247.60                      211.38
> 8192                301.99                      215.65
> 16384               340.79                      218.22
> 32768               365.51                      219.49
> 65536               377.92                      220.24
> 
> *cbc(aes128)*
> chunk_size(bytes)   MB/sec(afalg:cbc-aes-aesni)  MB/sec(nettle)
> 512                 371.76                       188.41
> 1024                559.86                       189.64
> 2048                768.66                       192.11
> 4096                939.15                       192.40
> 8192                1029.48                      192.49
> 16384               1072.79                      190.52
> 32768               1109.38                      190.41
> 65536               1102.38                      190.40
> 
> ---
> Changes since v1:
> 	- use "make check-speed" to testing the performance. [Daniel]
> 	- put private definations into crypto/***priv.h. [Daniel]
> 	- remove afalg socket from qapi-schema, put them into crypto/. [Daniel]
> 	- some Error report change. [Daniel]
> 	- s/QCryptoAfalg/QCryptoAFAlg. [Daniel]
> 	- use snprintf with bounds checking instead of sprintf. [Daniel]
> 	- use "qcrypto_afalg_" prefix and "qcrypto_nettle(gcrypt,glib,builtin)_" prefix. [Daniel]
> 	- add testing results in cover-letter. [Gonglei]
> 
> ---
> Longpeng(Mike) (18):
>   crypto: cipher: introduce context free function
>   crypto: cipher: introduce qcrypto_cipher_ctx_new for gcrypt-backend
>   crypto: cipher: introduce qcrypto_cipher_ctx_new for nettle-backend
>   crypto: cipher: introduce qcrypto_cipher_ctx_new for builtin-backend
>   crypto: cipher: add cipher driver framework
>   crypto: hash: add hash driver framework
>   crypto: hmac: move crypto/hmac.h into include/crypto/
>   crypto: hmac: introduce qcrypto_hmac_ctx_new for gcrypt-backend
>   crypto: hmac: introduce qcrypto_hmac_ctx_new for nettle-backend
>   crypto: hmac: introduce qcrypto_hmac_ctx_new for glib-backend
>   crypto: hmac: add hmac driver framework
>   crypto: introduce some common functions for af_alg backend
>   crypto: cipher: add afalg-backend cipher support
>   crypto: hash: add afalg-backend hash support
>   crypto: hmac: add af_alg hmac support
>   tests: crypto: add cipher speed benchmark support
>   tests: crypto: add hash speed benchmark support
>   tests: crypto: add hmac speed benchmark support
> 
>  configure                       |  21 ++++
>  crypto/Makefile.objs            |   3 +
>  crypto/afalg.c                  | 115 ++++++++++++++++++++
>  crypto/afalgpriv.h              |  64 +++++++++++
>  crypto/cipher-afalg.c           | 225 +++++++++++++++++++++++++++++++++++++++
>  crypto/cipher-builtin.c         | 125 +++++++++++-----------
>  crypto/cipher-gcrypt.c          | 105 +++++++++---------
>  crypto/cipher-nettle.c          |  84 +++++++++------
>  crypto/cipher.c                 |  91 ++++++++++++++++
>  crypto/cipherpriv.h             |  51 +++++++++
>  crypto/hash-afalg.c             | 229 ++++++++++++++++++++++++++++++++++++++++
>  crypto/hash-gcrypt.c            |  19 ++--
>  crypto/hash-glib.c              |  19 ++--
>  crypto/hash-nettle.c            |  19 ++--
>  crypto/hash.c                   |  24 +++++
>  crypto/hashpriv.h               |  35 ++++++
>  crypto/hmac-gcrypt.c            |  42 ++++----
>  crypto/hmac-glib.c              |  63 ++++++-----
>  crypto/hmac-nettle.c            |  42 ++++----
>  crypto/hmac.c                   |  69 ++++++++++++
>  crypto/hmac.h                   | 166 -----------------------------
>  crypto/hmacpriv.h               |  45 ++++++++
>  include/crypto/cipher.h         |   9 ++
>  include/crypto/hmac.h           | 175 ++++++++++++++++++++++++++++++
>  tests/Makefile.include          |  13 ++-
>  tests/benchmark-crypto-cipher.c |  90 ++++++++++++++++
>  tests/benchmark-crypto-hash.c   |  67 ++++++++++++
>  tests/benchmark-crypto-hmac.c   |  96 +++++++++++++++++
>  tests/test-crypto-cipher.c      |  10 +-
>  29 files changed, 1704 insertions(+), 412 deletions(-)
>  create mode 100644 crypto/afalg.c
>  create mode 100644 crypto/afalgpriv.h
>  create mode 100644 crypto/cipher-afalg.c
>  create mode 100644 crypto/cipherpriv.h
>  create mode 100644 crypto/hash-afalg.c
>  create mode 100644 crypto/hashpriv.h
>  delete mode 100644 crypto/hmac.h
>  create mode 100644 crypto/hmacpriv.h
>  create mode 100644 include/crypto/hmac.h
>  create mode 100644 tests/benchmark-crypto-cipher.c
>  create mode 100644 tests/benchmark-crypto-hash.c
>  create mode 100644 tests/benchmark-crypto-hmac.c
> 


-- 
Regards,
Longpeng(Mike)

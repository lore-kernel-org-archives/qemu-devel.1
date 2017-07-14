Received: from eggs.gnu.org ([2001:4830:134:3::10]:35834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVywD-0001Us-4Z
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyw8-0007zL-6l
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:39:13 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:35597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1dVyw7-0007yW-UI
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:39:08 -0400
Received: by mail-pg0-x229.google.com with SMTP id j186so44539874pge.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 04:39:07 -0700 (PDT)
From: longpeng.mike@gmail.com
Date: Fri, 14 Jul 2017 07:38:41 -0400
Message-Id: <1500032321-13951-20-git-send-email-longpeng.mike@gmail.com>
In-Reply-To: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
References: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 00/18]  crypto: add afalg-backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

The AF_ALG socket family is the userspace interface for linux
crypto API, users can use it to access hardware accelerators.

This patchset adds a afalg-backend for qemu crypto subsystem. Currently
when performs encrypt/decrypt, we'll try afalg-backend first and will
back to libiary-backend if it failed.

In the next step, It would support a command parameter to specifies
which backends prefer to and some other improvements.

I measured the performance about the afalg-backend impls, I tested
how many data could be encrypted in 5 seconds.

NOTE: If we use specific hardware crypto cards, I think afalg-backend
      would even faster.

test-environment: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

*sha256*
chunk_size(bytes)   MB/sec(afalg:sha256-ssse3)  MB/sec(nettle)
512                 93.03                       185.87
1024                146.32                      201.78
2048                213.32                      210.93
4096                275.48                      215.26
8192                321.77                      217.49
16384               349.60                      219.26
32768               363.59                      219.73
65536               375.79                      219.99

*hmac(sha256)*
chunk_size(bytes)   MB/sec(afalg:sha256-ssse3)  MB/sec(nettle)
512                 71.26                       165.55
1024                117.43                      189.15
2048                180.96                      203.24
4096                247.60                      211.38
8192                301.99                      215.65
16384               340.79                      218.22
32768               365.51                      219.49
65536               377.92                      220.24

*cbc(aes128)*
chunk_size(bytes)   MB/sec(afalg:cbc-aes-aesni)  MB/sec(nettle)
512                 371.76                       188.41
1024                559.86                       189.64
2048                768.66                       192.11
4096                939.15                       192.40
8192                1029.48                      192.49
16384               1072.79                      190.52
32768               1109.38                      190.41
65536               1102.38                      190.40

---
Changes since v4:
    - remove 'name' field in 'struct CryptoAFAlg'. [Daniel]
    - add error handling for read() returning less than requested. [Daniel]
    - use iov_send_recv to recv msg in hash-afalg.c. [Daniel]
    - refactor hmac benchmark as suggestion. [Daniel]

Changes since v3:
    - add "Reviewed-by: Daniel P. Berrange <address@hidden>" in
      commit messages of PATCH 1/2/3/4/5/7/8/9/10/11.
    - PATCH 12: use strlen() instead of qemu_strnlen() in 
qcrypto_afalg_build_saddr(). [Daniel]
    - PATCH 12: rather than indenting the entire method, just return immediately
                if afalg=NULL. [Daniel]
    - PATCH 13: use g_strdup_printf() instead of g_new0+snprintf() and remove
                redundant bounds check in qcrypto_afalg_cipher_format_name(). 
[Daniel]
    - PATCH 13: s/except_niv/expect_niv  s/origin_contorllen/origin_controllen. 
[Daniel]
    - PATCH 13: use '%zu' to print 'size_t' in qcrypto_afalg_cipher_setiv(). 
[Daniel]
    - PATCH 13: remove qcrypto_cipher_using_afalg_drv(). [Daniel]
    - PATCH 13: refactor the qcrypto_cipher_new() as Daniel's suggestion. 
[Daniel]
    - PATCH 13: correct the ->cmsg initialization int 
qcrypto_afalg_cipher_ctx_new() to
                avoid different behaviour in test_cipher_null_iv(). [Daniel]
    - PATCH 14: use g_strdup_printf() instead of g_new0+snprintf() and remove
                edundant bounds check in qcrypto_afalg_hash_format_name(). 
[Daniel]
    - PATCH 14: s/except_len/expect_len. [Daniel]
    - PATCH 14: free 'errp' if afalg_driver.hash_bytesv() failed. [Daniel]
    - PATCH 14: maybe some afalg errors should be treated as fatal, but we
                have no idea yet, so add a "TODO" comment.
    - PATCH 15: refactor the qcrypto_hmac_new() as Daniel's suggestion. [Daniel]

Changes since v2:
    - init sockaddr_alg object when it's defined. [Gonglei]
    - fix some superfluous initialization. [Gonglei]
    - s/opeartion/operation/g in crypto/afalgpriv.h. [Gonglei]
    - check 'niv' in qcrypto_afalg_cipher_setiv. [Gonglei]

Changes since v1:
    - use "make check-speed" to testing the performance. [Daniel]
    - put private definations into crypto/***priv.h. [Daniel]
    - remove afalg socket from qapi-schema, put them into crypto/. [Daniel]
    - some Error report change. [Daniel]
    - s/QCryptoAfalg/QCryptoAFAlg. [Daniel]
    - use snprintf with bounds checking instead of sprintf. [Daniel]
    - use "qcrypto_afalg_" prefix and "qcrypto_nettle(gcrypt,glib,builtin)_" 
prefix. [Daniel]
    - add testing results in cover-letter. [Gonglei]

---
Longpeng(Mike) (18):
  crypto: cipher: introduce context free function
  crypto: cipher: introduce qcrypto_cipher_ctx_new for gcrypt-backend
  crypto: cipher: introduce qcrypto_cipher_ctx_new for nettle-backend
  crypto: cipher: introduce qcrypto_cipher_ctx_new for builtin-backend
  crypto: cipher: add cipher driver framework
  crypto: hash: add hash driver framework
  crypto: hmac: move crypto/hmac.h into include/crypto/
  crypto: hmac: introduce qcrypto_hmac_ctx_new for gcrypt-backend
  crypto: hmac: introduce qcrypto_hmac_ctx_new for nettle-backend
  crypto: hmac: introduce qcrypto_hmac_ctx_new for glib-backend
  crypto: hmac: add hmac driver framework
  crypto: introduce some common functions for af_alg backend
  crypto: cipher: add afalg-backend cipher support
  crypto: hash: add afalg-backend hash support
  crypto: hmac: add af_alg-backend hmac support
  tests: crypto: add cipher speed benchmark support
  tests: crypto: add hash speed benchmark support
  tests: crypto: add hmac speed benchmark support

 configure                       |  22 ++++
 crypto/Makefile.objs            |   3 +
 crypto/afalg.c                  | 116 +++++++++++++++++++++
 crypto/afalgpriv.h              |  64 ++++++++++++
 crypto/cipher-afalg.c           | 226 ++++++++++++++++++++++++++++++++++++++++
 crypto/cipher-builtin.c         | 125 +++++++++++-----------
 crypto/cipher-gcrypt.c          | 105 ++++++++++---------
 crypto/cipher-nettle.c          |  84 ++++++++-------
 crypto/cipher.c                 |  80 ++++++++++++++
 crypto/cipherpriv.h             |  56 ++++++++++
 crypto/hash-afalg.c             | 214 +++++++++++++++++++++++++++++++++++++
 crypto/hash-gcrypt.c            |  19 ++--
 crypto/hash-glib.c              |  19 ++--
 crypto/hash-nettle.c            |  19 ++--
 crypto/hash.c                   |  30 ++++++
 crypto/hashpriv.h               |  39 +++++++
 crypto/hmac-gcrypt.c            |  42 ++++----
 crypto/hmac-glib.c              |  63 ++++++-----
 crypto/hmac-nettle.c            |  42 ++++----
 crypto/hmac.c                   |  58 +++++++++++
 crypto/hmac.h                   | 166 -----------------------------
 crypto/hmacpriv.h               |  48 +++++++++
 hw/virtio/vhost-backend.c       |   8 +-
 include/crypto/cipher.h         |   1 +
 include/crypto/hmac.h           | 167 +++++++++++++++++++++++++++++
 tests/Makefile.include          |  13 ++-
 tests/benchmark-crypto-cipher.c |  88 ++++++++++++++++
 tests/benchmark-crypto-hash.c   |  67 ++++++++++++
 tests/benchmark-crypto-hmac.c   |  82 +++++++++++++++
 29 files changed, 1654 insertions(+), 412 deletions(-)
 create mode 100644 crypto/afalg.c
 create mode 100644 crypto/afalgpriv.h
 create mode 100644 crypto/cipher-afalg.c
 create mode 100644 crypto/cipherpriv.h
 create mode 100644 crypto/hash-afalg.c
 create mode 100644 crypto/hashpriv.h
 delete mode 100644 crypto/hmac.h
 create mode 100644 crypto/hmacpriv.h
 create mode 100644 include/crypto/hmac.h
 create mode 100644 tests/benchmark-crypto-cipher.c
 create mode 100644 tests/benchmark-crypto-hash.c
 create mode 100644 tests/benchmark-crypto-hmac.c

-- 
1.8.3.1

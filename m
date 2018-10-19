Received: from eggs.gnu.org ([2001:4830:134:3::10]:36173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSeV-0000RD-4m
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSeN-0006J5-LJ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:09:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDSeL-0006En-Jk
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:09:01 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 19 Oct 2018 12:08:48 +0100
Message-Id: <20181019110856.18893-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/8] crypto: improve performance of XTS
 cipher mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

  v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01601.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03159.html

The XTS cipher mode is significantly slower than CBC mode. This series
approximately doubles the XTS performance which will improve the I/O
rate for LUKS disks.

Changed in v3:

 - Swap order of byteswapping calls in xts_mult_x
 - Clarify arithmetic ops in xts_mult_x
 - Do in-place encryption in some xts_tweak_encdec calls

Changed in v2:

 - Use union for xts_uint128 to allow bytewise access without casts
 - Use byteswapping for endian correct bit gf128 shifting
 - Optimize for aligned buffers, with fallback for unaligned buffers
 - Add tests for unaligned buffer usage

Daniel P. Berrang=C3=A9 (8):
  crypto: expand algorithm coverage for cipher benchmark
  crypto: remove code duplication in tweak encrypt/decrypt
  crypto: introduce a xts_uint128 data type
  crypto: convert xts_tweak_encdec to use xts_uint128 type
  crypto: convert xts_mult_x to use xts_uint128 type
  crypto: annotate xts_tweak_encdec as inlineable
  crypto: refactor XTS cipher mode test suite
  crypto: add testing for unaligned buffers with XTS cipher mode

 crypto/xts.c                    | 200 +++++++++++++++-------------
 tests/benchmark-crypto-cipher.c | 149 +++++++++++++++++----
 tests/test-crypto-xts.c         | 226 +++++++++++++++++++++++---------
 3 files changed, 402 insertions(+), 173 deletions(-)

--=20
2.17.2

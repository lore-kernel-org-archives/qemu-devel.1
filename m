Received: from eggs.gnu.org ([2001:4830:134:3::10]:41020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAYz1-0000QU-KQ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAYyx-0005OL-K1
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:13:51 -0400
Date: Fri, 3 Nov 2017 10:13:41 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171103101341.GE20155@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1509701953-8995-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1509701953-8995-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Run the test-crypto-block only if
 encryption is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Fri, Nov 03, 2017 at 10:39:13AM +0100, Thomas Huth wrote:
> The test-crypto-block currently fails if encryption has not been
> compiled into QEMU:
> 
> TEST: tests/test-crypto-block... (pid=22231)
>   /crypto/block/qcow:                                                  OK
>   /crypto/block/luks/default:
>   Unexpected error in qcrypto_pbkdf2() at qemu/crypto/pbkdf-stub.c:41:
> FAIL
> GTester: last random seed: R02Sbbb5b6f299c6727f41bb50ba4aa6ef5c
> (pid=22237)
>   /crypto/block/luks/aes-256-cbc-plain64:
>   Unexpected error in qcrypto_pbkdf2() at qemu/crypto/pbkdf-stub.c:41:
> FAIL
> GTester: last random seed: R02S3e27992a5ab4cc95e141c4ed3c7f0d2e
> (pid=22239)
>   /crypto/block/luks/aes-256-cbc-essiv:
>   Unexpected error in qcrypto_pbkdf2() at qemu/crypto/pbkdf-stub.c:41:
> FAIL
> GTester: last random seed: R02S51b52bb02a66c42d8b331fd305384f53
> (pid=22241)
> FAIL: tests/test-crypto-block
> 
> So run this test only if the required encryption support is available.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 434a2ce..ac46aea 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -145,7 +145,7 @@ check-unit-$(if $(CONFIG_NETTLE_KDF),y,$(CONFIG_GCRYPT_KDF)) += tests/test-crypt
>  check-unit-y += tests/test-crypto-ivgen$(EXESUF)
>  check-unit-y += tests/test-crypto-afsplit$(EXESUF)
>  check-unit-y += tests/test-crypto-xts$(EXESUF)
> -check-unit-y += tests/test-crypto-block$(EXESUF)
> +check-unit-$(call lor,$(CONFIG_NETTLE_KDF),$(CONFIG_GCRYPT_KDF)) += tests/test-crypto-block$(EXESUF)

This is disabling the entire test suite, even though only the LUKS part of
the test suite has problems. Can you just extend the logic for setting the
TEST_LUKS condition in the test source code instad. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

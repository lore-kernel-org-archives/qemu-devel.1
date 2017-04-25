Received: from eggs.gnu.org ([2001:4830:134:3::10]:60627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1d34H7-0006P8-Kx
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1d34H2-0000LQ-OF
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:29:17 -0400
Received: from mout.web.de ([212.227.17.12]:60547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gm.ijewski@web.de>) id 1d34H2-0000K1-Ce
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:29:12 -0400
References: <faa27752-45a9-e6f3-d6fc-cad8254c4f31@web.de>
	<20170425134259.GH21129@redhat.com>
From: Geert Martin Ijewski <gm.ijewski@web.de>
Message-ID: <004c87ba-5fd7-9d45-71a3-4435bb2927f2@web.de>
Date: Tue, 25 Apr 2017 19:11:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170425134259.GH21129@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] crypto_gen_random() now also works on
 windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, eblake@redhat.com

Am 25.04.2017 um 15:42 schrieb Daniel P. Berrange:
> On Mon, Apr 24, 2017 at 07:51:49PM +0200, Geert Martin Ijewski wrote:
>> +#ifdef _WIN32
>> +#include <Wincrypt.h>
>> +HCRYPTPROV hCryptProv;
>> +#else
>> +int fd; /* a file handle to either /dev/urandom or /dev/random */
>> +#endif
>
>
> Lets mark both these vars 'static'

Ah yes, of course - that was a stupid error.

>>
>> +int qcrypto_random_init(Error **errp)
>> +{
>> +#ifdef _WIN32
>> +    if (!CryptAcquireContext(&hCryptProv, NULL, NULL, PROV_RSA_FULL,
>> +                             CRYPT_SILENT | CRYPT_VERIFYCONTEXT)) {
>> +        error_setg_errno(errp, GetLastError(),
>> +                         "Unable to create cryptographic provider");
>
> Unfortunately the return value of 'GetLastError()' isn't an errno
> so we can't use error_setg_errno here.
>
> Just use error_setg, and report the error value with a '(code=%u)'
> substitution at the end of the error message.
>
>

I'll use Eric's suggestion here, thanks to the both of you.

>> +/**
>> + * qcrypto_random_init:
>> + * @errp: pointer to a NULL-initialized error object
>> + *
>> + * Initalizes the handles used by qcrypto_random_bytes
>> + *
>> + * Returns 0 on success, -1 on error
>> + */
>> +int qcrypto_random_init(Error **errp);
>
> We need to add a stub
>
>   int qcrypto_random_init(Error **errp G_GNUC_UNUSED) { return 0; }
>
> in the random-gcrypt.c and random-gnutls.c files

Oh, I didn't think to look into the makefile... Yes, sure I'll do that too

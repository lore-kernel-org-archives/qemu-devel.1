Received: from eggs.gnu.org ([2001:4830:134:3::10]:56183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEYl2-0008CT-RD
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEYkz-0004r5-O8
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:43:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cEYkz-0004qq-F7
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:43:21 -0500
Date: Wed, 7 Dec 2016 09:43:14 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161207094314.GE21167@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481099622-188132-1-git-send-email-longpeng2@huawei.com>
	<1481099622-188132-2-git-send-email-longpeng2@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA155BFA@DGGEMA505-MBX.china.huawei.com>
	<5847D42A.6090400@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5847D42A.6090400@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] crypto: add 3des-ede support
 when using libgcrypt/nettle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>

On Wed, Dec 07, 2016 at 05:19:38PM +0800, Longpeng (Mike) wrote:
> 
> 
> On 2016/12/7 16:52, Gonglei (Arei) wrote:
> 
> >> -----Original Message-----
> >> From: longpeng
> >> Sent: Wednesday, December 07, 2016 4:34 PM
> >> To: berrange@redhat.com; eblake@redhat.com; armbru@redhat.com;
> >> Gonglei (Arei)
> >> Cc: qemu-devel@nongnu.org; Wubin (H); Zhoujian (jay, Euler); longpeng
> >> Subject: [PATCH for-2.9 1/2] crypto: add 3des-ede support when using
> >> libgcrypt/nettle
> >>
> >> Libgcrypt and nettle support 3des-ede, so this patch add 3des-ede
> >> support when using libgcrypt or nettle.
> >>
> >> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> >> ---
> ......
> >> --- a/qapi/crypto.json
> >> +++ b/qapi/crypto.json
> >> @@ -63,6 +63,7 @@
> >>  # @aes-192: AES with 192 bit / 24 byte keys
> >>  # @aes-256: AES with 256 bit / 32 byte keys
> >>  # @des-rfb: RFB specific variant of single DES. Do not use except in VNC.
> >> +# @3des-ede: 3DES-EDE with 192 bit / 24 byte keys
> > 
> > Missing since 2.9 here.
> > 
> 
> Okay, I will add it in V2.
> 
> >>  # @cast5-128: Cast5 with 128 bit / 16 byte keys
> >>  # @serpent-128: Serpent with 128 bit / 16 byte keys
> >>  # @serpent-192: Serpent with 192 bit / 24 byte keys
> ......
> >> +    {
> >> +        /* Borrowed from linux-kernel crypto/testmgr.h */
> >> +        .path = "/crypto/cipher/3des-ede-ecb",
> >> +        .alg = QCRYPTO_CIPHER_ALG_3DES_EDE,
> >> +        .mode = QCRYPTO_CIPHER_MODE_ECB,
> >> +        .key =
> >> +            "0123456789abcdef5555555555555555"
> >> +            "fedcba9876543210",
> >> +        .plaintext =
> >> +            "736f6d6564617461",
> >> +        .ciphertext =
> >> +            "18d748e563620572",
> >> +    },
> >> +#endif
> > 
> > Pls adds the CTR mode test case as well.
> > 
> 
> Okay!
> 
> But I confuse with the 3DES's iv length now. I saw that cbc(3des-ede)'s iv-len
> can be 8 or 16 bytes, and ctr(3des-ede)'s iv-len is 24 bytes(according to
> linux-kernel crypto/testmgr.h).
> 
> However, I think qcrypto_cipher_get_iv_len() cannot distinguish a cipher alg
> with more than one iv-len.
> 
> Daniel, do you have any idea ?

Both nettle and libgcrypt require that the iv len match the block size of
the cipher, so iv-len for 3des must always be 24


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

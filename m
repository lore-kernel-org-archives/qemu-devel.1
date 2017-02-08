Received: from eggs.gnu.org ([2001:4830:134:3::10]:51831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbPsh-0002wo-9k
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbPsd-0003Ot-Ii
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:53:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cbPsd-0003Of-Aj
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:53:43 -0500
Date: Wed, 8 Feb 2017 10:53:36 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170208105336.GH3129@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <58733617.3050503@huawei.com>
	<20170109134310.GE30228@stefanha-x1.localdomain>
	<20170109162504.GH29989@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182982@DGGEMA505-MBX.china.huawei.com>
	<20170110100355.GD27720@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182ADA@DGGEMA505-MBX.china.huawei.com>
	<20170110120354.GH27720@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182B4A@DGGEMA505-MBX.china.huawei.com>
	<20170110133019.GJ27720@redhat.com> <589AF6EC.5050803@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <589AF6EC.5050803@huawei.com>
Subject: Re: [Qemu-devel] Question about add AF_ALG backend for virtio-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, QEMU-DEV <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>

On Wed, Feb 08, 2017 at 06:46:04PM +0800, Longpeng (Mike) wrote:
> Hi Daniel,
> 
> I was writing AF_ALG-backed for QEMU crypto these days, I think there're more
> than two ways to implements it.
> 
> The first one look likes below:
> [ cipher.c ]
> qcrypto_cipher_new(...)
> {
> 	if (...) { /* use AF_ALG */
> 		cipher = afalg_cipher_new(...)
> 		if (cipher) {
> 			return cipher;
> 		}
> 	}
> 	
> 	/* disabled AF_ALG or AF_ALG failed, then back to
> 	 * using 'builtin'(gcrypt/nettle/...)
> 	 */
> 	cipher = __qcrypto_cipher_new(...)
> }
> 
> [ cipher-afalg.c ]
> afalg_cipher_new(...) {....}
> afalg_cipher_encrypt(...) {...}
> ......
> 
> [ cipher-gcrypt.c ]
> __qcrypto_cipher_new(...) {...}
> __qcrypto_cipher_encrypt(...) {...}
> ......
> 
> [ cipher-nettle.c ]
> __qcrypto_cipher_new(...) {...}
> __qcrypto_cipher_encrypt(...) {...}
> ......
> 
> In this way, I think I need to rename most functions in
> cipher-gcrypt.c/cipher-nettle.c with a prefixion(such as '__')
> 
> 
> Alternative way is:
> [ cipher-afalg.c ]
> afalg_cipher_new(...) {....}
> afalg_cipher_encrypt(...) {...}
> ......
> 
> [ cipher-gcrypt.c ]
> qcrypto_cipher_new(...)
> {
> 	if (...) { /* use AF_ALG */
> 		cipher = afalg_cipher_new(...)
> 		if (cipher) {
> 			return cipher;
> 		}
> 	}
> 	
> 	/* disabled AF_ALG or AF_ALG failed, then back to
> 	 * using 'builtin'
> 	 */
> 	.......( the existing code )
> }
> ......
> 
> [ cipher-nettle.c ]
> qcrypto_cipher_new(...)
> {
> 	if (...) { /* use AF_ALG */
> 		cipher = afalg_cipher_new(...)
> 		if (cipher) {
> 			return cipher;
> 		}
> 	}
> 	
> 	/* disabled AF_ALG or AF_ALG failed, then back to
> 	 * using 'builtin'
> 	 */
> 	.......( the existing code )
> }
> ......
> 
> In this way, we should add AF_ALG-backed code in most functions in
> cipher-gcrypt.c/cipher-nettle.c, I'm afraid this would introduce lots of
> duplicate code because the same AF_ALG-backed code must in both gcrypt-backed
> impls and nettle-backed impls as above.
> 
> I'm confusing about which way you'd prefer, or do you have any better
> suggestion?

Yeah, both approaches have some reasonably significant downsides. Approach
1 is sort of like providing a virtual driver table, except it is hardcoded
to switch between 2 impls only.

A variant on approach 1 is to actually setup a proper driver-table dispatch
layer. eg define a struct that contains callbacks for each public api
operation. The qcrypto_cipher_new() method will then either setup callbacks
for AF_ALG, or for the library impl.

This is the design we took in crypto/{ivgen.c,ivgenpriv.h}


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

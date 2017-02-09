Received: from eggs.gnu.org ([2001:4830:134:3::10]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbmoZ-0003od-2b
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:23:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbmoV-0000vm-9U
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:23:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cbmoV-0000uw-16
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:22:59 -0500
Date: Thu, 9 Feb 2017 11:22:56 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170209112256.GB4742@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170110100355.GD27720@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182ADA@DGGEMA505-MBX.china.huawei.com>
	<20170110120354.GH27720@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182B4A@DGGEMA505-MBX.china.huawei.com>
	<20170110133019.GJ27720@redhat.com> <589AF6EC.5050803@huawei.com>
	<20170208105336.GH3129@redhat.com> <589BDAEF.8000703@huawei.com>
	<20170209101114.GA4742@redhat.com> <589C4C9D.3000008@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <589C4C9D.3000008@huawei.com>
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
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, QEMU-DEV <qemu-devel@nongnu.org>

On Thu, Feb 09, 2017 at 07:03:57PM +0800, Longpeng (Mike) wrote:
> Hi Daniel,
> 
> On 2017/2/9 18:11, Daniel P. Berrange wrote:
> 
> > On Thu, Feb 09, 2017 at 10:58:55AM +0800, Longpeng (Mike) wrote:
> >> Hi Daniel,
> 
> 
> >>
> >> So...you prefer approach 1 with a driver-table dispatch layer, right?
> >> And this implies that we must either rename some public methods in
> >> cipher-gcrypt.c/cipher-nettle.c, or change them to 'static'.
> > 
> > I'd suggest both - renaming them to have 'gcrypt' or 'nettle' in their
> > name, and also make them static.
> > 
> 
> 
> OK.
> 
> >> I also have some other ideas:
> >>
> 
> >> 2) *maybe we need a heuristic policy*
> >>
> >> I added some speed test in test-crypto-cipher/hash and found that for big
> >> packets AF_ALG is much faster than library-impl while library-impl is better
> >> when the packets is small:
> >>
> >> packet(bytes)	AF_ALG(MB/sec, intel QAT)	Library-impl(MB/sec)
> >> 512		53.68				127.82
> >> 1024		98.39				133.21
> >> 2048		167.56				134.62
> >> 4096		276.21				135.10
> >> 8192		410.80				135.82
> >> 16384		545.08				136.01
> >> 32768		654.49				136.30
> >> 65536		723.00				136.29
> >>
> >> If a @alg is both supported by AF_ALG and library-impl, I think we should decide
> >> to use which one dynamically.
> > 
> > What exactly are you measuring here?
> > 
> > Is this comparing encryption of a fixed total size of data, and
> > varying the packet size. ie sending 1024 * 512 byte packets against
> > 256  * 2048 byte packages.
> > 
> > Or is it sending a constant number of packets eg 1024 * 512 byte
> > packets against 1024 * 2048 byte packets ?
> > 
> 
> 
> The testcase encrypts data for 5 seconds and then calculates how many MBs it can
> encrypt per second, as below:
> 
>     g_test_timer_start();
>     do {
>         g_assert(qcrypto_cipher_setiv(cipher,
>                                       iv, niv,
>                                       &err) == 0);
> 
>         g_assert(qcrypto_cipher_encrypt(cipher,
>                                         plaintext,
>                                         ciphertext,
>                                         chunk_size,
>                                         &err) == 0);
>         total += chunk_size;
>     } while (g_test_timer_elapsed() < 5.0);
> 
>     total /= 1024 * 1024; /* to MB */
>     g_print("Testing cbc(aes128): ");
>     g_print("Encrypting in chunks of %ld bytes: ", chunk_size);
>     g_print("done. %.2f MB in %.2f secs: ", total, g_test_timer_last());
>     g_print("%.2f MB/sec\t", total / g_test_timer_last());
> 
> chunk_size = 512/1024/2048/.../65536 bytes.
> 
> Some other projects (ie. cryptodev-linux, libkcapi) also use this way to test speed.

I'd be interested to know if there's any different in the results if
you put the qcrypto_cipher_setiv() call outside of the loop.

Depending on the way the API is used, you might set an IV, and then
write many chunks of data before setting the next IV.

Of course for LUKS, we set a new IV every 512 bytes of data, since IVs
are tied to disk sectors, so we'd be hitting the small chunk size
code path.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

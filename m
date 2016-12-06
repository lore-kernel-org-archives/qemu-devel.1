Received: from eggs.gnu.org ([2001:4830:134:3::10]:58295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEBwq-0001T3-6h
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEBwn-0003Mf-0G
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:22:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cEBwm-0003Lx-O2
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:22:00 -0500
Date: Tue, 6 Dec 2016 09:21:52 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161206092152.GD2381@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1480928380-161760-1-git-send-email-longpeng2@huawei.com>
	<1480928380-161760-2-git-send-email-longpeng2@huawei.com>
	<20161205091842.GA2498@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA152B60@DGGEMA505-MBX.china.huawei.com>
	<20161205165905.GR2498@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA153D9F@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA153D9F@DGGEMA505-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/3] crypto: add standard des
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: longpeng <longpeng2@huawei.com>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>

On Tue, Dec 06, 2016 at 01:23:31AM +0000, Gonglei (Arei) wrote:
> >
> > From: Daniel P. Berrange [mailto:berrange@redhat.com]
> > Sent: Tuesday, December 06, 2016 12:59 AM
> > To: Gonglei (Arei)
> > Cc: longpeng; eblake@redhat.com; armbru@redhat.com;
> > qemu-devel@nongnu.org; Wubin (H); Zhoujian (jay, Euler)
> > Subject: Re: [PATCH for-2.9 1/3] crypto: add standard des support
> > 
> > On Mon, Dec 05, 2016 at 09:29:59AM +0000, Gonglei (Arei) wrote:
> > > >
> > > > >      switch (alg) {
> > > > > +    case QCRYPTO_CIPHER_ALG_DES:
> > > > >      case QCRYPTO_CIPHER_ALG_DES_RFB:
> > > > >      case QCRYPTO_CIPHER_ALG_AES_128:
> > > > >      case QCRYPTO_CIPHER_ALG_AES_192:
> > > > > @@ -256,11 +257,17 @@ QCryptoCipher
> > > > *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
> > > > >      ctx = g_new0(QCryptoCipherNettle, 1);
> > > > >
> > > > >      switch (alg) {
> > > > > +    case QCRYPTO_CIPHER_ALG_DES:
> > > > >      case QCRYPTO_CIPHER_ALG_DES_RFB:
> > > > >          ctx->ctx = g_new0(struct des_ctx, 1);
> > > > > -        rfbkey = qcrypto_cipher_munge_des_rfb_key(key, nkey);
> > > > > -        des_set_key(ctx->ctx, rfbkey);
> > > > > -        g_free(rfbkey);
> > > > > +
> > > > > +        if (alg == QCRYPTO_CIPHER_ALG_DES_RFB) {
> > > > > +            rfbkey = qcrypto_cipher_munge_des_rfb_key(key, nkey);
> > > > > +            des_set_key(ctx->ctx, rfbkey);
> > > > > +            g_free(rfbkey);
> > > > > +        } else {
> > > > > +            des_set_key(ctx->ctx, key);
> > > > > +        }
> > > > >
> > > > >          ctx->alg_encrypt_native = des_encrypt_native;
> > > > >          ctx->alg_decrypt_native = des_decrypt_native;
> > > > > diff --git a/crypto/cipher.c b/crypto/cipher.c
> > > > > index a9bca41..00d9682 100644
> > > > > --- a/crypto/cipher.c
> > > > > +++ b/crypto/cipher.c
> > > > > @@ -27,6 +27,7 @@ static size_t
> > > > alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
> > > > >      [QCRYPTO_CIPHER_ALG_AES_128] = 16,
> > > > >      [QCRYPTO_CIPHER_ALG_AES_192] = 24,
> > > > >      [QCRYPTO_CIPHER_ALG_AES_256] = 32,
> > > > > +    [QCRYPTO_CIPHER_ALG_DES] = 8,
> > > > >      [QCRYPTO_CIPHER_ALG_DES_RFB] = 8,
> > > > >      [QCRYPTO_CIPHER_ALG_CAST5_128] = 16,
> > > > >      [QCRYPTO_CIPHER_ALG_SERPENT_128] = 16,
> > > > > @@ -41,6 +42,7 @@ static size_t
> > > > alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
> > > > >      [QCRYPTO_CIPHER_ALG_AES_128] = 16,
> > > > >      [QCRYPTO_CIPHER_ALG_AES_192] = 16,
> > > > >      [QCRYPTO_CIPHER_ALG_AES_256] = 16,
> > > > > +    [QCRYPTO_CIPHER_ALG_DES] = 8,
> > > > >      [QCRYPTO_CIPHER_ALG_DES_RFB] = 8,
> > > > >      [QCRYPTO_CIPHER_ALG_CAST5_128] = 8,
> > > > >      [QCRYPTO_CIPHER_ALG_SERPENT_128] = 16,
> > > > > @@ -107,7 +109,8 @@
> > > > qcrypto_cipher_validate_key_length(QCryptoCipherAlgorithm alg,
> > > > >      }
> > > > >
> > > > >      if (mode == QCRYPTO_CIPHER_MODE_XTS) {
> > > > > -        if (alg == QCRYPTO_CIPHER_ALG_DES_RFB) {
> > > > > +        if (alg == QCRYPTO_CIPHER_ALG_DES_RFB
> > > > > +            || alg == QCRYPTO_CIPHER_ALG_DES) {
> > > > >              error_setg(errp, "XTS mode not compatible with
> > DES-RFB");
> > > > >              return false;
> > > > >          }
> > > > > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > > > > index 5c9d7d4..d403ab9 100644
> > > > > --- a/qapi/crypto.json
> > > > > +++ b/qapi/crypto.json
> > > > > @@ -75,7 +75,7 @@
> > > > >  { 'enum': 'QCryptoCipherAlgorithm',
> > > > >    'prefix': 'QCRYPTO_CIPHER_ALG',
> > > > >    'data': ['aes-128', 'aes-192', 'aes-256',
> > > > > -           'des-rfb',
> > > > > +           'des-rfb', 'des',
> > > >
> > > > Can we call this '3des' to make it clear that this is Triple-DES and not
> > > > the single-DES (which des-rfb is)
> > > >
> > > Actually the current des is not triple-DES, just the single-DES, and des-rfb in
> > QEMU is just a variant of
> > > single DES, which change the standard key by calling
> > qcrypto_cipher_munge_des_rfb_key().
> > >
> > > I think we can add the 3des support as well in the next step.
> > >
> > > The current single-DES in the patch set is ok to me. :)
> > 
> > Per my othre reply in this thread,
> 
> I saw that, thanks for your information, Daniel.
> 
> > I don't think we should be supporting
> > single-DES at all in QEMU / cryptodev. So IMHO, the correct fix is to
> > remove the single-DES support from cryptodev entirely
> > 
> The cryptodev-builtin is one kind of cryptodev backends. It provides the
> real crypto capability for virtio crypto device.
>  
> I don't think we should artificially remove one algorithm support if
> the frontend driver (users) wants to use it, though the algorithm is
> unsafe.

IIUC the cryptodev hardware is ultimately about allowing the guest
to offload crypto operations to the host, potentialy using hardware
acceleration. If the cryptodev backend doesn't support a particular
algorithm, the guest is still capable of using its own built-in
support for that algorithm. I see no compelling reason to provide
host offload / acceleration for single-DES. Just kill this obsolete
algorithm from cryptodev and in the unlikely event that a guest
really does want single-DES it can use its built-in impl instead.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

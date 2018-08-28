Received: from eggs.gnu.org ([2001:4830:134:3::10]:49235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fuaNB-0005Xi-98
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 05:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fuaN7-0001bT-8b
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 05:33:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36516 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fuaN6-0001b2-UA
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 05:33:13 -0400
Date: Tue, 28 Aug 2018 10:33:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180828093307.GD25114@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAKAH_gkRfw1aPb8osySr+qj5vhiW_32coL95NgkQo4YE83zT6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKAH_gkRfw1aPb8osySr+qj5vhiW_32coL95NgkQo4YE83zT6Q@mail.gmail.com>
Subject: Re: [Qemu-devel] Guest crash when VNC connection is established
 with password (QEMU 2.5.1.1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "John Y." <wjseven1707@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, Aug 28, 2018 at 09:01:24AM +0800, John Y. wrote:
> (Sorry for repost,  I had asked in qemu-stable, but someone told me that I
> should send to qemu-devel.)
> 
> After I updated my Centos to 7.5.1804, my virtual machine crashed when I
> connected with vnc password.

[snip]

> > (qemu) change vnc password 12345678
> > (qemu)
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x00007ffff528cc80 in pthread_mutex_lock () from /lib64/libpthread.so.0
> > (gdb) bt
> > #0  0x00007ffff528cc80 in pthread_mutex_lock () from /lib64/libpthread.so.0
> > #1  0x0000555555a97f4a in qemu_mutex_lock (mutex=0x0) at
> > util/qemu-thread-posix.c:73
> > #2  0x0000555555a5cce3 in qcrypto_gcrypt_mutex_lock (priv=0x7ffff6e90ca0)
> > at crypto/init.c:97
> > #3  0x00007ffff6c217c5 in mutex_init () from /lib64/libgcrypt.so.11
> > #4  0x00007ffff6c21baa in _gcry_ath_mutex_lock () from
> > /lib64/libgcrypt.so.11
> > #5  0x00007ffff6c5ad20 in lock_pool () from /lib64/libgcrypt.so.11
> > #6  0x00007ffff6c5be2e in _gcry_rngcsprng_fast_poll () from
> > /lib64/libgcrypt.so.11
> > #7  0x00007ffff6c23d4d in _gcry_cipher_open () from /lib64/libgcrypt.so.11
> > #8  0x0000555555a60251 in qcrypto_cipher_new
> > (alg=QCRYPTO_CIPHER_ALG_DES_RFB, mode=QCRYPTO_CIPHER_MODE_ECB,
> > key=0x7fffffffdf30 "12345678\020", nkey=8, errp=0x7fffffffdf08) at
> > ./crypto/cipher-gcrypt.c:97

THis crash is caused by missing init of gcrypt. It is fixed in QEMU 2.8.0
with

commit 373166636b9f07c60d7c32610bd346acf7d143e9 (tag: pull-qcrypto-2016-10-20-1)
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Mon Oct 10 12:17:50 2016 +0100

    crypto: fix initialization of gcrypt threading
    
    The gcrypt threads implementation must be set before calling
    any other gcrypt APIs, especially gcry_check_version(),
    since that triggers initialization of the random pool. After
    that is initialized, changes to the threads impl won't be
    honoured by the random pool code. This means that gcrypt
    will think thread locking is needed and so try to acquire
    the random pool mutex, but this is NULL as no threads impl
    was set originally. This results in a crash in the random
    pool code.
    
    For the same reasons, we must set the gcrypt threads impl
    before calling gnutls_init, since that will also trigger
    gcry_check_version
    
    Reviewed-by: Eric Blake <eblake@redhat.com>
    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

> *3.  My Question*
> For some reasons I have to use qemu 2.5.11 and update Centos.
> (1) What causes this problem and how can I solve it ?

Upgrade to a newer QEMU, or backport the above patch (should be easy to
backport)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBzzj-0007e0-AS
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBzzd-0001ac-HF
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:16:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eBzzd-0001aM-AR
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:16:25 -0500
Date: Tue, 7 Nov 2017 09:16:17 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171107091617.GC14232@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
	<d465b265-2f07-34df-4474-d5dd57ec7443@redhat.com>
	<5A0119FE.6060709@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5A0119FE.6060709@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] crypto: afalg: fix a NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

On Tue, Nov 07, 2017 at 10:27:10AM +0800, Longpeng (Mike) wrote:
> 
> 
> On 2017/11/7 1:00, Eric Blake wrote:
> 
> > On 11/06/2017 12:21 AM, Longpeng(Mike) wrote:
> >> Test-crypto-hash calls qcrypto_hash_bytesv/digest/base64 with
> >> errp=NULL, this will cause a NULL poniter deference if afalg_driver
> > 
> > s/poniter deference/pointer dereference/
> > 
> 
> OK.
> 
> >> doesn't support requested algos:
> >>     ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
> >>                                                 result, resultlen,
> >>                                                 errp);
> >>     if (ret == 0) {
> >>         return ret;
> >>     }
> >>
> >>     error_free(*errp);  // <--- here
> >>
> >> So we must check 'errp & *errp' before dereference.
> > 
> > No, if we are going to blindly ignore the error from the hash_bytesv()
> > call, then we should pass NULL rather than errp.
> > 
> 
> The 'errp' in this palce is convenient for debug, it can tell us the reason for
> failure without stepping into afalg_driver's hash_bytesv().

It doesn't do anything useful for debug, because we are just immediately
throwing away the error without printing it anywhere. Just pass NULL into
the hash_bytesv call above.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

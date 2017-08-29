Received: from eggs.gnu.org ([2001:4830:134:3::10]:41314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmjTI-0001hw-R2
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmjTE-000156-U3
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:34:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dmjTE-00014k-NM
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:34:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A941F7E42F
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 16:34:31 +0000 (UTC)
Date: Tue, 29 Aug 2017 17:34:27 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170829163427.GG25801@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170829162727.13081-1-berrange@redhat.com>
	<a51f6738-f858-1ea2-ec08-eb68339eff90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a51f6738-f858-1ea2-ec08-eb68339eff90@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] crypto: fix test cert generation to not
 use SHA1 algorithm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Aug 29, 2017 at 11:31:24AM -0500, Eric Blake wrote:
> On 08/29/2017 11:27 AM, Daniel P. Berrange wrote:
> > GNUTLS 3.6.0 marked SHA1 as untrusted for certificates.
> > Unfortunately the gnutls_x509_crt_sign() method we are
> > using to create certificates in the test suite is fixed
> > to always use SHA1. We must switch to a different method
> > and explicitly ask for SHA256.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  tests/crypto-tls-x509-helpers.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-helpers.c
> > index 64073d3bd3..173d4e28fb 100644
> > --- a/tests/crypto-tls-x509-helpers.c
> > +++ b/tests/crypto-tls-x509-helpers.c
> > @@ -406,7 +406,8 @@ test_tls_generate_cert(QCryptoTLSTestCertReq *req,
> >       * If no 'ca' is set then we are self signing
> >       * the cert. This is done for the root CA certs
> >       */
> > -    err = gnutls_x509_crt_sign(crt, ca ? ca : crt, privkey);
> > +    err = gnutls_x509_crt_sign2(crt, ca ? ca : crt, privkey,
> > +                                GNUTLS_DIG_SHA256, 0);
> 
> Is _sign2() available on all the older versions of gnutls that we must
> support, or do we need this to be a conditional compilation?

It dates to gnutls 1.2.0 from 2005, so we're fine even if using RHEL5
vintage :-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYZRR-0006V2-1i
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYZRN-0003X9-0W
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:06:41 -0400
Date: Thu, 28 Jun 2018 17:06:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180628160620.GS3513@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180628132211.8795-1-rjones@redhat.com>
	<20180628132211.8795-2-rjones@redhat.com>
	<cf457707-eaab-16f9-d1c9-3a3f6423958e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf457707-eaab-16f9-d1c9-3a3f6423958e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] crypto: Implement TLS Pre-Shared Keys
 (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, Jun 28, 2018 at 09:42:18AM -0500, Eric Blake wrote:
> On 06/28/2018 08:22 AM, Richard W.M. Jones wrote:
> 
> In the subject line: most commit summaries don't have a trailing '.'.
> 
> > Pre-Shared Keys (PSK) is a simpler mechanism for enabling TLS
> > connections than using certificates.  It requires only a simple secret
> > key:
> > 
> >    $ mkdir -m 0700 /tmp/keys
> >    $ psktool -u rjones -p /tmp/keys/keys.psk
> >    $ cat /tmp/keys/keys.psk
> >    rjones:d543770c15ad93d76443fb56f501a31969235f47e999720ae8d2336f6a13fcbc
> > 
> > The key can be secretly shared between clients and servers.  Clients
> > must specify the directory containing the "keys.psk" file and a
> > username (defaults to "qemu").  Servers must specify only the
> > directory.
> > 
> > Example NBD client:
> > 
> >    $ qemu-img info \
> >      --object tls-creds-psk,id=tls0,dir=/tmp/keys,username=rjones,endpoint=client \
> >      --image-opts \
> >      file.driver=nbd,file.host=localhost,file.port=10809,file.tls-creds=tls0,file.export=/
> 
> Not your problem, but it would be nice if someday our --object command line
> arguments also had QMP counterparts to better document what key/value pairs
> each particular object type permits/requires (yeah, you can do it via QMP
> now, but object-add is an untyped command that just passes a raw dict
> through rather than benefitting from type-safe parsing).
> 
> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> > ---
> >   crypto/Makefile.objs           |   1 +
> >   crypto/tlscredspsk.c           | 300 +++++++++++++++++++++++++++++++++
> >   crypto/tlssession.c            |  50 +++++-
> >   crypto/trace-events            |   3 +
> >   include/crypto/tlscredspsk.h   | 106 ++++++++++++
> >   qemu-doc.texi                  |  37 ++++
> >   qemu-options.hx                |  24 +++
> >   tests/Makefile.include         |   4 +-
> >   tests/crypto-tls-psk-helpers.c |  50 ++++++
> >   tests/crypto-tls-psk-helpers.h |  29 ++++
> >   tests/test-crypto-tlssession.c | 185 +++++++++++++++++---
> >   11 files changed, 763 insertions(+), 26 deletions(-)
> 
> > +static int
> > +lookup_key(const char *pskfile, const char *username, gnutls_datum_t *key,
> > +           Error **errp)
> > +{
> > +    FILE *fp;
> > +    char line[1024]; /* Maximum key length in psktool is 512 bytes. */
> 
> That's true for a valid file produced by psktool, but...
> 
> > +    size_t ulen = strlen(username);
> > +    size_t len;
> > +
> > +    fp = fopen(pskfile, "r");
> 
> Do we want to consider the use of qemu_open() to allow qemu to read from a
> pre-opened fd, rather than requiring the ability to open() from the file
> system? (May matter if we want to combine crypto usage with a locked-down
> qemu that has seccomp or selinux preventing bare open).  But that gets
> tricky since there may be more than one file within the directory to open,
> and the existing x509 certificate handling is also impacted by such a design
> decision, so that's more a question for Dan and not necessarily a problem in
> this patch.

Yeah, given our approach of passing in a dir, not a file, I don't think it is
viable to expect to use qemu_open() and FD passing. 


> > +static void
> > +qcrypto_tls_creds_psk_prop_set_username(Object *obj,
> > +                                        const char *value,
> > +                                        Error **errp G_GNUC_UNUSED)
> > +{
> > +    QCryptoTLSCredsPSK *creds = QCRYPTO_TLS_CREDS_PSK(obj);
> > +
> > +    creds->username = g_strdup(value);
> 
> Does it make sense to forbid this operation on servers (since it only makes
> sense for clients)?

We can't validate that here, because we can't guarantee that 'endpoint'
is set before 'username' is set.


We could enforce it in the setter for the "loaded" property as that is
set only after every other property is set.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

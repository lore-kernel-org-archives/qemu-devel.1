Received: from eggs.gnu.org ([2001:4830:134:3::10]:38221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv0Mt-0008M0-CX
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv0Mq-00044w-0u
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cv0Mp-00044j-Rl
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:41:51 -0400
Date: Mon, 3 Apr 2017 12:41:30 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170403114130.GT2768@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170327182137.7006-1-laurent@vivier.eu>
	<20170327182137.7006-2-laurent@vivier.eu>
	<237b2650-da58-c844-d594-390f41e23e65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <237b2650-da58-c844-d594-390f41e23e65@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On Mon, Mar 27, 2017 at 01:41:36PM -0500, Eric Blake wrote:
> On 03/27/2017 01:21 PM, Laurent Vivier wrote:
> > When the VM is used behind a firewall, This allows
> > to use a SOCKS5 proxy server to connect the VM IP stack
> 
> "allows to $verb" is not idiomatic English; the correct forms are
> generally "allows $subject to $verb" or "allows ${verb}ing".  In this
> case, I'd lean towards "this allows the use of a SOCKS5 proxy server"
> 
> > directly to the Internet.
> > 
> > This implementation doesn't manage UDP packets, so they
> > are simply dropped (as with restrict=on), except for
> > the localhost as we need it for DNS.
> > 
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > ---
> 
> > +++ b/qapi-schema.json
> > @@ -3680,6 +3680,9 @@
> >      '*ipv6-dns':         'str',
> >      '*smb':       'str',
> >      '*smbserver': 'str',
> > +    '*proxy-server': 'str',
> > +    '*proxy-user':   'str',
> > +    '*proxy-passwd': 'str',
> 
> Why can't we spell this out as password, instead of abbreviating?
> Should this hook into the "secrets object" framework so that someone
> does not have to pass the password in plaintext?

Yes.

> > +@item proxy-server=@var{addr}:@var{port}[,proxy-user=@var{user},proxy-passwd=@var{passwd}]]
> 
> Yes, you DEFINITELY need to hook into the "secrets object" framework to
> avoid having to pass a password in plaintext on the command line.  Dan
> Berrange may have more advice on doing that.

Agreed, this needs to use the secrets framework.

Rename 'proxy-password' to 'proxy-password-secret'. It'll provide the ID of
a secret's object. Given that you can use qcrypto_secret_lookup_as_utf8()
to get the associated password data. There's a few examples in the code
eg crypto/tlscredsx509.c is a fairly simple example. Ping me if you want
more help

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

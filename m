Received: from eggs.gnu.org ([2001:4830:134:3::10]:44901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlNb-0002V6-M3
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlNZ-00079T-TO
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:17:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eOlNZ-00078s-Ja
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:17:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C85E280481
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 14:17:52 +0000 (UTC)
Date: Tue, 12 Dec 2017 14:17:49 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171212141749.GC26971@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171208115834.21577-1-berrange@redhat.com>
	<8e85e5e6-01f6-9c01-f7fa-e33ec4f9d6c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e85e5e6-01f6-9c01-f7fa-e33ec4f9d6c7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: update information for TLS
 certificate management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>

On Fri, Dec 08, 2017 at 10:16:50AM -0600, Eric Blake wrote:
> On 12/08/2017 05:58 AM, Daniel P. Berrange wrote:
> > The current docs for TLS assume only VNC is using TLS. Some of the information
> > is also outdated (ie lacking subject alt name info for certs). Rewrite it to
> > more accurately reflect the current situation.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-doc.texi | 368 +++++++++++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 275 insertions(+), 93 deletions(-)
> > 
> 
> > +@subsection Configuring SASL mechanisms
> > +
> > +The following documentation assumes use of the Cyrus SASL implementation on a
> > +Linux host, but the principals should apply to any other SASL impl. When SASL
> 
> s/impl/implementation/

This is just a moved block of pre-existing text, and since expanding the
abbrev would cause reformatting of line breaks, I'll not change this.

> > +is enabled, the mechanism configuration will be loaded from system default
> > +SASL service config /etc/sasl2/qemu.conf. If running QEMU as an
> > +unprivileged user, an environment variable SASL_CONF_PATH can be used
> > +to make it search alternate locations for the service config.
> > +
> 
> 
> > +@node tls_generate_server
> > +@subsection Issuing server certificates
> >  
> >  Each server (or host) needs to be issued with a key and certificate. When connecting
> >  the certificate is sent to the client which validates it against the CA certificate.
> > -The core piece of information for a server certificate is the hostname. This should
> > -be the fully qualified hostname that the client will connect with, since the client
> > -will typically also verify the hostname in the certificate. On the host holding the
> > -secure CA private key:
> > +The core pieces of information for a server certificate are the hostnames and/or IP
> > +addresses that will be used by clients when connecting. The hostname / IP address
> > +that the client specifies when connecting will be validated aganist the hostname(s)
> 
> s/aganist/against/
> 
> > +and IP address(es) recorded in the server certificate, and if no match is found
> > +the client will close the connection.
> > +
> > +Thus it is recommended that the server certificate include both the fully qualfied
> 
> s/qualfied/qualified/
> 
> 
> > +
> > +If a single host is going to be using TLS in both a client and server
> > +role, it is possible to create a single certificate to cover both roles.
> > +This would be quite common for the migration and NBD services, where a
> > +QEMU be start by accepting a TLS protected incoming migration, and later
> 
> s/QEMU be start/QEMU process will be started/
> 
> > +itself be migrated out to another host. To generate a single certificate,
> > +simply include the template data from both the client and server
> > +instructions in one.
> >  
> 
> >  
> > -When not using TLS the recommended configuration is
> > +When copying the PEM files to the target host, save them twice
> > +once as @code{server-cert.pem} and @code{server-key.pem}, and
> 
> s/twice/twice,/
> 
> > +against as @code{client-cert.pem} and @code{client-key.pem}.
> 
> s/against/again/
> 
> > +
> > +@node tls_creds_setup
> > +@subsection TLS x509 credential configuration
> > +
> > +QEMU has a standard mechanism for loading x509 credentials that will be
> > +used for network services and clients. It requires specifying the
> > +@code{tls-creds-x509} class name to the @code{-object} command line
> > +argument for the system emulators. This also works for the helper tools
> > +like @code{qemu-nbd} and @code{qemu-img}, but is named @code{--object}.
> 
> You can use '--object' with qemu as well (getopt_long_only() accepts
> double-dash form in addition to single dash).  If it makes it any easier
> to only document the double-dash form, then go for it.

Since the QEMU -help text only mentions the single dash format, I'll
stick with that.

Perhaps though, we should change the -help text (and all docs) to always
use double dash format so we're consistent across QEMU codebase, and more
normal CLI arg syntax for long options ?

> 
> > +Each set of credentials loaded should be given a unique string identifier
> > +via the @code{id} parameter. A single set of TLS credentials can be used
> > +for multiple network backends, so VNC, migration, NBD, character devices
> > +can all share the same credentials. Note, however, that credentials for
> > +use in a client endpoint must be loaded separately from those used in
> > +a server endpoint.
> > +
> > +When specifying the object, the @code{dir} parameters specifies which
> > +directory contains the credential files. This directory is expected to
> > +contain files with the names mentioned previously, @code{ca-cert.pem},
> > +@code{server-key.pem}, @code{server-cert.pem}, @code{client-key.pem}
> > +and @code{client-cert.pem} as appropriate. It is also possible to
> > +include a set of pre-generated diffie-hellman parameters in a file
> > +@code{dh-params.pem}, which can be created using the
> > +@code{certtool --generate-dh-params} command. If omitted, QEMU will
> > +dynamically generated DH parameters when loading the credentials.
> 
> s/generated/generate/



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

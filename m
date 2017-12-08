Received: from eggs.gnu.org ([2001:4830:134:3::10]:35711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNHIl-0000j0-6M
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNHIh-0002pw-4v
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:58:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eNHIg-0002pi-BN
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:58:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DDA45D5F4
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 11:58:40 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  8 Dec 2017 11:58:34 +0000
Message-Id: <20171208115834.21577-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] docs: update information for TLS certificate
 management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The current docs for TLS assume only VNC is using TLS. Some of the information
is also outdated (ie lacking subject alt name info for certs). Rewrite it to
more accurately reflect the current situation.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-doc.texi | 368 +++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 275 insertions(+), 93 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index db2351c746..0c1f2d14ac 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -140,6 +140,7 @@ accelerator is required to use more than one host CPU for emulation.
 * direct_linux_boot::  Direct Linux Boot
 * pcsys_usb::          USB emulation
 * vnc_security::       VNC security
+* network_tls::        TLS setup for network services
 * gdb_usage::          GDB usage
 * pcsys_os_specific::  Target OS specific information
 @end menu
@@ -944,25 +945,104 @@ with the aforementioned TLS + x509 options:
 qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509,sasl -monitor stdio
 @end example
 
+@node vnc_setup_sasl
+
+@subsection Configuring SASL mechanisms
+
+The following documentation assumes use of the Cyrus SASL implementation on a
+Linux host, but the principals should apply to any other SASL impl. When SASL
+is enabled, the mechanism configuration will be loaded from system default
+SASL service config /etc/sasl2/qemu.conf. If running QEMU as an
+unprivileged user, an environment variable SASL_CONF_PATH can be used
+to make it search alternate locations for the service config.
+
+If the TLS option is enabled for VNC, then it will provide session encryption,
+otherwise the SASL mechanism will have to provide encryption. In the latter
+case the list of possible plugins that can be used is drastically reduced. In
+fact only the GSSAPI SASL mechanism provides an acceptable level of security
+by modern standards. Previous versions of QEMU referred to the DIGEST-MD5
+mechanism, however, it has multiple serious flaws described in detail in
+RFC 6331 and thus should never be used any more. The SCRAM-SHA-1 mechanism
+provides a simple username/password auth facility similar to DIGEST-MD5, but
+does not support session encryption, so can only be used in combination with
+TLS.
 
-@node vnc_generate_cert
-@subsection Generating certificates for VNC
+When not using TLS the recommended configuration is
 
-The GNU TLS packages provides a command called @code{certtool} which can
-be used to generate certificates and keys in PEM format. At a minimum it
-is necessary to setup a certificate authority, and issue certificates to
-each server. If using certificates for authentication, then each client
-will also need to be issued a certificate. The recommendation is for the
-server to keep its certificates in either @code{/etc/pki/qemu} or for
-unprivileged users in @code{$HOME/.pki/qemu}.
+@example
+mech_list: gssapi
+keytab: /etc/qemu/krb5.tab
+@end example
+
+This says to use the 'GSSAPI' mechanism with the Kerberos v5 protocol, with
+the server principal stored in /etc/qemu/krb5.tab. For this to work the
+administrator of your KDC must generate a Kerberos principal for the server,
+with a name of 'qemu/somehost.example.com@@EXAMPLE.COM' replacing
+'somehost.example.com' with the fully qualified host name of the machine
+running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
+
+When using TLS, if username+password authentication is desired, then a
+reasonable configuration is
+
+@example
+mech_list: scram-sha-1
+sasldb_path: /etc/qemu/passwd.db
+@end example
+
+The saslpasswd2 program can be used to populate the passwd.db file with
+accounts.
+
+Other SASL configurations will be left as an exercise for the reader. Note that
+all mechanisms except GSSAPI, should be combined with use of TLS to ensure a
+secure data channel.
+
+
+@node network_tls
+@section TLS setup for network services
+
+Almost all network services in QEMU have the ability to use TLS for
+session data encryption, along with x509 certificates for simple
+client authentication. What follows is a description of how to
+generate certificates suitable for usage with QEMU, and applies to
+the VNC server, character devices with the TCP backend, NBD server
+and client, and migration sever and client.
+
+At a high level, QEMU requires certificates and private keys to be
+provided in PEM format. Aside from the core fields, the certificates
+should include various extension data sets, including v3 basic
+constraints data, key purpose, key usage and subject alt name.
+
+The GNUTLS package includes a command called @code{certtool} which can
+be used to easily generate certificates and keys in the required format
+with expected data present. Alternatively a certificate management
+service may be used.
+
+At a minimum it is necessary to setup a certificate authority, and
+issue certificates to each server. If using x509 certificates for
+authentication, then each client will also need to be issued a
+certificate.
+
+Assuming that the QEMU network services will only ever be exposed to
+clients on a private intranet, there is no need to use a commercial
+certificate authority to create certificates. A self-signed CA is
+sufficient, and in fact likely to be more secure since it removes
+the ability of malicious 3rd parties to trick the CA into mis-issuing
+certs for impersonating your services. The only likely exception
+where a commercial CA might be desirable is if enabling the VNC
+websockets server and exposing it directly to remote browser clients.
+In such a case it might be useful to use a commercial CA to avoid
+needing to install custom CA certs in the web browsers.
+
+The recommendation is for the server to keep its certificates in either
+@code{/etc/pki/qemu} or for unprivileged users in @code{$HOME/.pki/qemu}.
 
 @menu
-* vnc_generate_ca::
-* vnc_generate_server::
-* vnc_generate_client::
+* network_generate_ca::
+* network_generate_server::
+* network_generate_client::
 @end menu
-@node vnc_generate_ca
-@subsubsection Setup the Certificate Authority
+@node network_generate_ca
+@subsection Setup the Certificate Authority
 
 This step only needs to be performed once per organization / organizational
 unit. First the CA needs a private key. This key must be kept VERY secret
@@ -973,11 +1053,10 @@ issued with it is lost.
 # certtool --generate-privkey > ca-key.pem
 @end example
 
-A CA needs to have a public certificate. For simplicity it can be a self-signed
-certificate, or one issue by a commercial certificate issuing authority. To
-generate a self-signed certificate requires one core piece of information, the
-name of the organization.
-
+To generate a self-signed certificate requires one core piece of information,
+the name of the organization. A template file @code{ca.info} should be
+populated with the desired data to avoid having to deal with interactive
+prompts from certtool:
 @example
 # cat > ca.info <<EOF
 cn = Name of your organization
@@ -990,123 +1069,226 @@ EOF
            --outfile ca-cert.pem
 @end example
 
-The @code{ca-cert.pem} file should be copied to all servers and clients wishing to utilize
-TLS support in the VNC server. The @code{ca-key.pem} must not be disclosed/copied at all.
+The @code{ca} keyword in the template sets the v3 basic constraints extension
+to indicate this certificate is for a CA, while @code{cert_signing_key} sets
+the key usage extension to indicate this will be used for signing other keys.
+The generated @code{ca-cert.pem} file should be copied to all servers and
+clients wishing to utilize TLS support in the VNC server. The @code{ca-key.pem}
+must not be disclosed/copied anywhere except the host responsible for issuing
+certificates.
 
-@node vnc_generate_server
-@subsubsection Issuing server certificates
+@node tls_generate_server
+@subsection Issuing server certificates
 
 Each server (or host) needs to be issued with a key and certificate. When connecting
 the certificate is sent to the client which validates it against the CA certificate.
-The core piece of information for a server certificate is the hostname. This should
-be the fully qualified hostname that the client will connect with, since the client
-will typically also verify the hostname in the certificate. On the host holding the
-secure CA private key:
+The core pieces of information for a server certificate are the hostnames and/or IP
+addresses that will be used by clients when connecting. The hostname / IP address
+that the client specifies when connecting will be validated aganist the hostname(s)
+and IP address(es) recorded in the server certificate, and if no match is found
+the client will close the connection.
+
+Thus it is recommended that the server certificate include both the fully qualfied
+and unqualified hostnames. If the server will have permanently assigned IP address(es),
+and clients are likely to use them when connecting, they may also be included in the
+certificate. Both IPv4 and IPv6 addresses are supported. Historically certificates
+only included 1 hostname in the @code{CN} field, however, usage of this field for
+validation is now deprecated. Instead modern TLS clients will validate against the
+Subject Alt Name extension data, which allows for multiple entries. In the future
+usage of the @code{CN} field may be discontinued entirely, so providing SAN
+extension data is strongly recommended.
+
+On the host holding the CA, create template files containing the information
+for each server, and use it to issue server certificates.
 
 @example
-# cat > server.info <<EOF
+# cat > server-hostNNN.info <<EOF
 organization = Name  of your organization
-cn = server.foo.example.com
+cn = hostNNN.foo.example.com
+dns_name = hostNNN
+dns_name = hostNNN.foo.example.com
+ip_address = 10.0.1.87
+ip_address = 192.8.0.92
+ip_address = 2620:0:cafe::87
+ip_address = 2001:24::92
 tls_www_server
 encryption_key
 signing_key
 EOF
-# certtool --generate-privkey > server-key.pem
+# certtool --generate-privkey > server-hostNNN-key.pem
 # certtool --generate-certificate \
            --load-ca-certificate ca-cert.pem \
            --load-ca-privkey ca-key.pem \
-           --load-privkey server-key.pem \
-           --template server.info \
-           --outfile server-cert.pem
+           --load-privkey server-hostNNN-key.pem \
+           --template server-hostNNN.info \
+           --outfile server-hostNNN-cert.pem
 @end example
 
-The @code{server-key.pem} and @code{server-cert.pem} files should now be securely copied
-to the server for which they were generated. The @code{server-key.pem} is security
-sensitive and should be kept protected with file mode 0600 to prevent disclosure.
+The @code{dns_name} and @code{ip_address} fields in the template are setting
+the subject alt name extension data. The @code{tls_www_server} keyword is the
+key purpose extension to indicate this certificate is intended for usage in
+a web server. Although QEMU network services are not in fact HTTP servers
+(except for VNC websockets), setting this key purpose is still recommended.
+The @code{encryption_key} and @code{signing_key} keyword is the key usage
+extension to indicate this certificate is intended for usage in the data
+session.
+
+The @code{server-hostNNN-key.pem} and @code{server-hostNNN-cert.pem} files
+should now be securely copied to the server for which they were generated,
+and renamed to @code{server-key.pem} and @code{server-cert.pem} when added
+to the @code{/etc/pki/qemu} directory on the target host. The @code{server-key.pem}
+file is security sensitive and should be kept protected with file mode 0600
+to prevent disclosure.
 
-@node vnc_generate_client
-@subsubsection Issuing client certificates
+@node tls_generate_client
+@subsection Issuing client certificates
+
+The QEMU x509 TLS credential setup defaults to enabling client verification
+using certificates, providing a simple authentication mechanism. If this
+default is used, each client also needs to be issued a certificate. The client
+certificate contains enough metadata to uniquely identify the client with the
+scope of the certificate authority. The client certificate would typically
+include fields for organization, state, city, building, etc.
+
+Once again on the host holding the CA, create template files containing the
+information for each client, and use it to issue client certificates.
 
-If the QEMU VNC server is to use the @code{x509verify} option to validate client
-certificates as its authentication mechanism, each client also needs to be issued
-a certificate. The client certificate contains enough metadata to uniquely identify
-the client, typically organization, state, city, building, etc. On the host holding
-the secure CA private key:
 
 @example
-# cat > client.info <<EOF
+# cat > client-hostNNN.info <<EOF
 country = GB
 state = London
-locality = London
+locality = City Of London
 organization = Name of your organization
-cn = client.foo.example.com
+cn = hostNNN.foo.example.com
 tls_www_client
 encryption_key
 signing_key
 EOF
-# certtool --generate-privkey > client-key.pem
+# certtool --generate-privkey > client-hostNNN-key.pem
 # certtool --generate-certificate \
            --load-ca-certificate ca-cert.pem \
            --load-ca-privkey ca-key.pem \
-           --load-privkey client-key.pem \
-           --template client.info \
-           --outfile client-cert.pem
+           --load-privkey client-hostNNN-key.pem \
+           --template client-hostNNN.info \
+           --outfile client-hostNNN-cert.pem
 @end example
 
-The @code{client-key.pem} and @code{client-cert.pem} files should now be securely
-copied to the client for which they were generated.
-
+The subject alt name extension data is not required for clients, so the
+the @code{dns_name} and @code{ip_address} fields are not included.
+The @code{tls_www_client} keyword is the key purpose extension to indicate
+this certificate is intended for usage in a web client. Although QEMU
+network clients are not in fact HTTP clients, setting this key purpose is
+still recommended. The @code{encryption_key} and @code{signing_key} keyword
+is the key usage extension to indicate this certificate is intended for
+usage in the data session.
+
+The @code{client-hostNNN-key.pem} and @code{client-hostNNN-cert.pem} files
+should now be securely copied to the client for which they were generated,
+and renamed to @code{client-key.pem} and @code{client-cert.pem} when added
+to the @code{/etc/pki/qemu} directory on the target host. The @code{client-key.pem}
+file is security sensitive and should be kept protected with file mode 0600
+to prevent disclosure.
+
+If a single host is going to be using TLS in both a client and server
+role, it is possible to create a single certificate to cover both roles.
+This would be quite common for the migration and NBD services, where a
+QEMU be start by accepting a TLS protected incoming migration, and later
+itself be migrated out to another host. To generate a single certificate,
+simply include the template data from both the client and server
+instructions in one.
 
-@node vnc_setup_sasl
-
-@subsection Configuring SASL mechanisms
-
-The following documentation assumes use of the Cyrus SASL implementation on a
-Linux host, but the principals should apply to any other SASL impl. When SASL
-is enabled, the mechanism configuration will be loaded from system default
-SASL service config /etc/sasl2/qemu.conf. If running QEMU as an
-unprivileged user, an environment variable SASL_CONF_PATH can be used
-to make it search alternate locations for the service config.
-
-If the TLS option is enabled for VNC, then it will provide session encryption,
-otherwise the SASL mechanism will have to provide encryption. In the latter
-case the list of possible plugins that can be used is drastically reduced. In
-fact only the GSSAPI SASL mechanism provides an acceptable level of security
-by modern standards. Previous versions of QEMU referred to the DIGEST-MD5
-mechanism, however, it has multiple serious flaws described in detail in
-RFC 6331 and thus should never be used any more. The SCRAM-SHA-1 mechanism
-provides a simple username/password auth facility similar to DIGEST-MD5, but
-does not support session encryption, so can only be used in combination with
-TLS.
+@example
+# cat > both-hostNNN.info <<EOF
+country = GB
+state = London
+locality = City Of London
+organization = Name of your organization
+cn = hostNNN.foo.example.com
+dns_name = hostNNN
+dns_name = hostNNN.foo.example.com
+ip_address = 10.0.1.87
+ip_address = 192.8.0.92
+ip_address = 2620:0:cafe::87
+ip_address = 2001:24::92
+tls_www_server
+tls_www_client
+encryption_key
+signing_key
+EOF
+# certtool --generate-privkey > both-hostNNN-key.pem
+# certtool --generate-certificate \
+           --load-ca-certificate ca-cert.pem \
+           --load-ca-privkey ca-key.pem \
+           --load-privkey both-hostNNN-key.pem \
+           --template both-hostNNN.info \
+           --outfile both-hostNNN-cert.pem
+@end example
 
-When not using TLS the recommended configuration is
+When copying the PEM files to the target host, save them twice
+once as @code{server-cert.pem} and @code{server-key.pem}, and
+against as @code{client-cert.pem} and @code{client-key.pem}.
+
+@node tls_creds_setup
+@subsection TLS x509 credential configuration
+
+QEMU has a standard mechanism for loading x509 credentials that will be
+used for network services and clients. It requires specifying the
+@code{tls-creds-x509} class name to the @code{-object} command line
+argument for the system emulators. This also works for the helper tools
+like @code{qemu-nbd} and @code{qemu-img}, but is named @code{--object}.
+Each set of credentials loaded should be given a unique string identifier
+via the @code{id} parameter. A single set of TLS credentials can be used
+for multiple network backends, so VNC, migration, NBD, character devices
+can all share the same credentials. Note, however, that credentials for
+use in a client endpoint must be loaded separately from those used in
+a server endpoint.
+
+When specifying the object, the @code{dir} parameters specifies which
+directory contains the credential files. This directory is expected to
+contain files with the names mentioned previously, @code{ca-cert.pem},
+@code{server-key.pem}, @code{server-cert.pem}, @code{client-key.pem}
+and @code{client-cert.pem} as appropriate. It is also possible to
+include a set of pre-generated diffie-hellman parameters in a file
+@code{dh-params.pem}, which can be created using the
+@code{certtool --generate-dh-params} command. If omitted, QEMU will
+dynamically generated DH parameters when loading the credentials.
+
+The @code{endpoint} parameter indicates whether the credentials will
+be used for a network client or server, and determines which PEM
+files are loaded.
+
+The @code{verify} parameter determines whether x509 certificate
+validation should be performed. This defaults to enabled, meaning
+clients will always validate the server hostname against the
+certificate subject alt name fields and/or CN field. It also
+means that servers will request that clients provide a certificate
+and validate them. Verification should never be turned off for
+client endpoints, however, it may be turned off for server endpoints
+if an alternative mechanism is used to authenticate clients. For
+example, the VNC server can use SASL to authenticate clients
+instead.
+
+To load server credentials with client certificate validation
+enabled
 
 @example
-mech_list: gssapi
-keytab: /etc/qemu/krb5.tab
+$QEMU -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server
 @end example
 
-This says to use the 'GSSAPI' mechanism with the Kerberos v5 protocol, with
-the server principal stored in /etc/qemu/krb5.tab. For this to work the
-administrator of your KDC must generate a Kerberos principal for the server,
-with a name of 'qemu/somehost.example.com@@EXAMPLE.COM' replacing
-'somehost.example.com' with the fully qualified host name of the machine
-running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
-
-When using TLS, if username+password authentication is desired, then a
-reasonable configuration is
+while to load client credentials use
 
 @example
-mech_list: scram-sha-1
-sasldb_path: /etc/qemu/passwd.db
+$QEMU -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=client
 @end example
 
-The saslpasswd2 program can be used to populate the passwd.db file with
-accounts.
+Network services which support TLS will all have a @code{tls-creds}
+parameter which expects the ID of the tls credentials object. For
+example with VNC:
 
-Other SASL configurations will be left as an exercise for the reader. Note that
-all mechanisms except GSSAPI, should be combined with use of TLS to ensure a
-secure data channel.
+@example
+$QEMU -vnc 0.0.0.0:0,tls-creds=tls0
+@end example
 
 @node gdb_usage
 @section GDB usage
-- 
2.14.3

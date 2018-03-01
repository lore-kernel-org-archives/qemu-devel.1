Received: from eggs.gnu.org ([2001:4830:134:3::10]:51287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQER-0000h9-N0
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQEN-0005eE-Iz
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:34:55 -0500
Date: Thu, 1 Mar 2018 15:34:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180301153438.GK14643@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301135856.22698-1-rjones@redhat.com>
	<20180301135856.22698-3-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301135856.22698-3-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] block: curl: Allow Certificate
 Authority bundle to be passed in.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: jcody@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

On Thu, Mar 01, 2018 at 01:58:56PM +0000, Richard W.M. Jones wrote:
> This allows a Certificate Authority bundle to be passed to the curl
> driver, allowing authentication against servers that check
> certificates.  For example this allows you to access a disk on an
> oVirt node:
> 
>   qemu-img create -f qcow2 \
>       -b 'json:{ "file.driver": "https",
>                  "file.url": "https://ovirt-node:54322/images/<disk-id>",
>                   "file.header": ["Authorization: <ticket>"] }' \
>                   "file.cainfo": "/tmp/ca.pem" }' \
>       test.qcow2

I think we ought to be using the TLS creds object to provide this data

   qemu-img create \
       --object tls-creds-x509,dir=/path/to/certs,id=tls0,verify-peer=yes,endpoint=client \
       -b 'json:{ "file.driver": "https",
                  "file.url": "https://ovirt-node:54322/images/<disk-id>",
                   "file.header": ["Authorization: <ticket>"] }' \
                   "file.tls-creds": "tls0" }' \
       test.qcow2

The /path/to/certs dir would contain ca-cert.pem, and optionally also a
client-key.pem & client-cert.pem, which would let curl provide client
certs to servers that mandate that. The 'verify-peer' option lets you
control whether to ignore or enforce CA validation errors too.

Take a look at block/vxhs.c and its vxhs_get_tls_creds() method.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

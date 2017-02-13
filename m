Received: from eggs.gnu.org ([2001:4830:134:3::10]:50977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdISm-0001Pg-It
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdISi-0003xS-U5
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:22:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cdISi-0003xG-Ld
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:22:44 -0500
Date: Mon, 13 Feb 2017 15:22:34 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170213152234.GF12387@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1486527494-3387-1-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1486527494-3387-1-git-send-email-Ashish.Mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, Ketan.Nilangekar@veritas.com, Abhijit.Dey@veritas.com

On Tue, Feb 07, 2017 at 08:18:13PM -0800, Ashish Mittal wrote:
> From: Ashish Mittal <ashish.mittal@veritas.com>
> 
> Source code for the qnio library that this code loads can be downloaded from:
> https://github.com/VeritasHyperScale/libqnio.git
> 
> Sample command line using JSON syntax:
> ./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc 0.0.0.0:0
> -k en-us -vga cirrus -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
> -msg timestamp=on
> 'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410",
> "server":{"host":"172.172.17.4","port":"9999"}}'
> 
> Sample command line using URI syntax:
> qemu-img convert -f raw -O raw -n
> /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386ad
> vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0
> 
> Signed-off-by: Ashish Mittal <ashish.mittal@veritas.com>
> ---
> TODO:
> (1) valgrind report to follow soon.
> (2) Security implementation for libqnio present in branch "securify".
>     QEMU patch will use this once it gets merged to libqnio master.
>     Please use master for building libqnio and testing with this patch.
> (3) Rename libqnio to libvxhs. Changes ready in branch "securify".

The securify branch is still lacking in some significant ways that
prevent effective use of TLS with QEMU. In particular the way it
is written to use certs from a hardcoded set of paths is not very
desirable. In addition the way it turns TLS on/off based on the
existance of a file file is disk is really bad. For something as
critical as TLS, we don't want it silently enabled/disabled as
a side-effect of external host OS state.

We need to be able to explicitly mandate TLS or plain text mode
from QEMU by calling a suitable API todo so. QEMU also needs to
be able to specify wher the certiticates are located, at the
time the connection is established, so that it can integrate with
the QEMU TLS credentials object system.

eg I'd expect configuration to look like (to be comparible with
use of NBD):

 $qemu-system-x86_64 \
   -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=client \
  'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410",
         "tls-creds": "tls0",
         "server":{"host":"172.172.17.4","port":"9999"}}'

The -object arg registers some TLS credentials with QEMU, at a given path.
QEMU validates existance of ca-cert.pem, ca-crl.pem, client-crt.pem &
client-key.pem files in the direct /etc/pki/qemu.

When QEMU talks to libqnio it will tell it to enable use of TLS and to use
the files

  /etc/pki/qemu/ca-cert.pem
  /etc/pki/qemu/ca-crl.pem
  /etc/pki/qemu/client-cert.pem
  /etc/pki/qemu/client-key.pem

for negotiating the session.

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 932f5bb..f37df56 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json

> @@ -2744,6 +2745,20 @@
>    'data': { '*offset': 'int', '*size': 'int' } }
>  
>  ##
> +# @BlockdevOptionsVxHS:
> +#
> +# Driver specific block device options for VxHS
> +#
> +# @vdisk-id:    UUID of VxHS volume
> +# @server:      vxhs server IP, port
> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'BlockdevOptionsVxHS',
> +  'data': { 'vdisk-id': 'str',
> +            'server': 'InetSocketAddress' } }

This will need to gain a field

    'tls-creds': 'str'

NB, naming picked to be consistent with naming used for NBD.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

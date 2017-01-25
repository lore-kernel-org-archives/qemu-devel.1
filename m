Received: from eggs.gnu.org ([2001:4830:134:3::10]:47380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWRk9-0005aC-Nk
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWRk5-0000oX-NB
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:52:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cWRk5-0000oC-He
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:52:21 -0500
Date: Wed, 25 Jan 2017 17:52:14 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170125175214.GH29006@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1485272673-5877-1-git-send-email-zdai@linux.vnet.ibm.com>
	<20170124173619.GB28745@redhat.com>
	<1485366465.1515.19.camel@oc5348122405>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485366465.1515.19.camel@oc5348122405>
Subject: Re: [Qemu-devel] [PATCH 1/1] Migration: libvirt live migration over
 RDMA of ipv6 addr failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "David Z. Dai" <zdai@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, zdai@us.ibm.com, mdroth@linux.vnet.ibm.com, quintela@redhat.com

On Wed, Jan 25, 2017 at 11:47:45AM -0600, David Z. Dai wrote:
>    In Previous test, I changed libvirtd code in src/util/viruri.c file,
>  virURIParse() routine to block
>  "virStringStripIPv6Brackets(ret->server);" call. It caused ssh ipv6
> authentication failure.
>   
>    You said libvirt needs to be changed to pass correct data to QEMU.
>    
>    As one of the solution on libvirt side: if I add this condition in
>  virURIParse() routine:
> +  if (strcmp(ret->scheme, "rdma")) {
>         /* Strip square bracket from an IPv6 address.
>          * The function modifies the string in-place. Even after such
>          * modification, it is OK to free the URI with xmlFreeURI. */
>         virStringStripIPv6Brackets(ret->server);
> +  }
> 
>    Now both the virsh live migration with tcp and rdma via ipv6 address
> work fine.
>   
>    Do you think this is the acceptable solution?

No, the viruri code is a general purpose URI parsing API and should
not be hacked with QEMU specific knowledge in this way.

You need to modify the QEMU driver code in libvirt to adding [] when
calling the QEMU migrate monitor command, and when creating the
-incoming CLI arg. eg modify various places in the src/qemu/qemu_*.c
files

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

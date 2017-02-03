Received: from eggs.gnu.org ([2001:4830:134:3::10]:56547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZh5t-0004qC-V2
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZh5p-00038f-Ch
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:52:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cZh5p-00037z-72
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:52:13 -0500
Date: Fri, 3 Feb 2017 16:52:09 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170203165209.GZ15182@redhat.com>
References: <20170202171625.28502-1-rjones@redhat.com>
	<20170202171625.28502-2-rjones@redhat.com>
	<20170203151643.GG642@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203151643.GG642@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, den@openvz.org, rkagan@virtuozzo.com, dplotnikov@virtuozzo.com, berrange@redhat.com

On Fri, Feb 03, 2017 at 03:16:43PM +0000, Stefan Hajnoczi wrote:
> On Thu, Feb 02, 2017 at 05:16:25PM +0000, Richard W.M. Jones wrote:
> > +    if (*port == NULL) {
> > +        *port = g_strdup_printf("%d", NBD_DEFAULT_PORT);;
> 
> Please stringify NBD_DEFAULT_PORT instead of using g_strdup_printf().
> That avoids the memory leak.

Oops.

Do we have a macro for this already?  I couldn't see one, and the
best I could come up with is:

#define MACRO_EXPAND_STRINGIFY(x) STRINGIFY(x)
#define STRINGIFY(x) #x

static void setup_address_and_port(const char **address, const char **port)
{
    if (*address == NULL) {
        *address = "0.0.0.0";
    }

    if (*port == NULL) {
        *port = MACRO_EXPAND_STRINGIFY(NBD_DEFAULT_PORT);
    }
}

It works, but it's a bit of a mouthful.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

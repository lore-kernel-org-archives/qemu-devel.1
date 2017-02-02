Received: from eggs.gnu.org ([2001:4830:134:3::10]:42927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZEQh-0004KD-Iy
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZEQe-0002f4-BP
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:15:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cZEQe-0002ek-3i
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:15:48 -0500
Date: Thu, 2 Feb 2017 10:15:37 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170202101537.GE2915@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
	<CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
	<E05FEFD5-A72D-4FC5-B600-58AAD2900A02@veritas.com>
	<CAJSP0QUWmU_XbB9TGxvL0hH-SCzRSWDciNhpZrarDDcE22RF_w@mail.gmail.com>
	<D1304CAA-9C32-4E42-AA65-27B3277130E8@veritas.com>
	<20170202100728.GA20760@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170202100728.GA20760@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v7 RFC] block/vxhs: Initial commit to add
 Veritas HyperScale VxHS block device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, ashish mittal <ashmit602@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Gaurav Bhandarkar <Gaurav.Bhandarkar@veritas.com>, Abhishek Kane <Abhishek.Kane@veritas.com>, Ketan Mahajan <Ketan.Mahajan@veritas.com>, Niranjan Pendharkar <Niranjan.Pendharkar@veritas.com>, Nirendra Awasthi <Nirendra.Awasthi@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Thu, Feb 02, 2017 at 10:07:28AM +0000, Stefan Hajnoczi wrote:
> On Wed, Feb 01, 2017 at 11:59:53PM +0000, Ketan Nilangekar wrote:
> > Patch for secure implementation in libqnio is available for review here:
> > 
> > https://github.com/VeritasHyperScale/libqnio/pull/12
> > 
> > libqnio client initialization now has an option to use X.509 certificates to authenticate itself to the vxhs server.  
> > Also each client IO request now includes an instance id that is used by the vxhs server to authorize the request.
> > A test client has also been added.
> > Libqnio.so so is renamed to libvxhs.so. We will rename the repository once the latest patches are merged.
> > QEMU patch to use the new secure interface will follow shortly.
> 
> I have left comments on specific lines of code on GitHub.
> 
> The server should do something based on the client X.509 certificate.
> Is the code actually verifying certificates on the client side?
> 
> Right now the code is just going through the motions of SSL but not
> protecting against man-in-the-middle attacks.
> 
> I noticed that the code uses OpenSSL.  QEMU uses GnuTLS instead of
> OpenSSL.  In practice it's hard to avoid duplication of SSL libraries:
> GlusterFS and Ceph use OpenSSL and NSS.  That means QEMU KVM may drag in
> GnuTLS, OpenSSL, and NSS!  But from a QEMU point of view it would be
> nicest to use GnuTLS to keep extra library dependencies minimal.

These points are all reasons why libqnio should not do anything TLS
related at all. It should delegate all actual I/O to QEMU, so that we
can use our existing QIO logic for TLS that is tried & tested, as well
as integrating with existing QEMU infrastructure. ie, ability to use
object_add QMP command to register TLS certificates with QEMU, instead
of hardcoding their location on disk in libqnio

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

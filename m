Received: from eggs.gnu.org ([2001:4830:134:3::10]:59900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffovd-0003jo-5p
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffovZ-0003DR-7A
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:03:49 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ffovY-0003Cx-Vk
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:03:45 -0400
Received: by mail-wm0-x243.google.com with SMTP id c14-v6so3327140wmb.4
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 09:03:44 -0700 (PDT)
Date: Wed, 18 Jul 2018 17:03:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180718160340.GP21825@stefanha-x1.localdomain>
References: <20180331084500.33313-1-jiangshanlai@gmail.com>
	<20180702131054.GE2155@stefanha-x1.localdomain>
	<CA+a=Yy72YN1DAczTnb47b4ZW_vummOVuK3M=F2CF5KF3mRD2Zw@mail.gmail.com>
	<20180703100555.GG16791@stefanha-x1.localdomain>
	<CA+a=Yy6NFKky=rBetZp1x7-vn4mRkoPLfCUqpp8L31CJegYTeQ@mail.gmail.com>
	<20180710134018.GC30635@stefanha-x1.localdomain>
	<CA+a=Yy7rTX3=t1j-77VzSKoknUTu37BPEevY5s6adCc2aEpR6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zecZT88ylESpiZX"
Content-Disposition: inline
In-Reply-To: <CA+a=Yy7rTX3=t1j-77VzSKoknUTu37BPEevY5s6adCc2aEpR6Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Tao <bergwolf@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Xu Wang <gnawux@gmail.com>, qemu-devel@nongnu.org, "James O . D . Hunt" <james.o.hunt@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kata-dev@lists.katacontainers.io


--9zecZT88ylESpiZX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2018 at 11:02:08PM +0800, Peng Tao wrote:
> On Tue, Jul 10, 2018 at 9:40 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > Two things come to mind:
> >
> > At that point both guest kernel and agent address-space layout
> > randomization (ASLR) is finished.  ALSR makes it harder for memory
> > corruption bugs to lead to real exploits because the attacker does not
> > know the full memory layout of the process.  Cloned VMs will not benefit
> > from ASLR because much of the memory layout of the guest kernel and
> > agent will be identical across all clones.
> >
> Yes, indeed. I am not arguing that ASLR is retained with VM
> templating. Just that ASLR is also compromised if one wants to use KSM
> to save memory by sharing among different guests. Kata is already
> shipping with KSM components and we are adding VM templating as a
> better alternative.

Hang on, ASLR is *not* compromised by KSM.  The address space layout is
still unique for each guest, even if KSM deduplicates physical pages on
the host.  Remember ASLR is about virtual addresses while KSM is about
sharing the physical pages.  Therefore KSM does not affect ASLR.

The KSM issue you referred to earlier is a timing side-channel attack.
Being vulnerable to timing side-channel attacks through KSM does not
reduce the effectiveness of ASLR.

> > Software random number generators have probably been initialized at this
> > point.  This doesn't mean that all cloned VMs will produce the same
> > sequence of random numbers since they should incorporate entropy sources
> > or use hardware random number generators, but the quality of random
> > numbers might be reduced.  Someone who knows random number generators
> > should take a look at this.
> >
> As Andrea pointed out earlier in his comments, we can configure the
> random number generator to printk a warning if it's being used at boot
> before it had its "shutdown" state restored. Then we can add a new
> kata-agent request set the entropy and check for such warning after a
> new VM is cloned and before it is given to the user. This way, we are
> guaranteed that random numbers generated by each guest is created with
> a different seed. Do you have other concern with this method?

Sounds good.

Stefan

--9zecZT88ylESpiZX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbT2TcAAoJEJykq7OBq3PIuuMIAJeSAcejr5m0JQttTYoaLFi8
/tvmaIhmNYbL8h3vdHe5DqjU1nHEaGH1kW/W398/JvjZjRT1U91xNgVdR/oHaeWQ
6xN9BhvrSux/qHMJoa8vTwm3J7GjnLsWLgRq8S0noqPERi1cY5WyE1xtZ+3yO8Li
LRIUjOmCb5lo5Ts2f6IyKZMOGjur5OOW1NZrJUfVmY5vOebjZpChQqdCJX7Eh9Wg
gWDgzuY79+n4jSVRmgdesTYkUr6p5vPNkEaO9I++3P4z0TyjUsk5B9t/vacuaWlK
mmgvTXZH3leasHoitQbBowevAOB3FGPC9j31qxH7xMIZ2e9QRQ4whGlOmU59JOI=
=g4pM
-----END PGP SIGNATURE-----

--9zecZT88ylESpiZX--

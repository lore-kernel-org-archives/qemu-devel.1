Received: from eggs.gnu.org ([2001:4830:134:3::10]:49664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUV1j-00082O-1H
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:07:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUV1d-0004t4-DJ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:07:33 -0500
Date: Wed, 5 Dec 2018 12:07:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181205120717.1713d8fe.cohuck@redhat.com>
In-Reply-To: <16daec26-f72a-326c-a808-729b9f1af129@linux.ibm.com>
References: <1543961939-2419-1-git-send-email-walling@linux.ibm.com>
	<16daec26-f72a-326c-a808-729b9f1af129@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390: guest support for diagnose 318
 and limit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: borntraeger@de.ibm.com, cotte@de.ibm.com, david@redhat.com, mimu@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com

On Tue, 4 Dec 2018 17:26:36 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> I screen-scraped the @ibm address again (Conny was the victim this time)
> 
> Reply to this thread to avoid any delivery failures.
> 
> On 12/4/18 5:18 PM, Collin Walling wrote:
> > Add migration and reset support for diagnose 318. This is a new z14 GA2 
> > hardware feature, but we can provide guest support starting with the 
> > zEC12-full CPU model.
> > 
> > Because new hardware introduces a new facility-availability byte in 
> > the Read SCP Info block, we lose one byte in the CPU entries list 
> > and must limit the maximum VCPUs to 247 (down from 248).
> > 
> > Signed-off-by: Collin Walling <walling@linux.ibm.com>
> > ---
> > 
> > Changelog
> > 
> >     RFC -> v1
> >         - introduced kvm stubs for set/get cpc
> >         - s/fac134/byte_134
> >         - moved diag318 vmstate description to diag.c
> >         - reduced S390_VCPU_MAX to 247
> > 
> >  hw/s390x/ipl.c                  |  3 +++
> >  hw/s390x/s390-virtio-ccw.c      |  3 +++
> >  hw/s390x/sclp.c                 |  2 ++
> >  include/hw/s390x/sclp.h         |  2 ++
> >  linux-headers/asm-s390/kvm.h    |  5 ++++
> >  target/s390x/cpu.h              |  2 +-
> >  target/s390x/cpu_features.c     |  3 +++
> >  target/s390x/cpu_features.h     |  1 +
> >  target/s390x/cpu_features_def.h |  3 +++
> >  target/s390x/diag.c             | 53 +++++++++++++++++++++++++++++++++++++++++
> >  target/s390x/gen-features.c     |  1 +
> >  target/s390x/internal.h         |  4 +++-
> >  target/s390x/kvm-stub.c         | 10 ++++++++
> >  target/s390x/kvm.c              | 23 ++++++++++++++++++
> >  target/s390x/kvm_s390x.h        |  3 +++
> >  15 files changed, 116 insertions(+), 2 deletions(-)

> > diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
> > index 0265482..8c206d2 100644
> > --- a/linux-headers/asm-s390/kvm.h
> > +++ b/linux-headers/asm-s390/kvm.h

Please split this out into a dummy headers update patch, which will be
replaced with a real headers update when applied.

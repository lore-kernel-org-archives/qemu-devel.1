Received: from eggs.gnu.org ([2001:4830:134:3::10]:35185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dtr68-00019g-LV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dtr63-0001cq-Nk
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:08:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dtr63-0001cR-F3
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:08:03 -0400
Date: Mon, 18 Sep 2017 10:07:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170918100756.75eec02d.cohuck@redhat.com>
In-Reply-To: <396c3d9d-644a-c946-3099-aba94f0571e8@de.ibm.com>
References: <20170915163952.32147-1-cohuck@redhat.com>
	<20170915163952.32147-2-cohuck@redhat.com>
	<987d04c6-dc24-e11b-3904-303058058c3b@de.ibm.com>
	<396c3d9d-644a-c946-3099-aba94f0571e8@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/1] s390x/ccw: create s390 phb for
 compat reasons as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Mon, 18 Sep 2017 09:47:00 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/18/2017 09:33 AM, Christian Borntraeger wrote:
> > 
> > 
> > On 09/15/2017 06:39 PM, Cornelia Huck wrote:  
> >> d32bd032d8 ("s390x/ccw: create s390 phb conditionally") made
> >> registering the s390 pci host bridge conditional on presense
> >> of the zpci facility bit. Sadly, that breaks migration from
> >> machines that did not use the cpu model (2.7 and previous).
> >>
> >> Create the s390 phb for pre-cpu model machines as well.
> >>
> >> Fixes: d32bd032d8 ("s390x/ccw: create s390 phb conditionally")
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>  hw/s390x/s390-virtio-ccw.c | 2 ++
> >>  target/s390x/cpu_models.c  | 3 +++
> >>  2 files changed, 5 insertions(+)
> >>
> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index 0471407187..907abc7a32 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -269,6 +269,8 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
> >>      }
> >>  }
> >>
> >> +static S390CcwMachineClass *get_machine_class(void);
> >> +
> >>  static void ccw_init(MachineState *machine)
> >>  {
> >>      int ret;

This hunk is from the previous version and should not be in there...

> >> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> >> index c295e641e6..5169379db5 100644
> >> --- a/target/s390x/cpu_models.c
> >> +++ b/target/s390x/cpu_models.c
> >> @@ -196,6 +196,9 @@ bool s390_has_feat(S390Feat feat)
> >>              }
> >>          }
> >>  #endif
> >> +        if (feat == S390_FEAT_ZPCI) {
> >> +            return true;
> >> +        }  
> > 
> > Shouldnt that be depend on the machine being 2.7? I mean unless I misread 
> > the context of this patch, you hard enable the PCI facility bit for all 
> > machines and make all s390_has_feat(S390_FEAT_ZPCI) useless?
> >   
> 
> Sorry, I had to lookup again the original code. So this is inside !cpu->model. 
> Yes makes sense then.

Yes, this is hard to figure out from the context alone.

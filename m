Received: from eggs.gnu.org ([2001:4830:134:3::10]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3IMm-000515-3I
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 05:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3IMj-0005Jk-05
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 05:36:36 -0400
Date: Tue, 3 Apr 2018 11:36:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180403113619.54ff1e18.cohuck@redhat.com>
In-Reply-To: <0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On Mon, 2 Apr 2018 12:36:27 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> On 03/26/2018 05:03 AM, Pierre Morel wrote:
> > On 26/03/2018 10:32, David Hildenbrand wrote:  
> >> On 16.03.2018 00:24, Tony Krowiak wrote:  

> >>> +    /*
> >>> +     * The Query Configuration Information (QCI) function (fc == 4) 
> >>> does not
> >>> +     * set a response code in reg 1, so check for that along with the
> >>> +     * AP feature.
> >>> +     */
> >>> +    if ((fc != 4) && s390_has_feat(S390_FEAT_AP)) {
> >>> +        env->regs[1] = 0x10000;
> >>> +
> >>> +        return 0;
> >>> +    }  
> >> This would imply an operation exception in case fc==4, which sounds very
> >> wrong.  
> >
> > It depends but I think that the S390_FEAT_AP_QUERY_CONFIG_INFO must be 
> > tested
> > to know what to answer.
> > If the feature is there, QCI must be answered correctly.  
> This is an interesting proposition which raises several issues that will 
> need to
> be addressed. The only time the PQAP(QCI) instruction is intercepted is 
> when:
> * A vfio-ap device is NOT defined for the guest because the vfio_ap 
> device driver
>    will set ECA.28 and the PQAP(QCI) instruction will be interpreted
> * STFLE.12 is set for the guest
> 
> You say that the QCI must be answered correctly, but what is the correct 
> response?
> If we return the matrix - i.e., APM, ADM and AQM - configured via the 
> mediated
> matrix device's sysfs attributes files, then if any APQNs are defined in 
> the matrix,
> we will have to handle *ALL* AP instructions by executing them on behalf 
> of the
> guest. I suppose we could return an empty matrix in which case the AP 
> bus will come
> up without any devices on the guest, but what is the expectation of an 
> admin who
> deliberately configures the mediated matrix device? Should we forego 
> handling interception
> of AP instructions and consider a guest configuration that turns on 
> S390_FEAT_AP but
> does not define a vfio-ap device to be erroneous and terminate starting 
> of the guest?
> Anybody have any thoughts?

Hard to really give good advice without access to the documentation, but:
- If we tell the guest that the feature is available, but it does not
  get any cards to use, returning an empty matrix makes the most sense
  to me.
- I would not tie starting the guest to the presence of a vfio-ap
  device. Having the feature available in theory but without any
  devices actually being usable by the guest does not really sound
  wrong (can we hotplug this later?)

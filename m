Received: from eggs.gnu.org ([2001:4830:134:3::10]:50543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXjyq-0006VI-GM
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXjyn-00015v-7s
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXjyn-000156-1q
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:05:09 -0400
Date: Wed, 19 Jul 2017 10:05:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170719100502.534cd337@gondolin>
In-Reply-To: <9e70ce06-7d67-e808-cbb9-5877bf852ac7@redhat.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-4-cohuck@redhat.com>
	<9e70ce06-7d67-e808-cbb9-5877bf852ac7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 3/9] s390x: chsc nt2 events are
 pci-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Wed, 19 Jul 2017 09:57:47 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Hmm, since you're having wrapper functions for these now anyway, I
> wonder whether it would be more elegant to make
> pci_chsc_sei_nt2_get_event() and pci_chsc_sei_nt2_have_event() function
> pointers in the S390pciState object instead. Then you could do something
> like:
> 
> static int chsc_sei_nt2_have_event(void)
> {
>     S390pciState *ps = s390_get_phb();
> 
>     if (s390_has_feat(S390_FEAT_ZPCI) && ps != NULL) {
>         return ps->pci_chsc_sei_nt2_have_event();
>     }
>     return 0;
> }
> 
> and you would not need the stubs in pci-stubs.c anymore?

Not really a fan. We would need to deal with a pci state in ioinst.c,
where IMO it doesn't really belong.

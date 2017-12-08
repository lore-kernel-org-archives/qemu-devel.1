Received: from eggs.gnu.org ([2001:4830:134:3::10]:40225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNFvS-00023I-Fb
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNFvP-0001U9-Bi
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:30:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eNFvP-0001SW-27
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:30:35 -0500
Date: Fri, 8 Dec 2017 10:30:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171208103028.GE2403@work-vm>
References: <CAO1xR-zb6Eni1LD0PB80hGRKU8PCqxjbfHtVM4aUt9i+3Utq3w@mail.gmail.com>
	<20171207184104.GA2489@work-vm>
	<CAN05THQcpCXpckxAymH00G96XdJ30RsnGAgXOA+F98vaaKWgHA@mail.gmail.com>
	<CAO1xR-yCeF9NBBLL_fr7D3CoSq924r+kP_DA+vmg41acUF0Ehw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO1xR-yCeF9NBBLL_fr7D3CoSq924r+kP_DA+vmg41acUF0Ehw@mail.gmail.com>
Subject: Re: [Qemu-devel] iSER transport name is not good
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Charles Kelimod <lichstor@gmail.com>
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>

* Charles Kelimod (lichstor@gmail.com) wrote:
> Hi Dave and Sahlberg,
> 
> for this type of name:iser://<host>/<iqn>/<lun>, I completely agree with
> you.
> my issue is when I create an vm from libvirt, the qemu command line should
> be:
> -drive
> file.driver=iser,file.portal=xx.xx.xx.xx:3260,file.target=iqn.xxx,file.lun=0,file.transport=iser
> 
> Actually "iser" is added by me in libvirt, which can work by a little
> modification. But I think file.transport=rdma would be better, as I think
> iser is protocol, and rdma is transport, and libvirt defined it, if I added
> a new transport name (iser) in libvirt, it will be confusable.

This isn't something I know much about, however:
   a) The transport name is already defined as 'iser' in qemu, so that's
what needs to be used; we can't change it because someone somewhere
might alreadybe using it.
   b) iSER is a standard name for this, so it won't be confusing to
     people used to dealing with iSCSI over RDMA
   c) You of course need to check on the libvirt lists how they want
     to expose the setting.

Dave

> Best Regards,
> Charles.
> 
> On Fri, Dec 8, 2017 at 2:07 PM, ronnie sahlberg <ronniesahlberg@gmail.com>
> wrote:
> 
> > David,
> >
> > Yes, QEMU has supported iSER (iSCSI extensions for RDMA) via a
> > userspace library, libiscsi, since about a year.
> > Here is a nice presentation from the developer of iSER support :
> > https://www.google.com.au/url?sa=t&rct=j&q=&esrc=s&source=
> > web&cd=1&cad=rja&uact=8&ved=0ahUKEwjChpba3PnXAhXBKZQKHQa9D
> > EYQFggpMAA&url=https%3A%2F%2Fwww.snia.org%2Fsites%2Fdefault%2Ffiles%2FSDC%
> > 2F2016%2Fpresentations%2Fstorage_networking%2FShterman-Grimberg_Greenberg_
> > Performance%2520Implications%2520Libiscsi_%2520RDMA_V6.pdf&usg=
> > AOvVaw3xyvdIciRKVprboN6rClTA
> >
> > In QEMU, you use it the same way as you would use the userspace iSCSI
> > support which has been in QEMU for quite a long time.
> > The only difference is that instead of providing a
> > iscsi://<host>/<iqn>/<lun> you select iSER by specifying an url of the
> > form
> > iser://<host>/<iqn>/<lun>
> >
> >
> > I.e. the only difference is the protocol part of the URL. When QEMU
> > passes this URL to libiscsi, it allows the library to decide on
> > whether to use normal iSCSI or whether it should use iSER.
> >
> > I think RDMA would be a less good name for this as RDMA is not only
> > used to transport iSCSI but is also used for NFS as well as SMB.
> >
> >
> >
> > regards
> > ronnie sahlberg
> >
> >
> > On Fri, Dec 8, 2017 at 4:41 AM, Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> > > * Charles Kelimod (lichstor@gmail.com) wrote:
> > >> Hello,
> > >>
> > >>
> > >> I'm on the road of modifying libvirt to add iSER support, and I found
> > qemu
> > >> is actually support that. But, the transport name is iSER, which should
> > be
> > >> RDMA and there libvirt already defined it.
> > >>
> > >> Best Regards,
> > >> Charles.
> > >
> > > Hi Charles,
> > >   So this is iSCSI extensions for RDMA?  I've cc'd in the qemu iSCSI
> > > maintainers.
> > >   Can you just explain what you're seeing libvirt do and what you think
> > > qemu is expecting it to do for iSER?
> > >
> > > Dave
> > >
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

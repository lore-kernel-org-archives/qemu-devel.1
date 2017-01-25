Received: from eggs.gnu.org ([2001:4830:134:3::10]:46155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zdai@linux.vnet.ibm.com>) id 1cWRfu-0001YC-2J
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zdai@linux.vnet.ibm.com>) id 1cWRfp-0007ab-5P
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:48:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zdai@linux.vnet.ibm.com>)
	id 1cWRfo-0007Zz-RS
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:47:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0PHdLe4145171
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 12:47:55 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 286xbreq4j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 12:47:54 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zdai@linux.vnet.ibm.com>;
	Wed, 25 Jan 2017 10:47:53 -0700
From: "David Z. Dai" <zdai@linux.vnet.ibm.com>
In-Reply-To: <20170124173619.GB28745@redhat.com>
References: <1485272673-5877-1-git-send-email-zdai@linux.vnet.ibm.com>
	<20170124173619.GB28745@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Jan 2017 11:47:45 -0600
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <1485366465.1515.19.camel@oc5348122405>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, zdai@us.ibm.com, mdroth@linux.vnet.ibm.com, quintela@redhat.com

On Tue, 2017-01-24 at 17:36 +0000, Daniel P. Berrange wrote:
> On Tue, Jan 24, 2017 at 09:44:33AM -0600, David Dai wrote:
> > Using libvirt to do live migration over RDMA via ip v6 address failed. 
> > For example:
> > # virsh migrate  --live --migrateuri rdma://[deba::2222]:49152  \
> >               rhel73_host1_guest1 qemu+ssh://[deba::2222]/system --verbose
> > root@deba::2222's password:
> > error: internal error: unable to execute QEMU command 'migrate': RDMA ERROR:  
> >                   could not rdma_getaddrinfo address deba
> > 
> > As we can see, the ip v6 address used by rdma_getaddrinfo() has only "deba" 
> > part. It should be "deba::2222".
> > 
> > 1) According to rfc 3986, a literal ip v6 address should be enclosed 
> > in '[' and ']'.
> > When using virsh command to do live migration via ip v6 addresss, user
> > will input the ip v6 address with brackets (i.e. rdma://[deba::2222]:49152).
> > libvirt will parse command line option by calling virURIParse(). 
> > Inside it calls virStringStripIPv6Brackets() to strip off the brackets.
> > The uri passed in to virURIParse()  is:
> >    "uri = rdma://[deba::2222]:49152"
> > Inside virURIParse() routine, it will strip off the bracket '[' and ']' if
> > it's ip v6 address. Then save the ip v6 address in this format "deba::2222" 
> > in the virURI->server field, and to be passed to qemu.
> > 
> > 2) At the beginning of migration, in qemu's qemu_rdma_data_init(host_port) 
> > routine, it calls inet_parse(host_port) routine to parse the ip v6 address and 
> > port string obtained from libvirt.
> > The input string host_port passed to qemu_rdma_data_init() can be:
> >     "hostname:port", or
> >     "ipv4address:port", or
> >     "[ipv6address]:port" (i.e "[deba::2222]:49152"), or
> >     "ipv6address:port" (i.e "deba::2222:49152").
> > Existing qemu api inet_parse() can handle the above first 3 cases properly,  
> > but didn't handle the last case ("ipv6address:port") correctly.
> > In this live migration over rdma via ip v6 address case, the server ip v6 
> > address obtained from libvirt doesn't contain the brackets '[' and ']' 
> > (i.e. "deba::2222:49152"). It caused inet_parse() to parse only "deba" part, 
> > and stopped at the 1st colon ':'. As the result, the subsequent 
> > rdma_getaddrinfo() with ip address "deba" will fail.
> > 
> > If we don't strip off brackets '[' and ']' for an ip v6 address in libvirt's 
> > virURIParse(), it will cause libvirt ipv6 ssh authentication failure.
> > 
> > NOTE:
> > If using libvirt to do live migration over TCP via ip v6 address:
> > # virsh migrate  --live --migrateuri tcp://[deba::2222]:49152  \
> >               rhel73_host1_guest1 qemu+ssh://[deba::2222]/system --verbose
> > It works fine.
> > In migrateuri of tcp case, libvirt will call virNetSocketNewConnectTCP()
> > directly to connect to remote "deba::2222:49152" after it strips off
> > the bracket '[' and ']' for an ip v6 address. 
> > On qemu side, fd_start_outgoing_migration() will be called to do migration.
> > It doesn't call inet_parse(). So we don't see issue in tcp case.
> > 
> > Solution:
> > I choose to fix the code in qemu's inet_parse() routine to parse the
> > ip v6 addresss w/o brackets properly (i.e. "deba::2222:49152" format).
> 
> That is not right - "deba::222:49152" is *not* a valid address. It
> is mandatory to use [] when providing a numeric IPv6 address. So
> there's nothing broken in QEMU here - libvirt needs fixing to pass
> correct data to QEMU
> 
> Regards,
> Daniel
Hi, Daniel:
   Just learned you are one of the libvirt maintainer from Dr. Gilbert.

   In Previous test, I changed libvirtd code in src/util/viruri.c file,
 virURIParse() routine to block
 "virStringStripIPv6Brackets(ret->server);" call. It caused ssh ipv6
authentication failure.
  
   You said libvirt needs to be changed to pass correct data to QEMU.
   
   As one of the solution on libvirt side: if I add this condition in
 virURIParse() routine:
+  if (strcmp(ret->scheme, "rdma")) {
        /* Strip square bracket from an IPv6 address.
         * The function modifies the string in-place. Even after such
         * modification, it is OK to free the URI with xmlFreeURI. */
        virStringStripIPv6Brackets(ret->server);
+  }

   Now both the virsh live migration with tcp and rdma via ipv6 address
work fine.
  
   Do you think this is the acceptable solution?

Thanks! - David Dai

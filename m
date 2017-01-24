Received: from eggs.gnu.org ([2001:4830:134:3::10]:44383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW51B-0000CG-SQ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW518-0006wo-38
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:36:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cW517-0006w5-Oi
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:36:26 -0500
Date: Tue, 24 Jan 2017 17:36:19 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124173619.GB28745@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1485272673-5877-1-git-send-email-zdai@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485272673-5877-1-git-send-email-zdai@linux.vnet.ibm.com>
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
To: David Dai <zdai@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, zdai@us.ibm.com, mdroth@linux.vnet.ibm.com, quintela@redhat.com

On Tue, Jan 24, 2017 at 09:44:33AM -0600, David Dai wrote:
> Using libvirt to do live migration over RDMA via ip v6 address failed. 
> For example:
> # virsh migrate  --live --migrateuri rdma://[deba::2222]:49152  \
>               rhel73_host1_guest1 qemu+ssh://[deba::2222]/system --verbose
> root@deba::2222's password:
> error: internal error: unable to execute QEMU command 'migrate': RDMA ERROR:  
>                   could not rdma_getaddrinfo address deba
> 
> As we can see, the ip v6 address used by rdma_getaddrinfo() has only "deba" 
> part. It should be "deba::2222".
> 
> 1) According to rfc 3986, a literal ip v6 address should be enclosed 
> in '[' and ']'.
> When using virsh command to do live migration via ip v6 addresss, user
> will input the ip v6 address with brackets (i.e. rdma://[deba::2222]:49152).
> libvirt will parse command line option by calling virURIParse(). 
> Inside it calls virStringStripIPv6Brackets() to strip off the brackets.
> The uri passed in to virURIParse()  is:
>    "uri = rdma://[deba::2222]:49152"
> Inside virURIParse() routine, it will strip off the bracket '[' and ']' if
> it's ip v6 address. Then save the ip v6 address in this format "deba::2222" 
> in the virURI->server field, and to be passed to qemu.
> 
> 2) At the beginning of migration, in qemu's qemu_rdma_data_init(host_port) 
> routine, it calls inet_parse(host_port) routine to parse the ip v6 address and 
> port string obtained from libvirt.
> The input string host_port passed to qemu_rdma_data_init() can be:
>     "hostname:port", or
>     "ipv4address:port", or
>     "[ipv6address]:port" (i.e "[deba::2222]:49152"), or
>     "ipv6address:port" (i.e "deba::2222:49152").
> Existing qemu api inet_parse() can handle the above first 3 cases properly,  
> but didn't handle the last case ("ipv6address:port") correctly.
> In this live migration over rdma via ip v6 address case, the server ip v6 
> address obtained from libvirt doesn't contain the brackets '[' and ']' 
> (i.e. "deba::2222:49152"). It caused inet_parse() to parse only "deba" part, 
> and stopped at the 1st colon ':'. As the result, the subsequent 
> rdma_getaddrinfo() with ip address "deba" will fail.
> 
> If we don't strip off brackets '[' and ']' for an ip v6 address in libvirt's 
> virURIParse(), it will cause libvirt ipv6 ssh authentication failure.
> 
> NOTE:
> If using libvirt to do live migration over TCP via ip v6 address:
> # virsh migrate  --live --migrateuri tcp://[deba::2222]:49152  \
>               rhel73_host1_guest1 qemu+ssh://[deba::2222]/system --verbose
> It works fine.
> In migrateuri of tcp case, libvirt will call virNetSocketNewConnectTCP()
> directly to connect to remote "deba::2222:49152" after it strips off
> the bracket '[' and ']' for an ip v6 address. 
> On qemu side, fd_start_outgoing_migration() will be called to do migration.
> It doesn't call inet_parse(). So we don't see issue in tcp case.
> 
> Solution:
> I choose to fix the code in qemu's inet_parse() routine to parse the
> ip v6 addresss w/o brackets properly (i.e. "deba::2222:49152" format).

That is not right - "deba::222:49152" is *not* a valid address. It
is mandatory to use [] when providing a numeric IPv6 address. So
there's nothing broken in QEMU here - libvirt needs fixing to pass
correct data to QEMU

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

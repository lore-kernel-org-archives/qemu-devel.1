Received: from eggs.gnu.org ([2001:4830:134:3::10]:41091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d3rEr-0007Dg-JI
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d3rEn-0003bk-Mk
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:46:13 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:48908)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d3rEn-0003aP-Fy
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:46:09 -0400
Date: Thu, 27 Apr 2017 15:21:26 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170427132126.lkdi5owqezvlp6o2@var.youpi.perso.aquilenet.fr>
References: <20170420204301.154912-1-lepton@google.com>
	<42f99074-9330-c974-e884-f0a62e63c697@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f99074-9330-c974-e884-f0a62e63c697@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: don't zero ti_i since we
 acccess it later.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Wu <ytht.net@gmail.com>, Tao Wu <lepton@google.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Hello,

Thomas Huth, on lun. 24 avril 2017 11:15:56 +0200, wrote:
> On 20.04.2017 22:43, Tao Wu wrote:
> > The current code looks buggy, we zero ti_i while we access
> > ti_dst/ti_src later.

Indeed.

> > Signed-off-by: Tao Wu <lepton@google.com>

> >  		*mtod(m, struct tcpiphdr *) = *ti;
> >  		ti = mtod(m, struct tcpiphdr *);
> > -		memset(&ti->ti, 0, sizeof(ti->ti));

But then we don't make sure that ih_x1 is 0, which is needed for the
checksum to be correct, but possibly not set by the caller.

So please replace the memset call with setting the proper ih_x1 field to
0 (which thus needs the introductino of a switch over af like below in
the code).

Samuel

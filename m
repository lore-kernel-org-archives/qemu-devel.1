Received: from eggs.gnu.org ([2001:4830:134:3::10]:44680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cxYFu-0000HG-1F
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cxYFq-0007dX-Sn
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:17:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cxYFq-0007d6-Ix
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:17:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3ACDpis101237
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 08:16:54 -0400
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29r8u8tub2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 08:16:54 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 10 Apr 2017 13:16:37 +0100
Date: Mon, 10 Apr 2017 14:16:29 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <ac949777-b259-f0b2-fc22-077dcbac8951@redhat.com>
References: <20170407111851.20680-1-cornelia.huck@de.ibm.com>
	<20170407111851.20680-2-cornelia.huck@de.ibm.com>
	<ac949777-b259-f0b2-fc22-077dcbac8951@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170410141629.2102a480.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/8] chardev: Basic support for
 TN3270
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, agraf@suse.de, borntraeger@de.ibm.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Yang Chen <bjcyang@linux.vnet.ibm.com>

On Fri, 7 Apr 2017 08:58:15 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 04/07/2017 06:18 AM, Cornelia Huck wrote:
> > From: Jing Liu <liujbjl@linux.vnet.ibm.com>
> > 
> > This introduces basic support for TN3270, which needs to negotiate
> > three Telnet options during handshake:
> >   - End of Record
> >   - Binary Transmission
> >   - Terminal-Type
> > 
> > As a basic implementation, this simply ignores NOP and Interrupt
> > Process(IP) commands. More work should be done for them later.
> > 
> > For more details, please refer to RFC 854 and 1576.
> > 
> > Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> > Signed-off-by: Yang Chen <bjcyang@linux.vnet.ibm.com>
> > Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> > Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> 
> > +++ b/qapi-schema.json
> > @@ -4874,6 +4874,8 @@
> >  # @nodelay: set TCP_NODELAY socket option (default: false)
> >  # @telnet: enable telnet protocol on server
> >  #          sockets (default: false)
> > +# @tn3270: enable tn3270 protocol on server
> > +#          sockets (default: false) (Since: 2.10)
> >  # @reconnect: For a client socket, if a socket is disconnected,
> >  #          then attempt a reconnect after the given number of seconds.
> >  #          Setting this to zero disables this function. (default: 0)
> > @@ -4887,6 +4889,7 @@
> >                                       '*wait'      : 'bool',
> >                                       '*nodelay'   : 'bool',
> >                                       '*telnet'    : 'bool',
> > +                                     '*tn3270'    : 'bool',
> >                                       '*reconnect' : 'int' },
> >    'base': 'ChardevCommon' }
> 
> I almost wonder if we should make this a flat union, so that members
> that only make sense with the server side (such as tn3270) or with the
> client side (reconnect) can only be present when that branch of the
> union is taken.  But that may break back-compat if we have existing code
> that silently ignores a member that makes no sense, and we start
> forcefully warning about the member being present.  

The existing mix of server and client side members is a bit
unfortunate, but I'm not sure it's worth spending effort on this.
Anyway, I'd defer that to the chardev maintainers :)

> At any rate, making
> such a change is not a prerequisite for this series.

Would be nice if this is fine as-is.

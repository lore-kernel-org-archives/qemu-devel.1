Received: from eggs.gnu.org ([2001:4830:134:3::10]:34073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0oFE-00027O-Eg
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0oFB-0003sP-Cj
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:58:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d0oFB-0003s6-43
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:57:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3JBsWFG049035
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 07:57:55 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29x74mh395-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 07:57:55 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 19 Apr 2017 12:57:52 +0100
Date: Wed, 19 Apr 2017 13:57:47 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170419115036.GK4019@redhat.com>
References: <1492621028-16280-1-git-send-email-lu.zhipeng@zte.com.cn>
	<20170419134147.458e4eb7.cornelia.huck@de.ibm.com>
	<20170419115036.GK4019@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170419135747.2b294d3e.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: add
 guest-network-get-interface-stat command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Wed, 19 Apr 2017 12:50:36 +0100
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Wed, Apr 19, 2017 at 01:41:47PM +0200, Cornelia Huck wrote:
> > On Thu, 20 Apr 2017 00:57:08 +0800
> > ZhiPeng Lu <lu.zhipeng@zte.com.cn> wrote:
> > 
> > > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > > index a02dbf2..60111dc 100644
> > > --- a/qga/qapi-schema.json
> > > +++ b/qga/qapi-schema.json
> > > @@ -1042,3 +1042,37 @@
> > >    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
> > >                 '*input-data': 'str', '*capture-output': 'bool' },
> > >    'returns': 'GuestExec' }
> > > +##
> > > +# @GuestNetworkInterfaceStat:
> > > +#
> > > +# @rx_bytes: received bytes of interface
> > > +#
> > > +# @rx_packets: received packets of interface
> > > +#
> > > +# @rx_errs: received error packets of interface
> > > +# @rx_drop: received drop packets of interface
> > > +#
> > > +# Since: 2.10
> > > +##
> > > +{ 'struct': 'GuestNetworkInterfaceStat',
> > > +  'data': {'rx_bytes': 'uint64',
> > > +            'rx_packets': 'uint64',
> > > +            'rx_errs': 'uint64',
> > > +            'rx_drop': 'uint64',
> > > +            'tx_bytes': 'uint64',
> > > +            'tx_packets': 'uint64',
> > > +            'tx_errs': 'uint64',
> > > +            'tx_drop': 'uint64'
> > > +           } }
> > > +##
> > > +# @guest-network-get-interface-stat:
> > > +#
> > > +# Get list of interface stat
> > > +#
> > > +# Returns: List of GuestNetworkInterfaceStat on success.
> > > +#
> > > +# Since: 2.10
> > > +##
> > > +{ 'command': 'guest-network-get-interface-stat',
> > > +  'data':    {'bus': 'int64', 'slot': 'int64', 'function': 'int64','netname':'str'},
> > > +  'returns': ['GuestNetworkInterfaceStat'] }
> > 
> > Disregarding the question whether this command should be added to the
> > guest agent (I'll leave that to others to discuss), I don't think it's
> > a good idea to enshrine pci identifiers here, as it means that we would
> > need to add a new interface for every non-pci network device.
> > 
> > Can you use a more general device identifier interface? It's fine to
> > only support pci for now (as that is likely your use case anyway), but
> > there should be a way to extend this in the future.
> 
> It would be better to match the identification approach uses for the
> existing guest-network-get-interfaces command, which is based on MAC
> address. Arguably the stats data could just be added to this existnig
> command instead of adding a new command.

Agreed, that sounds like a better choice.

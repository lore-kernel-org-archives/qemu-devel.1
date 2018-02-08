Received: from eggs.gnu.org ([2001:4830:134:3::10]:40456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejtx4-00080W-0O
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejtx0-0001v3-Sz
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:41:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ejtx0-0001ur-K3
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:41:50 -0500
Date: Thu, 8 Feb 2018 19:41:43 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180208214143.GF13981@localhost.localdomain>
References: <20180207175014.11157-1-lcapitulino@redhat.com>
	<20180207175014.11157-2-lcapitulino@redhat.com>
	<20180208195939.GJ13301@localhost.localdomain>
	<dab9dcff-619f-9c0f-0c8c-f6542b73ca88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dab9dcff-619f-9c0f-0c8c-f6542b73ca88@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, mihajlov@linux.vnet.ibm.com

On Thu, Feb 08, 2018 at 02:59:17PM -0600, Eric Blake wrote:
> On 02/08/2018 01:59 PM, Eduardo Habkost wrote:
> > On Wed, Feb 07, 2018 at 12:50:13PM -0500, Luiz Capitulino wrote:
> > > The query-cpus command has an extremely serious side effect:
> > > it always interrupt all running vCPUs so that they can run
> > > ioctl calls. This can cause a huge performance degradation for
> > > some workloads. And most of the information retrieved by the
> > > ioctl calls are not even used by query-cpus.
> > > 
> > > This commit introduces a replacement for query-cpus called
> > > query-cpus-fast, which has the following features:
> > > 
> 
> > > +# Notes: @halted is a transient state that changes frequently.  By the time the
> > > +#        data is sent to the client, the guest may no longer be halted.
> > > +##
> > > +{ 'struct': 'CpuInfo2',
> > > +  'data': {'cpu-index': 'int', '*halted': 'bool', 'qom-path': 'str',
> > > +           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
> > 
> > This will require duplicating struct fields every time we add a
> > new field to query-cpus-fast (e.g. how would VIktor's
> > CpuInfoS390State patch[1] look like if rebased on top of yours?).
> > 
> > One way to avoid that is to use CpuInfo for both, and make all
> > "slow"  fields optional.  Another option is to use QAPI
> > inheritance, but it could be a little complicated if unions are
> > involved?
> 
> Inheritance is better than optional fields for the sake of introspection
> learning which fields to expect.
> 
> Put the common fields to both interfaces in the base class, then have the
> slower (older) CpuInfo class extend the base class to add the additional
> fields.
> 
> Unions should be able to inherit just fine from structs (after all, a flat
> union requires a struct base); but if we need two layers of unions, we'll
> need to enhance QAPI code generation first.

If we can't do union-union inheritance yet, maybe we can work around it this
way:

# fields that are always returned by both query-cpus and query-cpus-fast
{ 'struct': 'BothCpuInfoBase',
  'data': {'cpu': 'int', 'qom_path': 'str', 'thread_id': 'int',
           '*props': 'CpuInstanceProperties' } }

# fields that are always returned by query-cpus
{ 'struct': 'CpuInfoBase',
  'base': 'BothCpuInfoBase',
  'data': {'current': 'bool', 'halted': 'bool', 'arch': 'CpuInfoArch' } }

# query-cpus return value
{ 'union': 'CpuInfo',
  'base': 'CpuInfoBase',
  'discriminator': 'arch',
  'data': { 'x86': 'CpuInfoX86',
            's390': 'CpuInfoS390',
            'sparc': 'CpuInfoSPARC',
            'ppc': 'CpuInfoPPC',
            'mips': 'CpuInfoMIPS',
            'tricore': 'CpuInfoTricore',
            'other': 'CpuInfoOther' } }

# fields that are always returned by query-cpus-fast
{ 'struct': 'FastCpuInfoBase',
  'base': 'BothCpuInfoBase',
  'data': { 'arch': 'CpuInfoArch' } }

# return value of query-cpus-fast
{ 'union': 'FastCpuInfo',
  'base': 'FastCpuInfoBase',
  'discriminator': 'arch',
  'data': { 'x86': 'CpuInfoOther',
            's390': 'FastCpuInfoS390',
            'sparc': 'CpuInfoOther',
            'ppc': 'CpuInfoOther',
            'mips': 'CpuInfoOther',
            'tricore': 'CpuInfoOther',
            'other': 'CpuInfoOther' } }

# fields returned by both query-cpus and query-cpus-fast on s390
{ 'struct': 'FastCpuInfoS390',
  'data': { 'fast_field': 'int' } }

# fields returned by query-cpus on s390
{ 'struct': 'CpuInfoS390',
  'base': 'FastCpuInfoS390',
  'data': { 'slow_field': 'int' } }

-- 
Eduardo

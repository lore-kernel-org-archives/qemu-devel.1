Received: from eggs.gnu.org ([2001:4830:134:3::10]:49801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fxaur-0005OU-4V
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fxaun-0007g0-3o
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:44:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fxaum-0007dv-QG
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:44:25 -0400
Date: Wed, 5 Sep 2018 13:44:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180905164422.GQ12698@habkost.net>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-4-git-send-email-robert.hu@linux.intel.com>
	<9e06fe89-2688-1e6e-16ec-d5e8cdc87ce4@redhat.com>
	<1536126475.15675.1.camel@linux.intel.com>
	<20180905141022.GM12698@habkost.net>
	<7273e550-8735-7524-f499-2e0710ed0619@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7273e550-8735-7524-f499-2e0710ed0619@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] Change other funcitons referring to
 feature_word_info[]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, robert.hu@intel.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com, Markus Armbruster <armbru@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

On Wed, Sep 05, 2018 at 10:32:33AM -0500, Eric Blake wrote:
> On 09/05/2018 09:10 AM, Eduardo Habkost wrote:
> > Question to the QAPI schema maintainers below:
> > 
> 
> > >   ##
> > > -{ 'struct': 'X86CPUFeatureWordInfo',
> > > -  'data': { 'cpuid-input-eax': 'int',
> > > -            '*cpuid-input-ecx': 'int',
> > > -            'cpuid-register': 'X86CPURegister32',
> > > +{ 'struct': 'X86CPUIDFeatureWordInfo',
> > > +  'data': { 'input-eax': 'int',
> > > +            '*input-ecx': 'int',
> > > +            'register': 'X86CPURegister32',
> > >               'features': 'int' } }
> 
> You are renaming the struct (which is not visible over the wire), as well as
> renaming members within the struct (which is visible, if this type appears
> on the wire).
> 
> However, 'grep FeatureWordInfo qapi/qapi-introspect.c' has no hits either
> before or after this patch (well, first you have to build with my
> currently-pending patch as part of Markus' pull request for this trick to
> work, https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg05968.html).
> Or, even without my patch, grepping for 'input-eax' has no hits as a member
> name in any struct.  Which means that there are no QMP commands currently
> exposing this struct over the wire.

There is one: qom-get.

> 
> > 
> > 
> > Question to the QAPI maintainers: is this really allowed?  With
> > this change, data that conforms to the new schema may not conform
> > to the old schema, because now the "input-eax" field will become
> > optional.
> 
> Yes, you can do whatever you want to QAPI structs that are not part of the
> QMP API, since they exist merely to make your C code easier.  You don't have
> to worry about backwards compatibility, because the only clients of such
> structs are being compiled at the same time as you make modifications to
> that struct.  Only once the struct appears in QMP introspection do you start
> having to worry about back-compat.  There, the rules are the struct names
> don't matter, but member names do; if the struct is used on input, then
> removing members is bad, adding mandatory members is bad, but adding
> optional members is okay (older clients don't know to pass in the new
> members, and may continue to pass in the member name you no longer want to
> use); if the struct is used on output, then removing non-optional members is
> bad, removing optional members is okay, and adding members is okay (clients
> are supposed to ignore unknown members, but may break if a previously
> mandatory member disappears).
> 
> > 
> > AFAICS, this will break the existing libvirt code: it will make
> > qemuMonitorJSONParseCPUx86Features() error out because it won't
> > find the "input-eax" field on all X86CPUFeatureWordInfo elements.
> 
> No, this change can't break libvirt, since I just proved there is no QMP
> command that libvirt could be using that either supplies an input member or
> expects an output member named "input-eax" in the first place.

I'm sure it will break libvirt.  libvirt uses
"qom-get path=<cpu-path> property=feature-words" to get
X86FeatureWordInfo data, and it expects the returned data to
have a "input-eax" field.

-- 
Eduardo

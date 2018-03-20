Received: from eggs.gnu.org ([2001:4830:134:3::10]:57755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eyLT7-0007sj-8d
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eyLT3-00043I-FT
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:54:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eyLT3-00042T-4m
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:54:37 -0400
Date: Tue, 20 Mar 2018 14:54:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180320175427.GU3417@localhost.localdomain>
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
	<1520888449-4352-3-git-send-email-babu.moger@amd.com>
	<20180316180006.GH28578@localhost.localdomain>
	<CY4PR12MB17686EB283987B8A5EDCF49295AB0@CY4PR12MB1768.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR12MB17686EB283987B8A5EDCF49295AB0@CY4PR12MB1768.namprd12.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD Processor
 Cache Information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "Hook, Gary" <Gary.Hook@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Mar 20, 2018 at 05:25:52PM +0000, Moger, Babu wrote:
> Hi Eduardo, Thanks for the comments. Please see the response inline.
> 
> > -----Original Message-----
> > From: Eduardo Habkost <ehabkost@redhat.com>
> > Sent: Friday, March 16, 2018 1:00 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: pbonzini@redhat.com; rth@twiddle.net; rkrcmar@redhat.com;
> > Lendacky, Thomas <Thomas.Lendacky@amd.com>; Singh, Brijesh
> > <brijesh.singh@amd.com>; kvm@vger.kernel.org; kash@tripleback.net;
> > mtosatti@redhat.com; Hook, Gary <Gary.Hook@amd.com>; qemu-
> > devel@nongnu.org
> > Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD
> > Processor Cache Information
> > 
> > On Mon, Mar 12, 2018 at 05:00:46PM -0400, Babu Moger wrote:
> > > From: Stanislav Lanci <pixo@polepetko.eu>
> > >
> > > Add information for cpuid 0x8000001D leaf. Populate cache topology
> > information
> > > for different cache types(Data Cache, Instruction Cache, L2 and L3)
> > supported
> > > by 0x8000001D leaf. Please refer Processor Programming Reference (PPR)
> > for AMD
> > > Family 17h Model for more details.
> > >
> > > Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > 
> > The new CPUID leaves don't seem to match the existing AMD cache
> > information
> > leaves.  Is this intentional?  Why?
> 
> It is not intentional. These values are from older family of processors. These values have changed from Family 14  or later.
> The latest one is Family 17. You can see the differences here.
>  https://support.amd.com/TechDocs/41131.pdf
> https://support.amd.com/TechDocs/55072_AMD_Family_15h_Models_70h-7Fh_BKDG.pdf
> https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf
> 
> Some of these are bugs in our code. For some we need to add checks for the family and correct these values.
> You understand the code much better than me. Correct me if I missed something. 
> 
> Note that older family of processors don't support topology extensions.  

If you want to make the cache size/topology look different
depending on the CPU model/options, this would require more work,
but it would be an interesting feature.

The "i386: Helpers to encode cache information consistently"
patch I sent last week might be a useful starting point for that.

If you plan to implement that, please keep in mind that existing
CPUID cache info needs to be kept on previous machine-types (this
is implemented by adding QOM properties that can be used to
enable the old behavior, and by setting them at
MachineClass::compat_props).

-- 
Eduardo

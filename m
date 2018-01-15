Received: from eggs.gnu.org ([2001:4830:134:3::10]:43520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eb5o3-0001ta-1h
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eb5ny-0008Q3-5h
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:32:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eb5nx-0008PZ-VG
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:32:06 -0500
Date: Mon, 15 Jan 2018 12:31:56 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180115143156.GO6646@localhost.localdomain>
References: <1515443797-10837-1-git-send-email-luwei.kang@intel.com>
	<20180112142252.GG6646@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E7630B@SHSMSX101.ccr.corp.intel.com>
	<97bf8d29-4009-6f61-f4bb-d128da5a4c9f@redhat.com>
	<20180115140455.GN6646@localhost.localdomain>
	<20180115142518.GN1602429@orkuz.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115142518.GN1602429@orkuz.home>
Subject: Re: [Qemu-devel] [PATCH RESEND v1 1/2] i386: Add Intel Processor
 Trace feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Kang, Luwei" <luwei.kang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, libvir-list@redhat.com

On Mon, Jan 15, 2018 at 03:25:18PM +0100, Jiri Denemark wrote:
> On Mon, Jan 15, 2018 at 12:04:55 -0200, Eduardo Habkost wrote:
> > CCing libvirt developers.
> ...
> > This case is slightly more problematic, however: the new feature
> > is actually migratable (under very controlled circumstances)
> > because of patch 2/2, but it is not migration-safe[1].  This
> > means libvirt shouldn't include it in "host-model" expansion
> > (which uses the query-cpu-model-expansion QMP command) until we
> > make the feature migration-safe.
> > 
> > For QEMU, this means the feature shouldn't be returned by
> > "query-cpu-model-expansion type=static model=max" (but it can be
> > returned by "query-cpu-model-expansion type=full model=max").
> > 
> > Jiri, it looks like libvirt uses type=full on
> > query-cpu-model-expansion on x86.  It needs to use
> > type=static[2], or it will have no way to find out if a feature
> > is migration-safe or not.
> ...
> > [2] It looks like libvirt uses type=full because it wants to get
> >     all QOM property aliases returned.  In this case, one
> >     solution for libvirt is to use:
> > 
> >     static_expansion = query_cpu_model_expansion(type=static, model)
> >     all_props = query_cpu_model_expansion(type=full, static_expansion)
> 
> This is exactly what libvirt is doing (with model = "host") ever since
> query-cpu-model-expansion support was implemented for x86.

Oh, now I see that the x86 code uses
QEMU_MONITOR_CPU_MODEL_EXPANSION_STATIC_FULL and not just
QEMU_MONITOR_CPU_MODEL_EXPANSION_FULL.  Nice!

-- 
Eduardo

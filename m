Received: from eggs.gnu.org ([2001:4830:134:3::10]:59429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fiQBK-0003jz-Vi
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 16:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fiQBH-0007Z2-Uo
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 16:14:46 -0400
Date: Wed, 25 Jul 2018 17:14:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180725201438.GG12380@localhost.localdomain>
References: <20180725091233.3300-1-david@redhat.com>
	<20180725170925.GE12380@localhost.localdomain>
	<a33a67eb-2fb6-31fd-f4ca-1d883a5a7b75@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a33a67eb-2fb6-31fd-f4ca-1d883a5a7b75@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpu_models: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Collin Walling <walling@linux.ibm.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>

On Wed, Jul 25, 2018 at 07:50:21PM +0200, David Hildenbrand wrote:
> On 25.07.2018 19:09, Eduardo Habkost wrote:
[...]
> >> +    if (local_err) {
> >> +        g_assert(kvm_enabled());
> >> +        error_report_err(local_err);
> >> +        /* fallback to unsupported CPU models */
> >> +        return;
> > 
> > What about moving this outside instance_init?
> 
> To which place for example? We at least have to copy the CPU model
> for each and every CPU instance (so we can modify it without side
> effects using properties).

To any code that will look at cpu->model.

You are wrapping an interface that needs to report errors
(kvm_s390_get_host_cpu_model()) behind an interface that is not
able to report errors (object_new()).  There's nothing that
requires you to do that, does it?  You are free to provide an API
that is actually able to report errors, instead of relying on
object_new() only.

But I understand that the QOM/qdev API doesn't make that job
easy.  On x86 we have X86CPU::max_features and
X86CPU::user_features because of that.

-- 
Eduardo

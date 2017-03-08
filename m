Received: from eggs.gnu.org ([2001:4830:134:3::10]:49098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1clZrR-0001HR-K6
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1clZrN-0006m0-LQ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:34:29 -0500
Received: from h2042504.stratoserver.net ([85.214.107.226]:34484)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1clZrN-0006le-Fd
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:34:25 -0500
References: <20170308001637.9838-1-git@kirschju.re>
	<a01a515b-4296-4f5f-0509-2227a68e6770@twiddle.net>
From: Julian Kirsch <git@kirschju.re>
Message-ID: <3d782dc6-4bff-fc63-5e61-e1c929351b35@kirschju.re>
Date: Wed, 8 Mar 2017 12:34:20 +0100
MIME-Version: 1.0
In-Reply-To: <a01a515b-4296-4f5f-0509-2227a68e6770@twiddle.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] X86/HMP: Expose x86 model specific
 registers via human monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 08.03.2017 04:09, Richard Henderson wrote:
> On 03/08/2017 11:16 AM, Julian Kirsch wrote:
>> For instance, many modern x86-64 operating systems maintain access to internal
>> data structures via the MSR_GSBASE/MSR_KERNELGSBASE MSRs. Giving
>> introspection utilities (such as a remotely attached gdb) a way of
>> accessing these registers improves analysis results drastically.
> 
> If this is just for gdb, then we should provide access via the normal gdbstub,
> plus appropriate xml files.  There are plenty of examples of this for other cpus.
> 
> 
> r~
> 

Hi Richard,

I considered adding this functionality to the gdbstub.
However, my understanding of this approach is that it would make the patch
dependent on a particular (newly added) xml file being present at the gdb client
side. The current solution avoids this by letting gdb clients simply use the
newly introduced commands by means of the "monitor" command already built into gdb.
While I appreciate that this is a bit hacky, I, on the other hand, cannot come
up with any good setting in which a normal user space gdb client might need
access to the MSRs except for the qemu one, such that adding a new xml file to
gdb just for this special use case might be difficult to communicate on the
gdb-devel list.
Another question arising in this context would also consider what and how many
MSRs the xml file(s) should contain, including the logic to provide distinct
architectural MSRs for 32 and 64 bit targets. I hope you can see this approach
incurring non-negligible planning overhead with the end result providing same or
even less functionality.
Nevertheless, I'd move the functionality over to the gdbstub and bug on
gdb-devel to include a new (minimal) xml file, if it was the only way to get an
according patch upstream in qemu.

Best,
Julian

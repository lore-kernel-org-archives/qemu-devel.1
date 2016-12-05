Received: from eggs.gnu.org ([2001:4830:134:3::10]:54655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cDwno-0003YW-8S
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cDwnj-0000Q0-7Z
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:11:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cDwni-0000PJ-TG
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:11:39 -0500
Date: Mon, 5 Dec 2016 15:11:35 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161205171135.GG13060@thinpad.lan.raisama.net>
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
	<d611cf93-06e4-edc1-8012-1501f3b883ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d611cf93-06e4-edc1-8012-1501f3b883ad@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/17] target-i386: Implement
 query-cpu-model-expansion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Dec 05, 2016 at 04:15:38PM +0100, David Hildenbrand wrote:
> Am 02.12.2016 um 22:17 schrieb Eduardo Habkost:
> > This series implements query-cpu-model-expansion on target-i386.
> > 
> > QAPI / interface changes
> > ------------------------
> > 
> > When implementing this, I have noticed that the "host" CPU model
> > in i386 includes some migration-unsafe features that can't be
> > translated to any migration-safe representation: "pmu", and
> > "host-cache-info".
> > 
> > To be able to handle the migration-unsafe features, I have
> > extended the query-cpu-model-expansion definition to be clear
> > about what happens to those features when the CPU model is
> > expanded (in short: static expansion removes them, full expansion
> > keeps them).
> 
> I think this makes sense. The important part is to really keep static
> expansion static :)
> 
> > 
> > I also added "static" and "migration-safe" fields to the return
> > value of query-cpu-model-expansion, so callers can know if the
> > the expanded representation is static and migration-safe.
> 
> Is static really needed? I can understand why migration-safe might be
> of interest, but can't see how "static" could help (I mean we have
> static expansion for this purpose). Do you have anything special in
> mind regarding exposing "static"?

I didn't have any specific use case in mind. My main worry is to
avoid letting management software make any assumptions about the
returned data. If we don't add an explicit "static" field, a
client might make some wrong assumptions just because some
conditions are known to be always true on existing
implementations. e.g.: a client could incorrectly assume that
"query-cpu-model-expansion type=full" of a migration-safe model
would always be static.


> 
> > 
> > Test code
> > ---------
> > 
> > I have added a Python test script for the feature, that will try
> > multiple combinations of the expansion operation, and see if the
> > returned data keeps matches some constratins.
> > 
> > The test script works with the s390x query-cpu-model-expansion
> > command, except that: 1) I couldn't test it with KVM; 2) qtest.py
> > error handling when QEMU refuses to run is unreliable (so the
> > script needs runnability information to be availble in TCG mode,
> > too, to skip not-runnable CPU models and avoid problems).
> 
> Everything except "host" should behave completely the same on s390x
> with or without KVM being active. So with !KVM tests we can already
> cover most of the interesting parts. Thanks for taking care of s390x.
> 
> > 
> > Future versions of the test script could run a arch-specific
> > CPUID-dump guest binary, and validate data seen by the guest
> > directly. While we don't do that, the script validates all QOM
> > properties on the CPU objects looking for unexpected changes. At
> > least in the case of x86, the QOM properties will include lots of
> > the CPUID data seen by the guest, giving us decent coverage.
> 
> Something like that would be cool. Unfortunately, e.g. on s390x some
> CPUID-like data (e.g. STFL(E) and SCP info) is only available from
> kernel space. So we can't simply run a user space script. However,
> something like a kernel module would be possible (or even something like the
> s390x pc-bios to simply read and dump the data).

I meant a kernel binary, above. On x86, there are existing test
cases on the autotest repository that run a very small kernel[1]
that simply dumps CPUID data to the serial console. We could
reuse it, or we could add a CPUID command to the qtest protocol.
I'm not sure what's the best solution.

We can try to use a similar approach on s390x to reuse code in
the test script, but we can add arch-specific code to it if
necessary.

[1] https://github.com/autotest/tp-qemu/tree/master/qemu/deps/cpuid/src

-- 
Eduardo

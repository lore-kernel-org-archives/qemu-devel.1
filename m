Received: from eggs.gnu.org ([2001:4830:134:3::10]:34392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cDuzd-0007wz-J4
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cDuzZ-0006ag-EX
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:15:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cDuzY-0006Ww-VE
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:15:45 -0500
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d611cf93-06e4-edc1-8012-1501f3b883ad@redhat.com>
Date: Mon, 5 Dec 2016 16:15:38 +0100
MIME-Version: 1.0
In-Reply-To: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>

Am 02.12.2016 um 22:17 schrieb Eduardo Habkost:
> This series implements query-cpu-model-expansion on target-i386.
>
> QAPI / interface changes
> ------------------------
>
> When implementing this, I have noticed that the "host" CPU model
> in i386 includes some migration-unsafe features that can't be
> translated to any migration-safe representation: "pmu", and
> "host-cache-info".
>
> To be able to handle the migration-unsafe features, I have
> extended the query-cpu-model-expansion definition to be clear
> about what happens to those features when the CPU model is
> expanded (in short: static expansion removes them, full expansion
> keeps them).

I think this makes sense. The important part is to really keep static 
expansion static :)

>
> I also added "static" and "migration-safe" fields to the return
> value of query-cpu-model-expansion, so callers can know if the
> the expanded representation is static and migration-safe.

Is static really needed? I can understand why migration-safe might be
of interest, but can't see how "static" could help (I mean we have
static expansion for this purpose). Do you have anything special in
mind regarding exposing "static"?

>
> Test code
> ---------
>
> I have added a Python test script for the feature, that will try
> multiple combinations of the expansion operation, and see if the
> returned data keeps matches some constratins.
>
> The test script works with the s390x query-cpu-model-expansion
> command, except that: 1) I couldn't test it with KVM; 2) qtest.py
> error handling when QEMU refuses to run is unreliable (so the
> script needs runnability information to be availble in TCG mode,
> too, to skip not-runnable CPU models and avoid problems).

Everything except "host" should behave completely the same on s390x
with or without KVM being active. So with !KVM tests we can already
cover most of the interesting parts. Thanks for taking care of s390x.

>
> Future versions of the test script could run a arch-specific
> CPUID-dump guest binary, and validate data seen by the guest
> directly. While we don't do that, the script validates all QOM
> properties on the CPU objects looking for unexpected changes. At
> least in the case of x86, the QOM properties will include lots of
> the CPUID data seen by the guest, giving us decent coverage.

Something like that would be cool. Unfortunately, e.g. on s390x some 
CPUID-like data (e.g. STFL(E) and SCP info) is only available from
kernel space. So we can't simply run a user space script. However,
something like a kernel module would be possible (or even something like 
the s390x pc-bios to simply read and dump the data).


-- 

David

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cKUwW-0001eG-OS
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cKUwT-0005ax-Nm
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:51:48 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:59479 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cKUwT-0005WX-BN
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:51:45 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148243173750.7321.8231977784466776952.stgit@fimbulvetr.bsc.es>
	<cf19ab2b-ef52-9fa3-dea8-662c4513379c@twiddle.net>
Date: Fri, 23 Dec 2016 19:51:33 +0100
In-Reply-To: <cf19ab2b-ef52-9fa3-dea8-662c4513379c@twiddle.net> (Richard
	Henderson's message of "Fri, 23 Dec 2016 10:05:53 -0800")
Message-ID: <87bmw24gy2.fsf@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/6] trace: [tcg] Optimize per-vCPU
 tracing states with separate TB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Richard Henderson writes:

> On 12/22/2016 10:35 AM, Llu=C3=ADs Vilanova wrote:
>> To handle both issues, this series replicates the shared physical TB cac=
he,
>> creating a separate physical TB cache for every combination of event sta=
tes
>> (those with the 'vcpu' and 'tcg' properties). Then, all vCPUs tracing th=
e same
>> events will use the same physical TB cache.

> Why do we need to "split the physical TB cache" as opposed to simply incl=
uding
> the trace state into the TB hash function?

Mmmm, that's an interesting alternative I did not consider. Are you aiming =
at
minimizing the changes, or do you also think it would be more efficient?

The dynamic tracing state would then be an arbitrarily long bitmap (defined=
 by
the number of events with the 'vcpu' property), so I'm not sure how to fit =
it
into the hashing function with minimal collisions (the bitmap is now limite=
d to
an unsigned long to use it as an index to the TB cache "matrix").

The other drawback I see is that then it would also take longer to compute =
the
hashing function, instead of the simpler array indexing. As a benefit, work=
loads
with a high frequency of TB-flushing operations might be a bit faster (there
would be a single QHT).

If someone can provide me the code for the modified hash lookup function to
account for the trace dstate bitmap contents, I will integrate it and measu=
re if
there is any important change in performance.


Cheers,
  Lluis

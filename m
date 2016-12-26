Received: from eggs.gnu.org ([2001:4830:134:3::10]:34641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLb92-0001p1-GT
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 14:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLb8z-0003dz-ES
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 14:41:16 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:32919 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLb8z-0003cU-3e
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 14:41:13 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148243173750.7321.8231977784466776952.stgit@fimbulvetr.bsc.es>
	<cf19ab2b-ef52-9fa3-dea8-662c4513379c@twiddle.net>
	<87bmw24gy2.fsf@fimbulvetr.bsc.es>
	<09280ca2-06f0-12f5-4217-0d9f79e4ee90@twiddle.net>
Date: Mon, 26 Dec 2016 20:41:07 +0100
In-Reply-To: <09280ca2-06f0-12f5-4217-0d9f79e4ee90@twiddle.net> (Richard
	Henderson's message of "Fri, 23 Dec 2016 12:09:24 -0800")
Message-ID: <87inq6wka4.fsf@fimbulvetr.bsc.es>
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

> On 12/23/2016 10:51 AM, Llu=C3=ADs Vilanova wrote:
>>> On 12/22/2016 10:35 AM, Llu=C3=ADs Vilanova wrote:
>>>> To handle both issues, this series replicates the shared physical TB c=
ache,
>>>> creating a separate physical TB cache for every combination of event s=
tates
>>>> (those with the 'vcpu' and 'tcg' properties). Then, all vCPUs tracing =
the same
>>>> events will use the same physical TB cache.
>>=20
>>> Why do we need to "split the physical TB cache" as opposed to simply in=
cluding
>>> the trace state into the TB hash function?
>>=20
>> Mmmm, that's an interesting alternative I did not consider. Are you aimi=
ng at
>> minimizing the changes, or do you also think it would be more efficient?

> I suspect that it will be more efficient.

I discovered that I ran my tests with "--enable-debug". Without it, the
performance changes for this series look within the noise range (great news!
guest code events are now for free), and the TB hash function approach shou=
ld
show the same type of results on the hot path:

* vanilla, statically disabled
real	0m2,259s
user	0m2,252s
sys	0m0,004s

* vanilla, statically enabled (overhead: 2.18x)
real	0m4,921s
user	0m4,912s
sys	0m0,008s

* multi-tb, statically disabled (overhead: 1.00x)
real	0m2,269s
user	0m2,248s
sys	0m0,020s

* multi-tb, statically enabled (overhead: 0.98x)
real	0m2,223s
user	0m2,204s
sys	0m0,016s


The only drawback I see with going for your proposal is the possibility of a
higher TB collision rate when users set vCPUs with different tracing states
(after all, my series has a separate QHT for each combination of tracing
states).


>> The dynamic tracing state would then be an arbitrarily long bitmap (defi=
ned by
>> the number of events with the 'vcpu' property), so I'm not sure how to f=
it it
>> into the hashing function with minimal collisions (the bitmap is now lim=
ited to
>> an unsigned long to use it as an index to the TB cache "matrix").

> You could consider that index a unique identifier for the tracing state, =
and
> then only compare and hash that integer.

Yes, I get that. I meant that the bitmap has a theoretically unbounded size=
. But
we can limit that to some arbitrary number to keep the hashing function fix=
ed
(in your example, you're using 32 bits, which should be enough).


>> The other drawback I see is that then it would also take longer to compu=
te the
>> hashing function, instead of the simpler array indexing. As a benefit, w=
orkloads
>> with a high frequency of TB-flushing operations might be a bit faster (t=
here
>> would be a single QHT).

> I don't see adding one more integer to the hashing function to be signifi=
cant
> at all.  Certainly not the 15% that you describe in your cover letter.

See results above.


>> If someone can provide me the code for the modified hash lookup function=
 to
>> account for the trace dstate bitmap contents, I will integrate it and me=
asure if
>> there is any important change in performance.

> Something like the following should do it.  There are two /* cpu->??? */
> markers that would need to be filled in.

Thanks for the code! If you think the TB hash function is a less invasive
change, then I'll send a new series with that.


> If you can reduce the tracing identifier to 8 bits, that would be excelle=
nt.
> I've been wanting to make some other changes to TB hashing, and that woul=
d fit
> in well with a second "flags" value.

With all the vCPU events I have in the queue, it should be on the order of =
16
bits. But we cannot shrink it down to 8 bits at compile time now, since we =
no
longer have a define with the number of vCPU events.


Cheers,
  Lluis

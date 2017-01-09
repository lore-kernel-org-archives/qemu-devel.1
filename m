Received: from eggs.gnu.org ([2001:4830:134:3::10]:43738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cQeYU-0002PE-4a
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 13:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cQeYP-0002gk-3d
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 13:20:26 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:36518)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cQeYO-0002cK-OL
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 13:20:21 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
	<148278449426.8988.2219094135462471980.stgit@fimbulvetr.bsc.es>
	<20170109163535.GJ30228@stefanha-x1.localdomain>
Date: Mon, 09 Jan 2017 19:20:07 +0100
In-Reply-To: <20170109163535.GJ30228@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 9 Jan 2017 16:35:35 +0000")
Message-ID: <87zij0jdt4.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/6] hypertrace: [*-user] Add QEMU-side
 proxy to "guest_hypertrace" event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>

Stefan Hajnoczi writes:

> On Mon, Dec 26, 2016 at 09:34:54PM +0100, Llu=C3=ADs Vilanova wrote:
>> +static void segv_handler(int signum, siginfo_t *siginfo, void *sigctxt)
>> +{
>> +    CPUState *vcpu =3D current_cpu;
>> +    void *control_0 =3D vcpu->hypertrace_control;
>> +    void *control_1 =3D vcpu->hypertrace_control + config.control_size =
/ 2;
>> +    void *control_2 =3D control_1 + config.control_size / 2;
>> +
>> +    if (control_0 <=3D siginfo->si_addr && siginfo->si_addr < control_1=
) {
>> +
>> +        /* 1st fault (guest will write cmd) */
>> +        assert(((unsigned long)siginfo->si_addr % sizeof(uint64_t)) =3D=
=3D 0);
>> +        swap_control(control_0, control_1);
>> +
>> +    } else if (control_1 <=3D siginfo->si_addr && siginfo->si_addr < co=
ntrol_2) {
>> +        size_t client =3D (siginfo->si_addr - control_1) / sizeof(uint6=
4_t);
>> +        uint64_t vcontrol =3D ((uint64_t *)control_0)[client];
>> +        uint64_t *data_ptr =3D &qemu_data[client * config.client_data_s=
ize];
>> +
>> +        /* 2nd fault (invoke) */
>> +        assert(((unsigned long)siginfo->si_addr % sizeof(uint64_t)) =3D=
=3D 0);
>> +        hypertrace_emit(current_cpu, vcontrol, data_ptr);
>> +        swap_control(control_1, control_0);

> A simpler and faster approach is to permanently mprotect just one region
> and load all arguments from data[] (including the first argument).  Then
> swapping isn't necessary.

I'm don't understand what you propose.

With a single protected region, you don't know when to restore protection o=
f it
so that later accesses will be detected too. That could be solved if we used
single-stepping (maybe that's what you meant):

* trap access
* unprotect memory region
* single-step guest
* read written data and emit event
* protect memory region again
* resume guest

If the single-stepping can be done without too much complexity, that'd be a
faster option, and that piece of code might be cleaner too.

We could only avoid the protect/unprotect sequence if we added target-speci=
fic
code to "skip" the failed instruction (assuming all useful writes go to the=
 data
channel), but I wanted to make all code target-agnostic.


Cheers,
  Lluis

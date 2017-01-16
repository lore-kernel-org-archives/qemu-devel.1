Received: from eggs.gnu.org ([2001:4830:134:3::10]:59766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cTAiy-0006K4-Ma
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cTAiv-0002OU-ED
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:05:40 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:34556)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cTAiu-0002Ny-Oa
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:05:37 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
	<148278449426.8988.2219094135462471980.stgit@fimbulvetr.bsc.es>
	<20170109154439.GF30228@stefanha-x1.localdomain>
Date: Mon, 16 Jan 2017 18:05:26 +0100
In-Reply-To: <20170109154439.GF30228@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 9 Jan 2017 15:44:39 +0000")
Message-ID: <87a8ardjft.fsf@ac.upc.edu>
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
Cc: qemu-devel@nongnu.org, Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>

Stefan Hajnoczi writes:

> On Mon, Dec 26, 2016 at 09:34:54PM +0100, Llu=C3=ADs Vilanova wrote:
>> @@ -847,6 +855,10 @@ int main(int argc, char **argv)
>> } else if (!strcmp(r, "trace")) {
>> g_free(trace_file);
>> trace_file =3D trace_opt_parse(optarg);
>> +        } else if (!strcmp(r, "hypertrace")) {
>> +            g_free(hypertrace_file);

> This variable hasn't been declared yet.  Perhaps it's in a later patch.
> Please reorder things to avoid the compilation error.

> Or was this supposed to be hypertrace_base?

It's hypertrace_base, yes.


>> +void hypertrace_init_config(struct hypertrace_config *config,
>> +                            unsigned int max_clients)
>> +{
>> +    config->max_clients =3D max_clients;
>> +    config->client_args =3D CONFIG_HYPERTRACE_ARGS;
>> +    config->client_data_size =3D config->client_args * sizeof(uint64_t);
>> +    config->control_size =3D QEMU_ALIGN_UP(
>> +        config->max_clients * sizeof(uint64_t), TARGET_PAGE_SIZE);

> This needs to be host page size aligned, too.  Otherwise protect will
> affect bytes beyond the end of the control region.

Ummm, so right. Although I think only host page alignment is required (ther=
e's
no soft TLB in user-mode, right?).


>> +static void init_channel(const char *base, const char *suffix, size_t s=
ize,
>> +                         char **path, int *fd, uint64_t **addr)
>> +{
>> +    *path =3D g_malloc(strlen(base) + strlen(suffix) + 1);
>> +    sprintf(*path, "%s%s", base, suffix);
>> +
>> +    *fd =3D open(*path, O_CREAT | O_EXCL | O_RDWR, S_IRUSR | S_IWUSR);
>> +    if (*fd =3D=3D -1) {
>> +        error_report("error: open(%s): %s", *path, strerror(errno));
>> +        abort();
>> +    }

> open() can fail for reasons outside QEMU's control.  This isn't an
> internal error.  Please exit cleanly instead of using abort(3).

By cleanly you mean exit with a non-zero code, right? It still is an error =
that
cannot be recovered.

Also, if this goes with exit() what about the abort()s I have added in other
places? (e.g., on a failed call to sigaction)


>> +void hypertrace_init(const char *base, unsigned int max_clients)
>> +{
>> +    struct sigaction sigint;
>> +    struct hypertrace_config *pconfig;
>> +
>> +    if (base =3D=3D NULL) {
>> +        return;
>> +    }
>> +
>> +    memset(&sigint, 0, sizeof(sigint));
>> +    sigint.sa_sigaction =3D fini_handler;
>> +    sigint.sa_flags =3D SA_SIGINFO | SA_RESTART;
>> +    if (sigaction(SIGINT, &sigint, NULL) !=3D 0) {
>> +        error_report("error: sigaction(SIGINT): %s", strerror(errno));
>> +        abort();
>> +    }
>> +    if (sigaction(SIGABRT, &sigint, NULL) !=3D 0) {
>> +        error_report("error: sigaction(SIGABRT): %s", strerror(errno));
>> +        abort();
>> +    }

> I don't know whether it's okay to set up signal handlers in user mode.

> Will this break guest code SIGINT/SIGABRT handling?

Yes, I should reflect the signal back to the guest.


>> +bool hypertrace_guest_mmap_check(int fd, unsigned long len,
>> +                                 unsigned long offset)
>> +{
>> +    struct stat s;
>> +    if (fstat(fd, &s) < 0) {
>> +        return true;

> Should this be return false?

>> +    }
>> +
>> +    if (s.st_dev !=3D control_fd_stat.st_dev ||
>> +        s.st_ino !=3D control_fd_stat.st_ino) {
>> +        return true;

> Here too.

Yes, that's so embarrassing.


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

> Please use uintptr_t instead of unsigned long.  It's more portable
> because it doesn't assume sizeof(void*) =3D=3D sizeof(unsigned long).  On
> Windows the 64-bit data model is LLP64, not LP64:
> https://en.wikipedia.org/wiki/64-bit_computing#64-bit_data_models

Got it.


>> +        swap_control(control_0, control_1);
>> +
>> +    } else if (control_1 <=3D siginfo->si_addr && siginfo->si_addr < co=
ntrol_2) {
>> +        size_t client =3D (siginfo->si_addr - control_1) / sizeof(uint6=
4_t);
>> +        uint64_t vcontrol =3D ((uint64_t *)control_0)[client];
>> +        uint64_t *data_ptr =3D &qemu_data[client * config.client_data_s=
ize];

> Is byte swapping required?

Ummmm, these are values passed to the trace emitter, so either is "correct".

But for the sake of people's sanity when looking at traces, it might be bet=
ter
to always swap to host endianness.


>> +
>> +        /* 2nd fault (invoke) */
>> +        assert(((unsigned long)siginfo->si_addr % sizeof(uint64_t)) =3D=
=3D 0);
>> +        hypertrace_emit(current_cpu, vcontrol, data_ptr);
>> +        swap_control(control_1, control_0);

> I don't understand how this scheme works for multi-threaded programs.
> If two threads are both writing at the same time can we miss events due
> to swap_control() changing mprotect?

Dang, with the version changes I forgot to add the per-client padding to pl=
ace
each on a separate page.


>> +
>> +    } else {
>> +        /* proxy to next handler */
>> +        if (segv_next.sa_sigaction !=3D NULL) {
>> +            segv_next.sa_sigaction(signum, siginfo, sigctxt);
>> +        } else if (segv_next.sa_handler !=3D NULL) {
>> +            segv_next.sa_handler(signum);
>> +        }

> Is there a case when no signal handler was installed (i.e. default
> action)?

Yes, before calling hypertrace_init() or if it is called without a
"hypertrace_base" argument set (i.e., the user has not enabled hypertrace i=
n the
command line).


Thanks,
  Lluis

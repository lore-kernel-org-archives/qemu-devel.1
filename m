Received: from eggs.gnu.org ([2001:4830:134:3::10]:49992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqfFR-0007El-Fs
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqfFO-0001lG-9L
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:20:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqfFO-0001l2-0I
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:20:14 -0400
References: <74f647b8-a890-6635-278a-ce55fbbb5537@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7cfc0f3b-2cd3-32b7-0274-90b2bcfc2efa@redhat.com>
Date: Wed, 22 Mar 2017 07:20:10 -0500
MIME-Version: 1.0
In-Reply-To: <74f647b8-a890-6635-278a-ce55fbbb5537@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SxDiJmhaHPkwtqcegm8GkvvvXrpgDd1nu"
Subject: Re: [Qemu-devel] [PATCH v3] qemu/thread: Add support for error
 reporting in qemu_thread_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Achilles Benetopoulos <abenetopoulos@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, quintela@redhat.com, armbru@redhat.com, crosthwaite.peter@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SxDiJmhaHPkwtqcegm8GkvvvXrpgDd1nu
From: Eric Blake <eblake@redhat.com>
To: Achilles Benetopoulos <abenetopoulos@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, quintela@redhat.com, armbru@redhat.com,
 crosthwaite.peter@gmail.com
Message-ID: <7cfc0f3b-2cd3-32b7-0274-90b2bcfc2efa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] qemu/thread: Add support for error
 reporting in qemu_thread_create
References: <74f647b8-a890-6635-278a-ce55fbbb5537@gmail.com>
In-Reply-To: <74f647b8-a890-6635-278a-ce55fbbb5537@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2017 04:00 PM, Achilles Benetopoulos wrote:
> Failure during thread creation in qemu_thread_create does not force
> the program to exit anymore, since that isn't always the desired
> behaviour. The caller of qemu_thread_create is responsible for the
> error handling.
>=20
> Signed-off-by: Achilles Benetopoulos <abenetopoulos@gmail.com>
> ---
>  cpus.c                      | 43 +++++++++++++++++++++++++++++++++++--=
------

When sending a new version, it's nice to summarize between the ---
separator and the diffstat what is different from the earlier version.


> +++ b/cpus.c
> @@ -1599,6 +1599,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>      char thread_name[VCPU_THREAD_NAME_SIZE];
>      static QemuCond *single_tcg_halt_cond;
>      static QemuThread *single_tcg_cpu_thread;
> +    Error *local_err =3D NULL;

We have a mix of 'err' and 'local_err'; if the shorter name makes it
easier to avoid 80-column lines, then that name might be worth using.

> =20
>      if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
>          cpu->thread =3D g_malloc0(sizeof(QemuThread));
> @@ -1612,14 +1613,25 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>                   cpu->cpu_index);
> =20
>              qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_=
thread_fn,
> -                               cpu, QEMU_THREAD_JOINABLE);
> +                    cpu, QEMU_THREAD_JOINABLE, &local_err);

The old indentation was correct, your change made it look wrong because
it is missing enough space.

> +
> +            if (local_err) {
> +                error_report_err(local_err);
> +                exit(1);
> +            }
> =20
>          } else {
>              /* share a single thread for all cpus with TCG */
>              snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG=
");
> +
>              qemu_thread_create(cpu->thread, thread_name,

Why the blank line addition?

> -                               qemu_tcg_rr_cpu_thread_fn,
> -                               cpu, QEMU_THREAD_JOINABLE);
> +                    qemu_tcg_rr_cpu_thread_fn, cpu, QEMU_THREAD_JOINAB=
LE,
> +                    &local_err);

Again, why are you changing correct indentation?  The
qemu_tc_rr_cpu_thread_fn line should not be touched.

> +
> +            if (local_err) {
> +                error_report_err(local_err);
> +                exit(1);
> +            }
> =20
>              single_tcg_halt_cond =3D cpu->halt_cond;
>              single_tcg_cpu_thread =3D cpu->thread;
> @@ -1640,6 +1652,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>  static void qemu_hax_start_vcpu(CPUState *cpu)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
> +    Error *local_err =3D NULL;
> =20
>      cpu->thread =3D g_malloc0(sizeof(QemuThread));
>      cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
> @@ -1648,7 +1661,11 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
>      snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
>               cpu->cpu_index);
>      qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_f=
n,
> -                       cpu, QEMU_THREAD_JOINABLE);
> +                           cpu, QEMU_THREAD_JOINABLE, &local_err);

Indentation is wrong, now in the opposite direction (too much space).


> @@ -342,13 +343,19 @@ static void pci_edu_realize(PCIDevice *pdev, Erro=
r **errp)
>  {
>      EduState *edu =3D DO_UPCAST(EduState, pdev, pdev);
>      uint8_t *pci_conf =3D pdev->config;
> +    Error *local_err =3D NULL;
> =20
>      timer_init_ms(&edu->dma_timer, QEMU_CLOCK_VIRTUAL, edu_dma_timer, =
edu);
> =20
>      qemu_mutex_init(&edu->thr_mutex);
>      qemu_cond_init(&edu->thr_cond);
>      qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
> -                       edu, QEMU_THREAD_JOINABLE);
> +                       edu, QEMU_THREAD_JOINABLE, &local_err);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }

Looking at code like this, I wonder if it would be easier to make
qemu_thread_create() return a value, rather than being void.  Then you
could write:

if (qemu_thread_create(..., errp) < 0) {
    return;
}

instead of having to futz around with local_err and error_propagate().


> +++ b/hw/usb/ccid-card-emulated.c
> @@ -34,6 +34,7 @@
> =20
>  #include "qemu/thread.h"
>  #include "sysemu/char.h"
> +#include "qapi/error.h"
>  #include "ccid.h"
> =20
>  #define DPRINTF(card, lvl, fmt, ...) \
> @@ -485,6 +486,7 @@ static int emulated_initfn(CCIDCardState *base)
>      EmulatedState *card =3D EMULATED_CCID_CARD(base);
>      VCardEmulError ret;
>      const EnumTable *ptable;
> +    Error *err =3D NULL, *local_err =3D NULL;

Huh? Why do you need two local error objects? One is generally sufficient=
=2E

> =20
>      QSIMPLEQ_INIT(&card->event_list);
>      QSIMPLEQ_INIT(&card->guest_apdu_list);
> @@ -541,9 +543,17 @@ static int emulated_initfn(CCIDCardState *base)
>          return -1;
>      }
>      qemu_thread_create(&card->event_thread_id, "ccid/event", event_thr=
ead,
> -                       card, QEMU_THREAD_JOINABLE);
> +                       card, QEMU_THREAD_JOINABLE, &err);
> +
>      qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu=
_thread,
> -                       card, QEMU_THREAD_JOINABLE);
> +                       card, QEMU_THREAD_JOINABLE, &local_err);
> +    error_propagate(&err, local_err);
> +
> +    if (err) {
> +        error_report_err(err);
> +        return -1;
> +    }


If you used the return value, you could write:

if (qemu_thread_create(..., &err) < 0 ||
    qemu_thread_create(..., &err) < 0) {
    error_report_err(err);
    return -1;
}

without needing the second object.

> +++ b/include/qemu/thread.h
> @@ -55,7 +55,7 @@ void qemu_event_destroy(QemuEvent *ev);
> =20
>  void qemu_thread_create(QemuThread *thread, const char *name,
>                          void *(*start_routine)(void *),
> -                        void *arg, int mode);
> +                        void *arg, int mode, Error **errp);

Hmm, we still haven't made it official recommended practice, but it's a
good idea to use 'git config diff.orderFile /path/to/file' in order to
hoist .h changes to the front of a diff (it makes diffs easier to review
when you see the interface change prior to the clients of the
interface).  I wish I had a better URL to point to on the topic, but
didn't want to spend time finding it in the mailing list archives at
this time.

> +++ b/iothread.c
> @@ -132,7 +132,14 @@ static void iothread_complete(UserCreatable *obj, =
Error **errp)
>      name =3D object_get_canonical_path_component(OBJECT(obj));
>      thread_name =3D g_strdup_printf("IO %s", name);
>      qemu_thread_create(&iothread->thread, thread_name, iothread_run,
> -                       iothread, QEMU_THREAD_JOINABLE);
> +                           iothread, QEMU_THREAD_JOINABLE, &local_erro=
r);

Indentation problems continue to be a theme. I'll quit pointing them
out, but expect that you'll fix all of theme.


> +++ b/migration/ram.c
> @@ -357,6 +357,7 @@ void migrate_compress_threads_join(void)
>  void migrate_compress_threads_create(void)
>  {
>      int i, thread_count;
> +    Error *err =3D NULL, *local_err =3D NULL;
> =20
>      if (!migrate_use_compression()) {
>          return;
> @@ -378,7 +379,16 @@ void migrate_compress_threads_create(void)
>          qemu_cond_init(&comp_param[i].cond);
>          qemu_thread_create(compress_threads + i, "compress",
>                             do_data_compress, comp_param + i,
> -                           QEMU_THREAD_JOINABLE);
> +                           QEMU_THREAD_JOINABLE, &local_err);
> +
> +        if (local_err) {
> +            error_propagate(&err, local_err);
> +            local_err =3D NULL;
> +        }
> +    }
> +
> +    if (err) {
> +        error_report_err(err);
>      }

Another place that looks weird with two error variables.

> +++ b/tests/iothread.c
> @@ -69,11 +69,18 @@ void iothread_join(IOThread *iothread)
>  IOThread *iothread_new(void)
>  {
>      IOThread *iothread =3D g_new0(IOThread, 1);
> +    Error *local_err =3D NULL;
> =20
>      qemu_mutex_init(&iothread->init_done_lock);
>      qemu_cond_init(&iothread->init_done_cond);
>      qemu_thread_create(&iothread->thread, NULL, iothread_run,
> -                       iothread, QEMU_THREAD_JOINABLE);
> +                       iothread, QEMU_THREAD_JOINABLE, &local_err);

In a test, you can just assert success, by using:

qemu_thread_create(..., &error_abort);

> +
> +    if (local_err) {
> +        error_report_err(local_err);
> +        /*what makes sense here as a return value?*/
> +        return NULL;

Doing that will get rid of this fishy comment.

> +++ b/tests/rcutorture.c
> @@ -64,6 +64,7 @@
>  #include "qemu/atomic.h"
>  #include "qemu/rcu.h"
>  #include "qemu/thread.h"
> +#include "qapi/error.h"
> =20
>  long long n_reads =3D 0LL;
>  long n_updates =3D 0L;
> @@ -85,12 +86,20 @@ static int n_threads;
> =20
>  static void create_thread(void *(*func)(void *))
>  {
> +    Error *local_err =3D NULL;
> +
>      if (n_threads >=3D NR_THREADS) {
>          fprintf(stderr, "Thread limit of %d exceeded!\n", NR_THREADS);=

>          exit(-1);
>      }
>      qemu_thread_create(&threads[n_threads], "test", func, &data[n_thre=
ads],
> -                       QEMU_THREAD_JOINABLE);
> +                       QEMU_THREAD_JOINABLE, &local_err);
> +
> +    if (local_err) {
> +        error_report_err(local_err);
> +        exit(1);

Again, in a test, if you're just going to exit anyway, then it's easier
to pass &error_abort to the original call, than it is to post-process
and report the error.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--SxDiJmhaHPkwtqcegm8GkvvvXrpgDd1nu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0mv6AAoJEKeha0olJ0NqOTMIAJvPgHbhFHCvnw/HA9j5YcD4
9oAu6CD0oV+1I+WuSySol9nVeAxbcQudBpaaYnFDwoAbi85jDMzqFD1PlvaNXUbB
GwN1YH586ThDPhOIfPGiLWHkArqNHspRGrYpMHR7ci3JsOrMRgzcr4OIw3JuXgIK
FQ10GUgJN90CUj8tbdOZ+R7Tm4/MKWAKUe4rL4Q/41Hu1FXNexCoxUVrZsQQgM4S
ErDyseexphDdHERXpfn/q6IECfVOHRBE120MhVUUjDnsb7huIamGLz+nAw3ozZsy
EyG2ZMpV0oozTlAwMqczL5lvdUrUHyCNgNzsd6xFJQnk1nYQHJWRMh6WAuvEsF4=
=CO9H
-----END PGP SIGNATURE-----

--SxDiJmhaHPkwtqcegm8GkvvvXrpgDd1nu--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciMRK-0007OJ-8k
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciMRJ-0001Pl-Cf
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:38:14 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciMRJ-0001PU-4D
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:38:13 -0500
Received: by mail-wr0-x233.google.com with SMTP id g10so53543887wrg.2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 06:38:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 14:37:51 +0000
Message-ID: <CAFEAcA8HOjCv1FniO6Zs_s75wHCru+c-PkAfbODcjYSqJZwX0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/17] KVM and cpu-exec patches for 2.9
 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2017 at 12:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit d992f2f1368ceb92e6bfd8efece174110f4236=
ff:
>
>   Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170226' =
into staging (2017-02-26 22:40:23 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f601681feff62113b526d4ad491af4a03aca825a:
>
>   qmp-events: fix GUEST_PANICKED description formatting (2017-02-27 13:31=
:25 +0100)
>
> v1->v2: add missing #ifdef KVM_HAVE_MCE_INJECTION
>
>         rebase over MTTCG pull request.  -icount is currently broken but
>         I'd like to preserve bisectability, so this pull request brings
>         in the icount patches through a merge commit.
>
> ----------------------------------------------------------------
> * kernel header update (requested by David and Vijay)
> * GuestPanicInformation fixups (Anton)
> * record/replay icount fixes (Pavel)
> * cpu-exec cleanup, unification of icount_decr with tcg_exit_req (me)
> * KVM_CAP_IMMEDIATE_EXIT support (me)
> * vmxcap update (me)

Build failures :-(

OSX:
/Users/pm215/src/qemu-for-merges/util/oslib-posix.c:634:35: error: use
of undeclared identifier 'SIGPOLL'
    } else if (info->ssi_signo =3D=3D SIGPOLL) {
                                  ^

There's no SIGPOLL on OSX, apparently (it is marked as obsolescent
in the POSIX spec). The sys/signal.h header only defines a SIGPOLL if
(defined(_POSIX_C_SOURCE) && !defined(_DARWIN_C_SOURCE)) (ie you
asked for the POSIX, the whole POSIX and nothing but the POSIX).
There is a SIGIO (which is defined if the exact opposite condition
is true).

PPC64, AArch64, ARM:

/home/pm215/qemu/kvm-all.c:1898:23: error: =E2=80=98pending_sigbus_addr=E2=
=80=99
defined but not used [-Werror=3Dunuse
d-variable]
 static __thread void *pending_sigbus_addr;
                       ^
/home/pm215/qemu/kvm-all.c:1899:21: error: =E2=80=98pending_sigbus_code=E2=
=80=99
defined but not used [-Werror=3Dunuse
d-variable]
 static __thread int pending_sigbus_code;
                     ^


Incidentally, trying to figure out which fields in a siginfo_t
should be valid is a losing game (though one we play elsewhere,
see host_to_target_siginfo_noswap() in linux-user), because
the si_code/signal doesn't actually tell you which fields are valid
given the existence of rt_sigqueueinfo(). (The kernel internally
is OK because it has the high 16 bits of si_code, but at least
for a real signal handler it doesn't tell userspace those high
bits, so userspace can't distinguish a spoofed si_code (which
has si_pid/si_uid) from a real one (has addr/band/timer/etc
depending on the code). Maybe signalfd() gives you the full
si_code; I haven't checked...

thanks
-- PMM

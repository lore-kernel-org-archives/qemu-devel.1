Received: from eggs.gnu.org ([2001:4830:134:3::10]:44940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOmQ-0003wl-7r
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOmN-0006Gb-DH
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:42:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWOmN-0006GH-4b
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:42:31 -0500
Date: Wed, 25 Jan 2017 14:42:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125144228.GQ10664@stefanha-x1.localdomain>
References: <20170124110151.937-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i13qRg9tmWEwo36p"
Content-Disposition: inline
In-Reply-To: <20170124110151.937-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Switch all subdirs over to modular
 trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>


--i13qRg9tmWEwo36p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 11:01:43AM +0000, Daniel P. Berrange wrote:
> This is the final part of my trace events refactoring.
>=20
> Previously we merged code that split trace-events up
> into one file per sub-directory. We also merged code
> to the code-generator that enables us to generate
> and use multiple independant sets of trace events.
>=20
> This is the final glue that makes use of these two
> earlier changes, so that we actually generate a
> separate trace.h & trace.c file per sub-directory.
>=20
> The result is that when adding a new trace event to
> a file, only files in that sub-directory get rebuilt.
> Theoretically the build is faster too, since each
> source file includes a much smaller trace.h that
> only contains probes relevant to it. In reality this
> speed benefit is probably marginal & lost in the noise.
>=20
> This patch series has massively changed since v2.
>=20
>  - It no longer modifies the Makefile.objs rules in each
>    sub-directory. A bit of magic in the top level
>    Makefile.objs file lets us generate all the needed
>    rules from one place
>=20
>  - It sticks with bare "trace.h" includes instead of adding
>    sub-dir prefix "hw/block/trace.h". To achieve this we
>    had to rename the trace.h to trace-root.h in the top
>    level directory to avoid ambiguity in places where a
>    file needs to include the top-level instead of local
>    trace.h
>=20
> Daniel P. Berrange (8):
>   make: move top level dir to end of include search path
>   trace: move hw/block/dataplane events to correct subdir
>   trace: move hw/xen events to correct subdir
>   trace: move hw/i386/xen events to correct subdir
>   trace: move setting of group name into Makefiles
>   trace: switch to modular code generation for sub-directories
>   trace: update docs to reflect new code generation approach
>   trace: improve error reporting when parsing simpletrace header
>=20
>  .gitignore                                |  22 +++--
>  Makefile                                  | 156 ++++++++++++++++++++++++=
++----
>  Makefile.objs                             |  99 ++++++++++---------
>  Makefile.target                           |  10 +-
>  aio-posix.c                               |   2 +-
>  balloon.c                                 |   2 +-
>  block.c                                   |   2 +-
>  blockdev-nbd.c                            |   1 -
>  blockdev.c                                |   2 +-
>  blockjob.c                                |   1 -
>  cpu-exec.c                                |   2 +-
>  dma-helpers.c                             |   2 +-
>  docs/tracing.txt                          |  55 ++++++++---
>  exec.c                                    |   2 +-
>  hw/block/dataplane/trace-events           |   6 ++
>  hw/block/trace-events                     |   5 -
>  hw/i386/trace-events                      |   7 --
>  hw/i386/xen/trace-events                  |   6 ++
>  hw/net/fsl_etsec/etsec.c                  |   1 -
>  hw/xen/trace-events                       |  13 +++
>  include/exec/cpu_ldst_template.h          |   2 +-
>  include/exec/cpu_ldst_useronly_template.h |   2 +-
>  include/hw/xen/xen_common.h               |   2 +-
>  include/trace.h                           |   6 --
>  ioport.c                                  |   2 +-
>  kvm-all.c                                 |   2 +-
>  memory.c                                  |   2 +-
>  monitor.c                                 |   2 +-
>  qom/cpu.c                                 |   2 +-
>  rules.mak                                 |  17 ++--
>  scripts/simpletrace.py                    |  10 +-
>  scripts/tracetool.py                      |  31 +++---
>  scripts/tracetool/backend/dtrace.py       |   7 +-
>  scripts/tracetool/backend/simple.py       |   1 -
>  scripts/tracetool/backend/ust.py          |   7 +-
>  scripts/tracetool/format/c.py             |   7 +-
>  scripts/tracetool/format/tcg_h.py         |   6 +-
>  scripts/tracetool/format/tcg_helper_c.py  |   6 +-
>  scripts/tracetool/format/ust_events_c.py  |   2 +-
>  scripts/tracetool/format/ust_events_h.py  |   7 +-
>  spice-qemu-char.c                         |   2 +-
>  tests/Makefile.include                    |   2 +-
>  thread-pool.c                             |   2 +-
>  trace-events                              |  10 --
>  trace/Makefile.objs                       |  93 ++----------------
>  trace/control-target.c                    |   2 +-
>  trace/control.c                           |   2 +-
>  trace/ftrace.c                            |   2 +-
>  trace/simple.c                            |   1 -
>  translate-all.c                           |   2 +-
>  vl.c                                      |   2 +-
>  xen-hvm.c                                 |   2 +-
>  xen-mapcache.c                            |   2 +-
>  53 files changed, 385 insertions(+), 258 deletions(-)
>  create mode 100644 hw/block/dataplane/trace-events
>  create mode 100644 hw/i386/xen/trace-events
>  create mode 100644 hw/xen/trace-events
>  delete mode 100644 include/trace.h

Looks good, I hope to merge v4.  Thanks for investigating all the
Makefile cruft needed to simplify this.

Stefan

--i13qRg9tmWEwo36p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiLlUAAoJEJykq7OBq3PI3WcH/0ZLkYZvSDlg6toi7p/z12tR
mIxMbuwDKBgHnKTosJK6fHygaUvWI341Fb7S8FfE4b8RwA220nTGyHLdX0fx0hoL
BtJsEsrnsaptt72X7DUbWrdBE77LxsxWBaVnFkF0MeiLv14iWzRZqcmhRcgwyOLD
wLX7T8vfgzugUDbMck5lXq5p32Chhdgow8vBQBgKpJxWTV5eYVxvSwU4mxHSYjUC
pYQsLnziMiEe5PEM8ftQI/zS44ayxC3fbmL4ABkFK2YtcboWDVLPzYBlCSA2z0OP
UYJDbLHMwDcJV7LFixAQ+srOdFnCWi5w4YqJT4s+TLmtsc5c8Z9qcMMXvzl4emo=
=41ZQ
-----END PGP SIGNATURE-----

--i13qRg9tmWEwo36p--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evkVe-0005xq-FH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evkVY-0001UH-4L
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:02:34 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:37312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evkVX-0001U3-U1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:02:28 -0400
Received: by mail-ot0-x235.google.com with SMTP id t2so19046068otj.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 07:02:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 14:02:06 +0000
Message-ID: <CAFEAcA9HLfz77eEHho+Vod=XSsvoNv10noFJjqoAd0=CXT-8dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/36] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 March 2018 at 18:35, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 6ceb1b51f05f9e1892d082960ed602dca7b669=
6e:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-pull-r=
equest' into staging (2018-03-12 16:14:37 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-12
>
> for you to fetch changes up to a083c533b5a17c77ef164acdbf30eedfa9681fc6:
>
>   qapi: add block latency histogram interface (2018-03-12 13:22:11 -0500)
>
> This builds and passes 'make check', so even though the OOB portion
> depends on chardev fixes that are still pending a pull request from
> Paolo, that dependence can only be observed at runtime by clients
> that use the new oob feature.  Given the timing of soft freeze, and
> the fact that the chardev fixes do not form a build dependency, I
> think it's okay if this pull request gets processed before Paolo's
> (but it's also okay if Paolo's goes in first).
>
> ----------------------------------------------------------------
> qapi patches for 2018-03-12, 2.12 softfreeze
>
> - Marc-Andr=C3=A9 Lureau: 0/4 qapi: generate a literal qobject for intros=
pection
> - Max Reitz: 0/7 block: Handle null backing link
> - Peter Xu: 00/23 QMP: out-of-band (OOB) execution support
> - Vladimir Sementsov-Ogievskiy: 0/2 block latency histogram
>

Hi; I'm afraid this failed some of my build tests:

x86/Linux and x86 OpenBSD, compile failure (probably gcc-version-dependent)=
:

/home/petmay01/linaro/qemu-for-merges/hw/i386/acpi-build.c: In
function =E2=80=98build_append_pci_bus_devices=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/i386/acpi-build.c:617:9:
error: =E2=80=98notify_method=E2=80=99 may be used uninitialized in this fu=
nction
[-Werror=3Dmaybe-uninitialized]
         aml_append(parent_scope, notify_method);
         ^
/home/petmay01/linaro/qemu-for-merges/hw/i386/acpi-build.c:510:16:
note: =E2=80=98notify_method=E2=80=99 was declared here
     Aml *dev, *notify_method, *method;
                ^
cc1: all warnings being treated as errors


on PPC64 Linux, FreeBSD x86, OpenBSD x86, aarch64 Linux hosts, test fails;
looks like the same assert but in different tests:

ppc64:
TEST: tests/qmp-test... (pid=3D48041)
  /alpha/qmp/protocol:                                                 OK
  /alpha/qmp/oob:                                                      OK
  /alpha/qmp/query-status:                                             OK
  /alpha/qmp/query-block:
qemu-system-alpha: /home/pm215/qemu/
chardev/char-io.c:91: io_watch_poll_finalize: Assertion `iwp->src =3D=3D
((void *)0)' failed.
Broken pipe
FAIL
GTester: last random seed: R02S3e793887202ca8b099adb20531a072e6
(pid=3D48057)

aarch64:
  /aarch64/qmp/query-qmp-schema:                                       OK
  /aarch64/qmp/query-version:                                          OK
  /aarch64/qmp/query-commands:
Assertion failed: (iwp->src =3D=3D NULL)
, function io_watch_poll_finalize, file /root/qemu/chardev/char-io.c, line =
91.
Broken pipe
FAIL
GTester: last random seed: R02Sbd982a1e1da0c16d183f7725739b58af
(pid=3D58277)

and the others are the same but in
/mips64/device/introspect/abstract-interfaces
/alpha/qmp/query-named-block-nodes

thanks
-- PMM

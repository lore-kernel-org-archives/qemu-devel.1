Received: from eggs.gnu.org ([2001:4830:134:3::10]:41489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZNIF-0006Ry-T1
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 16:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZNBJ-0001pQ-Jx
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 16:45:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:56826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gZNBJ-0001ox-Cd
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 16:45:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gZNBI-0003iB-2V
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 21:45:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EDB1D2E80CC
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 21:45:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Dec 2018 21:36:58 -0000
From: Eric Blake <1803872@bugs.launchpad.net>
Reply-To: Bug 1803872 <1803872@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154254872666.7803.12367996737502527787.malonedeb@wampee.canonical.com>
Message-Id: <5f619017-5a96-3679-a7e6-e2863018af61@redhat.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1803872] Re: [PATCH v3 4/5] migration: Use
 QEMU_NONSTRING for non NUL-terminated arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 12/18/18 11:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> GCC 8 added a -Wstringop-truncation warning:
> =

>    The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
>    bug 81117 is specifically intended to highlight likely unintended
>    uses of the strncpy function that truncate the terminating NUL
>    character from the source string.
> =

> This new warning leads to compilation failures:
> =

>      CC      migration/global_state.o
>    qemu/migration/global_state.c: In function 'global_state_store_running=
':
>    qemu/migration/global_state.c:45:5: error: 'strncpy' specified bound 1=
00 equals destination size [-Werror=3Dstringop-truncation]
>         strncpy((char *)global_state.runstate, state, sizeof(global_state=
.runstate));
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
>    make: *** [qemu/rules.mak:69: migration/global_state.o] Error 1
> =

> Use the QEMU_NONSTRING attribute, since this array is intended to store
> character arrays that do not necessarily contain a terminating NUL.

>   typedef struct {
>       uint32_t size;
> -    uint8_t runstate[100];
> +    uint8_t runstate[100] QEMU_NONSTRING;

Since 100 bytes for runstate[] is larger than any string possible in our =

current enum string values, could we instead add an assert that =

strlen(state) < sizeof(global_state.runstate), and then use strpadcpy() =

to make our intent obvious while still shutting up the compiler warning, =

but without having to deal with the fallout of marking runstate as a =

non-string?

-- =

Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1803872

Title:
  gcc 8.2 reports stringop-truncation when building qemu

Status in QEMU:
  New

Bug description:
  QEMU 3.0

  block/sheepdog.c: In function 'find_vdi_name':
  block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals dest=
ination size [-Werror=3Dstringop-truncation]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_V=
DI_TAG_LEN);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~

  If this is the intended behavior, please suppress the warning. For
  example:

  #pragma GCC diagnostic push
  #pragma GCC diagnostic ignored "-Wstringop-truncation"
  =C2=A0=C2=A0=C2=A0=C2=A0strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG=
_LEN);
  #pragma GCC diagnostic pop

  This also happens on other sources, for example hw/acpi/core.c, so
  another option is to suppress it globally on CFLAGS (-Wno-stringop-
  truncation)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1803872/+subscriptions

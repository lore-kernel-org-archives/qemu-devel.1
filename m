Received: from eggs.gnu.org ([209.51.188.92]:54682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gx5SE-0003gb-3U
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gx5SC-0000Ba-Is
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:41:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:52846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gx5SC-0008Oe-8l
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:41:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gx5Ry-0003yi-F1
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 70AC42E8029
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Feb 2019 07:32:57 -0000
From: Laurent Vivier <Laurent@vivier.eu>
Reply-To: Bug 1817239 <1817239@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155080581544.22842.8774442486795126526.malonedeb@wampee.canonical.com>
Message-Id: <5a86f68a-de14-b21c-01eb-174c802cc299@vivier.eu>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1817239] [NEW] add '--targets' option to
 qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 22/02/2019 04:31, Launchpad Bug Tracker wrote:
> I'd like to ask for the addition of option '--targets' to scripts/qemu-
> binfmt-conf.sh, in order to allow registering the interpreters for the
> given list of architectures only, instead of using all of the ones
> defined in qemu_target_list. The following is a possible patch that
> implements it:
> =

>   qemu-binfmt-conf.sh | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Please send your patch to the qemu-devel mailing list.

I think it's a good idea but we should homogenize "--debian" and =

"--systemd": remove the parameter from  "--systemd" to generate by =

default all the targets, and allow the user to provide a subset of the =

targets using the newly introduced "--target" parameter.

Thanks,
Laurent

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1817239

Title:
  add '--targets' option to qemu-binfmt-conf.sh

Status in QEMU:
  New

Bug description:
  I'd like to ask for the addition of option '--targets' to scripts
  /qemu-binfmt-conf.sh, in order to allow registering the interpreters
  for the given list of architectures only, instead of using all of the
  ones defined in qemu_target_list. The following is a possible patch
  that implements it:

   qemu-binfmt-conf.sh | 9 ++++++++-
   1 file changed, 8 insertions(+), 1 deletion(-)

  diff --git a/qemu-binfmt-conf.sh b/qemu-binfmt-conf.sh
  index b5a1674..be4a19b 100644
  --- a/qemu-binfmt-conf.sh
  +++ b/qemu-binfmt-conf.sh
  @@ -170,6 +170,7 @@ usage() {
   Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                              [--help][--credential yes|no][--exportdir PAT=
H]
                              [--persistent yes|no][--qemu-suffix SUFFIX]
  +                           [--targets TARGETS]

          Configure binfmt_misc to use qemu interpreter

  @@ -189,6 +190,8 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debia=
n][--systemd CPU]
          --persistent:  if yes, the interpreter is loaded when binfmt is
                         configured and remains in memory. All future uses
                         are cloned from the open file.
  +       --targets:     comma-separated list of targets. If provided, only
  +                      the targets in the list are registered.

       To import templates with update-binfmts, use :

  @@ -324,7 +327,7 @@ CREDENTIAL=3Dno
   PERSISTENT=3Dno
   QEMU_SUFFIX=3D""

  -options=3D$(getopt -o ds:Q:S:e:hc:p: -l debian,systemd:,qemu-path:,qemu-=
suffix:,exportdir:,help,credential:,persistent: -- "$@")
  +options=3D$(getopt -o ds:Q:S:e:hc:p:t: -l debian,systemd:,qemu-path:,qem=
u-suffix:,exportdir:,help,credential:,persistent:,targets: -- "$@")
   eval set -- "$options"

   while true ; do
  @@ -380,6 +383,10 @@ while true ; do
           shift
           PERSISTENT=3D"$1"
           ;;
  +    -t|--targets)
  +        shift
  +        qemu_target_list=3D"$(echo "$1" | tr ',' ' ')"
  +        ;;
       *)
           break
           ;;
  --
  2.20.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1817239/+subscriptions

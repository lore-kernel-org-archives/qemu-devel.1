Received: from eggs.gnu.org ([2001:4830:134:3::10]:51211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBJVu-0008I6-7p
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBJVp-0007m7-Pp
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:27:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fBJVp-0007lP-LB
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:27:05 -0400
References: <152460739715.2265.8996313982715372139@71c20359a636>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9ffb6634-3480-4ad8-1c9b-e1caa8425628@redhat.com>
Date: Wed, 25 Apr 2018 14:26:44 +0200
MIME-Version: 1.0
In-Reply-To: <152460739715.2265.8996313982715372139@71c20359a636>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] qapi: introduce the SysEmuTarget
 enumeration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, riku.voipio@iki.fi, crosthwaite.peter@gmail.com, sagark@eecs.berkeley.edu, kchamart@redhat.com, kbastian@mail.uni-paderborn.de, palmer@sifive.com, laurent@vivier.eu, armbru@redhat.com, mjc@sifive.com, kraxel@redhat.com, pbonzini@redhat.com, thuth@redhat.com, dgibson@redhat.com, rth@twiddle.net

On 04/25/18 00:03, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.

[snip]

> qapi/qapi-types-misc.h:654:20: error: expected identifier or '(' before numeric constant
>          CpuInfoX86 i386;
>                     ^
> qapi/qapi-types-misc.h:749:22: error: expected identifier or '(' before numeric constant
>          CpuInfoOther i386;
>                       ^
> make: *** [/tmp/qemu-test/src/rules.mak:66: qapi/qapi-types-misc.o] Error 1
> make: *** Waiting for unfinished jobs....
> qapi/qapi-types-misc.h:654:20: error: expected identifier or '(' before numeric constant
>          CpuInfoX86 i386;
>                     ^
> qapi/qapi-types-misc.h:749:22: error: expected identifier or '(' before numeric constant
>          CpuInfoOther i386;
>                       ^
> make: *** [/tmp/qemu-test/src/rules.mak:66: qapi/qapi-types.o] Error 1
> qapi/qapi-types-misc.h:654:20: error: expected identifier or '(' before numeric constant
>          CpuInfoX86 i386;
>                     ^
> qapi/qapi-types-misc.h:749:22: error: expected identifier or '(' before numeric constant
>          CpuInfoOther i386;
>                       ^

Wow, is "i386" a macro on mingw, one that expands to a number? That is
incredibly st...range.

I do need this enum constant to be "i386" in the QAPI schema, because
that's what TARGET_NAME will map to.

Can I let the generator use the "q_" prefix here somehow?

Hmm, I think that trick is already happening for "sparc":

    641 struct CpuInfo {
    642     /* Members inherited from CpuInfoBase: */
    643     char *qom_path;
    644     int64_t thread_id;
    645     bool has_props;
    646     CpuInstanceProperties *props;
    647     CpuInfoArch arch;
    648     int64_t CPU;
    649     bool current;
    650     bool halted;
    651     SysEmuTarget target;
    652     /* Own members: */
    653     union { /* union tag is @target */
    654         CpuInfoX86 i386;
    655         CpuInfoX86 x86_64;
    656         CpuInfoSPARC q_sparc;    <----------------- here

Alright, I'll add "i386" to "polluted_words" in "scripts/qapi/common.py".

Sigh, what else is there already... I see Eric's commit 86ae191163d4 :(

Laszlo

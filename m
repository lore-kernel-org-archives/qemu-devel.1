Received: from eggs.gnu.org ([2001:4830:134:3::10]:33144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW2HY-0006T2-TG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW2HX-0001uO-GH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:13:28 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW2HX-0001ts-9S
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:13:27 -0400
Received: by mail-wr0-x22a.google.com with SMTP id v60so2628636wrc.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 08:13:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170714061521.28300-1-david@gibson.dropbear.id.au>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 16:13:05 +0100
Message-ID: <CAFEAcA8kQF3xS6=uQiXf6FSbP56xmStPN9SoqWy1cmzMFFUpOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/18] ppc-for-2.10 queue 20170714
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, sbobroff@au1.ibm.com, Laurent Vivier <lvivier@redhat.com>

On 14 July 2017 at 07:15, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 49bcce4b9c11759678fd223aefb48691c4959d=
4f:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-12'=
 into staging (2017-07-13 16:56:06 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170714
>
> for you to fetch changes up to e11134d2ac7744569d7c387102368c507d340c30:
>
>   pseries: Allow HPT resizing with KVM (2017-07-14 09:28:30 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-07-14
>
> Two major batches in this set, rather than the usual collection of
> assorted fixes.
>
>     * More DRC cleanup.  This gets the state management into a state
>       which should fix many of the hotplug+migration problems we've
>       had.  Plus it gets the migration stream format into something
>       well defined and pretty minimal which we can reasonably support
>       into the future.
>
>     * Hashed Page Table resizing.  It's been a while since this was
>       posted, but it's been through several previous rounds of review.
>       The kernel parts (both guest and host) are merged in 4.11, so
>       this is the only remaining piece left to allow resizing of the
>       HPT in a running guest.
>
> There are also a handful of unrelated fixes.

Hi. I'm afraid this fails to build on the w32 compiler:
  CC      ppc64-softmmu/hw/ppc/spapr.o
/home/petmay01/linaro/qemu-for-merges/hw/ppc/spapr.c: In function
=E2=80=98spapr_get_resize_hpt=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/ppc/spapr.c:2642:1: error:
control reaches end of non-void functio
n [-Werror=3Dreturn-type]
 }
 ^

The compiler is confused (it doesn't realise that "assert(0)"
cannot return), but you can make it happier like this:

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 09b6ff0..68f936c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2638,7 +2638,7 @@ static char *spapr_get_resize_hpt(Object *obj,
Error **errp)
     case SPAPR_RESIZE_HPT_REQUIRED:
         return g_strdup("required");
     }
-    assert(0);
+    g_assert_not_reached();
 }

 static void spapr_set_resize_hpt(Object *obj, const char *value, Error **e=
rrp)


I think g_assert_not_reached() is easier to read anyway; I
always have to think for a moment about whether assert(0)
or assert(1) is the "always assert" condition...

thanks
-- PMM

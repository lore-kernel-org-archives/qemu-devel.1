Received: from eggs.gnu.org ([2001:4830:134:3::10]:46958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFhhy-0007OT-1I
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFhht-00083Q-RV
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:01:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dFhht-000839-JF
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:01:09 -0400
Date: Tue, 30 May 2017 11:01:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170530140103.GI32274@thinpad.lan.raisama.net>
References: <20170511191843.13784-1-ehabkost@redhat.com>
	<20170511191843.13784-3-ehabkost@redhat.com>
	<CAFEAcA-jdbDL1uuhM5W=b4qisPsvpJz7aciR8WQebVy43QuBKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-jdbDL1uuhM5W=b4qisPsvpJz7aciR8WQebVy43QuBKQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 02/29] numa: Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, He Chen <he.chen@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, May 30, 2017 at 11:45:55AM +0100, Peter Maydell wrote:
> On 11 May 2017 at 20:18, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > From: He Chen <he.chen@linux.intel.com>
> >
> > This patch is going to add SLIT table support in QEMU, and provides
> > additional option `dist` for command `-numa` to allow user set vNUMA
> > distance by QEMU command.
> 
> > Signed-off-by: He Chen <he.chen@linux.intel.com>
> > Message-Id: <1493260558-20728-1-git-send-email-he.chen@linux.intel.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Hi all; I'm afraid this patch breaks compilation on OSX:

It looks like this wasn't detected by travis-ci because the build
is not using -Werror:
https://travis-ci.org/ehabkost/qemu/jobs/236485778#L3881

> 
> > +static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
> > +{
> > +    uint16_t src = dist->src;
> > +    uint16_t dst = dist->dst;
> > +    uint8_t val = dist->val;
> > +
> > +    if (src >= MAX_NODES || dst >= MAX_NODES) {
> > +        error_setg(errp,
> > +                   "Invalid node %" PRIu16
> > +                   ", max possible could be %" PRIu16,
> > +                   MAX(src, dst), MAX_NODES);
> > +        return;
> > +    }
> 
> /Users/pm215/src/qemu-for-merges/numa.c:236:20: error: format
> specifies type 'unsigned short' but the argument has type 'int'
> [-Werror,-Wformat]
>                    MAX(src, dst), MAX_NODES);
> ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/qapi/error.h:163:35: note:
> expanded from macro 'error_setg'
>                         (fmt), ## __VA_ARGS__)
>                                   ^
> /sw/include/glib-2.0/glib/gmacros.h:192:20: note: expanded from macro 'MAX'
> #define MAX(a, b)  (((a) > (b)) ? (a) : (b))
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/numa.c:236:35: error: format
> specifies type 'unsigned short' but the argument has type 'int'
> [-Werror,-Wformat]
>                    MAX(src, dst), MAX_NODES);
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/qapi/error.h:163:35: note:
> expanded from macro 'error_setg'
>                         (fmt), ## __VA_ARGS__)
>                                   ^
> /Users/pm215/src/qemu-for-merges/include/sysemu/sysemu.h:165:19: note:
> expanded from macro 'MAX_NODES'
> #define MAX_NODES 128
>                   ^~~
> 
> The OSX compiler is pickier about format strings than gcc,
> and neither "MAX_NODES" nor "MAX(anything)" are uint16_t type.

src and dst are both uint16_t, so MAX(src, dst) is also uint16_t,
isn't it?  It looks like MAX_NODES is the problem.

I'm still waiting for travis-ci build[1], could you confirm if
the following patch fixes the issue?

[1] https://travis-ci.org/ehabkost/qemu-hacks/jobs/237526829

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/numa.c b/numa.c
index ca731455e9..df62b55a00 100644
--- a/numa.c
+++ b/numa.c
@@ -232,7 +232,7 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
     if (src >= MAX_NODES || dst >= MAX_NODES) {
         error_setg(errp,
                    "Invalid node %" PRIu16
-                   ", max possible could be %" PRIu16,
+                   ", max possible could be %d",
                    MAX(src, dst), MAX_NODES);
         return;
     }
-- 
2.11.0.259.g40922b1


-- 
Eduardo

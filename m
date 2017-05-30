Received: from eggs.gnu.org ([2001:4830:134:3::10]:32973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFefK-000316-Dg
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFefJ-0003tU-6N
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:46:18 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFefJ-0003tM-0g
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:46:17 -0400
Received: by mail-wm0-x230.google.com with SMTP id b84so86899505wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 03:46:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170511191843.13784-3-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
	<20170511191843.13784-3-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 11:45:55 +0100
Message-ID: <CAFEAcA-jdbDL1uuhM5W=b4qisPsvpJz7aciR8WQebVy43QuBKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, He Chen <he.chen@linux.intel.com>

On 11 May 2017 at 20:18, Eduardo Habkost <ehabkost@redhat.com> wrote:
> From: He Chen <he.chen@linux.intel.com>
>
> This patch is going to add SLIT table support in QEMU, and provides
> additional option `dist` for command `-numa` to allow user set vNUMA
> distance by QEMU command.

> Signed-off-by: He Chen <he.chen@linux.intel.com>
> Message-Id: <1493260558-20728-1-git-send-email-he.chen@linux.intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Hi all; I'm afraid this patch breaks compilation on OSX:

> +static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
> +{
> +    uint16_t src = dist->src;
> +    uint16_t dst = dist->dst;
> +    uint8_t val = dist->val;
> +
> +    if (src >= MAX_NODES || dst >= MAX_NODES) {
> +        error_setg(errp,
> +                   "Invalid node %" PRIu16
> +                   ", max possible could be %" PRIu16,
> +                   MAX(src, dst), MAX_NODES);
> +        return;
> +    }

/Users/pm215/src/qemu-for-merges/numa.c:236:20: error: format
specifies type 'unsigned short' but the argument has type 'int'
[-Werror,-Wformat]
                   MAX(src, dst), MAX_NODES);
~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/include/qapi/error.h:163:35: note:
expanded from macro 'error_setg'
                        (fmt), ## __VA_ARGS__)
                                  ^
/sw/include/glib-2.0/glib/gmacros.h:192:20: note: expanded from macro 'MAX'
#define MAX(a, b)  (((a) > (b)) ? (a) : (b))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/numa.c:236:35: error: format
specifies type 'unsigned short' but the argument has type 'int'
[-Werror,-Wformat]
                   MAX(src, dst), MAX_NODES);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
/Users/pm215/src/qemu-for-merges/include/qapi/error.h:163:35: note:
expanded from macro 'error_setg'
                        (fmt), ## __VA_ARGS__)
                                  ^
/Users/pm215/src/qemu-for-merges/include/sysemu/sysemu.h:165:19: note:
expanded from macro 'MAX_NODES'
#define MAX_NODES 128
                  ^~~

The OSX compiler is pickier about format strings than gcc,
and neither "MAX_NODES" nor "MAX(anything)" are uint16_t type.

thanks
-- PMM

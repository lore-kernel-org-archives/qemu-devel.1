Received: from eggs.gnu.org ([2001:4830:134:3::10]:48780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNOg7-0008LF-8Z
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 15:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNOg3-0003zy-4t
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 15:55:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNOg2-0003zD-RT
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 15:55:50 -0500
References: <cover.1542301855.git.xiezhide@huawei.com>
	<0fcad1d4a27bcf9066d3349e8f1a8af6dfe3bb6e.1542301855.git.xiezhide@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <078c1065-1e36-5f70-92f0-044b0d4daefe@redhat.com>
Date: Thu, 15 Nov 2018 14:55:46 -0600
MIME-Version: 1.0
In-Reply-To: <0fcad1d4a27bcf9066d3349e8f1a8af6dfe3bb6e.1542301855.git.xiezhide@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/4] fsdev-throttle-qmp: factor out
 throttle code to reuse code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiezhide <xiezhide@huawei.com>, qemu-devel@nongnu.org
Cc: groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, armbru@redhat.com, berto@igalia.com, zengcanfu@huawei.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

On 11/15/18 2:54 AM, xiezhide wrote:
> This patch factor out throttle parameter parse code to common function

s/factor/factors/

Actually, when I write commit messages, I like to use the imperative 
mood, with an implicit "Apply this patch in order to" unspoken prefix. 
Starting with an explicit "This patch does" is more of a descriptive 
mood. So I might have written:

Factor out the throttle parameter parsing code to a new common function 
which will be used by block and fsdev.

> which will be used by block and fsdev.
> rename function throttle_parse_options to throttle_parse_group to resolve
> function name conflict
> 
> Signed-off-by: xiezhide <xiezhide@huawei.com>
> ---
>   block/throttle.c                |  6 ++--
>   blockdev.c                      | 43 +-------------------------
>   fsdev/qemu-fsdev-throttle.c     | 44 ++------------------------
>   include/qemu/throttle-options.h |  2 ++
>   include/qemu/throttle.h         |  4 +--
>   include/qemu/typedefs.h         |  1 +
>   util/throttle.c                 | 68 +++++++++++++++++++++++++++++++++++++++++
>   7 files changed, 79 insertions(+), 89 deletions(-)
> 
> +++ b/include/qemu/throttle-options.h
> @@ -111,4 +111,6 @@
>               .help = "when limiting by iops max size of an I/O in bytes",\
>           }
>   
> +void throttle_parse_options(ThrottleConfig *, QemuOpts *);

It's okay to use parameter names in function declarations.

> +++ b/include/qemu/typedefs.h
> @@ -113,6 +113,7 @@ typedef struct uWireSlave uWireSlave;
>   typedef struct VirtIODevice VirtIODevice;
>   typedef struct Visitor Visitor;
>   typedef struct node_info NodeInfo;
> +typedef struct ThrottleConfig ThrottleConfig;

Please keep this in the right sorted location, right after SSIBus.

[Hmm, we already have an inconsistency on whether we are sorting by 
en_US rules, which are case-insensitive and therefore has 'struct 
node_info' in the wrong location, or by C rules which sort lowercase 
later and therefore has 'struct uWireSlave' in the wrong position. For 
that matter, why are we renaming 'struct node_info NodeInfo', and why 
does uWireSlave violate our naming conventions?  But those are 
independent cleanups, and not necessarily something for you to worry about]

With the sorting fixed,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

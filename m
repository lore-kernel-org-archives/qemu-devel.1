Received: from eggs.gnu.org ([2001:4830:134:3::10]:39184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duf6T-0006xJ-5Z
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duf6P-0007IP-36
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:31:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duf6O-0007I1-OF
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:31:44 -0400
Date: Wed, 20 Sep 2017 11:14:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170920111431.1435dacd.cohuck@redhat.com>
In-Reply-To: <20170919074314.10350-1-borntraeger@de.ibm.com>
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Jing Liu <liujbjl@linux.vnet.ibm.com>

On Tue, 19 Sep 2017 09:43:14 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Jing Liu <liujbjl@linux.vnet.ibm.com>
> 
> This patch is the s390 implementation of guest crash information, similar
> to commit d187e08dc4 ("i386/cpu: add crash-information QOM property") and
> the related commits. We will detect several crash reasons, with the
> "disabled wait" being the most important one, since this is used by all
> s390 guests as a "panic like" notification.
> 
> Demonstrate the these ways with examples as follows.

s/the these/these/

> 
>   1. crash-information QOM property;
> 
>   Run qemu with -qmp unix:qmp-sock,server, then use utility "qmp-shell"
>   to execute "qom-get" command, and might get the result like,
> 
>   (QEMU) qom-get path=/machine/cpu[0]/ property=crash-information
>   {"return": {"psw-addr": 1105350, "psw-mask": 562956395872256, "reason":
>    "disabled wait", "type": "s390"}}
> 
>   2. GUEST_PANICKED event reporting;
> 
>   Run qemu with a socket option, and telnet or nc to that,
>   -chardev socket,id=qmp,port=4444,host=localhost,server \
>   -mon chardev=qmp,mode=control,pretty=on \
>   Negotiating the mode by { "execute": "qmp_capabilities" }, and the crash
>   information will be reported on a guest crash event like,
> 
>   {
>       "timestamp": {
>           "seconds": 1499931739,
>           "microseconds": 961296
>       },
>       "event": "GUEST_PANICKED",
>       "data": {
>           "action": "pause",
>           "info": {
>               "psw-addr": 1105350,
>               "reason": "disabled wait",
>               "psw-mask": 562956395872256,
>               "type": "s390"
>           }
>       }
>   }

Out of scope for this patch, but is there a way to print the values as
hex in the monitor?

> 
>   3. log;
> 
>   Run qemu with the parameters: -D <logfile> -d guest_errors, to
>   specify the logfile and log item. The results might be,
> 
>   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  
>   Guest crashed
>   S390 crash parameters: (0x2000180000000 0x10ddc6)

Would it make sense to pad with zeroes, for readability?

>   S390 crash reason: disabled wait
>   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  
> 
> Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [minor fixes due to upstream feedback]
> ---
> V1->V2:
> 	- rename kvm-s390 to s390 in all places
> 	- add "loop" to the crash reasons where appropriate
> 	- use "-" instead of "_" for qapi
> 
>  qapi/run-state.json | 19 ++++++++++++++++--
>  target/s390x/cpu.c  | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/cpu.h  |  6 ++++++
>  target/s390x/kvm.c  | 29 +++++++++++++++++++++------
>  vl.c                |  6 ++++++
>  5 files changed, 109 insertions(+), 8 deletions(-)

No further comments over what others have already said.

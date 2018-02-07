Received: from eggs.gnu.org ([2001:4830:134:3::10]:37592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejT3I-0007nv-Cp
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:58:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejT3D-000279-HC
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:58:32 -0500
Date: Wed, 7 Feb 2018 17:58:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180207175810.6db572e7.cohuck@redhat.com>
In-Reply-To: <20180207123833.211687-1-borntraeger@de.ibm.com>
References: <20180207123833.211687-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] s390x/cpu: expose the guest crash
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>

On Wed,  7 Feb 2018 12:38:33 +0000
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> This patch is the s390 implementation of guest crash information,
> similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
> property") and the related commits. We will detect several crash
> reasons, with the "disabled wait" being the most important one, since
> this is used by all s390 guests as a "panic like" notification.
> 
> Demonstrate these ways with examples as follows.
> 
>   1. crash-information QOM property;
> 
>   Run qemu with -qmp unix:qmp-sock,server, then use utility "qmp-shell"
>   to execute "qom-get" command, and might get the result like,
> 
>   (QEMU) (QEMU) qom-get path=/machine/unattached/device[0] \
>       property=crash-information
>   {"return": {"core": 0, "reason": "disabledwait", "psw-mask": 562956395872256, \
>       "type": "s390", "psw-addr": 1102832}}
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
>     "timestamp": {
>         "seconds": 1518004739,
>         "microseconds": 552563
>     },
>     "event": "GUEST_PANICKED",
>     "data": {
>         "action": "pause",
>         "info": {
>             "core": 0,
>             "psw-addr": 1102832,
>             "reason": "disabledwait",
>             "psw-mask": 562956395872256,
>             "type": "s390"
>         }
>     }
>   }
> 
>   3. log;
> 
>   Run qemu with the parameters: -D <logfile> -d guest_errors, to
>   specify the logfile and log item. The results might be,
> 
>   Guest crashed on cpu 0: disabledwait
>   PSW: 0x0002000180000000 0x000000000010d3f0
> 
> Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> V5->V6: - use qapi enum
> 	- add core id to the crash parameters
> 	- indent fixes
> 	- rework debug log message to reuse the enum string
> 	- update patch description
> 
>  qapi/run-state.json   | 54 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  target/s390x/cpu.c    | 41 ++++++++++++++++++++++++++++++++++++++
>  target/s390x/cpu.h    |  2 ++
>  target/s390x/helper.c |  5 ++++-
>  target/s390x/kvm.c    | 15 +++++++-------
>  vl.c                  | 12 ++++++++++--
>  6 files changed, 116 insertions(+), 13 deletions(-)
> 

> +##
> +# @S390CrashReason:
> +#
> +# Reason why the CPU is in a crashed state.
> +#
> +# @unknown: no crash reason was set
> +#
> +# @disabledwait: the CPU has entered a disabled wait state
> +#
> +# @extintloop: timer interrupt with new PSW enabled for timer
> +#
> +# @pgmintloop: program interrupt with BAD new PSW
> +#
> +# @opintloop: operation exception interrupt with invalid code at the program
> +#             interrupt new PSW
> +#
> +# Since: 2.12
> +##
> +{ 'enum': 'S390CrashReason',
> +  'data': [ 'unknown',
> +            'disabledwait',
> +            'extintloop',
> +            'pgmintloop',
> +            'opintloop' ] }

Would some hyphens or underscores make this a bit more readable? FWICS,
QAPI would create something like S390_CRASH_REASON_DISABLED_WAIT for
'disabled-wait', which looks reasonable to me.

With the build fix and the description change for extintloop, this
looks fine to me (with or without a changed enum).

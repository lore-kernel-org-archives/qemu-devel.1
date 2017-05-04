Received: from eggs.gnu.org ([2001:4830:134:3::10]:43116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6D8L-00055Z-Lj
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6D8H-0003T2-OD
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:33:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d6D8H-0003Rs-IE
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:33:09 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170504084210.7488.37561.stgit@PASHA-ISP> (Pavel Dovgalyuk's
	message of "Thu, 04 May 2017 11:42:10 +0300")
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
	<20170504084210.7488.37561.stgit@PASHA-ISP>
Reply-To: quintela@redhat.com
Date: Thu, 04 May 2017 11:33:03 +0200
Message-ID: <874lx1t19s.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 06/10] replay: fix save/load vm for
 non-empty queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, kraxel@redhat.com, pbonzini@redhat.com

Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru> wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> This patch does not allows saving/loading vmstate when
> replay events queue is not empty. There is no reliable
> way to save events queue, because it describes internal
> coroutine state. Therefore saving and loading operations
> should be deferred to another record/replay step.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This functions have changed, see last series (but change is trivial from
monitor_printf to error_<something>)

> @@ -2083,6 +2084,12 @@ int save_vmstate(Monitor *mon, const char *name)
>      Error *local_err = NULL;
>      AioContext *aio_context;
>  
> +    if (!replay_can_snapshot()) {
> +        monitor_printf(mon, "Record/replay does not allow making snapshot right now. "
> +                        "Try stopping at another step.\n");
> +        return ret;
> +    }
> +

To issue a savevm/loadvm the user don't have to stop qemu, so I think we
can improve the message to something les in both places?

"Try saving/loading later"?

Thanks, Juan.

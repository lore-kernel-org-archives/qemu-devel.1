Received: from eggs.gnu.org ([2001:4830:134:3::10]:50499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6DbP-0008R2-Db
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6DbK-0005ab-Cu
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:03:15 -0400
Received: from mail.ispras.ru ([83.149.199.45]:50428)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6DbK-0005Xy-4q
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:03:10 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170504084135.7488.24715.stgit@PASHA-ISP>	<20170504084210.7488.37561.stgit@PASHA-ISP>
	<874lx1t19s.fsf@secure.mitica>
In-Reply-To: <874lx1t19s.fsf@secure.mitica>
Date: Thu, 4 May 2017 13:03:12 +0300
Message-ID: <000301d2c4bd$a3dd0640$eb9712c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: quintela@redhat.com, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, kraxel@redhat.com, pbonzini@redhat.com

> From: Juan Quintela [mailto:quintela@redhat.com]
> Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru> wrote:
> > From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> >
> > This patch does not allows saving/loading vmstate when
> > replay events queue is not empty. There is no reliable
> > way to save events queue, because it describes internal
> > coroutine state. Therefore saving and loading operations
> > should be deferred to another record/replay step.
> >
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 
> This functions have changed, see last series (but change is trivial from
> monitor_printf to error_<something>)
> 
> > @@ -2083,6 +2084,12 @@ int save_vmstate(Monitor *mon, const char *name)
> >      Error *local_err = NULL;
> >      AioContext *aio_context;
> >
> > +    if (!replay_can_snapshot()) {
> > +        monitor_printf(mon, "Record/replay does not allow making snapshot right now. "
> > +                        "Try stopping at another step.\n");
> > +        return ret;
> > +    }
> > +
> 
> To issue a savevm/loadvm the user don't have to stop qemu, so I think we
> can improve the message to something les in both places?
> 
> "Try saving/loading later"?

Right, thanks.

Pavel Dovgalyuk

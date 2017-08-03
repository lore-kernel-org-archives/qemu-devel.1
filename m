Received: from eggs.gnu.org ([2001:4830:134:3::10]:51715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddOjj-0008PO-SW
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddOjf-0007me-3b
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ddOje-0007lM-UX
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:36:55 -0400
Date: Thu, 3 Aug 2017 18:36:51 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1246900984.1258310.1501799811039.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170803164516.GG3673@work-vm>
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170802144229.GA5821@igalia.com> <20170803164516.GG3673@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, jsnow@redhat.com



----- Original Message -----
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> To: "Alberto Garcia" <berto@igalia.com>
> Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jsnow@redhat.com
> Sent: Thursday, August 3, 2017 6:45:17 PM
> Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block devices
> 
> * Alberto Garcia (berto@igalia.com) wrote:
> > On Thu, Jul 13, 2017 at 08:01:16PM +0100, Dr. David Alan Gilbert (git)
> > wrote:
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -4787,8 +4787,8 @@ int main(int argc, char **argv, char **envp)
> > >      replay_disable_events();
> > >      iothread_stop_all();
> > >  
> > > -    bdrv_close_all();
> > >      pause_all_vcpus();
> > > +    bdrv_close_all();
> > >      res_free();
> > 
> > I haven't debugged it yet, but in my computer iotest 093 stops working
> > (it never finishes) after this change.
> 
> Yes, I can reproduce that here (I've got to explicitly run 093 - it
> doesn't do it automatically for me):

The culprit so to speak is this:

        if (qtest_enabled()) {
            /* For testing block IO throttling only */
            tg->clock_type = QEMU_CLOCK_VIRTUAL;
        }

So after pause_all_vcpus(), the clock doesn't advance and bdrv_close_all
hangs.  Should throttling be disabled by the time bdrv_close drains the
BlockDriverState, and likewise for bdrv_close_all?

Paolo

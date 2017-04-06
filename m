Received: from eggs.gnu.org ([2001:4830:134:3::10]:42580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cw9Ng-0003pT-3T
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cw9Nb-0007eY-Hp
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cw9Nb-0007d0-8V
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:31:23 -0400
Date: Thu, 6 Apr 2017 09:31:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170406093119.792a591e@t450s.home>
In-Reply-To: <58E6011F.6030002@cn.fujitsu.com>
References: <1490260051-6046-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161238.366ce6a7@t450s.home>
	<58DA6954.2000601@cn.fujitsu.com>
	<20170328101233.74f50a92@t450s.home>
	<20170329000148.GA18849@redhat.com>
	<20170328205513.21b97381@t450s.home>
	<20170330205823-mutt-send-email-mst@kernel.org>
	<20170330121652.2ac8fa62@t450s.home>
	<58E4B0C9.50109@cn.fujitsu.com>
	<20170406005028-mutt-send-email-mst@kernel.org>
	<58E6011F.6030002@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com

On Thu, 6 Apr 2017 16:49:35 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> On 04/06/2017 05:56 AM, Michael S. Tsirkin wrote:
> > On Wed, Apr 05, 2017 at 04:54:33PM +0800, Cao jin wrote:  
> >> Apparently, I don't have experience to induce non-fatal error, device
> >> error is more of a chance related with the environment(temperature,
> >> humidity, etc) as I understand.  
> > 
> > I'm not sure how to interpret this statement. I think what Alex is
> > saying is simply that patches should include some justification. They
> > make changes but what are they improving?
> > For example:
> > 
> > 	I tested device ABC in conditions DEF. Without a patch VM
> > 	stops. With the patches applied VM recovers and proceeds to
> > 	use the device normally.
> > 
> > is one reasonable justification imho.
> >   
> 
> Got it. But unfortunately, until now, I haven't seen a VM stop caused by
> a real device non-fatal error during device assignment(Only saw real
> fatal errors after start VM).
> On one side, AER error could occur theoretically; on the other side,
> seldom people have seen a VM stop caused by AER. Now I am asked that do
> I have a real evidence or scenario to prove that this patchset is really
> useful? I don't, and we all know it is hard to trigger a real hardware
> error, so, seems I am pushed into the corner.  I guess these questions
> also apply for AER driver's author, if the scenario is easy to
> reproduce, there is no need to write aer_inject to fake errors.

Yes, non-fatal errors are rare, so rare in fact that I wonder if
anything actually implements them.  Could we take a survey of Linux
drivers with AER support and see which ones actually do anything useful
on a non-fatal error?  I know fatal errors exist, I've seen them.  The
situation I want to avoid is adding non-fatal AER support that never
gets used and just gets in the way of the next attempt to support fatal
error recovery.  We're extending the user ABI here, which means that
for any feature we add, we need to consider how we'll support it long
term and how we'll deprecate it or further extend it when the next
level of support comes.  I'm reluctant to add code that only partially
solves a problem and only addresses the side of the problem that we're
not even sure occurs.  Thanks,

Alex

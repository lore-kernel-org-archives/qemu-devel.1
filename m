Received: from eggs.gnu.org ([2001:4830:134:3::10]:49234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE3hT-00026v-Kg
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE3hQ-0005p5-5b
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:10:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fE3hP-0005on-Vo
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:10:24 -0400
Date: Thu, 3 May 2018 10:10:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180503021010.GC8239@xz-mi>
References: <20180426091519.26934-1-xiaoguangrong@tencent.com>
	<32eaad8e-35a0-5240-37a2-4242b7890ab9@redhat.com>
	<a14b1b5b-4f0c-c085-35b8-9539afa5091f@gmail.com>
	<20180427093135.GC13269@xz-mi>
	<2f84ab90-2b9c-9888-e6e2-9114ae046078@gmail.com>
	<20180502030309.GC25938@xz-mi> <20180502145713.GE2679@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180502145713.GE2679@work-vm>
Subject: Re: [Qemu-devel] [PATCH] migration: introduce decompress-error-check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, wei.w.wang@intel.com, jiang.biao2@zte.com.cn

On Wed, May 02, 2018 at 03:57:13PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Fri, Apr 27, 2018 at 06:40:09PM +0800, Xiao Guangrong wrote:
> > > 
> > > 
> > > On 04/27/2018 05:31 PM, Peter Xu wrote:
> > > > On Fri, Apr 27, 2018 at 11:15:37AM +0800, Xiao Guangrong wrote:
> > > > > 
> > > > > 
> > > > > On 04/26/2018 10:01 PM, Eric Blake wrote:
> > > > > > On 04/26/2018 04:15 AM, guangrong.xiao@gmail.com wrote:
> > > > > > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > > > > > 
> > > > > > > QEMU 2.13 enables strict check for compression & decompression to
> > > > > > > make the migration more robuster, that depends on the source to fix
> > > > > > 
> > > > > > s/robuster/robust/
> > > > > > 
> > > > > 
> > > > > Will fix, thank you for pointing it out.
> > > > > 
> > > > > > > the internal design which triggers the unexpected error conditions
> > > > > > 
> > > > > > 2.13 hasn't been released yet.  Why do we need a knob to explicitly turn
> > > > > > off strict checking?  Can we not instead make 2.13 automatically smart
> > > > > > enough to tell if the incoming stream is coming from an older qemu
> > > > > > (which might fail if the strict checks are enabled) vs. a newer qemu
> > > > > > (the sender gave us what we need to ensure the strict checks are
> > > > > > worthwhile)?
> > > > > > 
> > > > > 
> > > > > Really smart.
> > > > > 
> > > > > How about introduce a new command, MIG_CMD_DECOMPRESS_ERR_CHECK,
> > > > > the destination will do strict check if got this command (i.e, new
> > > > > QEMU is running on the source), otherwise, turn the check off.
> > > > 
> > > > Why not we just introduce a compat bit for that?  I mean something
> > > > like: 15c3850325 ("migration: move skip_section_footers",
> > > > 2017-06-28).  Then we turn that check bit off for <=2.12.
> > > > 
> > > > Would that work?
> > > 
> > > I am afraid it can not. :(
> > > 
> > > The compat bit only impacts local behavior, however, in this case, we
> > > need the source QEMU to tell the destination if it supports strict
> > > error check.
> > 
> > My understanding is that the new compat bit will only take effect when
> > at destination.
> > 
> > I'm not sure I'm thinking that correctly. I'll give some examples.
> > 
> > When we migrate from <2.12 to 2.13, on 2.13 QEMU we'll possibly with
> > (using q35 as example, always) "-M pc-q35-2.12" to make the migration
> > work, so this will let the destination QEMU stop checking
> > decompressing errors.  IMHO that's what we want so it's fine (forward
> > migration).
> > 
> > When we migrate from 2.13 to <2.12, on 2.12 it'll always skip checking
> > decompression errors, so it's fine too even if we don't send some
> > compress-errored pages.
> > 
> > Then, would this mean that the compat bit could work too just like
> > this patch?  AFAIU the compat bit idea is very similar to current
> > patch, however we don't really need a new parameter to make things
> > complicated, we just let old QEMUs behave differently and
> > automatically, then user won't need to worry about manually specify
> > that parameter.
> 
> I think you're saying just to wire it to the machine type for receive;
> that would work and would be fairly simple, although wouldn't provide
> the protection when going from new->new using an old machine type.

Yes.  But actually we can still leverage the protection even with
new->new and old machine types - we just need to explicitly override
that parameter on both sides (instead of explicitly disalbe that on
old ones):

  -M pc-q35-2.12 -global migration.x-error-decompress-check=true

After all the user already specified "-M pc-q35-2.12" explicitly
rather than using the default 2.13 one, I would consider he/she an
advanced user.  Then IMHO it would be acceptable to make this explicit
too when the user really wants that.

(Will that happen a lot when people still use old machine types even
 if they are creating new VMs?)

-- 
Peter Xu
